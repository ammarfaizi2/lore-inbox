Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272027AbRHVPNi>; Wed, 22 Aug 2001 11:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272028AbRHVPN1>; Wed, 22 Aug 2001 11:13:27 -0400
Received: from ns.cablesurf.de ([195.206.131.193]:44503 "EHLO ns.cablesurf.de")
	by vger.kernel.org with ESMTP id <S272027AbRHVPNX>;
	Wed, 22 Aug 2001 11:13:23 -0400
Message-Id: <200108221524.RAA27973@ns.cablesurf.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: linux-usb-devel@lists.sourceforge.net
Subject: extending BKL in v4l open
Date: Wed, 22 Aug 2001 17:13:43 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to propose an extension of code under the BKL in v4l's open method 
to include the actual open of the low level v4l driver. Otherwise there's a 
race with usb v4l drivers which deregister themselves as v4l devices upon 
being disconnected on usb, as the pointer passed may point to freed memory.

	Regards
		Oliver


--- videodev.c.alt	Sun Aug 12 19:38:48 2001
+++ videodev.c	Wed Aug 22 17:07:51 2001
@@ -164,8 +164,7 @@

 	if(vfl->owner)
 		__MOD_INC_USE_COUNT(vfl->owner);
-	unlock_kernel();
-
+
 	if(vfl->open)
 	{
 		err=vfl->open(vfl,0);	/* Tell the device it is open */
@@ -174,10 +173,12 @@
 			vfl->busy=0;
 			if(vfl->owner)
 				__MOD_DEC_USE_COUNT(vfl->owner);
-
+
+			unlock_kernel();
 			return err;
 		}
 	}
+	unlock_kernel();
 	return 0;
 error_out:
 	unlock_kernel();
