Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276923AbRJCSMI>; Wed, 3 Oct 2001 14:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276936AbRJCSL6>; Wed, 3 Oct 2001 14:11:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11784 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S276923AbRJCSLm>; Wed, 3 Oct 2001 14:11:42 -0400
Date: Wed, 3 Oct 2001 20:11:51 +0200
From: Jan Kara <jack@suse.cz>
To: Paul Menage <pmenage@ensim.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.2.20: Avoid buffer overrun in quota warning
Message-ID: <20011003201151.B22147@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010914104657.E31478@atrey.karlin.mff.cuni.cz> <E15hugS-0006C4-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15hugS-0006C4-00@pmenage-dt.ensim.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> >  Actually that delayed printing of quota messages isn't even in regular
> >2.4 - it's just in ac-patches. Regular 2.4 has just print_warning()
> >function which works rather the same way as printing in 2.2.
> 
> Regular 2.4 prints bdevname(dquot->dq_sb->s_dev) rather than 
> dquot->dq_mnt->mnt_dirname, so is rather less likely to have the same
> sprintf() overrun problems.
  I've created patch for 2.2.18 kernel (applies well against 2.2.19 too) which
makes quota code print bdevname() rather that mountpoint and so avoids
possible overrun. Actually this overrun is possible only if root makes
mountpoint deep in directory structure so IMO there's no possibility for
exploit but anyway... Alan please apply the patch.

								Honza
--
Jan Kara <jack@suse.cz>
SuSE Labs

<cut>
----------------------------------------------------------------------
diff -ru -X /home/jack/.kerndiffexclude linux-2.2.18/fs/dquot.c linux-2.2.18-overflowfix/fs/dquot.c
--- linux-2.2.18/fs/dquot.c	Fri Dec 15 17:27:15 2000
+++ linux-2.2.18-overflowfix/fs/dquot.c	Mon Oct  1 22:43:08 2001
@@ -848,7 +848,7 @@
 		if ((dquot->dq_flags & DQ_INODES) == 0 &&
                      need_print_warning(type, initiator, dquot)) {
 			sprintf(quotamessage, "%s: write failed, %s file limit reached\n",
-			        dquot->dq_mnt->mnt_dirname, quotatypes[type]);
+			        bdevname(dquot->dq_dev), quotatypes[type]);
 			tty_write_message(tty, quotamessage);
 			dquot->dq_flags |= DQ_INODES;
 		}
@@ -861,7 +861,7 @@
             !ignore_hardlimit(dquot, initiator)) {
                 if (need_print_warning(type, initiator, dquot)) {
 			sprintf(quotamessage, "%s: warning, %s file quota exceeded too long.\n",
-		        	dquot->dq_mnt->mnt_dirname, quotatypes[type]);
+		        	bdevname(dquot->dq_dev), quotatypes[type]);
 			tty_write_message(tty, quotamessage);
 		}
 		return(NO_QUOTA);
@@ -872,7 +872,7 @@
 	    dquot->dq_itime == 0) {
                 if (need_print_warning(type, initiator, dquot)) {
 			sprintf(quotamessage, "%s: warning, %s file quota exceeded\n",
-		        	dquot->dq_mnt->mnt_dirname, quotatypes[type]);
+		        	bdevname(dquot->dq_dev), quotatypes[type]);
 			tty_write_message(tty, quotamessage);
 		}
 		dquot->dq_itime = CURRENT_TIME + dquot->dq_mnt->mnt_dquot.inode_expire[type];
@@ -893,7 +893,7 @@
 		if (warn && (dquot->dq_flags & DQ_BLKS) == 0 &&
                      need_print_warning(type, initiator, dquot)) {
 			sprintf(quotamessage, "%s: write failed, %s disk limit reached.\n",
-			        dquot->dq_mnt->mnt_dirname, quotatypes[type]);
+			        bdevname(dquot->dq_dev), quotatypes[type]);
 			tty_write_message(tty, quotamessage);
 			dquot->dq_flags |= DQ_BLKS;
 		}
@@ -906,7 +906,7 @@
             !ignore_hardlimit(dquot, initiator)) {
                 if (warn && need_print_warning(type, initiator, dquot)) {
 			sprintf(quotamessage, "%s: write failed, %s disk quota exceeded too long.\n",
-		        	dquot->dq_mnt->mnt_dirname, quotatypes[type]);
+		        	bdevname(dquot->dq_dev), quotatypes[type]);
 			tty_write_message(tty, quotamessage);
 		}
 		return(NO_QUOTA);
@@ -917,7 +917,7 @@
 	    dquot->dq_btime == 0) {
                 if (warn && need_print_warning(type, initiator, dquot)) {
 			sprintf(quotamessage, "%s: warning, %s disk quota exceeded\n",
-		        	dquot->dq_mnt->mnt_dirname, quotatypes[type]);
+		        	bdevname(dquot->dq_dev), quotatypes[type]);
 			tty_write_message(tty, quotamessage);
 		}
 		dquot->dq_btime = CURRENT_TIME + dquot->dq_mnt->mnt_dquot.block_expire[type];
