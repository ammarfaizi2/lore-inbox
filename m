Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281169AbRKOXXV>; Thu, 15 Nov 2001 18:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281171AbRKOXXM>; Thu, 15 Nov 2001 18:23:12 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:54512 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281169AbRKOXXG>;
	Thu, 15 Nov 2001 18:23:06 -0500
Date: Thu, 15 Nov 2001 16:21:49 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115162149.U5739@lynx.no>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no> <20011115170628.J329@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011115170628.J329@visi.net>; from bcollins@debian.org on Thu, Nov 15, 2001 at 05:06:28PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  17:06 -0500, Ben Collins wrote:
> On Thu, Nov 15, 2001 at 02:58:03PM -0700, Andreas Dilger wrote:
> > Please run e2fsck (1.25) to clear this up.  It may be that you have other
> > corruption in your filesystem.  If you are sure you _never_ tried ext3
> > on this filesystem before, yet the has_journal bit is set, this could
> > be an indication of memory or cable problems.
> 
> Uh, something corrupted it. Believe me, there is no other corruption.
> I've reverted to a non-ext3 kernel, and after a day of serious IO, no
> problems have shown. So something is wrong, and it isn't my filesystem
> (the erroneous flag needs to be cleared, yes, but the fact remains that
> there is a problem in this case).

I don't disagree that something corrupted it, but it is hard to tell from
here what it could be.  Looking at ext3_read_super(), it is pretty much
a read-only path, except journal recovery.  If, for some reason, you had
an old, unrecovered ext3 journal in the fs, it is possible that recovering
from it would corrupt your fs by writing old data into the fs.

This _shouldn't_ happen with newer kernels, but with old 2.2 ext3 code
this was a possibility.  Also, with old e2fsck code (1.18 was right at the
very beginning when ext3 support was being added) it is possible that it
didn't fail because of the has_journal flag, but it wasn't smart enough
to detect and remove an old corrupt journal.  I'm not saying this is a
likely scenario either, but we don't have much to go on.

Are you _absolutely_ sure that there was never any ext3 testing done a
long time ago on this fs?  Looking at it closer, it seems unlikely that
random corruption could cause something like the above scenario, because
there are many checks before we get to journal recovery.

Looking at the ext3_read_super() path, we call ext3_load_journal(),
which calls journal_wipe() and journal_load(), which both call
journal_load()->load_superblock()->journal_get_superblock(), which
gives us the two "JBD: no valid journal superblock found" messages,
and return errors before doing anything else.  Then we get the message
"EXT3-fs: error loading journal." and return without mounting the fs.

Hmm, there is a possibility that journal_destroy() calling
journal_update_superblock() scribbling data into the first block of
the old "journal".  Stephen, Andrew, we need to exit from the
journal_get_superblock() with j_sb_buffer = NULL, and then check for
this in journal_destroy() so we don't call journal_update_superblock().
How does the below patch look?

Ben, unfortunately, the dumpe2fs 1.18 output doesn't show the journal
fields.  When you upgrade to e2fsprogs 1.25, can you run dumpe2fs -h <dev>
again and send the output, so we can see what is all set?  It appears
that at least the "has_journal" flag and a s_journal_inum are set for it
to get as far as it did.  The new e2fsck will clean that up properly.

Cheers, Andreas
=========================================================================
--- ext3/fs/jbd/journal.c	Thu Nov  1 00:47:55 2001
+++ linux/fs/jbd/journal.c	Thu Nov 15 16:09:46 2001
@@ -900,7 +900,7 @@
 	if (sb->s_header.h_magic != htonl(JFS_MAGIC_NUMBER) ||
 	    sb->s_blocksize != htonl(journal->j_blocksize)) {
 		printk(KERN_WARNING "JBD: no valid journal superblock found\n");
-		return -EINVAL;
+		goto error;
 	}
 
 	switch(ntohl(sb->s_header.h_blocktype)) {
@@ -912,17 +912,22 @@
 		break;
 	default:
 		printk(KERN_WARNING "JBD: unrecognised superblock format ID\n");
-		return -EINVAL;
+		goto error;
 	}
 
 	if (ntohl(sb->s_maxlen) < journal->j_maxlen)
 		journal->j_maxlen = ntohl(sb->s_maxlen);
 	else if (ntohl(sb->s_maxlen) > journal->j_maxlen) {
 		printk (KERN_WARNING "JBD: journal file too short\n");
-		return -EINVAL;
+		goto error;
 	}
 
 	return 0;
+
+error:
+	brelse(bh);
+	journal->j_sb_buffer = NULL;
+	return -EINVAL;
 }
 
 /*
@@ -1027,7 +1032,8 @@
 	/* We can now mark the journal as empty. */
 	journal->j_tail = 0;
 	journal->j_tail_sequence = ++journal->j_transaction_sequence;
-	journal_update_superblock(journal, 1);
+	if (journal->j_sb_buffer)
+		journal_update_superblock(journal, 1);
 
 	if (journal->j_inode)
 		iput(journal->j_inode);
@@ -1716,7 +1710,6 @@
 	journal_destroy_caches();
 }
 
+MODULE_LICENSE("GPL");
 module_init(journal_init);
 module_exit(journal_exit);
 
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

