Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTDQFuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbTDQFuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:50:54 -0400
Received: from granite.he.net ([216.218.226.66]:49168 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263071AbTDQFuw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:50:52 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10505595042504@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <10505595032542@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:04 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1056, 2003/04/14 10:17:46-07:00, greg@kroah.com

[PATCH] USB: fix up spin_unlock_irqrestore() issues in previous patch


diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Wed Apr 16 10:49:33 2003
+++ b/drivers/usb/core/hcd.c	Wed Apr 16 10:49:33 2003
@@ -1283,13 +1283,13 @@
 		if (urb->status != -EINPROGRESS)
 			continue;
 		usb_get_urb (urb);
-		spin_unlock (&hcd_data_lock);
+		spin_unlock_irqrestore (&hcd_data_lock, flags);
 
-		spin_lock (&urb->lock);
+		spin_lock_irqsave (&urb->lock, flags);
 		tmp = urb->status;
 		if (tmp == -EINPROGRESS)
 			urb->status = -ESHUTDOWN;
-		spin_unlock (&urb->lock);
+		spin_unlock_irqrestore (&urb->lock, flags);
 
 		/* kick hcd unless it's already returning this */
 		if (tmp == -EINPROGRESS) {

