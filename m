Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161465AbWFWA27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161465AbWFWA27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161466AbWFWA27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:28:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161465AbWFWA24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:28:56 -0400
Date: Thu, 22 Jun 2006 17:32:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-Id: <20060622173215.446e9de8.akpm@osdl.org>
In-Reply-To: <20060622235259.GA30639@suse.de>
References: <20060621220656.GA10652@kroah.com>
	<Pine.LNX.4.64.0606221546120.6483@g5.osdl.org>
	<20060622234040.GB30143@suse.de>
	<Pine.LNX.4.64.0606221646200.6483@g5.osdl.org>
	<20060622235259.GA30639@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
>
> I would think it's something new too, as I did change that very line
> that oopsed.  That's why I found it odd that I couldn't reproduce it
> anymore.

device_destroy() looks wrong.  It alters the class->devices list outside
its lock.

--- 25/drivers/base/core.c~device_destroy-locking-fix	Thu Jun 22 17:29:07 2006
+++ 25-akpm/drivers/base/core.c	Thu Jun 22 17:29:34 2006
@@ -632,14 +632,13 @@ void device_destroy(struct class *class,
 	list_for_each_entry(dev_tmp, &class->devices, node) {
 		if (dev_tmp->devt == devt) {
 			dev = dev_tmp;
+			list_del_init(&dev->node);
 			break;
 		}
 	}
 	up(&class->sem);
 
-	if (dev) {
-		list_del_init(&dev->node);
+	if (dev)
 		device_unregister(dev);
-	}
 }
 EXPORT_SYMBOL_GPL(device_destroy);

That won't be it though.
