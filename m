Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265317AbUFTVuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUFTVuI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUFTVuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:50:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:23770 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265317AbUFTVuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:50:02 -0400
Date: Sun, 20 Jun 2004 14:49:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tom Vier <tmv@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7: preempt + sysfs = BUG on ppc
Message-Id: <20040620144906.095a4f93.akpm@osdl.org>
In-Reply-To: <20040620153922.GA20103@zero>
References: <20040620153922.GA20103@zero>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier <tmv@comcast.net> wrote:
>
> i forgot to exclude /sys when i ran rsync. this is easily reproducable.
> 
>  kernel BUG in fill_read_buffer at fs/sysfs/file.c:92!

Please add this patch, then retest:

--- 25/fs/sysfs/file.c~sysfs-overflow-debug	2004-06-20 14:44:44.272707136 -0700
+++ 25-akpm/fs/sysfs/file.c	2004-06-20 14:48:23.580367304 -0700
@@ -5,6 +5,8 @@
 #include <linux/module.h>
 #include <linux/dnotify.h>
 #include <linux/kobject.h>
+#include <linux/kallsyms.h>
+
 #include <asm/uaccess.h>
 
 #include "sysfs.h"
@@ -83,7 +85,13 @@ static int fill_read_buffer(struct file 
 		return -ENOMEM;
 
 	count = ops->show(kobj,attr,buffer->page);
-	BUG_ON(count > PAGE_SIZE);
+	if (count > PAGE_SIZE) {
+		printk("%s: show handler overrun\n", __FUNCTION__);
+		printk("->show handler: 0x%p",  ops->show);
+		print_symbol(" (%s)", (unsigned long)ops->show);
+		printk("\n");
+		BUG();
+	}
 	if (count >= 0)
 		buffer->count = count;
 	else
_

