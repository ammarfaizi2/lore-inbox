Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWAXLzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWAXLzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 06:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWAXLzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 06:55:22 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:11965 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S964976AbWAXLzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 06:55:21 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Tue, 24 Jan 2006 12:25:41 +0100
Subject: [PATCH] media video stradis memory fix
To: akpm@osdl.org, torvalds@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, laredo@gnu.org,
       Dave Jones <davej@redhat.com>
In-reply-to: <20060124061721.GA6861@redhat.com>
References: <20060124060103.GA3532@redhat.com>,
	<20060124060103.GA3532@redhat.com>
Message-Id: <20060124112541.99C4822B406@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

media video stradis memory fix

memset clears once set structure, there is actually no need for memset,
because configure function do it for us. Next, vfree(NULL) is legal, so
avoid useless labels.

Thanks Dave Jones for reporting this.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 6bf69f737175c593ae5dbccf1c836e86e60e80d4
tree 06984cc9874957c93276ad546f9e0756ebc2a11f
parent 34f0900e27681dd7bea568f6c593b9b216e7ce78
author <ku@bellona.(none)> Tue, 24 Jan 2006 12:18:56 +0100
committer <ku@bellona.(none)> Tue, 24 Jan 2006 12:18:56 +0100

 drivers/media/video/stradis.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

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
