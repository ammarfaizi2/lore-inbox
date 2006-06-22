Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWFVTK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWFVTK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWFVTK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:10:26 -0400
Received: from ns.suse.de ([195.135.220.2]:17297 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751819AbWFVTKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:10:25 -0400
Date: Thu, 22 Jun 2006 12:07:19 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060622190719.GA7369@kroah.com>
References: <20060622004648.f1912e34.akpm@osdl.org> <Pine.LNX.4.44L0.0606221144190.8121-100000@iolanthe.rowland.org> <20060622184649.GA6768@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622184649.GA6768@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 11:46:49AM -0700, Greg KH wrote:
> On Thu, Jun 22, 2006 at 11:51:18AM -0400, Alan Stern wrote:
> > On Thu, 22 Jun 2006, Andrew Morton wrote:
> > 
> > > On Wed, 21 Jun 2006 23:19:05 -0700
> > > Greg KH <greg@kroah.com> wrote:
> > > 
> > > > > I have the same problems also with suspend to disk. BTW I can't resume
> > > > > from disk since 2.6.17-rc5-mm1, but I'll try to be more precise
> > > > > tomorrow, as it seems removing the usb stuff makes it do some more steps
> > > > > toward resumimg (eg: with usb modules this laptop immediately reboots
> > > > > after reading all pages, without them I can reach "resuming device.."
> > > > > stage).
> > > > 
> > > > Removing uhci-hcd causes all USB devices to be removed from the system.
> > > > 
> > > > Alan, you've been working in the "generic usb" section lately, any ideas
> > > > why we can't suspend that kind of device now?
> > 
> > See below...
> > 
> > > My laptop has the same problem.
> > 
> > > Shrinking memory... done (0 pages freed)
> > > hci_usb 3-1:1.1: no suspend for driver hci_usb?
> > > hci_usb 3-1:1.0: no suspend for driver hci_usb?
> > >  usbdev3.2_ep00: not suspended
> > > usb_generic_suspend(): verify_suspended+0x0/0x3c() returns -16
> > > suspend_device(): usb_generic_suspend+0x0/0x134() returns -16
> > > Could not suspend device 3-1: error -16
> > > hci_usb 3-1:1.0: no resume for driver hci_usb?
> > > hci_usb 3-1:1.1: no resume for driver hci_usb?
> > > Some devices failed to suspend
> > > Restarting tasks... done
> > > 
> > > 
> > > What's a usbdev3.2_ep00?
> > 
> > Evidently the regression was caused by Greg's patch making endpoints into 
> > real struct devices.  usbdev3.2_ep00 is the device corresponding to 
> > endpoint 0 on device 2 of USB bus 3.
> > 
> > Is it really true that this patch has been sitting in -mm for several
> > months (as stated in the cover message to Linus for the new batch of
> > changes for 2.6.17 sent in yesterday)?
> 
> Ugh, no, you are right, the endpoint change was not in for that long,
> sorry.  I thought it did make at least one -mm though.
> 
> > There are several possible ways to fix this.  One is to add suspend and 
> > resume routines to the endpoint-device driver.  Another is to change the 
> > code that checks for the children being suspended, to make it check only 
> > for child USB devices and not child endpoints.
> 
> I think it needs to check for _USB_ devices, not just any old device
> that could possibly be attached to the main USB device (as this one is.)
> What's to stop any other struct device to bind here and cause the same
> problem?

Ok, the problem is in verify_suspended(), we are not detecting what type
of device this is.

Alan, what are you trying to check for here?  What "bogus requests" were
you seeing from sysfs that you are trying to filter out?

thanks,

greg k-h
