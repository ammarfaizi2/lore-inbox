Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVCaMc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVCaMc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVCaMc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:32:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57991 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261396AbVCaMcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:32:53 -0500
Date: Thu, 31 Mar 2005 14:32:53 +0200
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix possible oops on quotaoff
Message-ID: <20050331123252.GA8008@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi!

  Attached one-liner should fix possible Oops on quotaoff - the code
does not expect quotafiles to have any dquots initialized but they
actually could have some in the following scenario:
  turn on one quota type
  write to the file with the other quota type (quota gets initialize)
  turn on the other quota type

  Please apply the fix (it should apply well to any recent kernel)

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.11-dropfix.diff"

Remove dquot structures from quota file on quotaon - quota code does not expect them
to be there.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.11/fs/dquot.c linux-2.6.11-dropfix/fs/dquot.c
--- linux-2.6.11/fs/dquot.c	2005-03-30 13:37:05.000000000 +0200
+++ linux-2.6.11-dropfix/fs/dquot.c	2005-03-31 14:03:45.000000000 +0200
@@ -1444,6 +1444,7 @@ static int vfs_quota_on_inode(struct ino
 	oldflags = inode->i_flags & (S_NOATIME | S_IMMUTABLE | S_NOQUOTA);
 	inode->i_flags |= S_NOQUOTA | S_NOATIME | S_IMMUTABLE;
 	up_write(&dqopt->dqptr_sem);
+	sb->dq_op->drop(inode);
 
 	error = -EIO;
 	dqopt->files[type] = igrab(inode);

--u3/rZRmxL6MmkK24--
