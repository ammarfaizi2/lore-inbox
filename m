Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271390AbUJVPuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271390AbUJVPuD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271394AbUJVPuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:50:03 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:61596 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S271390AbUJVPtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:49:43 -0400
Date: Fri, 22 Oct 2004 17:50:43 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041022155043.GE14325@dualathlon.random>
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <20041021182651.082e7f68.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021182651.082e7f68.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 06:26:51PM -0700, Andrew Morton wrote:
> But I'd be worried about making the default values anything other than zero
> because nobody seems to be hitting the problems.

Google reported the bug two years ago, and that's when I've seen and
fixed the problem the first time. Now the same workload that hurted two
years ago would still hurt today on 2.6 (not on 2.4 anymore).

On a x86 32G box reserving 800M is needed, otherwise if you sawpoff I'll
trivially deadlock the box, and if you implement relocationg you'd be
wasting cpu. The only scare of a 32GB x86 owner, is to run out of
lowmem. And the only scare of a 256G x86-64 or ia64 user is to run out
of DMA. They cannot care less to spend 1/32 of HIGHMEM and 1/256 of
HIGHMEM+NORMAL as an insurance to avoid expensive relocation memcopies
in the middle of their peak loads and to avoid running out of memory.

I've some VM deadlocks in my queue, amittedly they should never deadlock
but return -ENOMEM like 2.4 does, but that's an orthogonal known
problem. I've also a DMA failure allocation in x86-64 that triggers the
oom killer, that as well might not be strictly related, but there is no
swap to relocate anonymous memory, there cannot be sawp since yast
hasn't formatted the disk yet, my current workaround has been to turn
off the oom killer during install, and that sort of worked for now
despite somebody says it tends to slowdown.

I tried to tune the protection sysctl, but that resulted in too much
memory being reserved and a deadlock with oom killer turned off, hence
my decision to start fixing this instead of putting kernel internal
knowledge on the pages_min algorithm to set protection properly (plus I
wasn't 100% sure protection does exactly what the lowmem_reserve does,
plus keeping both protecetion and pages_min is a waste of ram).

As for the sysctl, sure, I'm retaining those runtime settable
improvements in 2.6, that's pretty cool compared to the not-working
command line of 2.4 (such boot time command line is invoked far too late
to make a difference but nobody has ever needed to turn off the values
so nobody (or peraphs only one person) ever noticed ;).

> But then again, this get discussed so infrequently that by the time it
> comes around again I've forgotten all the previous discussion.  Ho hum.

;)
