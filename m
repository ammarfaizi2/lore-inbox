Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTIBXwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 19:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbTIBXwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 19:52:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:159 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261351AbTIBXwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 19:52:32 -0400
Date: Tue, 2 Sep 2003 16:52:24 -0700
From: Greg KH <greg@kroah.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Message-ID: <20030902235224.GA20901@kroah.com>
References: <200309020139.08248.mhf@linuxmail.org> <20030902164341.GF17568@kroah.com> <200309030613.19800.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309030613.19800.mhf@linuxmail.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 06:13:19AM +0800, Michael Frank wrote:
> On Wednesday 03 September 2003 00:43, Greg KH wrote:
> > On Tue, Sep 02, 2003 at 01:39:08AM +0800, Michael Frank wrote:
> > > PL2303 is used to connect the serial console on a classic serial port
> > > of a test machine. HW nandshaking is used
> > > The test machine reboots once a minute and dumps lots of messages
> > >
> > > Frequently:
> > > - driver hangs
> > > - userspace (cu) can't be stopped
> > > - pl2303 and/or usbserial can't be unloaded
> > > - USB interrupts stop
> > > - problems result in requiring a reboot.
> >
> > Hm, it looks like you physically removed the device, is that correct?
> > Or were you just unloading the pl2303 and other USB drivers and then
> > reloading them?
> >
> > What exactly were you doing in this log?
> >
> > Oh, and can you send a copy of /proc/bus/usb/devices with your pl2303
> > device plugged in?
> >
> 
> Whenever it stops working I follow this sequence, which you can match
> to the logs.
> 
> 1) Exit cu by ~.
>    - if this does not work
>        try \r~.
>        - if this does not work
>           Send SIGHUP, (which so far always worked)
> 
> 2) Start cu again
>    - if it prints leftover characters
>      exit cu again by ~. and continue from step 2)

Ah, I think I just found this problem.

Try the patch below and let me know if this solves it for you or not.

Oh, and where is the copy of /proc/bus/usb/devices with your device
plugged in?  :)

thanks,

greg k-h


# USB: fix data toggle problem for pl2303 driver.

diff -Nru a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	Tue Sep  2 16:49:31 2003
+++ b/drivers/usb/serial/pl2303.c	Tue Sep  2 16:49:31 2003
@@ -404,6 +404,9 @@
 		
 	dbg("%s -  port %d", __FUNCTION__, port->number);
 
+	usb_clear_halt(serial->dev, port->write_urb->pipe);
+	usb_clear_halt(serial->dev, port->read_urb->pipe);
+
 #define FISH(a,b,c,d)								\
 	result=usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev,0),	\
 			       b, a, c, d, buf, 1, 100);			\
