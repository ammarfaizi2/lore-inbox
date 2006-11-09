Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423988AbWKIBQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423988AbWKIBQX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423981AbWKIBQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:16:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:21726 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161777AbWKIBQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:16:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=pnkGq1fHBLd1tiVKxgObO47G0FAc7/E8XgneYRCfVTsYK7WJe4NjNiDVtJ9QiGPrmheNv+TSFFyyLceienZrs8QvhJebMxFy5MYTjt1iaX04QVIJbLK9mnGGxWkQamqJl4dUmAX/QpPJu6YNiBILqDr36A2gCMyjol9essfeaIc=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] direct-io: fix dio_complete() errno passing in sync completion path
In-Reply-To: <11630349713427-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Thu, 9 Nov 2006 10:16:11 +0900
Message-Id: <11630349712471-git-send-email-htejun@gmail.com>
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

In synchronous completion path, the number of transferred bytes is
always passed to dio_complete() as @bytes argument whether the
transfer succeeded or not.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 fs/direct-io.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 25721b2..c85aee3 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1138,10 +1138,11 @@ direct_io_worker(int rw, struct kiocb *i
 			if (rw == READ && (offset + transferred > i_size))
 				transferred = i_size - offset;
 		}
-		dio_complete(dio, offset, transferred);
 		if (ret == 0)
 			ret = transferred;
 
+		dio_complete(dio, offset, ret);
+
 		/* We could have also come here on an AIO file extend */
 		if (!is_sync_kiocb(iocb) && (rw & WRITE) &&
 		    ret >= 0 && dio->result == dio->size)
-- 
1.4.3.3


