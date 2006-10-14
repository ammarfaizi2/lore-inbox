Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWJNMHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWJNMHw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWJNMHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:07:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4813 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932183AbWJNMHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:07:45 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 04/18] V4L/DVB (4729): Fix VIDIOC_G_FMT for NTSC in cx25840.
Date: Sat, 14 Oct 2006 09:00:50 -0300
Message-id: <20061014120050.PS35870300004@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>

VIDIOC_G_FMT returned the sliced VBI types in the wrong lines for NTSC
(three lines too low).

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx25840/cx25840-vbi.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/media/video/cx25840/cx25840-vbi.c b/drivers/media/video/cx25840/cx25840-vbi.c
index 48014a2..f85f208 100644
--- a/drivers/media/video/cx25840/cx25840-vbi.c
+++ b/drivers/media/video/cx25840/cx25840-vbi.c
@@ -235,6 +235,7 @@ int cx25840_vbi(struct i2c_client *clien
 			0, 0, V4L2_SLICED_VPS, 0, 0,	/* 9 */
 			0, 0, 0, 0
 		};
+		int is_pal = !(cx25840_get_v4lstd(client) & V4L2_STD_525_60);
 		int i;
 
 		fmt = arg;
@@ -246,13 +247,25 @@ int cx25840_vbi(struct i2c_client *clien
 		if ((cx25840_read(client, 0x404) & 0x10) == 0)
 			break;
 
-		for (i = 7; i <= 23; i++) {
-			u8 v = cx25840_read(client, 0x424 + i - 7);
+		if (is_pal) {
+			for (i = 7; i <= 23; i++) {
+				u8 v = cx25840_read(client, 0x424 + i - 7);
+
+				svbi->service_lines[0][i] = lcr2vbi[v >> 4];
+				svbi->service_lines[1][i] = lcr2vbi[v & 0xf];
+				svbi->service_set |=
+					svbi->service_lines[0][i] | svbi->service_lines[1][i];
+			}
+		}
+		else {
+			for (i = 10; i <= 21; i++) {
+				u8 v = cx25840_read(client, 0x424 + i - 10);
 
-			svbi->service_lines[0][i] = lcr2vbi[v >> 4];
-			svbi->service_lines[1][i] = lcr2vbi[v & 0xf];
-			svbi->service_set |=
-				 svbi->service_lines[0][i] | svbi->service_lines[1][i];
+				svbi->service_lines[0][i] = lcr2vbi[v >> 4];
+				svbi->service_lines[1][i] = lcr2vbi[v & 0xf];
+				svbi->service_set |=
+					svbi->service_lines[0][i] | svbi->service_lines[1][i];
+			}
 		}
 		break;
 	}

