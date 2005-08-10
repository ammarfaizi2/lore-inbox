Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVHJNGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVHJNGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVHJNGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:06:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23770 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965092AbVHJNGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:06:35 -0400
Date: Wed, 10 Aug 2005 15:06:27 +0200
From: Jan Kara <jack@suse.cz>
To: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>
Cc: "Vladimir V. Saveliev" <vs@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs 3.6 + quota enabled, crash on delete (or maybe truncate)
Message-ID: <20050810130627.GF22112@atrey.karlin.mff.cuni.cz>
References: <42F27161.2020702@winch-hebergement.net> <42F33379.5030804@namesys.com> <42F91FC2.3010305@winch-hebergement.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <42F91FC2.3010305@winch-hebergement.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

> I just applied the patch submitted by Jan Kara:
> http://bugzilla.kernel.org/show_bug.cgi?id=4771#c3
> I dont know yet if it solves the problem :)
  I actually should cure your problem but can have some unexpected
sideffects. Please try an attached patch (it's the new one I posted 
to bugzilla) - that should be a better fix.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reiser-2.6.13-rc6-create_fix.diff"

Initialize key object ID in inode so that we don't try to remove the inode
when we fail on some checks even before we manage to allocate something.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.13-rc6/fs/reiserfs/namei.c linux-2.6.13-rc6-reiser_create_fix/fs/reiserfs/namei.c
--- linux-2.6.13-rc6/fs/reiserfs/namei.c	2005-08-12 10:39:25.000000000 +0200
+++ linux-2.6.13-rc6-reiser_create_fix/fs/reiserfs/namei.c	2005-08-12 10:39:07.000000000 +0200
@@ -593,6 +593,9 @@ static int new_inode_init(struct inode *
 	 */
 	inode->i_uid = current->fsuid;
 	inode->i_mode = mode;
+	/* Make inode invalid - just in case we are going to drop it before
+	 * the initialization happens */
+	INODE_PKEY(inode)->k_objectid = 0;
 
 	if (dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;

--oC1+HKm2/end4ao3--
