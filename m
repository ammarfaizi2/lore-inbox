Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSJJRS6>; Thu, 10 Oct 2002 13:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261702AbSJJRS6>; Thu, 10 Oct 2002 13:18:58 -0400
Received: from smtp.urbanet.ch ([195.202.193.135]:34469 "HELO smtp.urbanet.ch")
	by vger.kernel.org with SMTP id <S261701AbSJJRS5>;
	Thu, 10 Oct 2002 13:18:57 -0400
From: Sylvain Pasche <sylvain_pasche@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15781.47072.335973.295982@yahoo.fr>
Date: Thu, 10 Oct 2002 19:24:48 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 isofs patch to avoid "bad: scheduling while atomic!"
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without the patch:
bad: scheduling while atomic!
Call Trace:
 [<c01161b1>] schedule+0x3d/0x4d4
 [<c01123fd>] smp_apic_timer_interrupt+0x111/0x124
 [<c0107595>] need_resched+0x1f/0x2a
 [<c01a0068>] sysvipc_sem_read_proc+0x1b0/0x227
 [<c01acba5>] serial_in+0x45/0x4c
 [<c01aeadd>] serial8250_console_write+0x5d/0x1cc
 [<c011ba26>] __call_console_drivers+0x3e/0x50
 [<c011ba8b>] _call_console_drivers+0x53/0x58
 [<c011bb45>] call_console_drivers+0xb5/0xe0
 [<c011bed7>] release_console_sem+0xc3/0x164
 [<c011bd7f>] printk+0x1a7/0x1f4
 [<c011890f>] __might_sleep+0x4f/0x58
 [<c013f2f4>] __alloc_pages+0x24/0x24c
 [<c013f544>] __get_free_pages+0x28/0x60
 [<f8998797>] isofs_readdir+0x6f/0xf7 [isofs]
 [<c015dfd5>] vfs_readdir+0x75/0x88
 [<c015e260>] filldir64+0x0/0x114
 [<c015e3c3>] sys_getdents64+0x4f/0xb3
 [<c015e260>] filldir64+0x0/0x114
 [<c015d52d>] sys_fcntl64+0x85/0x98
 [<c015d539>] sys_fcntl64+0x91/0x98
 [<c01075d3>] syscall_call+0x7/0xb

the simple fix:

--- linux-2.5.41/fs/isofs/dir.c_old     2002-10-10 19:12:19.000000000 +0200
+++ linux-2.5.41/fs/isofs/dir.c 2002-10-10 19:13:26.000000000 +0200
@@ -256,7 +256,7 @@
 
        lock_kernel();
 
-       tmpname = (char *) __get_free_page(GFP_KERNEL);
+       tmpname = (char *) __get_free_page(GFP_KERNEL | GFP_ATOMIC);
        if (!tmpname)
                return -ENOMEM;
        tmpde = (struct iso_directory_record *) (tmpname+1024);



Sylvain Pasche
