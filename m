Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbUJ0Xta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbUJ0Xta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbUJ0Xsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 19:48:55 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:1260 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262679AbUJ0Xpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 19:45:36 -0400
From: David Brownell <david-b@pacbell.net>
To: Colin Leroy <colin@colino.net>
Subject: Re: [PATCH] usb: don't spit out too much errors with suspended devices
Date: Wed, 27 Oct 2004 16:13:56 -0700
User-Agent: KMail/1.6.2
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20041026172843.6ac07c1a.colin@colino.net> <200410260905.14869.david-b@pacbell.net> <20041027091925.56d31d91.colin@colino.net>
In-Reply-To: <20041027091925.56d31d91.colin@colino.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410271613.56201.david-b@pacbell.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0uCgB1m8IJljnb8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0uCgB1m8IJljnb8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 27 October 2004 00:19, Colin Leroy wrote:
> On 26 Oct 2004 at 09h10, David Brownell wrote:
> 
> Hi, 
> 
> > What's wrong there is emitting voluminous diagnostics for
> > something that's not an error ... the root hub is suspended,
> > and as with any suspended device, you can't talk to it.
> > The descriptor read logic can skip retries in that case, and
> > usbfs should refuse up front to talk to suspended devices.
> > (Silently!)
> 
> Here's a patch that does it. Hope it's fine.

The "message.c" part is fine, but the usbfs/devio change
only tests one of several paths for device access.  (My
first whack at this only covered a different one!)  Can
you verify this one instead?

- Dave



--Boundary-00=_0uCgB1m8IJljnb8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Diff"

--- 1.67/drivers/usb/core/message.c	Tue Oct 26 09:42:33 2004
+++ edited/drivers/usb/core/message.c	Wed Oct 27 16:02:03 2004
@@ -704,6 +704,8 @@
 	int err;
 	unsigned int u, idx;
 
+	if (dev->state == USB_STATE_SUSPENDED)
+		return -EHOSTUNREACH;
 	if (size <= 0 || !buf || !index)
 		return -EINVAL;
 	buf[0] = 0;
--- 1.67/drivers/usb/core/devio.c	Wed Oct 20 11:45:30 2004
+++ edited/drivers/usb/core/devio.c	Wed Oct 27 16:07:40 2004
@@ -411,6 +411,8 @@
 
 static int checkintf(struct dev_state *ps, unsigned int ifnum)
 {
+	if (ps->dev->state != USB_STATE_CONFIGURED)
+		return -EHOSTUNREACH;
 	if (ifnum >= 8*sizeof(ps->ifclaimed))
 		return -EINVAL;
 	if (test_bit(ifnum, &ps->ifclaimed))
@@ -450,6 +452,8 @@
 {
 	int ret = 0;
 
+	if (ps->dev->state != USB_STATE_CONFIGURED)
+		return -EHOSTUNREACH;
 	if (USB_TYPE_VENDOR == (USB_TYPE_MASK & requesttype))
 		return 0;
 
@@ -1131,7 +1135,7 @@
 	}
 
 	if (ps->dev->state != USB_STATE_CONFIGURED)
-		retval = -ENODEV;
+		retval = -EHOSTUNREACH;
 	else if (!(intf = usb_ifnum_to_if (ps->dev, ctrl.ifno)))
                retval = -EINVAL;
 	else switch (ctrl.ioctl_code) {

--Boundary-00=_0uCgB1m8IJljnb8--
