Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWGLGim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWGLGim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWGLGim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:38:42 -0400
Received: from web81202.mail.mud.yahoo.com ([68.142.199.106]:63092 "HELO
	web81202.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751188AbWGLGim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:38:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5y2LKkHxg8ndPm9n/cGRcg4mHTuajX6aXchvc62TqNNxh6TYrFOfHt+bxSqHw2rUdBjl2s7kwooH+FC0id8wouwJQ4Z6UlqM9QLIor2L5qa0PTIKWVHjX1Yn2s8VTeN0LaNoEH4DhPPvglFwwie7yHe0weMIMue4wTFGIXVlP5Y=  ;
Message-ID: <20060712063841.18958.qmail@web81202.mail.mud.yahoo.com>
Date: Tue, 11 Jul 2006 23:38:41 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: [PATCH] Properly unregister reboot notifier in case of failure in ehci hcd
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: gregkh@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  If some problem occurs during ehci startup, for instance, request_irq fails, echi hcd driver
tries it best to cleanup, but fails to unregister reboot notifier, which in turn leads to crash on
reboot/poweroff. Below is the patch against current git to fix this.
  I did not check if the same problem existed for uhci/ohci host drivers.

Signed off by: Aleks Gorelov <dared1st@yahoo.com>

--- linux-2.6/drivers/usb/host/ehci-hcd.c-orig	2006-07-11 17:27:54.000000000 -0700
+++ linux-2.6/drivers/usb/host/ehci-hcd.c	2006-07-11 17:27:20.000000000 -0700
@@ -483,9 +483,6 @@
 	}
 	ehci->command = temp;
 
-	ehci->reboot_notifier.notifier_call = ehci_reboot;
-	register_reboot_notifier(&ehci->reboot_notifier);
-
 	return 0;
 }
 
@@ -499,7 +496,6 @@
 
 	/* EHCI spec section 4.1 */
 	if ((retval = ehci_reset(ehci)) != 0) {
-		unregister_reboot_notifier(&ehci->reboot_notifier);
 		ehci_mem_cleanup(ehci);
 		return retval;
 	}
@@ -560,6 +556,9 @@
 	 */
 	create_debug_files(ehci);
 
+	ehci->reboot_notifier.notifier_call = ehci_reboot;
+	register_reboot_notifier(&ehci->reboot_notifier);
+
 	return 0;
 }
 

