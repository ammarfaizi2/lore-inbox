Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWBHGvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWBHGvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWBHGut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:50:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:63616 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161006AbWBHGmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:42:38 -0500
Message-Id: <20060208064855.681844000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Nathan Scott <nathans@sgi.com>
Subject: [PATCH 05/23] [XFS] fix regression in xfs_buf_rele
Content-Disposition: inline; filename=fix-regression-in-xfs_buf_rele.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix regression in xfs_buf_rele dealing with non-hashed buffers, as
occur during log replay.  Novell bug 145204, Fedora bug 177848.

Signed-off-by: Nathan Scott <nathans@sgi.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 fs/xfs/linux-2.6/xfs_buf.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-2.6.15.3/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.15.3.orig/fs/xfs/linux-2.6/xfs_buf.c
+++ linux-2.6.15.3/fs/xfs/linux-2.6/xfs_buf.c
@@ -830,6 +830,13 @@ pagebuf_rele(
 
 	PB_TRACE(pb, "rele", pb->pb_relse);
 
+	if (unlikely(!hash)) {
+		ASSERT(!pb->pb_relse);
+		if (atomic_dec_and_test(&pb->pb_hold))
+			xfs_buf_free(pb);
+		return;
+	}
+
 	if (atomic_dec_and_lock(&pb->pb_hold, &hash->bh_lock)) {
 		if (pb->pb_relse) {
 			atomic_inc(&pb->pb_hold);

--
