Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbULTTwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbULTTwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 14:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbULTTwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 14:52:17 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:48844 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261621AbULTTwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 14:52:07 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Scheduling while atomic (2.6.10-rc3-bk13)
Date: Mon, 20 Dec 2004 11:52:16 -0800
User-Agent: KMail/1.7.1
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <20041219231015.GB4166@mail.muni.cz> <20041220184814.GA21215@kroah.com>
In-Reply-To: <20041220184814.GA21215@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w1yxBb3rvy3yaWn"
Message-Id: <200412201152.16329.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_w1yxBb3rvy3yaWn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 20 December 2004 10:48 am, Greg KH wrote:

> 
> David, it looks like you grab a spinlock, and then call msleep(20);
> which causes this warning.
> 
> Care to fix it?

How bizarre ... I must have been tested that without spinlock
debugging, for some reason.  Grr.  I usually leave that on,
just to prevent stuff like this.

Here's a quick'n'dirty patch, msleep --> mdelay.  I'd rather
not mdelay for that long, but this late in 2.6.10 it's safer.
(And this is also what OHCI does in that same code path.)

- Dave


--Boundary-00=_w1yxBb3rvy3yaWn
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Diff"

--- 1.43/drivers/usb/host/ehci-hub.c	Fri Dec 17 18:57:39 2004
+++ edited/drivers/usb/host/ehci-hub.c	Mon Dec 20 11:48:01 2004
@@ -122,7 +122,7 @@
 		writel (temp, &ehci->regs->port_status [i]);
 	}
 	i = HCS_N_PORTS (ehci->hcs_params);
-	msleep (20);
+	mdelay (20);
 	while (i--) {
 		temp = readl (&ehci->regs->port_status [i]);
 		if ((temp & PORT_SUSPEND) == 0)

--Boundary-00=_w1yxBb3rvy3yaWn--
