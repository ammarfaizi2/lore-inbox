Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbTBFVO3>; Thu, 6 Feb 2003 16:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbTBFVO2>; Thu, 6 Feb 2003 16:14:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:34767 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267388AbTBFVO1>;
	Thu, 6 Feb 2003 16:14:27 -0500
Date: Thu, 6 Feb 2003 13:23:46 -0800
From: Andrew Morton <akpm@digeo.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible partition corruption
Message-Id: <20030206132346.4b635676.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302061501510.998-100000@localhost.localdomain>
References: <20030206123631.617524f7.akpm@digeo.com>
	<Pine.LNX.4.44.0302061501510.998-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2003 21:23:58.0862 (UTC) FILETIME=[0FC7B2E0:01C2CE26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cox.net> wrote:
>
> > Everything you describe is consistent with a kernel which does not have ext3
> > compiled into it.
> ...
> I'm aware of that.

In that case you may be experiencing the mysterious vanishing
ext3_read_super-doesn't-work bug.  Usually a recompile/relink makes it go
away.  I haven't seen it in months.

Could you please drop this additional debugging in there and see
what happens?


 fs/ext3/super.c |   34 ++++++++++++++++++++++------------
 1 files changed, 22 insertions(+), 12 deletions(-)

diff -puN fs/ext3/super.c~efs fs/ext3/super.c
--- 25/fs/ext3/super.c~efs	Thu Feb  6 13:17:55 2003
+++ 25-akpm/fs/ext3/super.c	Thu Feb  6 13:21:16 2003
@@ -1017,12 +1017,16 @@ static int ext3_fill_super (struct super
 	int i;
 	int needs_recovery;
 
+	printk("%s: enter\n", __FUNCTION__);
+
 #ifdef CONFIG_JBD_DEBUG
 	ext3_ro_after = 0;
 #endif
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
-	if (!sbi)
+	if (!sbi) {
+		printk("no sbi\n");
 		return -ENOMEM;
+	}
 	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(*sbi));
 	sbi->s_mount_opt = 0;
@@ -1057,10 +1061,10 @@ static int ext3_fill_super (struct super
 	sbi->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
 	if (sb->s_magic != EXT3_SUPER_MAGIC) {
-		if (!silent)
-			printk(KERN_ERR 
-			       "VFS: Can't find ext3 filesystem on dev %s.\n",
-			       sb->s_id);
+		printk(KERN_ERR 
+		       "VFS: Can't find ext3 filesystem on dev %s.\n",
+		       sb->s_id);
+		printk("magic=0x%x\n", sb->s_magic);
 		goto failed_mount;
 	}
 	
@@ -1091,8 +1095,10 @@ static int ext3_fill_super (struct super
 	sbi->s_resuid = le16_to_cpu(es->s_def_resuid);
 	sbi->s_resgid = le16_to_cpu(es->s_def_resgid);
 
-	if (!parse_options ((char *) data, sbi, &journal_inum, 0))
+	if (!parse_options ((char *) data, sbi, &journal_inum, 0)) {
+		printk("option parsing failed\n");
 		goto failed_mount;
+	}
 
 	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
 		((sbi->s_mount_opt & EXT3_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
@@ -1276,16 +1282,19 @@ static int ext3_fill_super (struct super
 	 */
 	if (!test_opt(sb, NOLOAD) &&
 	    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL)) {
-		if (ext3_load_journal(sb, es))
+		if (ext3_load_journal(sb, es)) {
+			printk("journal loading failed\n");
 			goto failed_mount2;
+		}
 	} else if (journal_inum) {
-		if (ext3_create_journal(sb, es, journal_inum))
+		if (ext3_create_journal(sb, es, journal_inum)) {
+			printk("journal creation failed\n");
 			goto failed_mount2;
+		}
 	} else {
-		if (!silent)
-			printk (KERN_ERR
-				"ext3: No journal on filesystem on %s\n",
-				sb->s_id);
+		printk (KERN_ERR
+			"ext3: No journal on filesystem on %s\n",
+			sb->s_id);
 		goto failed_mount2;
 	}
 
@@ -1371,6 +1380,7 @@ failed_mount:
 out_fail:
 	sb->s_fs_info = NULL;
 	kfree(sbi);
+	printk("%s: failing\n", __FUNCTION__);
 	return -EINVAL;
 }
 

_

