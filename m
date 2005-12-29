Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVL2RBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVL2RBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 12:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbVL2RBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 12:01:13 -0500
Received: from cpe-70-112-167-32.austin.res.rr.com ([70.112.167.32]:35514 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750878AbVL2RBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 12:01:13 -0500
To: akpm@osdl.org
Subject: [PATCH] v9fs: fix fd_close
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       mostrows@watson.ibm.com
Message-Id: <20051229170116.765055A8033@localhost.localdomain>
Date: Thu, 29 Dec 2005 11:01:16 -0600 (CST)
From: ericvh@gmail.com (Eric Van Hensbergen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] v9fs: fix fd_close

If a 9pfs server crashes, v9fs_fd_close() is called.
Subsequently, in cleaning up by performing a umount() on the FS
that was provided by this server v9fs_fd_close() is called again, and
uses the old, freed valus of trans->priv.  This patch ensures that
trans->priv can be freed only once, otherwise this function bails early.

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit db73617a4959fa8af9f72063e3bd666c70363d99
tree 3e05d73b024cdcf7462aae64e62a63849d8aa175
parent 3603bc8dc5ab33941e6378fe52ea03b7f5561109
author Eric Van Hensbergen <ericvh@ericvh.localdomain> Thu, 29 Dec 2005 10:54:06 -0600
committer Eric Van Hensbergen <ericvh@ericvh.localdomain> Thu, 29 Dec 2005 10:54:06 -0600

 fs/9p/trans_fd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/trans_fd.c b/fs/9p/trans_fd.c
index 63b58ce..b7ffb98 100644
--- a/fs/9p/trans_fd.c
+++ b/fs/9p/trans_fd.c
@@ -148,12 +148,12 @@ static void v9fs_fd_close(struct v9fs_tr
 	if (!trans)
 		return;
 
-	trans->status = Disconnected;
-	ts = trans->priv;
+	ts = xchg(&trans->priv, NULL);
 
 	if (!ts)
 		return;
 
+	trans->status = Disconnected;
 	if (ts->in_file)
 		fput(ts->in_file);
 
