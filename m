Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWBQHO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWBQHO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWBQHO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:14:27 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:17678 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S932570AbWBQHO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:14:26 -0500
Date: Fri, 17 Feb 2006 15:13:40 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] autofs4 - change AUTOFS_TYP_* AUTOFS_TYPE_*
Message-ID: <Pine.LNX.4.64.0602171509470.4069@eagle.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, forgot I wanted to do this change prior to submission.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.16-rc3-mm1/fs/autofs4/autofs_i.h.typ-to-type	2006-02-17 15:02:40.000000000 +0800
+++ linux-2.6.16-rc3-mm1/fs/autofs4/autofs_i.h	2006-02-17 15:04:05.000000000 +0800
@@ -91,9 +91,9 @@ struct autofs_wait_queue {
 
 #define AUTOFS_SBI_MAGIC 0x6d4a556d
 
-#define AUTOFS_TYP_INDIRECT     0x0001
-#define AUTOFS_TYP_DIRECT       0x0002
-#define AUTOFS_TYP_OFFSET       0x0004
+#define AUTOFS_TYPE_INDIRECT     0x0001
+#define AUTOFS_TYPE_DIRECT       0x0002
+#define AUTOFS_TYPE_OFFSET       0x0004
 
 struct autofs_sb_info {
 	u32 magic;
--- linux-2.6.16-rc3-mm1/fs/autofs4/inode.c.typ-to-type	2006-02-17 15:03:07.000000000 +0800
+++ linux-2.6.16-rc3-mm1/fs/autofs4/inode.c	2006-02-17 15:04:57.000000000 +0800
@@ -178,9 +178,9 @@ static int autofs4_show_options(struct s
 	seq_printf(m, ",minproto=%d", sbi->min_proto);
 	seq_printf(m, ",maxproto=%d", sbi->max_proto);
 
-	if (sbi->type & AUTOFS_TYP_OFFSET)
+	if (sbi->type & AUTOFS_TYPE_OFFSET)
 		seq_printf(m, ",offset");
-	else if (sbi->type & AUTOFS_TYP_DIRECT)
+	else if (sbi->type & AUTOFS_TYPE_DIRECT)
 		seq_printf(m, ",direct");
 	else
 		seq_printf(m, ",indirect");
@@ -267,13 +267,13 @@ static int parse_options(char *options, 
 			*maxproto = option;
 			break;
 		case Opt_indirect:
-			*type = AUTOFS_TYP_INDIRECT;
+			*type = AUTOFS_TYPE_INDIRECT;
 			break;
 		case Opt_direct:
-			*type = AUTOFS_TYP_DIRECT;
+			*type = AUTOFS_TYPE_DIRECT;
 			break;
 		case Opt_offset:
-			*type = AUTOFS_TYP_DIRECT | AUTOFS_TYP_OFFSET;
+			*type = AUTOFS_TYPE_DIRECT | AUTOFS_TYPE_OFFSET;
 			break;
 		default:
 			return 1;
@@ -364,7 +364,7 @@ int autofs4_fill_super(struct super_bloc
 	}
 
 	root_inode->i_fop = &autofs4_root_operations;
-	root_inode->i_op = sbi->type & AUTOFS_TYP_DIRECT ?
+	root_inode->i_op = sbi->type & AUTOFS_TYPE_DIRECT ?
 			&autofs4_direct_root_inode_operations :
 			&autofs4_indirect_root_inode_operations;
 
--- linux-2.6.16-rc3-mm1/fs/autofs4/waitq.c.typ-to-type	2006-02-17 15:03:25.000000000 +0800
+++ linux-2.6.16-rc3-mm1/fs/autofs4/waitq.c	2006-02-17 15:05:55.000000000 +0800
@@ -207,7 +207,7 @@ int autofs4_wait(struct autofs_sb_info *
 		return -ENOMEM;
 
 	/* If this is a direct mount request create a dummy name */
-	if (IS_ROOT(dentry) && (sbi->type & AUTOFS_TYP_DIRECT))
+	if (IS_ROOT(dentry) && (sbi->type & AUTOFS_TYPE_DIRECT))
 		len = sprintf(name, "%p", dentry);
 	else {
 		len = autofs4_getpath(sbi, dentry, &name);
@@ -283,11 +283,11 @@ int autofs4_wait(struct autofs_sb_info *
 				type = autofs_ptype_expire_multi;
 		} else {
 			if (notify == NFY_MOUNT)
-				type = (sbi->type & AUTOFS_TYP_DIRECT) ?
+				type = (sbi->type & AUTOFS_TYPE_DIRECT) ?
 					autofs_ptype_missing_direct :
 					 autofs_ptype_missing_indirect;
 			else
-				type = (sbi->type & AUTOFS_TYP_DIRECT) ?
+				type = (sbi->type & AUTOFS_TYPE_DIRECT) ?
 					autofs_ptype_expire_direct :
 					autofs_ptype_expire_indirect;
 		}
--- linux-2.6.16-rc3-mm1/fs/autofs4/expire.c.typ-to-type	2006-02-17 15:02:52.000000000 +0800
+++ linux-2.6.16-rc3-mm1/fs/autofs4/expire.c	2006-02-17 15:04:19.000000000 +0800
@@ -424,7 +424,7 @@ int autofs4_expire_multi(struct super_bl
 	if (arg && get_user(do_now, arg))
 		return -EFAULT;
 
-	if (sbi->type & AUTOFS_TYP_DIRECT)
+	if (sbi->type & AUTOFS_TYPE_DIRECT)
 		dentry = autofs4_expire_direct(sb, mnt, sbi, do_now);
 	else
 		dentry = autofs4_expire_indirect(sb, mnt, sbi, do_now);

