Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbTANWqx>; Tue, 14 Jan 2003 17:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbTANWqx>; Tue, 14 Jan 2003 17:46:53 -0500
Received: from air-2.osdl.org ([65.172.181.6]:8407 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265098AbTANWqv>;
	Tue, 14 Jan 2003 17:46:51 -0500
Date: Tue, 14 Jan 2003 15:53:26 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: <Valdis.Kletnieks@vt.edu>
cc: <ivangurdiev@attbi.com>, LKML <linux-kernel@vger.kernel.org>,
       <James.Bottomley@steeleye.com>
Subject: Re: 2.5.58 Oops when booting from initrd - kobject_del 
In-Reply-To: <200301141807.h0EI7srO012993@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.33.0301141552130.1025-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Jan 2003 Valdis.Kletnieks@vt.edu wrote:

> On Tue, 14 Jan 2003 02:47:40 MST, "Ivan G." <ivangurdiev@attbi.com>  said:
> > Kernel: 2.5.58 (everything but the tag changeset)
> > 
> > My attempt to boot an initrd resulted in the following oops:
> > (scribbled down important parts)
> > =======================================================
> > unable to handle kernel NULL pointer at virtual address 00000064
> 
> > Call Trace:
> > ==========
> > kobject_del+0x13/0x30
> > kobject_unregister+0x13/0x30
> > elv_unregister_queue+0x1c/0x30
> > unlink_gendisk+0x13/0x40
> > del_gendisk+0x80/0x140
> > initrd_release+0x4e/0x90
> > __fput+0xf1/0x100
> > filp_close+0x74/0xa0
> > sys_close+0x62/0xa0
> > syscall_call+0x7/0xb
> > prepare_namespace+0x13a/0x1b0
> > init+0x3a/0x160
> > init+0x0/0x160
> > kernel_thread_helper+0x5/0x18
> > ...
> > Code: 8b 70 28 85 f6 0f 84 1e 01 00 00 8b 06 85 c0 75 08 0f 0b 02

Could you please try the following patch and see if it fixes the problem?

Thanks,

	-pat

===== drivers/block/elevator.c 1.36 vs edited =====
--- 1.36/drivers/block/elevator.c	Sun Jan 12 08:10:40 2003
+++ edited/drivers/block/elevator.c	Tue Jan 14 15:46:00 2003
@@ -431,10 +431,13 @@
 void elv_unregister_queue(struct gendisk *disk)
 {
 	request_queue_t *q = disk->queue;
-	elevator_t *e = &q->elevator;
+	elevator_t *e;
 
-	kobject_unregister(&e->kobj);
-	kobject_put(&disk->kobj);
+	if (q) {
+		e = &q->elevator;
+		kobject_unregister(&e->kobj);
+		kobject_put(&disk->kobj);
+	}
 }
 
 elevator_t elevator_noop = {


