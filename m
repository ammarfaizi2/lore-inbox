Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269690AbUJGEy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269690AbUJGEy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 00:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269691AbUJGEy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 00:54:27 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:65177 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269690AbUJGEyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 00:54:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Driver core change request
Date: Wed, 6 Oct 2004 23:54:18 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410062354.18885.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am reworking my sysfs serio patches (trying to get dynamic psmouse
protocol switching) and I am wondering if we could export device_attach
function. Serio system allows user to request device rescan - force current
driver to let go off the device and find another suitable driver. Also user
can manually request device to be disconnected/connected to a driver. By
having device_attach exported I could get rid of some duplicated code.

Also serio allows user to request a specific driver to be bound to a device
in case there are several options (psmouse/serio_raw for example). To do
that and not poke in the driver core guts too much I need something like the
following:

int driver_probe_device(struct device_driver *dev, struct device *dev)
{
        int error;
        
	dev->driver = drv;
        if (drv->probe) {
        	if ((error = drv->probe(dev))) {
                	dev->driver = NULL;
                        return error;
                }
	}
        device_bind_driver(dev);
        return 0;
}


static int bus_match(struct device * dev, struct device_driver * drv)
{
        if (dev->bus->match(dev, drv))
		return driver_probe_device(drv, dev);

        return -ENODEV;
}

I.e driver_probe_device is exported. Does it have a chance to be accepted?

Thanks!

-- 
Dmitry
