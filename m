Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318164AbSG3AbJ>; Mon, 29 Jul 2002 20:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318165AbSG3AbJ>; Mon, 29 Jul 2002 20:31:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:31192 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318164AbSG3Aa7>;
	Mon, 29 Jul 2002 20:30:59 -0400
Subject: Re: 2.4.19rc2aa1 i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020723170807.GW1116@dualathlon.random>
References: <1026949132.20314.0.camel@joe2.pdx.osdl.net>
	<1026951041.2412.38.camel@IBM-C> <20020718103511.GG994@dualathlon.random>
	<1027037361.2424.73.camel@IBM-C> <20020719112305.A15517@oldwotan.suse.de>
	<1027119396.2629.16.camel@IBM-C>  <20020723170807.GW1116@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 Jul 2002 17:34:16 -0700
Message-Id: <1027989256.578.30.camel@IBM-C>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

Sorry I haven't responded, but I was on vacation all last week and
was not near a computer.

I like your code change.  Incrementing the v2 before the v1 in the
i_size_write() is much better.  My code was definitely uglier -- but
it was correct since the version1 and version2 where sampled before
i_size was read and version1 and version2 where checked again after.
It was excessive, but correct.

On your patch, shouldn't non-smp preempt still use the 64-bit stuff?
The comment says it should, but the #ifdef's are not checking for
PREEMPT or did I miss something?

I would still be curious about the performance difference between the 
version approach and the cmpxchg8 approach.  With SMP I'm a bit worried
about the cacheline bouncing around and the memory bandwith wasted.

Any ideas on what kind of test would be appropriate?
I've got access to 2-proc to 8-proc systems I could run some tests on,
just not sure what test would be useful.  The fstat() test isn't
realistic.

Increasing the versions to 32-bit is ok with -- I was just trying to
not waste too much space.

Daniel

On Tue, 2002-07-23 at 10:08, Andrea Arcangeli wrote:
> On Fri, Jul 19, 2002 at 03:56:36PM -0700, Daniel McNeil wrote:
> > +	short v1;
> > +	short v2;
> > +	loff_t i_size;
> > +
> > +	/*
> > +	 * retry if i_size was possibly modified while sampling.
> > +	 */
> > +	do {
> > +		v1 = inode->i_attr_version1;
> > +		v2 = inode->i_attr_version2;
> > +		rmb();
> > +		i_size = inode->i_size;
> > +		rmb();
> > +	} while (v1 != v2 ||
> > +		 v1 != inode->i_attr_version1 ||
> > +		 v1 != inode->i_attr_version2);
> > +	return i_size;
> [..]
> >  #elif BITS_PER_LONG==64
> >  	return inode->i_size;
> >  #endif
> > @@ -548,8 +566,12 @@
> >  static inline void i_size_write(struct inode * inode, loff_t i_size)
> >  {
> >  #if BITS_PER_LONG==32
> > -	set_64bit((unsigned long long *) &inode->i_size,
> > -		  (unsigned long long) i_size);
> > +	inode->i_attr_version1++;       /* changing i_size */
> > +	wmb();
> > +	inode->i_size = i_size;
> > +	wmb();
> > +	inode->i_attr_version2++;       /* done with change */
> > +	wmb();
> >  #elif BITS_PER_LONG==64
> >  	inode->i_size = i_size;
> >  #endif
> 
> btw, looking at the implementation the read side was buggy. First it's
> pointless to read both version1 and version2 before reading the isize,
> secondly if you increase version1 first (in the writer), the reader has
> to read version2 before i_size and version1 after i_size. While you're
> doing the opposite, you compare v1 (version1) read before i_size with
> version2 after i_size.
> 
> So while merging it I rewrote it this way (I also change the type of the
> sequence number to int, 2^16 can overflow quite fast in a multighz cpu,
> mostly for paranoid of course, and to go safe with the atomic granularty
> provided by archs, int certainly has to be atomic-granular).
> 
> 	loff_t i_size;
> 	int v1, v2;
> 
> 	/* Retry if i_size was possibly modified while sampling. */
> 	do {
> 		v1 = inode->i_size_version1;
> 		rmb();
> 		i_size = inode->i_size;
> 		rmb();
> 		v2 = inode->i_size_version2;
> 	} while (v1 != v2);
> 
> 	return i_size;
> 
> 
> and the new writer side:
> 
> 	inode->i_size_version2++;
> 	wmb();
> 	inode->i_size = i_size;
> 	wmb();
> 	inode->i_size_version1++;
> 	wmb(); /* make it visible ASAP */
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


