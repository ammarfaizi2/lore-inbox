Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030662AbWJKGg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030662AbWJKGg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030663AbWJKGg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:36:28 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:17326 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030662AbWJKGg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:36:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Q/hVBGta4bE/MyZ/jlbBn311cc4JnEBdiy1isxrWbZU1GuKO/lQAzZkx5gVJUhOuZBvy/ejVPTGe7vcnEdBTpsGJz5QolLx7VBXpxLTBOUSZ0rX9kkG3OSGCg3G7sb3GeguBcLGViHnh7I+1mj09GSWerCzHC/T/jftsNorIG+g=
Date: Tue, 10 Oct 2006 23:36:23 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc1 1/2] drivers/media/video/se401.c: check kmalloc()
 return value.
Message-Id: <20061010233623.95a47224.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function se401_start_stream(), in file drivers/media/video/se401.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/media/video/se401.c b/drivers/media/video/se401.c
index 7aeec57..20b91db 100644
--- a/drivers/media/video/se401.c
+++ b/drivers/media/video/se401.c
@@ -57,6 +57,7 @@ MODULE_PARM_DESC(flickerless, "Net frequ
 module_param(video_nr, int, 0);
 
 static struct usb_driver se401_driver;
+static int se401_stop_stream(struct usb_se401 *se401);
 
 
 /**********************************************************************
@@ -450,6 +451,11 @@ static int se401_start_stream(struct usb
 	}
 	for (i=0; i<SE401_NUMSBUF; i++) {
 		se401->sbuf[i].data=kmalloc(SE401_PACKETSIZE, GFP_KERNEL);
+		/* No memory, stop streaming */
+		if (!se401->sbuf[i].data) {
+			se401_stop_stream(se401);
+			return -ENOMEM;
+		}
 	}
 
 	se401->bayeroffset=0;
@@ -458,6 +464,11 @@ static int se401_start_stream(struct usb
 	se401->scratch_overflow=0;
 	for (i=0; i<SE401_NUMSCRATCH; i++) {
 		se401->scratch[i].data=kmalloc(SE401_PACKETSIZE, GFP_KERNEL);
+		/* No memory, stop streaming */
+		if (!se401->scratch[i].data) {
+			se401_stop_stream(se401);
+			return -ENOMEM;
+		}
 		se401->scratch[i].state=BUFFER_UNUSED;
 	}
 
