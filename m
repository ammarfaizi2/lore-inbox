Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280187AbRJaPqI>; Wed, 31 Oct 2001 10:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280216AbRJaPp6>; Wed, 31 Oct 2001 10:45:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56071 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280187AbRJaPpk>; Wed, 31 Oct 2001 10:45:40 -0500
Date: Wed, 31 Oct 2001 07:43:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: pre6 oom killer oops
In-Reply-To: <3BE00A61.EAA52CE1@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110310730260.32330-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Oct 2001, Jeff Garzik wrote:
>
> I'm reinstalling now, with a bad blocks check, to make sure random disk
> crap isn't affecting things.  Disk is good AFAIK.  Vaguely recent ATA-33
> drive.  I'll switch to the other alpha to see if I can see similar
> symptoms.

Bad disks won't cause the kind of page table corruption you saw - even if
the disk is total cr*p, and you have a swap partition on it, we never
actually put metadata in swap, only the actual user pages (some other
systems will page out the page directories too, Linux won't).

To me it actually looks like something corrupted a _big_ chunk of memory.
Which is not indicative of memory trouble either (sure, random one-bit
corruption can do just about anything, including causing a big memcpy to
go to the wrong place, but ..).

One thing that does things like this is missed TLB invalidates. Especially
on SMP. If you unmap and free a page, and user space still has a TLB entry
for it, you can have the kernel re-use the page at the same time user
space writes "garbage" to it.

This is, of course, a lot easier to trigger with MMU contexts and the
like.



Something like that is especially likely, as one of the values in your
oops is

	swap_free: Bad swap file entry 2e66656464747368

where that value looks suspiciously like a likely string from a compiler:

	"hstddef."

So I'd look very closely at the TLB invalidate code, or possibly try to
see if we might re-use a page for some other reason too early.

		Linus

