Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965332AbWCTP31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965332AbWCTP31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965328AbWCTP3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:29:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58808 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965316AbWCTP2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:28:44 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Jiri Slaby <xslaby@fi.muni.cz>,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 036/141] V4L/DVB (3439a): media video stradis memory fix
Date: Mon, 20 Mar 2006 12:08:43 -0300
Message-id: <20060320150843.PS016578000036@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <xslaby@fi.muni.cz>
Date: 1138137306 -0800

memset clears once set structure, there is actually no need for memset,
because configure function do it for us.  Next, vfree(NULL) is legal, so
avoid useless labels.

Thanks Dave Jones for reporting this.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/stradis.c b/drivers/media/video/stradis.c
diff --git a/drivers/media/video/stradis.c b/drivers/media/video/stradis.c
index 54fc330..9d76926 100644
--- a/drivers/media/video/stradis.c
+++ b/drivers/media/video/stradis.c
@@ -2012,7 +2012,6 @@ static int __devinit init_saa7146(struct
 {
 	struct saa7146 *saa = pci_get_drvdata(pdev);
 
-	memset(saa, 0, sizeof(*saa));
 	saa->user = 0;
 	/* reset the saa7146 */
 	saawrite(0xffff0000, SAA7146_MC1);
@@ -2062,16 +2061,16 @@ static int __devinit init_saa7146(struct
 	}
 	if (saa->audbuf == NULL && (saa->audbuf = vmalloc(65536)) == NULL) {
 		dev_err(&pdev->dev, "%d: malloc failed\n", saa->nr);
-		goto errvid;
+		goto errfree;
 	}
 	if (saa->osdbuf == NULL && (saa->osdbuf = vmalloc(131072)) == NULL) {
 		dev_err(&pdev->dev, "%d: malloc failed\n", saa->nr);
-		goto erraud;
+		goto errfree;
 	}
 	/* allocate 81920 byte buffer for clipping */
 	if ((saa->dmavid2 = kzalloc(VIDEO_CLIPMAP_SIZE, GFP_KERNEL)) == NULL) {
 		dev_err(&pdev->dev, "%d: clip kmalloc failed\n", saa->nr);
-		goto errosd;
+		goto errfree;
 	}
 	/* setup clipping registers */
 	saawrite(virt_to_bus(saa->dmavid2), SAA7146_BASE_EVEN2);
@@ -2085,15 +2084,11 @@ static int __devinit init_saa7146(struct
 	I2CBusScan(saa);
 
 	return 0;
-errosd:
+errfree:
 	vfree(saa->osdbuf);
-	saa->osdbuf = NULL;
-erraud:
 	vfree(saa->audbuf);
-	saa->audbuf = NULL;
-errvid:
 	vfree(saa->vidbuf);
-	saa->vidbuf = NULL;
+	saa->audbuf = saa->osdbuf = saa->vidbuf = NULL;
 err:
 	return -ENOMEM;
 }

