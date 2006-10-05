Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWJEKcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWJEKcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWJEKcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:32:10 -0400
Received: from mail.gmx.de ([213.165.64.20]:8624 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751621AbWJEKcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:32:07 -0400
X-Authenticated: #704063
Subject: [Patch] Memory leak in drivers/usb/serial/airprime.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: andy@andynet.net
Content-Type: text/plain
Date: Thu, 05 Oct 2006 12:31:53 +0200
Message-Id: <1160044314.6153.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

the commit http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=5dda171202f94127e49c12daf780cdae1b4e668b
added a memory leak. In case we cant allocate an urb, we dont free
the buffer and leak it. Coverity id #1438

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.19-rc1/drivers/usb/serial/airprime.c.orig	2006-10-05 12:25:56.000000000 +0200
+++ linux-2.6.19-rc1/drivers/usb/serial/airprime.c	2006-10-05 12:26:35.000000000 +0200
@@ -133,6 +133,7 @@ static int airprime_open(struct usb_seri
 		}
 		urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!urb) {
+			kfree(buffer);
 			dev_err(&port->dev, "%s - no more urbs?\n",
 				__FUNCTION__);
 			result = -ENOMEM;


