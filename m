Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTDXXgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTDXXgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:36:02 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:30869 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264495AbTDXXeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280523224@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280511591@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:32 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.4, 2003/04/23 12:05:40-07:00, david-b@pacbell.net

[PATCH] usb: fix (rare?) disconnect

It's not good to dereference pointers before checking
them for null.  Seen once on a faulty device init,
which I don't think I'd ever seen before "in the wild".
(Caused by some other 2.5.68 strangeness.)


 drivers/usb/core/usb.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)


diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Thu Apr 24 16:27:39 2003
+++ b/drivers/usb/core/usb.c	Thu Apr 24 16:27:39 2003
@@ -791,14 +791,22 @@
 void usb_disconnect(struct usb_device **pdev)
 {
 	struct usb_device	*dev = *pdev;
-	struct usb_bus		*bus = dev->bus;
-	struct usb_operations	*ops = bus->op;
+	struct usb_bus		*bus;
+	struct usb_operations	*ops;
 	int			i;
 
 	might_sleep ();
 
-	if (!dev)
+	if (!dev) {
+		pr_debug ("%s nodev\n", __FUNCTION__);
 		return;
+	}
+	bus = dev->bus;
+	if (!bus) {
+		pr_debug ("%s nobus\n", __FUNCTION__);
+		return;
+	}
+	ops = bus->op;
 
 	*pdev = NULL;
 

