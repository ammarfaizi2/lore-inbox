Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTDQFyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbTDQFwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:52:39 -0400
Received: from granite.he.net ([216.218.226.66]:53520 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263079AbTDQFu6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:50:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1050559504205@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <10505595043780@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:04 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1060, 2003/04/14 10:22:36-07:00, greg@kroah.com

[PATCH] USB: kobil_sct fix up errors found by smatch


diff -Nru a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
--- a/drivers/usb/serial/kobil_sct.c	Wed Apr 16 10:49:08 2003
+++ b/drivers/usb/serial/kobil_sct.c	Wed Apr 16 10:49:08 2003
@@ -514,7 +514,9 @@
 			dbg("%s - port %d Error in verify_area", __FUNCTION__, port->number);
 			return(result);
 		}
-		kernel_termios_to_user_termios((struct termios *)arg, &priv->internal_termios);
+		if (kernel_termios_to_user_termios((struct termios *)arg,
+						   &priv->internal_termios))
+			return -EFAULT;
 		return 0;
 
 	case TCSETS:   // 0x5402
@@ -527,7 +529,9 @@
 			dbg("%s - port %d Error in verify_area", __FUNCTION__, port->number);
 			return result;
 		}
-		user_termios_to_kernel_termios( &priv->internal_termios, (struct termios *)arg);
+		if (user_termios_to_kernel_termios(&priv->internal_termios,
+						   (struct termios *)arg))
+			return -EFAULT;
 		
 		settings = (unsigned char *) kmalloc(50, GFP_KERNEL);  
 		if (! settings) {

