Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281252AbRKPSjH>; Fri, 16 Nov 2001 13:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKPSi7>; Fri, 16 Nov 2001 13:38:59 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:46073 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281475AbRKPSin>; Fri, 16 Nov 2001 13:38:43 -0500
Date: Fri, 16 Nov 2001 18:38:37 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: Re: Bug in ext3
Message-ID: <20011116183837.D6626@redhat.com>
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no> <20011115170628.J329@visi.net> <20011115162149.U5739@lynx.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011115162149.U5739@lynx.no>; from adilger@turbolabs.com on Thu, Nov 15, 2001 at 04:21:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Nov 15, 2001 at 04:21:49PM -0700, Andreas Dilger wrote:

> I don't disagree that something corrupted it, but it is hard to tell from
> here what it could be.  Looking at ext3_read_super(), it is pretty much
> a read-only path, except journal recovery.  If, for some reason, you had
> an old, unrecovered ext3 journal in the fs, it is possible that recovering
> from it would corrupt your fs by writing old data into the fs.

Except that can only happen once we have found a journal to recover,
and the error that ext3 spat out indicated that it couldn't find a
journal at all and was giving up.

> Looking at the ext3_read_super() path, we call ext3_load_journal(),
> which calls journal_wipe() and journal_load(), which both call
> journal_load()->load_superblock()->journal_get_superblock(), which
> gives us the two "JBD: no valid journal superblock found" messages,
> and return errors before doing anything else.  Then we get the message
> "EXT3-fs: error loading journal." and return without mounting the fs.

Indeed.

> Hmm, there is a possibility that journal_destroy() calling
> journal_update_superblock() scribbling data into the first block of
> the old "journal".  Stephen, Andrew, we need to exit from the
> journal_get_superblock() with j_sb_buffer = NULL, and then check for
> this in journal_destroy() so we don't call journal_update_superblock().
> How does the below patch look?

Looks OK.  I've done a slightly better version which catches a couple
of extra cases but it's basically the same solution.  I've also added
a tiny patch to prevent a failed journal_wipe() from being followed by
a journal_load() attempt, so we don't get the same error twice.

Patch below.

Cheers,
 Stephen

--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext3-bad-super.diff"

Index: fs/ext3/super.c
===================================================================
RCS file: /cvsroot/gkernel/ext3/fs/ext3/super.c,v
retrieving revision 1.34.2.11
diff -u -r1.34.2.11 super.c
--- fs/ext3/super.c	2001/10/27 03:34:03	1.34.2.11
+++ fs/ext3/super.c	2001/11/16 18:30:39
@@ -1350,7 +1350,7 @@
 	journal_t *journal;
 	int journal_inum = le32_to_cpu(es->s_journal_inum);
 	int journal_dev = le32_to_cpu(es->s_journal_dev);
-	int err;
+	int err = 0;
 	int really_read_only;
 
 	really_read_only = is_read_only(sb->s_dev);
@@ -1400,9 +1400,10 @@
 	}
 
 	if (!EXT3_HAS_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER))
-		journal_wipe(journal, !really_read_only);
+		err = journal_wipe(journal, !really_read_only);
+	if (!err)
+		err = journal_load(journal);
 
-	err = journal_load(journal);
 	if (err) {
 		printk(KERN_ERR "EXT3-fs: error loading journal.\n");
 		journal_destroy(journal);
Index: fs/jbd/journal.c
===================================================================
RCS file: /cvsroot/gkernel/ext3/fs/jbd/journal.c,v
retrieving revision 1.49.2.6
diff -u -r1.49.2.6 journal.c
--- fs/jbd/journal.c	2001/11/16 14:45:21	1.49.2.6
+++ fs/jbd/journal.c	2001/11/16 18:30:42
@@ -773,6 +773,18 @@
 	return journal;
 }
 
+/* 
+ * If the journal init or create aborts, we need to mark the journal
+ * superblock as being NULL to prevent the journal destroy from writing
+ * back a bogus superblock. 
+ */
+static void journal_fail_superblock (journal_t *journal)
+{
+	struct buffer_head *bh = journal->j_sb_buffer;
+	brelse(bh);
+	journal->j_sb_buffer = NULL;
+}
+
 /*
  * Given a journal_t structure, initialise the various fields for
  * startup of a new journaling session.  We use this both when creating
@@ -826,6 +838,7 @@
 	if (journal->j_maxlen < JFS_MIN_JOURNAL_BLOCKS) {
 		printk (KERN_ERR "Journal length (%d blocks) too short.\n",
 			journal->j_maxlen);
+		journal_fail_superblock(journal);
 		return -EINVAL;
 	}
 
@@ -916,7 +929,8 @@
 {
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
-
+	int err = -EIO;
+	
 	bh = journal->j_sb_buffer;
 
 	J_ASSERT(bh != NULL);
@@ -926,16 +940,18 @@
 		if (!buffer_uptodate(bh)) {
 			printk (KERN_ERR
 				"JBD: IO error reading journal superblock\n");
-			return -EIO;
+			goto out;
 		}
 	}
 
 	sb = journal->j_superblock;
 
+	err = -EINVAL;
+	
 	if (sb->s_header.h_magic != htonl(JFS_MAGIC_NUMBER) ||
 	    sb->s_blocksize != htonl(journal->j_blocksize)) {
 		printk(KERN_WARNING "JBD: no valid journal superblock found\n");
-		return -EINVAL;
+		goto out;
 	}
 
 	switch(ntohl(sb->s_header.h_blocktype)) {
@@ -947,17 +963,21 @@
 		break;
 	default:
 		printk(KERN_WARNING "JBD: unrecognised superblock format ID\n");
-		return -EINVAL;
+		goto out;
 	}
 
 	if (ntohl(sb->s_maxlen) < journal->j_maxlen)
 		journal->j_maxlen = ntohl(sb->s_maxlen);
 	else if (ntohl(sb->s_maxlen) > journal->j_maxlen) {
 		printk (KERN_WARNING "JBD: journal file too short\n");
-		return -EINVAL;
+		goto out;
 	}
 
 	return 0;
+
+out:
+	journal_fail_superblock(journal);
+	return err;
 }
 
 /*
@@ -1062,7 +1082,10 @@
 	/* We can now mark the journal as empty. */
 	journal->j_tail = 0;
 	journal->j_tail_sequence = ++journal->j_transaction_sequence;
-	journal_update_superblock(journal, 1);
+	if (journal->j_sb_buffer) {
+		journal_update_superblock(journal, 1);
+		brelse(journal->j_sb_buffer);
+	}
 
 	if (journal->j_inode)
 		iput(journal->j_inode);
@@ -1070,7 +1093,6 @@
 		journal_destroy_revoke(journal);
 
 	unlock_journal(journal);
-	brelse(journal->j_sb_buffer);
 	kfree(journal);
 	MOD_DEC_USE_COUNT;
 }

--IiVenqGWf+H9Y6IX--
