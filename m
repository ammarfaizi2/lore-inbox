Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUD1JQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUD1JQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 05:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264708AbUD1JQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 05:16:14 -0400
Received: from mail.native-instruments.de ([217.9.41.138]:47266 "EHLO
	mail.native-instruments.de") by vger.kernel.org with ESMTP
	id S264704AbUD1JQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 05:16:12 -0400
Message-ID: <015701c42d01$70886260$9602010a@jingle>
From: "Florian Schirmer" <jolt@tuxbox.org>
To: "Linus Torvalds" <torvalds@osdl.org>, <armin@melware.de>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <i4ldeveloper@listserv.isdn4linux.de>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
Subject: Re: Linux 2.6.6-rc3
Date: Wed, 28 Apr 2004 11:16:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Armin Schindler:
>   o ISDN CAPI: add ncci list semaphore

This looks broken for !CONFIG_ISDN_CAPI_MIDDLEWARE configs. Note the up()
inside the #ifdef.

@@ -904,13 +917,17 @@
 			if (copy_from_user((void *)&ncci, (void *)arg,
 					   sizeof(ncci)))
 				return -EFAULT;
-			nccip = capincci_find(cdev, (u32) ncci);
-			if (!nccip)
+
+			down(&cdev->ncci_list_sem);
+			if ((nccip = capincci_find(cdev, (u32) ncci)) == 0) {
+				up(&cdev->ncci_list_sem);
 				return 0;
+			}
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 			if ((mp = nccip->minorp) != 0) {
 				count += atomic_read(&mp->ttyopencount);
 			}
+			up(&cdev->ncci_list_sem);
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
 			return count;
 		}


Regards,
   Florian

