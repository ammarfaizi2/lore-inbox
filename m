Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTEMRRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTEMRRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:17:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:16885 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261832AbTEMRRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:17:05 -0400
Date: Tue, 13 May 2003 10:30:44 -0700
From: Greg KH <greg@kroah.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
Subject: Re: 2.5.69 Interrupt Latency
Message-ID: <20030513173044.GB10284@kroah.com>
References: <Pine.LNX.4.44L0.0305131117240.3274-100000@ida.rowland.org> <1052840106.2255.24.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052840106.2255.24.camel@diemos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 10:35:07AM -0500, Paul Fulghum wrote:
> On Tue, 2003-05-13 at 10:26, Alan Stern wrote:
> 
> > Putting in a sanity check for the global suspend state will be very easy.  
> > But I would like to point out that this "global suspend" does not refer to
> > the entire system, only the USB bus.
> 
> That is a problem then, because the delay can still
> occur during normal system operation.

Ok, can you try the attached patch and see if it causes your latency
problem to go away?

thanks,

greg k-h


--- a/drivers/usb/host/uhci-hcd.c	Sun May  4 23:49:54 2003
+++ b/drivers/usb/host/uhci-hcd.c	Tue May 13 10:26:02 2003
@@ -1947,6 +1947,11 @@
 
 	dbg("%x: wakeup_hc", io_addr);
 
+	/* Verify that we really should wake up the hc */
+	status = inw(io_addr + USBCMD);
+	if (!(status & USBCMD_EGSM))
+		return;
+
 	/* Global resume for 20ms */
 	outw(USBCMD_FGR | USBCMD_EGSM, io_addr + USBCMD);
 	wait_ms(20);
