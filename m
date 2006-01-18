Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWARWUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWARWUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWARWUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:20:46 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:51378 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932560AbWARWUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:20:45 -0500
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] ehci calling put_device from irq handler
Date: Wed, 18 Jan 2006 14:18:35 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0601181648010.4974-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0601181648010.4974-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181418.35590.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 1:54 pm, Alan Stern wrote:
> On Wed, 18 Jan 2006, Greg KH wrote:
> 
> > We can not call put_device() from irq context :(
> > 
> > I added a "might_sleep()" to the driver core and get the following from
> > the ehci driver.  Any thoughts?
> 
> In principle the put_device and corresponding get_device calls aren't
> needed.  We don't release a usb_device structure until after disabling all
> its endpoints, and disabling an endpoint will wait until all the URBs for
> that endpoint have completed.  So there's no reason to keep a reference to
> the device structure for each URB.
> 
> I see that uhci-hcd is guilty of the same thing (reference acquired for 
> each QH, released while holding a spinlock).  Probably each of the 
> host controller drivers is.

I think it dated from the days before we had any mechanism for
disabling endpoints properly, and was (important!) insurance
against the inevitable "driver disconnect() didn't work right"
class of bugs.

So it should be safe to remove those calls now.

- Dave
