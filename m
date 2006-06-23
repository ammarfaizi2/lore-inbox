Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWFWDhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWFWDhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWFWDhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:37:10 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:12897 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932099AbWFWDhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:37:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=XbNNNKYNFpJoujuVSvLePtRiGXbldEBofaeOgRCAgwHZPVUSfb4ThkRsnpZ38Z2aKNXHY3p9cvQd3LbsOZiqcQ2dlb+aZ+9OkFR8Lj3A9W898I6W2PcFM0RFINH4XpGsNj4pqW8KRWMSRfSH93I+k7OsEcQT34KAHieFHUvEoP0=
Message-ID: <449B6349.7070205@gmail.com>
Date: Thu, 22 Jun 2006 23:43:05 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: potential memory leaks in jffs2_scan_medium()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch deals with 3 return paths that fail to perform proper cleanup
(which can result into leaking 'flashbuf' and/or 's').

Coverity IDs: 676, 1301

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

 fs/jffs2/scan.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 6161808..4a068de 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -128,12 +128,12 @@ #endif
 	}
 
 	if (jffs2_sum_active()) {
-		s = kmalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
+		s = kzalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
 		if (!s) {
 			JFFS2_WARNING("Can't allocate memory for summary\n");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out;
 		}
-		memset(s, 0, sizeof(struct jffs2_summary));
 	}
 
 	for (i=0; i<c->nr_blocks; i++) {
@@ -194,7 +194,7 @@ #endif
 				if (c->nextblock) {
 					ret = file_dirty(c, c->nextblock);
 					if (ret)
-						return ret;
+						goto out;
 					/* deleting summary information of the old nextblock */
 					jffs2_sum_reset_collected(c->summary);
 				}
@@ -205,7 +205,7 @@ #endif
 			} else {
 				ret = file_dirty(c, jeb);
 				if (ret)
-					return ret;
+					goto out;
 			}
 			break;
 


