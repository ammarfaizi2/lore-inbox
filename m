Return-Path: <linux-kernel-owner+w=401wt.eu-S1751422AbXAOTOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXAOTOd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXAOTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:14:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51518 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbXAOTOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:14:20 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 9/9] V4L/DVB (5023): Fix compilation on ppc32 architecture
Date: Mon, 15 Jan 2007 16:37:07 -0200
Message-id: <20070115183707.PS1359440009@infradead.org>
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

There's a problem, pointed by Meelis Roos <mroos@linux.ee>, that, on ppc32 arch,
with some gcc versions (noticed with prerelease 4.1.2 20061115), compilation 
fails, due the lack of __ucmpdi2 to do the required 64-bit comparision.
This patch takes some sugestions made by Andrew Morton <akpm@osdl.org>,
Stelian Pop <stelian@popies.net> and Segher Boessenkool <segher@kernel.crashing.org>

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/v4l2-common.c |    9 ++++++++-
 include/linux/videodev2.h         |    9 +++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
index 752c82c..b87d571 100644
--- a/drivers/media/video/v4l2-common.c
+++ b/drivers/media/video/v4l2-common.c
@@ -90,8 +90,15 @@ MODULE_LICENSE("GPL");
 char *v4l2_norm_to_name(v4l2_std_id id)
 {
 	char *name;
+	u32 myid = id;
 
-	switch (id) {
+	/* HACK: ppc32 architecture doesn't have __ucmpdi2 function to handle
+	   64 bit comparations. So, on that architecture, with some gcc variants,
+	   compilation fails. Currently, the max value is 30bit wide.
+	 */
+	BUG_ON(myid != id);
+
+	switch (myid) {
 	case V4L2_STD_PAL:
 		name="PAL";		break;
 	case V4L2_STD_PAL_BG:
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index 5cb380a..d94e268 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -662,6 +662,15 @@ #define V4L2_STD_SECAM_LC       ((v4l2_s
 #define V4L2_STD_ATSC_8_VSB     ((v4l2_std_id)0x01000000)
 #define V4L2_STD_ATSC_16_VSB    ((v4l2_std_id)0x02000000)
 
+/* FIXME:
+   Although std_id is 64 bits, there is an issue on PPC32 architecture that
+   makes switch(__u64) to break. So, there's a hack on v4l2-common.c rounding
+   this value to 32 bits.
+   As, currently, the max value is for V4L2_STD_ATSC_16_VSB (30 bits wide),
+   it should work fine. However, if needed to add more than two standards,
+   v4l2-common.c should be fixed.
+ */
+
 /* some merged standards */
 #define V4L2_STD_MN	(V4L2_STD_PAL_M|V4L2_STD_PAL_N|V4L2_STD_PAL_Nc|V4L2_STD_NTSC)
 #define V4L2_STD_B	(V4L2_STD_PAL_B|V4L2_STD_PAL_B1|V4L2_STD_SECAM_B)

