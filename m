Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbULCWsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbULCWsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbULCWru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:47:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:19143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262457AbULCWr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:47:26 -0500
Date: Fri, 3 Dec 2004 14:51:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: franz_pletz@t-online.de, axboe@suse.de, linux-kernel@vger.kernel.org,
       ludoschmidt@web.de
Subject: Re: [PATCH] loopback device can't act as its backing store
Message-Id: <20041203145140.002e338f.akpm@osdl.org>
In-Reply-To: <20041203145056.541308d1.akpm@osdl.org>
References: <Pine.LNX.4.61.0412032028220.10184@sgx.home>
	<20041203145056.541308d1.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Andries posted such a patch



Begin forwarded message:

Date: Sun, 14 Nov 2004 23:31:21 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
To: akpm@osdl.org, lkml@happyjack.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH?] prevent loop infinite recursion


After "losetup /dev/loop0 /dev/loop0" I see a hard crash upon
access of /dev/loop0. And of course the same happens after
"losetup /dev/loop0 /dev/loop1; "losetup /dev/loop1 /dev/loop0"

Chris Spiegel reports a slightly different crash doing similar things.

The easiest fix is saying "don't do that then".

The patch below adds a (somewhat ugly) test for recursion.
Maybe someone can think of a nicer version.

Andries

diff -uprN -X /linux/dontdiff a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	2004-08-26 22:05:15.000000000 +0200
+++ b/drivers/block/loop.c	2004-11-14 22:43:31.000000000 +0100
@@ -622,10 +622,17 @@ static int loop_change_fd(struct loop_de
 	return error;
 }
 
+static inline int is_loop_device(struct file *file)
+{
+	struct inode *i = file->f_mapping->host;
+
+	return i && S_ISBLK(i->i_mode) && MAJOR(i->i_rdev) == LOOP_MAJOR;
+}
+
 static int loop_set_fd(struct loop_device *lo, struct file *lo_file,
 		       struct block_device *bdev, unsigned int arg)
 {
-	struct file	*file;
+	struct file	*file, *f;
 	struct inode	*inode;
 	struct address_space *mapping;
 	unsigned lo_blocksize;
@@ -636,15 +643,28 @@ static int loop_set_fd(struct loop_devic
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	error = -EBUSY;
-	if (lo->lo_state != Lo_unbound)
-		goto out;
-
 	error = -EBADF;
 	file = fget(arg);
 	if (!file)
 		goto out;
 
+	error = -EBUSY;
+	if (lo->lo_state != Lo_unbound)
+		goto out_putf;
+
+	/* Avoid recursion */
+	f = file;
+	while (is_loop_device(f)) {
+		struct loop_device *l;
+
+		if (f->f_mapping->host == lo_file->f_mapping->host)
+			goto out_putf;
+		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
+		if (l->lo_state == Lo_unbound)
+			break;
+		f = l->lo_backing_file;
+	}
+
 	mapping = file->f_mapping;
 	inode = mapping->host;
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
