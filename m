Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWGPFT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWGPFT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 01:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWGPFT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 01:19:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964901AbWGPFT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 01:19:56 -0400
Date: Sat, 15 Jul 2006 22:19:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Gary Funck" <gary@intrepid.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-1.2145_FC5 mmap-related soft lockup
Message-Id: <20060715221942.9f1543ca.akpm@osdl.org>
In-Reply-To: <JCEPIPKHCJGDMPOHDOIGGEKJDFAA.gary@intrepid.com>
References: <JCEPIPKHCJGDMPOHDOIGGEKJDFAA.gary@intrepid.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2006 10:07:26 -0700
"Gary Funck" <gary@intrepid.com> wrote:

> 
> A test program which allocates about 256M of MAP_ANONYMOUS mmap memory,
> and then spawns 4 processess, where each process i writes to 1/4 of the
> mapped memory, and then reads the memory written by
> the process (i + 1)%4, triggers a soft lockup, when exiting.
> Hardware:
> dual core dual Opteron 275 (Tyan motherboard, 4G physical memory)
> has been rock solid reliable.
> 
> BUG: soft lockup detected on CPU#3!
> 
> Call Trace: <IRQ> <ffffffff802b2fb5>{softlockup_tick+219}
>        <ffffffff8029708e>{update_process_times+66}
> <ffffffff8027a3ed>{smp_local_timer_interrupt+35}
>        <ffffffff8027aa95>{smp_apic_timer_interrupt+65}
> <ffffffff80263acb>{apic_timer_interrupt+135} <EOI>
>        <ffffffff8020e578>{__set_page_dirty_nobuffers+0}
> <ffffffff8026a128>{_write_unlock_irq+11}
>        <ffffffff8020e62d>{__set_page_dirty_nobuffers+181}
> <ffffffff80207af6>{unmap_vmas+1037}
>        <ffffffff8023c7d9>{exit_mmap+120} <ffffffff8023eda8>{mmput+44}
>        <ffffffff80215ece>{do_exit+599}
> <ffffffff8024cacd>{debug_mutex_init+0}
>        <ffffffff80262f01>{tracesys+209}
> 
> ..
>
> The test program runs successfully, but hangs several seconds upon exit.
> 
> The hardware and software configuration has been solid for several months,
> but
> we have seen timer-related synchronization issues with recent kernels (where
> ntp has to force a re-sync for example, and an occasional lost ticks
> message).
> 
> The test program mentioned above is more complicated than described, and
> can't easily be reproduced in source form, but the binary could be
> made available.

ah-hah.  This sounds like the write_lock(tree_lock) starvation bug.

Are you able to confirm that setting CONFIG_DEBUG_SPINLOCK=n fixes it?

And are you able to get us a copy of that test app?

Thanks.
