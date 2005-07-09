Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVGINgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVGINgi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 09:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVGINgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 09:36:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11667 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261384AbVGINgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 09:36:37 -0400
Date: Sat, 9 Jul 2005 15:36:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050709133625.GA6314@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709124105.GB4665@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709124105.GB4665@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (gdb) ####################################
> (gdb) # c0169503, stack size:  408 bytes #
> (gdb) ####################################
> (gdb) 0xc0169503 is in blkdev_get (fs/block_dev.c:663).

----
this patch reduces the stack footprint of blkdev_get() from 408 bytes to 
28 bytes. Build and boot-tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/fs/block_dev.c
===================================================================
--- linux.orig/fs/block_dev.c
+++ linux/fs/block_dev.c
@@ -667,14 +667,32 @@ int blkdev_get(struct block_device *bdev
 	 * For now, block device ->open() routine must _not_
 	 * examine anything in 'inode' argument except ->i_rdev.
 	 */
-	struct file fake_file = {};
-	struct dentry fake_dentry = {};
-	fake_file.f_mode = mode;
-	fake_file.f_flags = flags;
-	fake_file.f_dentry = &fake_dentry;
-	fake_dentry.d_inode = bdev->bd_inode;
-
-	return do_open(bdev, &fake_file);
+	struct file *fake_file;
+	struct dentry *fake_dentry;
+	int err = -ENOMEM;
+
+	fake_file = kmalloc(sizeof(*fake_file), GFP_KERNEL);
+	if (!fake_file)
+		goto out;
+	memset(fake_file, 0, sizeof(*fake_file));
+
+	fake_dentry = kmalloc(sizeof(*fake_dentry), GFP_KERNEL);
+	if (!fake_dentry)
+		goto out_free_file;
+	memset(fake_dentry, 0, sizeof(*fake_dentry));
+
+	fake_file->f_mode = mode;
+	fake_file->f_flags = flags;
+	fake_file->f_dentry = fake_dentry;
+	fake_dentry->d_inode = bdev->bd_inode;
+
+	err = do_open(bdev, fake_file);
+
+	kfree(fake_dentry);
+out_free_file:
+	kfree(fake_file);
+out:
+	return err;
 }
 
 EXPORT_SYMBOL(blkdev_get);
