Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318268AbSIOVst>; Sun, 15 Sep 2002 17:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318269AbSIOVst>; Sun, 15 Sep 2002 17:48:49 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:2751 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318268AbSIOVss>; Sun, 15 Sep 2002 17:48:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@wanadoo.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.5.26 hotplug failure
Date: Sun, 15 Sep 2002 23:53:41 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200207180950.42312.duncan.sands@wanadoo.fr> <20020718183617.GI15529@kroah.com>
In-Reply-To: <20020718183617.GI15529@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209152353.41285.duncan.sands@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 20:36, Greg KH wrote:
> On Thu, Jul 18, 2002 at 09:50:42AM +0200, Duncan Sands wrote:
> > I just gave 2.5.26 a whirl.  The first thing I noticed was
> > that the hotplug system didn't run the script for my usb
> > modem...
> >
> > kernel: usb.c: USB disconnect on device 2
> > kernel: hub.c: new USB device 00:0b.0-2, assigned address 4
> > kernel: usb.c: USB device 4 (vend/prod 0x6b9/0x4061) is not claimed by
> > any active driver. /etc/hotplug/usb.agent: ... no modules for USB product
> > 6b9/4061/0
> >
> > however this works just fine with 2.4.19-rc1 and 2.5.24 (i.e. only
> > difference is the change in kernel)...
>
> But that message is from the hotplug agent, right?
>
> What kind of script used to get run, and how was it run (i.e. on network
> interface registration, etc.)
>
> thanks,
>
> greg k-h

OK, I've worked out what was wrong (patch below): /proc/bus/usb was
being unmounted by the hotplug/usb.rc script.  After loading a HCD, usb.rc
executes the following lines:

    if [ -d /proc/bus/usb ]; then
        # If we see there are no busses, we "failed" and
        # can report so even if we're partially nonmodular.
        COUNT=`ls /proc/bus/usb | wc -l`
        if [ $COUNT -le 2 ]; then
            umount /proc/bus/usb
            rmmod usbcore >/dev/null 2>&1
            return 1
        fi

In the 2.4 kernels, /proc/bus/usb contains at least

001  devices  drivers

i.e. at least three entries.  However sometime during
the 2.5 kernel series the drivers file went away.  So
now there are only two entries and usb.rc unmounts
/proc/bus/usb.

A simple fix is to change the test to [ $COUNT -lt 2 ];

Duncan.

--- hotplug/usb.rc.orig	2002-09-15 23:29:14.000000000 +0200
+++ hotplug/usb.rc	2002-09-15 23:29:39.000000000 +0200
@@ -149,7 +149,7 @@
 	# If we see there are no busses, we "failed" and
 	# can report so even if we're partially nonmodular.
 	COUNT=`ls /proc/bus/usb | wc -l`
-	if [ $COUNT -le 2 ]; then
+	if [ $COUNT -lt 2 ]; then
 	    umount /proc/bus/usb
 	    rmmod usbcore >/dev/null 2>&1
 	    return 1
