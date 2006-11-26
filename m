Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935409AbWKZOab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935409AbWKZOab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 09:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935408AbWKZOab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 09:30:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37526 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S935409AbWKZOaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 09:30:30 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 1/2] V4L/DVB (4885): Improve saa711x check
Date: Sun, 26 Nov 2006 12:26:51 -0200
Message-id: <20061126142651.PS1380670006@infradead.org>
In-Reply-To: <20061126141928.PS6336290000@infradead.org>
References: <20061126141928.PS6336290000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>

The old code would accept any device on the same i2c address as the
saa711x chips as an saa711x. However, this fails with saa717x chips,
which use that same address and so are misdetected as a saa7111. Now
check whether the chip is really a saa711x model.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7115.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
index c5719f7..f28398d 100644
--- a/drivers/media/video/saa7115.c
+++ b/drivers/media/video/saa7115.c
@@ -1464,8 +1464,6 @@ static int saa711x_attach(struct i2c_ada
 	client->driver = &i2c_driver_saa711x;
 	snprintf(client->name, sizeof(client->name) - 1, "saa7115");
 
-	v4l_dbg(1, debug, client, "detecting saa7115 client on address 0x%x\n", address << 1);
-
 	for (i=0;i<0x0f;i++) {
 		saa711x_write(client, 0, i);
 		name[i] = (saa711x_read(client, 0) &0x0f) +'0';
@@ -1477,6 +1475,13 @@ static int saa711x_attach(struct i2c_ada
 	saa711x_write(client, 0, 5);
 	chip_id = saa711x_read(client, 0) & 0x0f;
 
+	/* Check whether this chip is part of the saa711x series */
+	if (memcmp(name, "1f711", 5)) {
+		v4l_dbg(1, debug, client, "chip found @ 0x%x (ID %s) does not match a known saa711x chip.\n",
+			address << 1, name);
+		return 0;
+	}
+
 	snprintf(client->name, sizeof(client->name) - 1, "saa711%d",chip_id);
 	v4l_info(client, "saa711%d found (%s) @ 0x%x (%s)\n", chip_id, name, address << 1, adapter->name);
 

