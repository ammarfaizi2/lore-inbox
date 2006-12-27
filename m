Return-Path: <linux-kernel-owner+w=401wt.eu-S932998AbWL0RKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998AbWL0RKl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933008AbWL0RKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:10:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41436 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbWL0RK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:10:28 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 13/28] V4L/DVB (4980): Fixes bug 7267: PAL/60 is not working
Date: Wed, 27 Dec 2006 14:57:29 -0200
Message-id: <20061227165729.PS66228100013@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

On cx88 driver, sampling rate should be at chroma subcarrier freq (FSC).
However, driver were programming wrong values for PAL/60, PAL/Nc and
NTSC 4.43. This patch do the proper calculation. It also calculates
htotal, hdelay and hactive constants, according with the sampling
rate.
It is tested with PAL/60 by Piotr Maksymuk and Olivier. Also tested with
the already-supported standards.

Test is still required for PAL/Nc.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-core.c |   35 +++++++++++++++++++++-------------
 drivers/media/video/cx88/cx88.h      |    2 +-
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-core.c b/drivers/media/video/cx88/cx88-core.c
index 453af5e..1899736 100644
--- a/drivers/media/video/cx88/cx88-core.c
+++ b/drivers/media/video/cx88/cx88-core.c
@@ -633,12 +633,12 @@ int cx88_reset(struct cx88_core *core)
 
 static unsigned int inline norm_swidth(struct cx88_tvnorm *norm)
 {
-	return (norm->id & V4L2_STD_625_50) ? 922 : 754;
+	return (norm->id & (V4L2_STD_MN & ~V4L2_STD_PAL_Nc)) ? 754 : 922;
 }
 
 static unsigned int inline norm_hdelay(struct cx88_tvnorm *norm)
 {
-	return (norm->id & V4L2_STD_625_50) ? 186 : 135;
+	return (norm->id & (V4L2_STD_MN & ~V4L2_STD_PAL_Nc)) ? 135 : 186;
 }
 
 static unsigned int inline norm_vdelay(struct cx88_tvnorm *norm)
@@ -648,24 +648,33 @@ static unsigned int inline norm_vdelay(s
 
 static unsigned int inline norm_fsc8(struct cx88_tvnorm *norm)
 {
-	static const unsigned int ntsc = 28636360;
-	static const unsigned int pal  = 35468950;
-	static const unsigned int palm  = 28604892;
-
 	if (norm->id & V4L2_STD_PAL_M)
-		return palm;
+		return 28604892;      // 3.575611 MHz
+
+	if (norm->id & (V4L2_STD_PAL_Nc))
+		return 28656448;      // 3.582056 MHz
+
+	if (norm->id & V4L2_STD_NTSC) // All NTSC/M and variants
+		return 28636360;      // 3.57954545 MHz +/- 10 Hz
 
-	return (norm->id & V4L2_STD_625_50) ? pal : ntsc;
+	/* SECAM have also different sub carrier for chroma,
+	   but step_db and step_dr, at cx88_set_tvnorm already handles that.
+
+	   The same FSC applies to PAL/BGDKIH, PAL/60, NTSC/4.43 and PAL/N
+	 */
+
+	return 35468950;      // 4.43361875 MHz +/- 5 Hz
 }
 
 static unsigned int inline norm_htotal(struct cx88_tvnorm *norm)
 {
-	/* Should always be Line Draw Time / (4*FSC) */
 
-	if (norm->id & V4L2_STD_PAL_M)
-		return 909;
+	unsigned int fsc4=norm_fsc8(norm)/2;
 
-	return (norm->id & V4L2_STD_625_50) ? 1135 : 910;
+	/* returns 4*FSC / vtotal / frames per seconds */
+	return (norm->id & V4L2_STD_625_50) ?
+				((fsc4+312)/625+12)/25 :
+				((fsc4+262)/525*1001+15000)/30000;
 }
 
 static unsigned int inline norm_vbipack(struct cx88_tvnorm *norm)
@@ -692,7 +701,7 @@ int cx88_set_scale(struct cx88_core *cor
 	value &= 0x3fe;
 	cx_write(MO_HDELAY_EVEN,  value);
 	cx_write(MO_HDELAY_ODD,   value);
-	dprintk(1,"set_scale: hdelay  0x%04x\n", value);
+	dprintk(1,"set_scale: hdelay  0x%04x (width %d)\n", value,swidth);
 
 	value = (swidth * 4096 / width) - 4096;
 	cx_write(MO_HSCALE_EVEN,  value);
diff --git a/drivers/media/video/cx88/cx88.h b/drivers/media/video/cx88/cx88.h
index 7054e94..a9575ad 100644
--- a/drivers/media/video/cx88/cx88.h
+++ b/drivers/media/video/cx88/cx88.h
@@ -91,7 +91,7 @@ struct cx88_tvnorm {
 
 static unsigned int inline norm_maxw(struct cx88_tvnorm *norm)
 {
-	return (norm->id & V4L2_STD_625_50) ? 768 : 640;
+	return (norm->id & (V4L2_STD_MN & ~V4L2_STD_PAL_Nc)) ? 720 : 768;
 }
 
 

