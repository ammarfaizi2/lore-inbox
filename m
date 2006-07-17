Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWGQQqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWGQQqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWGQQcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:30138 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750937AbWGQQbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:31:55 -0400
Date: Mon, 17 Jul 2006 09:25:18 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Mandy Kirkconnell <alkirkco@sgi.com>, Nathan Scott <nathans@sgi.com>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/45] XFS: corruption fix
Message-ID: <20060717162518.GB4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="xfs-corruption-fix-for-next-stable-release.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Mandy Kirkconnell <alkirkco@sgi.com>

Fix nused counter.  It's currently getting set to -1 rather than getting
decremented by 1.  Since nused never reaches 0, the "if (!free->hdr.nused)"
check in xfs_dir2_leafn_remove() fails every time and xfs_dir2_shrink_inode()
doesn't get called when it should.  This causes extra blocks to be left on
an empty directory and the directory in unable to be converted back to
inline extent mode.

Signed-off-by: Mandy Kirkconnell <alkirkco@sgi.com>
Signed-off-by: Nathan Scott <nathans@sgi.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/xfs/xfs_dir2_node.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.2.orig/fs/xfs/xfs_dir2_node.c
+++ linux-2.6.17.2/fs/xfs/xfs_dir2_node.c
@@ -970,7 +970,7 @@ xfs_dir2_leafn_remove(
 			/*
 			 * One less used entry in the free table.
 			 */
-			free->hdr.nused = cpu_to_be32(-1);
+			be32_add(&free->hdr.nused, -1);
 			xfs_dir2_free_log_header(tp, fbp);
 			/*
 			 * If this was the last entry in the table, we can

--
