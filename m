Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTK3UGU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 15:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTK3UGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 15:06:20 -0500
Received: from holomorphy.com ([199.26.172.102]:45767 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263057AbTK3UGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 15:06:18 -0500
Date: Sun, 30 Nov 2003 12:06:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: James W McMechan <mcmechanjw@juno.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031130200615.GG19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James W McMechan <mcmechanjw@juno.com>,
	linux-kernel@vger.kernel.org
References: <20031130.093449.-1591395.2.mcmechanjw@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130.093449.-1591395.2.mcmechanjw@juno.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Please post the oops (run through ksymoops as-needed).

On Sun, Nov 30, 2003 at 09:34:44AM -0800, James W McMechan wrote:
> I still think the one line test program was easier...
> I hope this helps

Could you try 2.6 with the following patch and send in the resulting
oops/BUG? Please turn on kallsyms for the run.


Thanks.


-- wli


--- fs/libfs.c.orig	2003-11-30 12:02:09.000000000 -0800
+++ fs/libfs.c	2003-11-30 12:04:36.000000000 -0800
@@ -60,6 +60,9 @@
 
 loff_t dcache_dir_lseek(struct file *file, loff_t offset, int origin)
 {
+	BUG_ON(!file);
+	BUG_ON(!file->f_dentry);
+	BUG_ON(!file->f_dentry->d_inode);
 	down(&file->f_dentry->d_inode->i_sem);
 	switch (origin) {
 		case 1:
@@ -83,10 +86,12 @@
 			while (n && p != &file->f_dentry->d_subdirs) {
 				struct dentry *next;
 				next = list_entry(p, struct dentry, d_child);
+				BUG_ON(!next);
 				if (!d_unhashed(next) && next->d_inode)
 					n--;
 				p = p->next;
 			}
+			BUG_ON(!cursor);
 			list_del(&cursor->d_child);
 			list_add_tail(&cursor->d_child, p);
 			spin_unlock(&dcache_lock);
