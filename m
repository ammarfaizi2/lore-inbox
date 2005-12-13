Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVLMDo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVLMDo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 22:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVLMDo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 22:44:59 -0500
Received: from mx1.rowland.org ([192.131.102.7]:47364 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932360AbVLMDo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 22:44:58 -0500
Date: Mon, 12 Dec 2005 22:44:57 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "J.A. Magallon" <jamagallon@able.es>
cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: 2.6.15-rc5-mm1
In-Reply-To: <20051212145845.7a76da76.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0512122241270.17181-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2005, Andrew Morton wrote:

> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > > Sorry for the delay. I'm just compiling all rcs from rc2 to rc5 and will
> > > try to boot whith them.
> > > 
> > > For the rest of your questions:
> > > - I have no /etc/udev/agents.d/usb/usbcore
> > > - I have killed all the devfs compat scripts/rules (BTW, when will be finally
> > >   erradicated from  udev ;) ?
> > > - Distro: Mandriva Cooker, updated daily, udev-077 now (the hangs I reported
> > >   were with 075).
> > > 
> > > More info soon...
> > > 
> > 
> > No problems with plain rc5. It does not seem to _always_ happen on -mm1,
> > I thing I even got a clean boot, but just one. 
> > Detailed oops screenshot is here:
> > 
> > http://belly.cps.unizar.es/~magallon/oops/oops.jpg
> > 
> 
> Thanks for that.
> 
> Let's add the usb list..

Uh-oh.  Looks like this one was my fault...  Clashing uses of a local 
variable.  :-(

Does this patch fix it?

Alan Stern



Index: usb-2.6/drivers/usb/core/message.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/message.c
+++ usb-2.6/drivers/usb/core/message.c
@@ -1387,11 +1387,11 @@ free_interfaces:
 	if (dev->state != USB_STATE_ADDRESS)
 		usb_disable_device (dev, 1);	// Skip ep0
 
-	n = dev->bus_mA - cp->desc.bMaxPower * 2;
-	if (n < 0)
+	i = dev->bus_mA - cp->desc.bMaxPower * 2;
+	if (i < 0)
 		dev_warn(&dev->dev, "new config #%d exceeds power "
 				"limit by %dmA\n",
-				configuration, -n);
+				configuration, -i);
 
 	if ((ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			USB_REQ_SET_CONFIGURATION, 0, configuration, 0,

