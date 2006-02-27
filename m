Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWB0Wcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWB0Wcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWB0Wcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:32:46 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:58753 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932391AbWB0WcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:32:13 -0500
Message-Id: <20060227223407.009013000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:37 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Mike OConnor" <mjo@dojo.mi.org>
Subject: [patch 37/39] [PATCH] XFS ftruncate() bug could expose stale data (CVE-2006-0554)
Content-Disposition: inline; filename=xfs-ftruncate-bug-could-expose-stale-data.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This is CVE-2006-0554 and SGI bug 942658.  With certain types of
ftruncate() activity on 2.6 kernels, XFS can end up exposing stale
data off disk to a user, putting extents where holes should be.  

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 fs/xfs/linux-2.6/xfs_aops.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.4.orig/fs/xfs/linux-2.6/xfs_aops.c
+++ linux-2.6.15.4/fs/xfs/linux-2.6/xfs_aops.c
@@ -385,7 +385,7 @@ xfs_probe_unmapped_cluster(
 
 	/* First sum forwards in this page */
 	do {
-		if (buffer_mapped(bh))
+		if (buffer_mapped(bh) || !buffer_uptodate(bh))
 			break;
 		total += bh->b_size;
 	} while ((bh = bh->b_this_page) != head);

--
