Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbSKVBOW>; Thu, 21 Nov 2002 20:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbSKVBOW>; Thu, 21 Nov 2002 20:14:22 -0500
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:37384 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S267264AbSKVBOV>;
	Thu, 21 Nov 2002 20:14:21 -0500
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, chris@qwirx.com
Subject: wingel@nano-system.com
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 22 Nov 2002 02:21:27 +0100
Message-ID: <87heeav1pk.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

Chris Wilson found and fixed a few bugs in the failure paths of the
scx200_wdt driver that I'm the maintainer for.  Could you please apply
this patch that fixes these.

  /Christer 


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=scx200_wdt.patch

--- linux-2.5.47/drivers/char/scx200_wdt.c	Mon Nov 11 03:28:26 2002
+++ linux-2.5.47-chris/drivers/char/scx200_wdt.c	Sun Nov 17 19:27:32 2002
@@ -240,23 +240,28 @@
 	}
 
 	scx200_wdt_update_margin();
 	scx200_wdt_disable();
 
 	sema_init(&open_semaphore, 1);
 
 	r = misc_register(&scx200_wdt_miscdev);
-	if (r)
+	if (r) {
+		release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
+				SCx200_WDT_SIZE);
 		return r;
+	}
 
 	r = register_reboot_notifier(&scx200_wdt_notifier);
         if (r) {
                 printk(KERN_ERR NAME ": unable to register reboot notifier");
 		misc_deregister(&scx200_wdt_miscdev);
+		release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
+				SCx200_WDT_SIZE);
                 return r;
         }
 
 	return 0;
 }
 
 static void __exit scx200_wdt_cleanup(void)
 {

--=-=-=


-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se

--=-=-=--
