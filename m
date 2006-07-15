Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWGORHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWGORHU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 13:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWGORHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 13:07:20 -0400
Received: from intrepid.intrepid.com ([192.195.190.1]:61842 "EHLO
	intrepid.intrepid.com") by vger.kernel.org with ESMTP
	id S1750722AbWGORHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 13:07:18 -0400
From: "Gary Funck" <gary@intrepid.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: 2.6.17-1.2145_FC5 mmap-related soft lockup
Date: Sat, 15 Jul 2006 10:07:26 -0700
Message-ID: <JCEPIPKHCJGDMPOHDOIGGEKJDFAA.gary@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Spam-Score: -1.44 () ALL_TRUSTED
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A test program which allocates about 256M of MAP_ANONYMOUS mmap memory,
and then spawns 4 processess, where each process i writes to 1/4 of the
mapped memory, and then reads the memory written by
the process (i + 1)%4, triggers a soft lockup, when exiting.
Hardware:
dual core dual Opteron 275 (Tyan motherboard, 4G physical memory)
has been rock solid reliable.

BUG: soft lockup detected on CPU#3!

Call Trace: <IRQ> <ffffffff802b2fb5>{softlockup_tick+219}
       <ffffffff8029708e>{update_process_times+66}
<ffffffff8027a3ed>{smp_local_timer_interrupt+35}
       <ffffffff8027aa95>{smp_apic_timer_interrupt+65}
<ffffffff80263acb>{apic_timer_interrupt+135} <EOI>
       <ffffffff8020e578>{__set_page_dirty_nobuffers+0}
<ffffffff8026a128>{_write_unlock_irq+11}
       <ffffffff8020e62d>{__set_page_dirty_nobuffers+181}
<ffffffff80207af6>{unmap_vmas+1037}
       <ffffffff8023c7d9>{exit_mmap+120} <ffffffff8023eda8>{mmput+44}
       <ffffffff80215ece>{do_exit+599}
<ffffffff8024cacd>{debug_mutex_init+0}
       <ffffffff80262f01>{tracesys+209}
BUG: soft lockup detected on CPU#0!

Call Trace: <IRQ> <ffffffff802b2fb5>{softlockup_tick+219}
       <ffffffff8029708e>{update_process_times+66}
<ffffffff8027a3ed>{smp_local_timer_interrupt+35}
       <ffffffff8027aa95>{smp_apic_timer_interrupt+65}
<ffffffff80263acb>{apic_timer_interrupt+135} <EOI>
       <ffffffff8020e578>{__set_page_dirty_nobuffers+0}
<ffffffff8026a128>{_write_unlock_irq+11}
       <ffffffff8020e62d>{__set_page_dirty_nobuffers+181}
<ffffffff80207af6>{unmap_vmas+1037}
       <ffffffff8023c7d9>{exit_mmap+120} <ffffffff8023eda8>{mmput+44}
       <ffffffff80215ece>{do_exit+599}
<ffffffff8024cacd>{debug_mutex_init+0}
       <ffffffff80262f01>{tracesys+209}
BUG: soft lockup detected on CPU#2!

Call Trace: <IRQ> <ffffffff802b2fb5>{softlockup_tick+219}
       <ffffffff8029708e>{update_process_times+66}
<ffffffff8027a3ed>{smp_local_timer_interrupt+35}
       <ffffffff8027aa95>{smp_apic_timer_interrupt+65}
<ffffffff80263acb>{apic_timer_interrupt+135} <EOI>
       <ffffffff8020e578>{__set_page_dirty_nobuffers+0}
<ffffffff8026a128>{_write_unlock_irq+11}
       <ffffffff8020e62d>{__set_page_dirty_nobuffers+181}
<ffffffff80207af6>{unmap_vmas+1037}
       <ffffffff8023c7d9>{exit_mmap+120} <ffffffff8023eda8>{mmput+44}
       <ffffffff80215ece>{do_exit+599}
<ffffffff8024cacd>{debug_mutex_init+0}
       <ffffffff80262f01>{tracesys+209}
BUG: soft lockup detected on CPU#1!

Call Trace: <IRQ> <ffffffff802b2fb5>{softlockup_tick+219}
       <ffffffff8029708e>{update_process_times+66}
<ffffffff8027a3ed>{smp_local_timer_interrupt+35}
       <ffffffff8027aa95>{smp_apic_timer_interrupt+65}
<ffffffff80263acb>{apic_timer_interrupt+135} <EOI>
       <ffffffff8020e578>{__set_page_dirty_nobuffers+0}
<ffffffff8026a128>{_write_unlock_irq+11}
       <ffffffff8020e62d>{__set_page_dirty_nobuffers+181}
<ffffffff80207af6>{unmap_vmas+1037}
       <ffffffff8023c7d9>{exit_mmap+120} <ffffffff8023eda8>{mmput+44}
       <ffffffff80215ece>{do_exit+599}
<ffffffff8024cacd>{debug_mutex_init+0}
       <ffffffff80262f01>{tracesys+209}

The test program runs successfully, but hangs several seconds upon exit.

The hardware and software configuration has been solid for several months,
but
we have seen timer-related synchronization issues with recent kernels (where
ntp has to force a re-sync for example, and an occasional lost ticks
message).

The test program mentioned above is more complicated than described, and
can't easily be reproduced in source form, but the binary could be
made available.

