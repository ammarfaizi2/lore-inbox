Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVA0PGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVA0PGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVA0PGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:06:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59314 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262481AbVA0PGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:06:42 -0500
Date: Thu, 27 Jan 2005 16:06:33 +0100
From: Jan Kara <jack@suse.cz>
To: Vladimir Saveliev <vs@namesys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.11-rc2] kernel BUG at fs/reiserfs/prints.c:362
Message-ID: <20050127150632.GA17882@atrey.karlin.mff.cuni.cz>
References: <200501271024.13778.rathamahata@ehouse.ru> <1106821035.3270.30.camel@tribesman> <20050127112647.GA20806@atrey.karlin.mff.cuni.cz> <1106835321.6191.130.camel@tribesman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1106835321.6191.130.camel@tribesman>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi!

> On Thu, 2005-01-27 at 14:26, Jan Kara wrote:
> >   Hello,
> > 
> > > On Thu, 2005-01-27 at 10:24, Sergey S. Kostyliov wrote:
> > > > Hello all,
> > > > 
> > > > Here is a BUG() I've just hited on quota enabled reiserfs disk.
> > > > 
> > > > rathamahata@dev rathamahata $ mount | grep /dev/sdb2
> > > > /dev/sdb2 on /var/www type reiserfs (rw,noatime,nodiratime,data=writeback,grpquota,usrquota)
> > > > rathamahata@dev rathamahata $
> > > > 
> > > > REISERFS: panic (device sdb2): journal_begin called without kernel lock held
> > > 
> > > Would you check whether this patch helps, please?
> >   BTW: What are the exact rules where lock_kernel() should be held for
> > reiserfs? Is there a doc somewhere? 
> I do not think so.
> Earlier reiserfs used to lock_kernel on entering and unlock on exit. The
> reason is that reiserfs has no fine grain locking protecting access to
> its data structures.
> Since that time there could be introduced some minor improvements,
> though.
  So in that case reiserfs_quota_read() also needs a BKL
because it can be called from the quota code without any lock
guarantees (e.g. quota_on() and quotactl() can call reading routine
without BKL).
  Attached patch adds this BKL locking and adds also missing
lock_buffer() I found.
  If you agree with the patch then you can forward it to Andrew/Linus.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reiser-lock-fix.diff"

Add missing locking to reiserfs_quota_read() and reiserfs_quota_write().

Signed-off-by: Jan Kara <jack@suse.cz>

--- linux/fs/reiserfs/super.c	2005-01-27 12:56:27.000000000 +0100
+++ linux/fs/reiserfs/super.c	2005-01-27 17:41:20.000000000 +0100
@@ -1993,7 +1993,9 @@ static ssize_t reiserfs_quota_read(struc
 	tocopy = sb->s_blocksize - offset < toread ? sb->s_blocksize - offset : toread;
 	tmp_bh.b_state = 0;
 	/* Quota files are without tails so we can safely use this function */
+	reiserfs_write_lock(sb);
 	err = reiserfs_get_block(inode, blk, &tmp_bh, 0);
+	reiserfs_write_unlock(sb);
 	if (err)
 	    return err;
 	if (!buffer_mapped(&tmp_bh))    /* A hole? */
@@ -2041,8 +2043,11 @@ static ssize_t reiserfs_quota_write(stru
 	    err = -EIO;
 	    goto out;
 	}
+	lock_buffer(bh);
 	memcpy(bh->b_data+offset, data, tocopy);
+	flush_dcache_page(bh->b_page);
 	set_buffer_uptodate(bh);
+	unlock_buffer(bh);
 	reiserfs_prepare_for_journal(sb, bh, 1);
 	journal_mark_dirty(current->journal_info, sb, bh);
 	if (!journal_quota)

--5vNYLRcllDrimb99--
