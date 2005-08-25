Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVHYIin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVHYIin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVHYIin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:38:43 -0400
Received: from [218.25.172.144] ([218.25.172.144]:6919 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S964877AbVHYIim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:38:42 -0400
Date: Thu, 25 Aug 2005 16:38:37 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] bh_lru_install() optimize
Message-ID: <20050825083837.GA4084@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This optimizes bh_lru_install(). It's a hot spot I think.  The bh_lru is well
manipulated now so we can use put_bh() as a substitute for the first __brelse()
here, and a bogus BUG_ON() can be removed safely.  We evict at the right place
too.  Boot tested.

	Coywolf


Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

 buffer.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

--- 2.6.13-rc6-mm2/fs/buffer.c~orig	2005-08-23 13:42:04.000000000 +0800
+++ 2.6.13-rc6-mm2/fs/buffer.c	2005-08-25 16:04:21.000000000 +0800
@@ -1356,7 +1356,6 @@ static inline void check_irqs_on(void)
  */
 static void bh_lru_install(struct buffer_head *bh)
 {
-	struct buffer_head *evictee = NULL;
 	struct bh_lru *lru;
 
 	check_irqs_on();
@@ -1372,15 +1371,14 @@ static void bh_lru_install(struct buffer
 		for (in = 0; in < BH_LRU_SIZE; in++) {
 			struct buffer_head *bh2 = lru->bhs[in];
 
-			if (bh2 == bh) {
-				__brelse(bh2);
-			} else {
+			if (bh2 == bh)
+				put_bh(bh2);
+			else {
 				if (out >= BH_LRU_SIZE) {
-					BUG_ON(evictee != NULL);
-					evictee = bh2;
-				} else {
+					if (bh2)
+						__brelse(bh2);	/* evict bh2 */
+				} else
 					bhs[out++] = bh2;
-				}
 			}
 		}
 		while (out < BH_LRU_SIZE)
@@ -1388,9 +1386,6 @@ static void bh_lru_install(struct buffer
 		memcpy(lru->bhs, bhs, sizeof(bhs));
 	}
 	bh_lru_unlock();
-
-	if (evictee)
-		__brelse(evictee);
 }
 
 /*
