Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423992AbWKIBRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423992AbWKIBRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423989AbWKIBQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:16:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:21726 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161777AbWKIBQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:16:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=rLm93wMYcfQU1w2vBE8RGWKb/UHTypfdZT+291wOUJys8Jlig4EPOm1/SgMxXK5076SSjLaFebQwRm6p/RY+9S/oMgPlqamqV0sSavUrEiqhKvzg5n3wK2TdHxXYfKon5v60U1dHBaAYFmnvjYn+iKNmthiTNHOq2+cF5BIlM2k=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] direct-io: fix double completion on partially valid async requests
In-Reply-To: <11630349713427-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Thu, 9 Nov 2006 10:16:12 +0900
Message-Id: <1163034972736-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: zach.brown@oracle.com, pbadari@us.ibm.com, suparna@in.ibm.com,
       jmoyer@redhat.com, akpm@osdl.org, cwyang@aratech.co.kr,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a request which is valid in the first half but has the second half
unmapped, the current code issues the first half and returns issue
error.  This causes both the caller and completion callback complete
the aio request thus either causing oops immediately or memory
corruption.

This path makes direct_io_worker() wait completion for such request
and return error without aio_complete()'ing it.

This bug has been spotted by Chul-Woong Yang.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Chul-Woong Yang <cwyang@aratech.co.kr>
---
 fs/direct-io.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index c558aa6..316598b 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -956,19 +956,17 @@ direct_io_worker(int rw, struct kiocb *i
 	 * If this request can be completed asynchronously, drop the
 	 * extra reference and return.
 	 */
-	if (!is_sync_kiocb(iocb) &&
+	if (!is_sync_kiocb(iocb) && ret == 0 &&
 	    ((rw == READ) || (dio->result == dio->size &&
 			      offset + dio->size <= dio->i_size))) {
-		if (ret == 0)
-			ret = dio->result;
 		finished_one_bio(dio);		/* This can free the dio */
-		return ret;
+		return dio->result;
 	}
 
 	/*
 	 * We need to wait for the request to complete if the request
-	 * is synchronous or an async write which writes to hole or
-	 * extends the file.
+	 * is synchronous, failed to issue in the middle or is an
+	 * async write which writes to hole or extends the file.
 	 *
 	 * For file extending writes updating i_size before data
 	 * writeouts complete can expose uninitialized blocks. So even
-- 
1.4.3.3


