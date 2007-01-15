Return-Path: <linux-kernel-owner+w=401wt.eu-S1751409AbXAOTNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXAOTNA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXAOTNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:13:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51497 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXAOTM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:12:59 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 2/9] V4L/DVB (5020): Fix: disable interrupts while at
	KM_BOUNCE_READ
Date: Mon, 15 Jan 2007 16:37:05 -0200
Message-id: <20070115183705.PS5598290002@infradead.org>
In-Reply-To: <20070115183647.PS0588920000@infradead.org>
References: <20070115183647.PS0588920000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

vivi.c uses the KM_BOUNCE_READ with local interrupts enabled. 
This means that if a disk interrupt occurs while vivi.c is using this
fixmap slot, the vivi.c driver will, upon return from that interrupt, find
that the fixmap slot now points at a different physical page.
The net result will probably be rare corruption of disk file contents,
because viv.c will now be altering the page which the disk code was
recently using. 

Thanks to Andrew Morton for pointing this.
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/vivi.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/vivi.c b/drivers/media/video/vivi.c
index bacb311..d4cf556 100644
--- a/drivers/media/video/vivi.c
+++ b/drivers/media/video/vivi.c
@@ -270,10 +270,15 @@ static void gen_line(struct sg_to_addr t
 	char *p,*s,*basep;
 	struct page *pg;
 	u8   chr,r,g,b,color;
+	unsigned long flags;
+	spinlock_t spinlock;
+
+	spin_lock_init(&spinlock);
 
 	/* Get first addr pointed to pixel position */
 	oldpg=get_addr_pos(pos,pages,to_addr);
 	pg=pfn_to_page(sg_dma_address(to_addr[oldpg].sg) >> PAGE_SHIFT);
+	spin_lock_irqsave(&spinlock,flags);
 	basep = kmap_atomic(pg, KM_BOUNCE_READ)+to_addr[oldpg].sg->offset;
 
 	/* We will just duplicate the second pixel at the packet */
@@ -376,6 +381,8 @@ static void gen_line(struct sg_to_addr t
 
 end:
 	kunmap_atomic(basep, KM_BOUNCE_READ);
+	spin_unlock_irqrestore(&spinlock,flags);
+
 }
 static void vivi_fillbuff(struct vivi_dev *dev,struct vivi_buffer *buf)
 {

