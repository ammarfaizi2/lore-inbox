Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbUJ0HVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUJ0HVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbUJ0HVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 03:21:19 -0400
Received: from colino.net ([213.41.131.56]:27888 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261522AbUJ0HUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 03:20:41 -0400
Date: Wed, 27 Oct 2004 09:19:25 +0200
From: Colin Leroy <colin@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: don't spit out too much errors with suspended devices
Message-ID: <20041027091925.56d31d91.colin@colino.net>
In-Reply-To: <200410260905.14869.david-b@pacbell.net>
References: <20041026172843.6ac07c1a.colin@colino.net>
	<200410260905.14869.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs132.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Oct 2004 at 09h10, David Brownell wrote:

Hi, 

> What's wrong there is emitting voluminous diagnostics for
> something that's not an error ... the root hub is suspended,
> and as with any suspended device, you can't talk to it.
> The descriptor read logic can skip retries in that case, and
> usbfs should refuse up front to talk to suspended devices.
> (Silently!)

Here's a patch that does it. Hope it's fine.

Signed-off-by: Colin Leroy <colin@colino.net>

--- a/drivers/usb/core/message.c	2004-10-27 09:09:34.332120419 +0200
+++ b/drivers/usb/core/message.c	2004-10-27 09:15:05.323320163 +0200
@@ -703,6 +705,8 @@
 	int err;
 	unsigned int u, idx;
 
+	if (dev->state == USB_STATE_SUSPENDED)
+		return -EHOSTUNREACH;
 	if (size <= 0 || !buf || !index)
 		return -EINVAL;
 	buf[0] = 0;
--- a/drivers/usb/core/devio.c	2004-10-27 09:08:45.401856241 +0200
+++ b/drivers/usb/core/devio.c	2004-10-27 09:16:09.079846340 +0200
@@ -541,6 +541,8 @@
 	unsigned char *tbuf;
 	int i, j, ret;
 
+	if (dev->state == USB_STATE_SUSPENDED)
+		return -EHOSTUNREACH;
 	if (copy_from_user(&ctrl, arg, sizeof(ctrl)))
 		return -EFAULT;
 	if ((ret = check_ctrlrecip(ps, ctrl.bRequestType, ctrl.wIndex)))
