Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUG2DWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUG2DWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 23:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUG2DWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 23:22:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41388 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263895AbUG2DWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 23:22:07 -0400
Date: Wed, 28 Jul 2004 21:25:36 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Caputo <ccaputo@alt.net>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <20040729002535.GA5145@logos.cnet>
References: <20040727141935.GB17456@logos.cnet> <Pine.LNX.4.44.0407270837180.24755-200000@nacho.alt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407270837180.24755-200000@nacho.alt.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jul 27, 2004 at 09:08:57AM -0700, Chris Caputo wrote:

> I may have phrased the question poorly.  I am trying to get at whether the
> x86 "lock ; dec $x" operation can somehow be affected by changes to IRQ
> affinity, since that is what appears to happen.  I assume SMP inter-cpu
> locking doesn't generate IRQs at the linux kernel level (right?), but
> there seems to be something at a low level which gets affected by changes
> to which CPU handles which IRQs.
> 
> > > I would like to come up with a more reliable way to reproduce the problem
> > > with a stock kernel (2.4.26), since it is presently very rare (less than
> > > once per week) in the way I presently get it to happen, but as yet have
> > > not done so. 
> > 
> > What is your workload? I'm more than willing to use the SMP boxes I have 
> > access to try to reproduce this. 
> 
> Here is the basic repro so far:
> 
> -1) SMP x86 machine (PIII or PIV), 4 gigs of RAM, kernel 2.4.26.  Here are 
>     some possibly relevant configs:
> 
> CONFIG_X86=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_HAS_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_F00F_WORKS_OK=y
> CONFIG_X86_MCE=y
> CONFIG_HIGHMEM4G=y
> CONFIG_HIGHMEM=y
> CONFIG_HIGHIO=y
> CONFIG_MTRR=y
> CONFIG_SMP=y
> CONFIG_X86_TSC=y
> CONFIG_HAVE_DEC_LOCK=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> 
> 0) Start irqbalance.
> 1) Have 10+ gigs of space available for testing preferably on two separate
>    filesystems, mounted on say /test_0 and /test_1.
> 2) As root do a "find /" to fill up the dcache/inode caches with a bunch 
>    of data.
> 3) Compile the attached writer2.c: "gcc -O2 -o writer2 writer2.c"
> 4) Run "writer2 /test_0 0" and "writer2 /test_1 0" in the background.
> 5) Run "emerge sync" a few times per day.
> 6) Wait for crash.

OK, I have started a testcase on OSDL 8-way PentiumIII, 16GB RAM.
Running stock 2.4.26, ext2 and ext3 filesystems.

Three "write2" running on three different partitions, plus
a "dbench 2" (which guarantees high inode cache activity).

Lets wait a week or so and see what has happened ;)

> Step 5 is unique to Gentoo, so it would be nice to have another test
> program which does the equivalent in terms of opening/created/deleting a
> bunch of times.  Intent to be inspiring that a bunch of items are added to
> and removed from the inode_unused list regularly.
> 
> > You said you also reproduced the same inode_unused corruption with
> > 2.4.24, yes?
> 
> I have reproduced the same symptoms (inode_unused list corruption) on
> 2.4.24 with a modified kernel (tux patches plus my filesystem) but I have
> not tried to do so with a stock 2.4.24.  So far only stock kernel I have
> tried has been 2.4.26.
> 
> > > My plan of attack is to remove irqbalance from the equation and repeatedly
> > > change with random intervals /proc/irq entries directly from one user mode
> > > program while another user mode program does things which inspire a lot of
> > > fs/inode.c spinlock activity (since that is where I continue to see list
> > > corruption).
> > > 
> > > A few questions which could help me with this:
> > > 
> > >   - Which IRQ (if any) is used by CPU's to coordinate inter-CPU locking?
> > 
> > None as far as spinlocks are concerned. On x86 spinlock just does "lock
> > ; dec $x"  operation which guarantees the atomicity of the "dec".
> > 
> > I feel I'm not answering your question, still. What do you mean?
> 
> What I seem to be seeing is that changes in IRQ affinity are at some level
> screwing up the guaranteed atomicity of the "lock ; dec $x".  I realize
> that might be crazy to think, but maybe it is something known about the
> x86 spec.  The two CPU's I have seen this with, by the way, are a PIV-Xeon
> (CPUID F29) and a PIII (CPUID 06B1), so I don't imagine a microcode-type
> bug unique to a certain CPU release.

Changing the affinity writes new values to the IOAPIC registers, I can't see
how that could interfere with the atomicity of a spinlock operation. I dont
understand why you think irqbalance could affect anything.

