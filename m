Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVCPGe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVCPGe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 01:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVCPGe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 01:34:27 -0500
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:54455 "EHLO
	inet-tsb5.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S262533AbVCPGcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 01:32:46 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: tty->driver_data is NULL
Date: Wed, 16 Mar 2005 15:29:56 +0900
Message-ID: <BF571719A4041A478005EF3F08EA6DF0C678A3@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Thread-Topic: [PATCH][2/2] SquashFS
Thread-Index: AcUpxOxoLvnaOQ3OTaGVXxTXxm7/vwAKeI7g
From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
To: <linux-kernel@vger.kernel.org>
Cc: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I obtained following oops. 

Modules Linked in: parport_pc lp parport autofs4 i2c_dev i2c_core xxxnrpc dm_mod
button battery ac md5 ipv6 uhci_hcd ehci_hcd e1000 floppy ext3 jbd ata_piix liba
ta sd_mod scsi_mod
CPU:	0
EIP:	0060:[<021f39cd>]	Not tainted VLI
EFLAGS:	00010216	(2.6.9-5.0.3.ELhugeme)
EIP is at vt_ioctl+0x1d/0x17b7
eax: 00000000 ebx: 00004b3b ecx: 00004b3b edx: 02dcea80
esi: feed6f60 edi: feed6f60 ebp: 11145000 esp: 08b0fe88
ds: 007b es: 007b ss: 0068
Process gpm (pid: 2190, threadinfo=08b0f000 task=0813ab30)
Stack:  00000001 00000000 11ed3e80 11949344 00000000 00000000 00000000 00000000
	00000000 00000000 00000000 00000000 11145000 00000000 00000000 00000000
	00000246 00000000 00000246 00000246 00005315 02120dbc 00000007 11145000
Call Trace:
[<02120dbc>] release_console_sem+0x75/0xa9
[<021fbe9c>] con_open+0x88/0x8e
[<021eecd0>] tty_open+0x189/0x2a0
[<0215c132>] chrdev_open+0x171/0x187
[<02154058>] dentry_open+0xf0/0x1a5
[<02153f62>] filp_open+0x36/0x3c
[<021efad4>] tty_ioctl+0x33e/0x38d
[<0216415a>] sys_ioctl+0x211/0x253
Code: Bad EIP value.

tty->driver_data is NULL.
The following patches were made. Is this patch correct?

diff -urN linux-2.6.11.3orig/drivers/char/vt_ioctl.c linux-2.6.11.3/drivers/char/vt_ioctl.c
--- linux-2.6.11.3orig/drivers/char/vt_ioctl.c	2005-03-13 15:44:51.000000000 +0900
+++ linux-2.6.11.3/drivers/char/vt_ioctl.c	2005-03-16 15:08:49.000000000 +0900
@@ -366,7 +366,7 @@
 	     unsigned int cmd, unsigned long arg)
 {
 	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
-	struct vc_data *vc = vc_cons[vt->vc_num].d;
+	struct vc_data *vc;
 	struct console_font_op op;	/* used in multiple places here */
 	struct kbd_struct * kbd;
 	unsigned int console;
@@ -374,7 +374,14 @@
 	void __user *up = (void __user *)arg;
 	int i, perm;
 	
+	acquire_console_sem();
+	if (vt == NULL) {
+		release_console_sem();
+		return -EINVAL;
+	}
+	vc = vc_cons[vt->vc_num].d;
 	console = vt->vc_num;
+	release_console_sem();
 
 	if (!vc_cons_allocated(console)) 	/* impossible? */
 		return -ENOIOCTLCMD;

--
Haruo
