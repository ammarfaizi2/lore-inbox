Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWFZXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWFZXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933210AbWFZXa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:30:56 -0400
Received: from dh134.citi.umich.edu ([141.211.133.134]:1980 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S933208AbWFZXaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:30:09 -0400
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH 3/5] NFSv4: Ensure nfs4_lock_expired() caches delegated locks
Date: Mon, 26 Jun 2006 19:30:08 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20060626233008.6059.63173.stgit@lade.trondhjem.org>
In-Reply-To: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
References: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/nfs4proc.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b8c6375..8bdfe3f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3454,10 +3454,10 @@ static int nfs4_lock_reclaim(struct nfs4
 	struct nfs4_exception exception = { };
 	int err;
 
-	/* Cache the lock if possible... */
-	if (test_bit(NFS_DELEGATED_STATE, &state->flags))
-		return 0;
 	do {
+		/* Cache the lock if possible... */
+		if (test_bit(NFS_DELEGATED_STATE, &state->flags) != 0)
+			return 0;
 		err = _nfs4_do_setlk(state, F_SETLK, request, 1);
 		if (err != -NFS4ERR_DELAY)
 			break;
@@ -3476,6 +3476,8 @@ static int nfs4_lock_expired(struct nfs4
 	if (err != 0)
 		return err;
 	do {
+		if (test_bit(NFS_DELEGATED_STATE, &state->flags) != 0)
+			return 0;
 		err = _nfs4_do_setlk(state, F_SETLK, request, 0);
 		if (err != -NFS4ERR_DELAY)
 			break;
