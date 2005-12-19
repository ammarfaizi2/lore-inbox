Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVLSC5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVLSC5d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 21:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVLSC5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 21:57:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:16864 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932460AbVLSC5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 21:57:32 -0500
Subject: Re: USB rejecting sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051218222516.GA19183@kroah.com>
References: <1134937642.6102.85.camel@gaston>
	 <20051218215051.GA18257@kroah.com> <1134944031.6102.103.camel@gaston>
	 <20051218222516.GA19183@kroah.com>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 13:51:45 +1100
Message-Id: <1134960706.6162.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 14:25 -0800, Greg KH wrote:
> On Mon, Dec 19, 2005 at 09:13:50AM +1100, Benjamin Herrenschmidt wrote:
> > On Sun, 2005-12-18 at 13:50 -0800, Greg KH wrote:
> > 
> > > Yes it is, and I have a patch in my tree now that fixes this up and
> > > keeps the suspend process working properly for usb drivers that do not
> > > have a suspend function.
> > > 
> > > Hm, I wonder if it should go in for 2.6.15?
> > 
> > Do you have an URL I can send to those users to test ?
> 
> Here's the patch itself, feel free to spread it around.
> 
> It's also at:
>   kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usbcore-allow-suspend-resume-even-if-drivers-don-t-support-it.patch

Ok, I did a bit more tests here with a Keyspan adapter on my laptop
(well known driver for not having the suspend/resume routines).

The good thing is with the patch, the machine goes to sleep. However,
the device is not disconnected/reconnected. What happens it that the bus
gets suspended anyway and the driver stays around (possibly getting
errors on some URBs).

This is fine, but not optimal, since that means most of the time that
the device will not work on resume unless disconnected/reconnected. (For
keyspan, it seems that the HW does support the suspend state, thus it's
just a matter of closing/re-opening the port, I suppose it would be easy
enough to fix the driver).

So this patch is good for it doesn't prevent sleep anymore, but it also
doesn't do what we decided it should do. I think David is right that we
should be able to disconnect the device without actually removing the
device & driver from sysfs, just let that happen at resume time.

Ben.


