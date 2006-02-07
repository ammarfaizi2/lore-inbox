Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWBGXXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWBGXXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWBGXXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:23:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030254AbWBGXXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:23:10 -0500
Date: Tue, 7 Feb 2006 15:24:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: William Heimbigner <icxcnika@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Oops: 0002 [#1] ("Unable to handle kernel NULL pointer
 dereference at virtual address 00000040")
Message-Id: <20060207152436.3f240ab6.akpm@osdl.org>
In-Reply-To: <43E798C5.2030803@hotpop.com>
References: <43E798C5.2030803@hotpop.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Heimbigner <icxcnika@hotpop.com> wrote:
>
> [   57.739172] Unable to handle kernel NULL pointer dereference at virtual address 00000040
> [   57.739179]  printing eip:
> [   57.739182] c0328c6d
> [   57.739183] *pde = 00000000
> [   57.739186] Oops: 0002 [#1]
> [   57.742859] PREEMPT 
> [   57.746490] Modules linked in: ohci_hcd 8139cp intelfb
> [   57.750079] CPU:    0
> [   57.750080] EIP:    0060:[<c0328c6d>]    Not tainted VLI
> [   57.750082] EFLAGS: 00010292   (2.6.15-gentoo-r1_icxcnika) 
> [   57.760267] EIP is at parport_claim_or_block+0xb/0x65
> [   57.763733] eax: 00000000   ebx: 00000000   ecx: 00000000   edx: fffffff0
> [   57.767305] esi: df70777c   edi: c15de280   ebp: c03129df   esp: de111ea8
> [   57.770985] ds: 007b   es: 007b   ss: 0068
> [   57.774660] Process parallel (pid: 9137, threadinfo=de110000 task=df667030)
> [   57.774896] Stack: de111ed8 00000000 c0312a31 00000000 de110000 c15de280 dfc5c500 00000000 
> [   57.778866]        c016c50e df70777c c15de280 de111ed8 00000000 c15de280 df70777c c016c42a 
> [   57.782976]        00000001 c016224f df70777c c15de280 c15de280 de111f38 00000000 de110000 
> [   57.787156] Call Trace:
> [   57.795368]  [<c0312a31>] tipar_open+0x52/0x9a
> [   57.799666]  [<c016c50e>] chrdev_open+0xe4/0x1c5
> [   57.804032]  [<c016c42a>] chrdev_open+0x0/0x1c5
> [   57.808368]  [<c016224f>] __dentry_open+0xdc/0x21d
> [   57.812737]  [<c01624a8>] nameidata_to_filp+0x3a/0x50

OK, that driver needs help.

Could you please add the below patch which should prevent the oopses and
then send us the full output of `dmesg -s 1000000'?



diff -puN drivers/char/tipar.c~tipar-fixes drivers/char/tipar.c
--- 25/drivers/char/tipar.c~tipar-fixes	Tue Feb  7 15:20:19 2006
+++ 25-akpm/drivers/char/tipar.c	Tue Feb  7 15:22:41 2006
@@ -256,6 +256,11 @@ tipar_open(struct inode *inode, struct f
 	if (test_and_set_bit(minor, &opened))
 		return -EBUSY;
 
+	if (!table[minor].dev) {
+		printk(KERN_ERR "%s: NULL device for minor %u\n",
+				__FUNCTION__, minor);
+		return -ENXIO;
+	}
 	parport_claim_or_block(table[minor].dev);
 	init_ti_parallel(minor);
 	parport_release(table[minor].dev);
@@ -510,16 +515,20 @@ tipar_init_module(void)
 		err = PTR_ERR(tipar_class);
 		goto out_chrdev;
 	}
-	if (parport_register_driver(&tipar_driver)) {
+	if (parport_register_driver(&tipar_driver) || tp_count == 0) {
 		printk(KERN_ERR "tipar: unable to register with parport\n");
 		err = -EIO;
-		goto out;
+		goto out_class;
 	}
 
 	err = 0;
 	goto out;
 
+out_class:
+	class_destroy(tipar_class);
+
 out_chrdev:
+	devfs_remove("ticables/par");
 	unregister_chrdev(TIPAR_MAJOR, "tipar");
 out:
 	return err;	
_

