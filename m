Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTJ0Kr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 05:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTJ0Kr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 05:47:59 -0500
Received: from smtp02.web.de ([217.72.192.151]:12582 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261580AbTJ0Kr5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 05:47:57 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 two Oops reports
Date: Mon, 27 Oct 2003 11:48:55 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310271148.55723.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I after running it during the weekend on my laptop I got several oopses. 
I already applied this patch (from Andrew Morton) to make powermanagement 
(acpi or apm) working at all:

--- 25/fs/binfmt_misc.c~bm_register_write-locking-fix        2003-10-25 
18:39:45.000000000 -0700
+++ 25-akpm/fs/binfmt_misc.c        2003-10-25 18:40:29.000000000 -0700
@@ -529,8 +529,8 @@ static ssize_t bm_register_write(struct 
         inode->u.generic_ip = e;
         inode->i_fop = &bm_entry_operations;
 
-        write_lock(&entries_lock);
         d_instantiate(dentry, inode);
+        write_lock(&entries_lock);
         list_add(&e->list, &entries);
         write_unlock(&entries_lock);


1.) This happens from time to time, maybe triggered by acpid? 

Oct 27 02:09:02 beno kernel: Debug: sleeping function called from invalid 
context at include/asm/uaccess.h:473
Oct 27 02:09:02 beno kernel: in_atomic():0, irqs_disabled():1
Oct 27 02:09:02 beno kernel: Call Trace:
Oct 27 02:09:02 beno kernel:  [<c0124406>] __might_sleep+0xa6/0xad
Oct 27 02:09:02 beno kernel:  [<c010e3c2>] save_v86_state+0x72/0x1e4
Oct 27 02:09:02 beno kernel:  [<c010ac22>] work_notifysig_v86+0x6/0x14
Oct 27 02:09:02 beno kernel:  [<c010abcf>] syscall_call+0x7/0xb
Oct 27 02:09:02 beno kernel: 


2.) On shutting down the system I get this one:

Oct 27 02:27:05 beno kernel: irq 9: nobody cared!
Oct 27 02:27:05 beno kernel: Call Trace:
Oct 27 02:27:05 beno kernel:  [<c010cc0b>] __report_bad_irq+0x2b/0x90
Oct 27 02:27:05 beno kernel:  [<c010cc13>] __report_bad_irq+0x33/0x90
Oct 27 02:27:05 beno kernel:  [<c010cce8>] note_interrupt+0x50/0x78
Oct 27 02:27:05 beno kernel:  [<c010d235>] __crc_pnp_add_card_device
+0x35/0x114
Oct 27 02:27:05 beno kernel:  [<c010b53c>] common_interrupt+0x18/0x20
Oct 27 02:27:05 beno kernel:  [<c012c814>] do_softirq+0x44/0xa0
Oct 27 02:27:05 beno kernel:  [<c010d2f8>] __crc_pnp_add_card_device
+0xf8/0x114
Oct 27 02:27:05 beno kernel:  [<c010b53c>] common_interrupt+0x18/0x20
Oct 27 02:27:05 beno kernel:  [<c0121a84>] schedule+0x0/0x784
Oct 27 02:27:05 beno kernel:  [<c010ab19>] need_resched+0x27/0x32
Oct 27 02:27:05 beno kernel:  [<c02852ae>] acpi_processor_idle+0xf2/0x204
Oct 27 02:27:05 beno kernel:  [<c0108034>] default_idle+0x0/0x34
Oct 27 02:27:05 beno kernel:  [<c0105000>] Letext+0x0/0xcc
Oct 27 02:27:05 beno kernel:  [<c01080e5>] cpu_idle+0x31/0x40
Oct 27 02:27:05 beno kernel:  [<c01050c5>] Letext+0xc5/0xcc
Oct 27 02:27:05 beno kernel:  [<c05ae6fe>] start_kernel+0x1ca/0x1d4
Oct 27 02:27:05 beno kernel: 
Oct 27 02:27:05 beno kernel: handlers:
Oct 27 02:27:05 beno kernel: [<c02531d0>] (acpi_irq+0x0/0x1c)
Oct 27 02:27:05 beno kernel: Disabling IRQ #9

Cheers,
	Bernd

