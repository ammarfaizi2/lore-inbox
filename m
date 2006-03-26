Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWCZOPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWCZOPx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 09:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWCZOPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 09:15:53 -0500
Received: from wproxy.gmail.com ([64.233.184.225]:40152 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751232AbWCZOPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 09:15:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ljxerth23gUxVrOWVvYHHPkGzl86yoRGkCgmVpS0EVfydUEhtVe2uPJADg9z2jBFhoGMfukksqN1j5Sbqk96ocmXvpLRHYeLB00klP8sLk7Dx7Zdm/8gPw+m/NWOFbAeHCZ2o53q9jjZq4O+n8rvPN9KVHAQ9EcGwR0sBkYI0Hk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ISDN: fix a few resource leaks in sc_ioctl()
Date: Sun, 26 Mar 2006 16:16:25 +0200
User-Agent: KMail/1.9.1
Cc: Karsten Keil <kkeil@suse.de>, Kai Germaschewski <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603261616.25741.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix a few resource leaks in drivers/isdn/sc/ioctl.c::sc_ioctl()


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/isdn/sc/ioctl.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.16-mm1-orig/drivers/isdn/sc/ioctl.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-mm1/drivers/isdn/sc/ioctl.c	2006-03-26 16:11:49.000000000 +0200
@@ -46,7 +46,8 @@ int sc_ioctl(int card, scs_ioctl *data)
 		pr_debug("%s: SCIOCRESET: ioctl received\n",
 			sc_adapter[card]->devicename);
 		sc_adapter[card]->StartOnReset = 0;
-		return (reset(card));
+		kfree(rcvmsg);
+		return reset(card);
 	}
 
 	case SCIOCLOAD:
@@ -183,7 +184,7 @@ int sc_ioctl(int card, scs_ioctl *data)
 				sc_adapter[card]->devicename);
 
 		spid = kmalloc(SCIOC_SPIDSIZE, GFP_KERNEL);
-		if(!spid) {
+		if (!spid) {
 			kfree(rcvmsg);
 			return -ENOMEM;
 		}
@@ -195,10 +196,10 @@ int sc_ioctl(int card, scs_ioctl *data)
 		if (!status) {
 			pr_debug("%s: SCIOCGETSPID: command successful\n",
 					sc_adapter[card]->devicename);
-		}
-		else {
+		} else {
 			pr_debug("%s: SCIOCGETSPID: command failed (status = %d)\n",
 				sc_adapter[card]->devicename, status);
+			kfree(spid);
 			kfree(rcvmsg);
 			return status;
 		}


