Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWJEAFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWJEAFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWJEAFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:05:15 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:1248 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751246AbWJEAFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:05:12 -0400
Message-Id: <200610050004.k9504IpO022761@laptop13.inf.utfsm.cl>
To: Jiri Kosina <jikos@jikos.cz>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: DWARF2 unwinder stuck 
In-Reply-To: Message from Jiri Kosina <jikos@jikos.cz> 
   of "Wed, 04 Oct 2006 22:46:33 +0200." <Pine.LNX.4.64.0610042223020.12556@twin.jikos.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Wed, 04 Oct 2006 20:04:18 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 04 Oct 2006 20:04:25 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <jikos@jikos.cz> wrote:
> Hi Andi,
> 
> I know you are hunting all the DWARF2 unwinding stucks. I have just got 
> the one below, when debuging kernel panic in MPU401 driver, with Linus' 
> current git tree.

OK, if somebody is collecting these beasts...

Loading the ipw3945-1.1.0 driver I get with Fedora rawhide's
2.6.18-1.2726.fc6 on a Centrino duo:

ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.1.0d
ipw3945: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:05:00.0 to 64
ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
ipw3945: Detected geography ABG (11 802.11bg channels, 13 802.11a channels)

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.18-1.2726.fc6 #1
-------------------------------------------------------
iwconfig/3058 is trying to acquire lock:
 (&priv->mutex){--..}, at: [<c06133a2>] mutex_lock+0x21/0x24

but task is already holding lock:
 (rtnl_mutex){--..}, at: [<c06133a2>] mutex_lock+0x21/0x24

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){--..}:
       [<c043bf70>] lock_acquire+0x4b/0x6b
       [<c0613233>] __mutex_lock_slowpath+0xbc/0x20a
       [<c06133a2>] mutex_lock+0x21/0x24
       [<c05c083c>] rtnl_lock+0xd/0xf
       [<c05b9be8>] register_netdev+0xe/0x69
       [<f8e882b4>] ipw_bg_calibrated_work+0x6c/0x1d1 [ipw3945]
       [<c043330a>] run_workqueue+0x7a/0xbb
       [<c0433c3f>] worker_thread+0xd2/0x107
       [<c04361b9>] kthread+0xc3/0xf2
       [<c0402005>] kernel_thread_helper+0x5/0xb

-> #0 (&priv->mutex){--..}:
       [<c043bf70>] lock_acquire+0x4b/0x6b
       [<c0613233>] __mutex_lock_slowpath+0xbc/0x20a
       [<c06133a2>] mutex_lock+0x21/0x24
       [<f8e8dba6>] ipw_wx_set_essid+0x3c/0x21e [ipw3945]
       [<c05c384c>] ioctl_standard_call+0x15c/0x217
       [<c05c3b4d>] wireless_process_ioctl+0x55/0x313
       [<c05ba776>] dev_ioctl+0x433/0x46e
       [<c05b00bd>] sock_ioctl+0x1b4/0x1c7
       [<c0482f3a>] do_ioctl+0x22/0x67
       [<c04831d7>] vfs_ioctl+0x258/0x26b
       [<c0483231>] sys_ioctl+0x47/0x62
       [<c0403fb7>] syscall_call+0x7/0xb

other info that might help us debug this:

1 lock held by iwconfig/3058:
 #0:  (rtnl_mutex){--..}, at: [<c06133a2>] mutex_lock+0x21/0x24

stack backtrace:
 [<c04051ed>] show_trace_log_lvl+0x58/0x16a
 [<c04057fa>] show_trace+0xd/0x10
 [<c0405913>] dump_stack+0x19/0x1b
 [<c043b0e7>] print_circular_bug_tail+0x59/0x64
 [<c043b870>] __lock_acquire+0x77e/0x90d
 [<c043bf70>] lock_acquire+0x4b/0x6b
 [<c0613233>] __mutex_lock_slowpath+0xbc/0x20a
 [<c06133a2>] mutex_lock+0x21/0x24
 [<f8e8dba6>] ipw_wx_set_essid+0x3c/0x21e [ipw3945]
 [<c05c384c>] ioctl_standard_call+0x15c/0x217
 [<c05c3b4d>] wireless_process_ioctl+0x55/0x313
 [<c05ba776>] dev_ioctl+0x433/0x46e
 [<c05b00bd>] sock_ioctl+0x1b4/0x1c7
 [<c0482f3a>] do_ioctl+0x22/0x67
 [<c04831d7>] vfs_ioctl+0x258/0x26b
 [<c0483231>] sys_ioctl+0x47/0x62
 [<c0403fb7>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb
Leftover inexact backtrace:
 [<c04057fa>] show_trace+0xd/0x10
 [<c0405913>] dump_stack+0x19/0x1b
 [<c043b0e7>] print_circular_bug_tail+0x59/0x64
 [<c043b870>] __lock_acquire+0x77e/0x90d
 [<c043bf70>] lock_acquire+0x4b/0x6b
 [<c0613233>] __mutex_lock_slowpath+0xbc/0x20a
 [<c06133a2>] mutex_lock+0x21/0x24
 [<f8e8dba6>] ipw_wx_set_essid+0x3c/0x21e [ipw3945]
 [<c05c384c>] ioctl_standard_call+0x15c/0x217
 [<c05c3b4d>] wireless_process_ioctl+0x55/0x313
 [<c05ba776>] dev_ioctl+0x433/0x46e
 [<c05b00bd>] sock_ioctl+0x1b4/0x1c7
 [<c0482f3a>] do_ioctl+0x22/0x67
 [<c04831d7>] vfs_ioctl+0x258/0x26b
 [<c0483231>] sys_ioctl+0x47/0x62
 [<c0403fb7>] syscall_call+0x7/0xb
ADDRCONF(NETDEV_UP): eth1: link is not ready
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth1: no IPv6 routers present

Reported as <https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=209385>
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
