Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264308AbUEMQpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUEMQpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbUEMQpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 12:45:36 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:48315 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264308AbUEMQpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 12:45:32 -0400
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.6 Oops disconnecting speedtouch usb modem
Date: Thu, 13 May 2004 18:45:29 +0200
User-Agent: KMail/1.5.4
Cc: Nuno Ferreira <nuno.ferreira@graycell.biz>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sf.net>
References: <Pine.LNX.4.44L0.0405131132310.1543-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0405131132310.1543-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405131845.29812.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see how that can be.  The stack dump is getting unwieldy so I
> haven't duplicated it here, but if I'm reading it right the problem occurs
> when usb_set_interface() is called by usb_unbind_interface(), which itself
> is called indirectly by device_unregister() above.  The pointer for the
> interface being unregistered has not yet been set to NULL, hence this
> shouldn't cause an oops.

No, but the pointer for another (previous) interface may just have been
set to NULL, causing an Oops when usb_ifnum_to_if loops over all
interfaces.  In other words, maybe

                for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
                        struct usb_interface    *interface;

                        /* remove this interface */
                        interface = dev->actconfig->interface[i];
                        dev_dbg (&dev->dev, "unregistering interface %s\n",
                                interface->dev.bus_id);
                        device_unregister (&interface->dev);
                        dev->actconfig->interface[i] = NULL;
                }

should be turned into

                for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
                        struct usb_interface    *interface;

                        /* remove this interface */
                        interface = dev->actconfig->interface[i];
                        dev_dbg (&dev->dev, "unregistering interface %s\n",
                                interface->dev.bus_id);
                        device_unregister (&interface->dev);
                }
                for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++)
                        dev->actconfig->interface[i] = NULL;

All the best,

Duncan.
