Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269646AbUICL7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269646AbUICL7v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269645AbUICL7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:59:50 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:45992 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S269646AbUICL6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:58:48 -0400
Date: Fri, 3 Sep 2004 13:57:59 +0200 (DFT)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@isabelle.frec.bull.fr
To: Simon Derr <Simon.Derr@bull.net>
cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible race in sysfs_read_file() and sysfs_write_file()
In-Reply-To: <Pine.A41.4.53.0409031134040.122970@isabelle.frec.bull.fr>
Message-ID: <Pine.A41.4.53.0409031355200.122970@isabelle.frec.bull.fr>
References: <Pine.A41.4.53.0409010924250.122970@isabelle.frec.bull.fr>
 <20040901163436.263802bc.akpm@osdl.org> <Pine.A41.4.53.0409020917350.122970@isabelle.frec.bull.fr>
 <20040902155758.1eba30a5.akpm@osdl.org> <Pine.A41.4.53.0409031056280.122970@isabelle.frec.bull.fr>
 <Pine.A41.4.53.0409031134040.122970@isabelle.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Simon Derr wrote:

> Possible fix would be to add a 'dirty' flag to the sysfs_buffer when
> write() is called, so we force a call to fill_read_buffer() on the next
> read().

This additional patch does just that.
I'm just afraid the flag has not a very good name.

Signed-off-by: Simon Derr <simon.derr@bull.net>


Index: 269mm2kdb/fs/sysfs/file.c
===================================================================
--- 269mm2kdb.orig/fs/sysfs/file.c	2004-09-03 11:43:01.744675609 +0200
+++ 269mm2kdb/fs/sysfs/file.c	2004-09-03 11:56:06.993689427 +0200
@@ -55,6 +55,7 @@
 	char			* page;
 	struct sysfs_ops	* ops;
 	struct semaphore	sem;
+	int			needs_read_fill;
 };


@@ -82,6 +83,7 @@
 		return -ENOMEM;

 	count = ops->show(kobj,attr,buffer->page);
+	buffer->needs_read_fill = 0;
 	BUG_ON(count > (ssize_t)PAGE_SIZE);
 	if (count >= 0)
 		buffer->count = count;
@@ -146,7 +148,7 @@
 	ssize_t retval = 0;

 	down(&buffer->sem);
-	if ((!*ppos) || (!buffer->page)) {
+	if (buffer->needs_read_fill) {
 		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
 			goto out;
 	}
@@ -182,6 +184,7 @@
 	if (count >= PAGE_SIZE)
 		count = PAGE_SIZE - 1;
 	error = copy_from_user(buffer->page,buf,count);
+	buffer->needs_read_fill = 1;
 	return error ? -EFAULT : count;
 }

@@ -299,6 +302,7 @@
 	if (buffer) {
 		memset(buffer,0,sizeof(struct sysfs_buffer));
 		init_MUTEX(&buffer->sem);
+		buffer->needs_read_fill = 1;
 		buffer->ops = ops;
 		file->private_data = buffer;
 	} else
