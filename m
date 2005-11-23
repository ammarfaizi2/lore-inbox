Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVKWOVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVKWOVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVKWOVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:21:12 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:39412 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750815AbVKWOVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:21:10 -0500
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
From: Steven Rostedt <rostedt@goodmis.org>
To: maneesh@in.ibm.com
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1132755344.13395.32.camel@localhost.localdomain>
References: <1132695202.13395.15.camel@localhost.localdomain>
	 <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com>
	 <Pine.LNX.4.58.0511230748000.23751@gandalf.stny.rr.com>
	 <20051123135847.GF22714@in.ibm.com>
	 <1132755344.13395.32.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 09:20:54 -0500
Message-Id: <1132755654.13395.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 09:15 -0500, Steven Rostedt wrote:

> 
> But this is not the end of the problems.  I'll follow up on that comment
> right after this.

Here's what I mean.  I'm using the below patch to see what happens on
the error cases, and things are still bombing.

The patch returns a failure after 30 calls. Even with my previous patch,
I'm crashing.

PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
kobject_register failed for CHN1 (-12)
 [<c01041ee>] dump_stack+0x1e/0x20
 [<c02206ab>] kobject_register+0x6b/0x80
 [<c0255e33>] acpi_device_register+0x105/0x11b
 [<c0256b8e>] acpi_add_single_object+0xf6/0x146
 [<c0256cee>] acpi_bus_scan+0x110/0x17b
 [<c03d6297>] acpi_scan_init+0x6b/0x89
 [<c03be9e7>] do_initcalls+0x57/0xd0
 [<c03bea85>] do_basic_setup+0x25/0x30
 [<c01002e5>] init+0x35/0x170
 [<c01013e5>] kernel_thread_helper+0x5/0x10
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c01ab6ef
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c01ab6ef>]    Not tainted VLI
EFLAGS: 00010296   (2.6.15-rc2-git2)
EIP is at create_dir+0xf/0x250
eax: 00000000   ebx: cfe92a0c   ecx: cfe8b224   edx: 00000000
esi: cfe92a08   edi: cfe92e08   ebp: cffc1ec0   esp: cffc1e9c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=cffc0000 task=c127aa50)
Stack: 00000000 00000010 cffc1eb8 c023b56b cfff2a40 000000d0 cfe92a08 cfe92a08
       cfe92e08 cffc1ee0 c01ab998 cfe92a08 00000000 cfe92a0c cffc1ed8 00000000
       00000000 cffc1ef4 c022035f cfe92a08 cfe92a08 fffffffe cffc1f0c c02205db
Call Trace:
 [<c010418b>] show_stack+0xab/0xf0
 [<c010437f>] show_registers+0x18f/0x230
 [<c01045bd>] die+0xed/0x190
 [<c032731a>] do_page_fault+0x33a/0x670
 [<c0103df7>] error_code+0x4f/0x54
 [<c01ab998>] sysfs_create_dir+0x38/0x80
 [<c022035f>] create_dir+0x1f/0x60
 [<c02205db>] kobject_add+0x8b/0xf0
 [<c0220668>] kobject_register+0x28/0x80
 [<c0255e33>] acpi_device_register+0x105/0x11b
 [<c0256b8e>] acpi_add_single_object+0xf6/0x146
 [<c0256cee>] acpi_bus_scan+0x110/0x17b
 [<c03d6297>] acpi_scan_init+0x6b/0x89
 [<c03be9e7>] do_initcalls+0x57/0xd0
 [<c03bea85>] do_basic_setup+0x25/0x30
 [<c01002e5>] init+0x35/0x170
 [<c01013e5>] kernel_thread_helper+0x5/0x10
Code: 37 c0 89 e5 8b 45 08 89 88 8c 00 00 00 31 c0 5d c3 8d 74 26 00 8d bc 27 00 00 00 00 55 89 e5 57 56 53 83 ec 18 8b 45 0c 8b 5d 10 <8b> 50 08 ff 4a 70 0f 88 8c 0e 00 00 31 c0 b9 ff ff ff ff 89 df
 <0>Kernel panic - not syncing: Attempted to kill init!


I'm still looking into this, to see who can't handle the -ENOMEM.

-- Steve

Index: linux-2.6.15-rc2-git2/fs/sysfs/dir.c
===================================================================
--- linux-2.6.15-rc2-git2.orig/fs/sysfs/dir.c	2005-10-27 20:02:08.000000000 -0400
+++ linux-2.6.15-rc2-git2/fs/sysfs/dir.c	2005-11-23 08:04:42.000000000 -0500
@@ -98,13 +98,17 @@
 {
 	int error;
 	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
+	static int breakme = 0;
 
 	down(&p->d_inode->i_sem);
 	*d = lookup_one_len(n, p, strlen(n));
 	if (!IS_ERR(*d)) {
 		error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
 		if (!error) {
-			error = sysfs_create(*d, mode, init_dir);
+			if ((++breakme % 30)) 
+				error = sysfs_create(*d, mode, init_dir);
+			else
+				error = -ENOMEM;
 			if (!error) {
 				p->d_inode->i_nlink++;
 				(*d)->d_op = &sysfs_dentry_ops;



