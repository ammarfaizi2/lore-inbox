Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318266AbSHKKR2>; Sun, 11 Aug 2002 06:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSHKKR2>; Sun, 11 Aug 2002 06:17:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36109 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318266AbSHKKRW>;
	Sun, 11 Aug 2002 06:17:22 -0400
Message-ID: <3D563CE3.12BCBA99@zip.com.au>
Date: Sun, 11 Aug 2002 03:30:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vincent Bernat <bernat@free.fr>
CC: lkml <linux-kernel@vger.kernel.org>, noflushd-devel@lists.sourceforge.net,
       sct@redhat.com
Subject: Re: [patch 4/12] tunable ext3 commit interval
References: <3D5464CF.DCD510D6@zip.com.au> <m3u1m1itv9.fsf@neo.loria>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Bernat wrote:
> 
> OoO En cette nuit striée d'éclairs du samedi 10 août 2002, vers 02:56,
> Andrew Morton <akpm@zip.com.au> disait:
> 
> > The patch from Stephen Tweedie allows users to modify the journal
> > commit interval for the ext3 filesystem.
> 
> Could this patch be officially backported to 2.4 to allow the use of
> the flexible commit interval in noflushd ?

It's in the 2.4 devel tree, so it will appear in 2.4.20-pre sometime.



-------- Original Message --------
Subject: [gkernel-commit] CVS: ext3/fs/ext3 super.c,1.34.2.21,1.34.2.22
Date: Mon, 29 Jul 2002 14:31:41 -0700
From: "Stephen C. Tweedie" <sct@users.sourceforge.net>
To: gkernel-commit@lists.sourceforge.net

Update of /cvsroot/gkernel/ext3/fs/ext3
In directory usw-pr-cvs1:/tmp/cvs-serv7665

Modified Files:
      Tag: ext3-1_0-branch
	super.c 
Log Message:
Allow an arbitrary commit interval to be set when mounting or remounting
a filesystem.

Note that if this is greater than the system bdflush interval, then the
regular sync()s will beat the commit timer and you won't get longer
commit timeouts.


Index: super.c
===================================================================
RCS file: /cvsroot/gkernel/ext3/fs/ext3/super.c,v
retrieving revision 1.34.2.21
retrieving revision 1.34.2.22
diff -u -r1.34.2.21 -r1.34.2.22
--- super.c	15 Apr 2002 20:34:54 -0000	1.34.2.21
+++ super.c	29 Jul 2002 21:31:38 -0000	1.34.2.22
@@ -646,6 +646,11 @@
 				*mount_options &= ~EXT3_MOUNT_DATA_FLAGS;
 				*mount_options |= data_opt;
 			}
+		} else if (!strcmp (this_char, "commit")) {
+			unsigned long v;
+			if (want_numeric(value, "commit", &v))
+				return 0;
+			sbi->s_commit_interval = (HZ * v);
 		} else {
 			printk (KERN_ERR 
 				"EXT3-fs: Unrecognized mount option %s\n",
@@ -1229,6 +1234,22 @@
 	return NULL;
 }
 
+/*
+ * Setup any per-fs journal parameters now.  We'll do this both on
+ * initial mount, once the journal has been initialised but before we've
+ * done any recovery; and again on any subsequent remount. 
+ */
+static void ext3_init_journal_params(struct ext3_sb_info *sbi, 
+				     journal_t *journal)
+{
+	if (sbi->s_commit_interval)
+		journal->j_commit_interval = sbi->s_commit_interval;
+	/* We could also set up an ext3-specific default for the commit
+	 * interval here, but for now we'll just fall back to the jbd
+	 * default. */
+}
+
+
 static journal_t *ext3_get_journal(struct super_block *sb, int journal_inum)
 {
 	struct inode *journal_inode;
@@ -1263,7 +1284,7 @@
 		printk(KERN_ERR "EXT3-fs: Could not load journal inode\n");
 		iput(journal_inode);
 	}
-	
+	ext3_init_journal_params(EXT3_SB(sb), journal);
 	return journal;
 }
 
@@ -1341,6 +1362,7 @@
 		goto out_journal;
 	}
 	EXT3_SB(sb)->journal_bdev = bdev;
+	ext3_init_journal_params(EXT3_SB(sb), journal);
 	return journal;
 out_journal:
 	journal_destroy(journal);
@@ -1638,6 +1660,8 @@
 
 	es = sbi->s_es;
 
+	ext3_init_journal_params(sbi, sbi->s_journal);
+	
 	if ((*flags & MS_RDONLY) != (sb->s_flags & MS_RDONLY)) {
 		if (sbi->s_mount_opt & EXT3_MOUNT_ABORT)
 			return -EROFS;



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
_______________________________________________
Gkernel-commit mailing list
Gkernel-commit@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/gkernel-commit
