Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265715AbSKAT0Z>; Fri, 1 Nov 2002 14:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265717AbSKAT0Z>; Fri, 1 Nov 2002 14:26:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59660 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265715AbSKAT0X>; Fri, 1 Nov 2002 14:26:23 -0500
Date: Fri, 1 Nov 2002 11:18:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Joel Becker <Joel.Becker@oracle.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bill Davidsen <davidsen@tmr.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <20021101190022.GB17573@nic1-pc.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Nov 2002, Joel Becker wrote:
> 
> 	I always liked the AIX dumper choices.  You could either dump to
> the swap area (and startup detects the dump and moves it to the
> filesystem before swapon) or provide a dedicated dump partition.  The
> latter was prefered.
> 	Either of these methods merely require the dumper to correctly
> write to one disk partition.  This is about as simple as you are going
> to get in disk dumping.

Ehh.. That was on closed hardware that was largely designed with and for
the OS.

Alan isn't worried about the "which sector do I write" kind of thing.  
That's the trivial part. Alan is worried about the fact that once you know
which sector to write, actually _doing_ so is a really hard thing. You
have bounce buffers, you have exceedingly complex drivers that work
differently in PIO and DMA modes and are more likely than not the _cause_
of a number of problems etc.

And you have a situation where interrupts are not likely to work well
(because you crashed with various locks held), so the regular driver
simply isn't likely to work all that well.

And you have a situation where there are hundreds of different kinds of 
device drivers for the disk.

In other words, the AIX situation isn't even _remotely_ comparable. A
large portion of the complexity in the PC stability space is in device
drivers. It's the thing I worry most about for 2.6.x stabilization, by 
_far_.

And if you get these things wrong, you're quite likely to stomp on your
disk. Hard. You may be tryign to write the swap partition, but if the
driver gets confused, you just overwrote all your important data. At which
point it doesn't matter if your filesystem is journaling or not, since you
just potentially overwrote it.

In other words: it's a huge risk to play with the disk when the system is
already known to be unstable. The disk drivers tend to be one of the main
issues even when everything else is _stable_, for chrissake!

To add insult to injury, you will not be able to actually _test_ any of 
the real error paths in real life. Sure, you will be able to test forced 
dumps on _your_ hardware, but while that is fine in the AIX model ("we 
control the hardware, and charge the user five times what it is worth"), 
again that doesn't mean _squat_ in the PC hardware space.

See?

		Linus

