Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVF0H4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVF0H4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVF0H4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:56:54 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:48809 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261912AbVF0H4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:56:50 -0400
Date: Mon, 27 Jun 2005 16:56:45 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, sekharan@us.ibm.com,
       frankeh@us.ibm.com, nagar@us.ibm.com, vivk@us.ibm.com, gh@us.ibm.com,
       nacc@us.ibm.com
Subject: Re: [ckrm-tech] [patch 04/38] CKRM e18: Resource Control File
 System (rcfs)
In-Reply-To: <20050623061754.815239000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
	<20050623061754.815239000@w-gerrit.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050627075648.F39E07002C@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 22 Jun 2005 23:15:56 -0700
Gerrit Huizenga <gh@us.ibm.com> wrote:

> Index: linux-2.6.12-ckrm1/fs/rcfs/magic.c

> +static ssize_t
> +magic_write(struct file *file, const char __user *buf,
> +			   size_t count, loff_t *ppos)
> +{
> +	struct rcfs_inode_info *ri =
> +		rcfs_get_inode_info(file->f_dentry->d_parent->d_inode);

> +	done = magic_parse(ri->mfdentry->d_name.name,
> +			optbuf, &resname, &otherstr);

I've got kernel oops (NULL pointer dereference) when writing 
"res=cpu,mode=enabled" to /rcfs/taskclass/config.  ri->mfdentry
has been NULL.
The 1st argument of magic_parse() should not be anything of 
the class directory but the name of the written file itself.

The following patch fixes the problem for me:

--- fs/rcfs/magic.c	2005/06/27 05:42:47	1.1
+++ fs/rcfs/magic.c	2005/06/27 07:23:57
@@ -181,23 +181,23 @@ magic_write(struct file *file, const cha
 	}
 	__copy_from_user(optbuf, buf, count);
 	mkvalidstr(optbuf);
-	done = magic_parse(ri->mfdentry->d_name.name,
+	done = magic_parse(file->f_dentry->d_name.name,
 			optbuf, &resname, &otherstr);
 	if (!done) {
 		printk(KERN_ERR "Error parsing data written to %s\n",
-				ri->mfdentry->d_name.name);
+				file->f_dentry->d_name.name);
 		goto out;
 	}
-	if (!strcmp(ri->mfdentry->d_name.name, RCFS_CONFIG_NAME)) {
+	if (!strcmp(file->f_dentry->d_name.name, RCFS_CONFIG_NAME)) {
 		func = core->classtype->set_config;
-	} else if (!strcmp(ri->mfdentry->d_name.name, RCFS_STATS_NAME)) {
+	} else if (!strcmp(file->f_dentry->d_name.name, RCFS_STATS_NAME)) {
 		func = core->classtype->reset_stats;
 	}
 	if (func) {
 		rc = func(core, resname, otherstr);
 		if (rc) {
-			printk(KERN_ERR "magic_write: %s: error\n",
-				ri->mfdentry->d_name.name);
+			printk(KERN_ERR "magic_write: %s: error %d\n",
+				file->f_dentry->d_name.name, rc);
 		}
 	}
 out:
