Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVLYGtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVLYGtf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 01:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVLYGte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 01:49:34 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36056 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750799AbVLYGte
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 01:49:34 -0500
Date: Sun, 25 Dec 2005 06:49:33 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: [PATCH] nfsd4_lock() returns bogus values to clients
Message-ID: <20051225064933.GZ27946@ftp.linux.org.uk>
References: <20051225062937.GW27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225062937.GW27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135493243 -0500

missing nfserror() in default case of a switch by return value of
posix_lock_file(); as the result we send negative host-endian to
clients that expect positive network-endian, preferably mentioned
in RFC...  BTW, that case is not impossible - posix_lock_file()
can return -ENOLCK and we do not handle that one explicitly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/nfsd/nfs4state.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

d91fdfa7ab75e45dd9dba36808d36fc2e1d5c634
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 71689b0..f32f68c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2815,7 +2815,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 		goto conflicting_lock;
 	case (EDEADLK):
 		status = nfserr_deadlock;
+		dprintk("NFSD: nfsd4_lock: posix_lock_file() failed! status %d\n",status);
+		goto out_destroy_new_stateid;
 	default:        
+		status = nfserror(status);
 		dprintk("NFSD: nfsd4_lock: posix_lock_file() failed! status %d\n",status);
 		goto out_destroy_new_stateid;
 	}
-- 
0.99.9.GIT

