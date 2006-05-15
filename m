Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWEOP4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWEOP4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWEOP4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:56:51 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:2134 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751586AbWEOP4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:56:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=n3IwUBfqLp6gdurb1j/h+6XSraO1COuXIoM7IDKHCyW98ZSKecVCTfW7EvLHfOcofCgzyndhLv5qfKdU4AqgMO0zXN0D0lech8lh76tiF+yECHGyChIKlz/cj1d0hi34FsiC2aC3Nz1MxpZRnPUO9GCbh7eWl/yV2R0e67x29Z0=
Message-ID: <4468A450.9000908@gmail.com>
Date: Mon, 15 May 2006 11:54:56 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: dwmw2@infradead.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: memory leak in jffs2_scan_medium()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If jffs2_scan_eraseblock() fails and the exit path is taken, 's' is not
being deallocated.

Reported by Coverity, CID: 1258.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index cf55b22..27a7021 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -222,9 +222,6 @@ #endif
 		}
 	}
 
-	if (jffs2_sum_active() && s)
-		kfree(s);
-
 	/* Nextblock dirty is always seen as wasted, because we cannot recycle it now */
 	if (c->nextblock && (c->nextblock->dirty_size)) {
 		c->nextblock->wasted_size += c->nextblock->dirty_size;
@@ -266,6 +263,8 @@ #ifndef __ECOS
 	else
 		c->mtd->unpoint(c->mtd, flashbuf, 0, c->mtd->size);
 #endif
+	kfree(s);
+	
 	return ret;
 }
 


