Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312295AbSCYE00>; Sun, 24 Mar 2002 23:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312296AbSCYE0Q>; Sun, 24 Mar 2002 23:26:16 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:32521 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312295AbSCYEZ7>; Sun, 24 Mar 2002 23:25:59 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: bit ops on unsigned long? 
In-Reply-To: Your message of "Sun, 24 Mar 2002 19:45:26 PDT."
             <200203250245.g2P2jQa20821@vindaloo.ras.ucalgary.ca> 
Date: Mon, 25 Mar 2002 15:27:56 +1100
Message-Id: <E16pM5N-0000zb-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200203250245.g2P2jQa20821@vindaloo.ras.ucalgary.ca> you write:
> Rusty Russell writes:
> > Richard: 3 bugs in devfs.  Particularly note that the memset was
> > bogus.  I can't convince myself that your memcpy & memset stuff is
> > right anyway, given that you can ONLY treat them as unsigned longs
> > (ie. bit 31 will be in byte 0 or byte 3, depending on endianness).
> 
> Yes, the memset is bogus because I didn't cast the pointer to a
> char * or void *.

Yes.

> The memcpy should be fine, though. And so should
> everything else, because the bitfield array is allocated in 16 byte
> multiples.

No:

 struct major_list
 {
     spinlock_t lock;
-    __u32 bits[8];
+    unsigned long bits[256 / BITS_PER_LONG];
 };
 
 /*  Block majors already assigned:
@@ -212,7 +212,7 @@
 struct minor_list
 {
     int major;
-    __u32 bits[8];
+    unsigned long bits[256 / BITS_PER_LONG];
     struct minor_list *next;
 };

These changed are required because otherwise you try to do set_bit on
something not aligned as a long on all archs.

(Turning to the gallery) I assert: if you're going to do bitops on it,
make it a "unsigned long".

> So there should be no issues with big vs. little endian,
> since memset/memcpy operations are done in blocks of sufficient
> alignment.

I think you're right, as long as length is always a multiple of
sizeof(long).  This is not obvious from this hunk of code alone, which
is why I queried it...

    if (space->num_free < 1)
    {
	if (space->length < 16) length = 16;
	else length = space->length << 1;
	if ( ( bits = vmalloc (length) ) == NULL )
	{
	    up (&space->semaphore);
	    return -ENOMEM;
	}
	if (space->bits != NULL)
	{
	    memcpy (bits, space->bits, space->length);
	    vfree (space->bits);
	}
	space->num_free = (length - space->length) << 3;
	space->bits = bits;
	memset (bits + space->length, 0, length - space->length);
	space->length = length;
    }

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
