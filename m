Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030942AbWKUM74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030942AbWKUM74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030938AbWKUM7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:59:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28614 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030935AbWKUM71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:59:27 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Ira Snyder <kernel@irasnyder.com>,
       "Ira W. Snyder" <devel@irasnyder.com>, "Hans J. Koch" <koch@hjk-az.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 4/5] V4L/DVB (4849): Add missing spin_unlock to saa6588
	decoder driver
Date: Tue, 21 Nov 2006 10:38:50 -0200
Message-id: <20061121123850.PS5395860004@infradead.org>
In-Reply-To: <20061121123202.PS8610150000@infradead.org>
References: <20061121123202.PS8610150000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ira Snyder <kernel@irasnyder.com>

Sparse noticed a lock imbalance in read_from_buf(). Further inspection shows
that the lock should not be held when the function exits.
This adds a spin_unlock_irqrestore(), so that every exit path of the
read_from_buf() function is consistent. The unlock was missing on an error
path.

Signed-off-by: Ira W. Snyder <devel@irasnyder.com>
Signed-off-by: Hans J. Koch <koch@hjk-az.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa6588.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/saa6588.c b/drivers/media/video/saa6588.c
index a81285c..7b9859c 100644
--- a/drivers/media/video/saa6588.c
+++ b/drivers/media/video/saa6588.c
@@ -212,8 +212,10 @@ static void read_from_buf(struct saa6588
 	if (rd_blocks > s->block_count)
 		rd_blocks = s->block_count;
 
-	if (!rd_blocks)
+	if (!rd_blocks) {
+		spin_unlock_irqrestore(&s->lock, flags);
 		return;
+	}
 
 	for (i = 0; i < rd_blocks; i++) {
 		if (block_to_user_buf(s, buf_ptr)) {

