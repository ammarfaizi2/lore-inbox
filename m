Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTHWR5F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTHWRwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:52:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63236 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264550AbTHWRsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:48:24 -0400
Date: Sat, 23 Aug 2003 18:48:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PCI PM & compatibility
Message-ID: <20030823184819.B1158@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1061649597.780.4.camel@gaston> <20030823180815.A1158@flint.arm.linux.org.uk> <1061659704.769.8.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061659704.769.8.camel@gaston>; from benh@kernel.crashing.org on Sat, Aug 23, 2003 at 07:28:25PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 07:28:25PM +0200, Benjamin Herrenschmidt wrote:
> On Sat, 2003-08-23 at 19:08, Russell King wrote:
> > On Sat, Aug 23, 2003 at 04:39:57PM +0200, Benjamin Herrenschmidt wrote:
> > > What about this patch to stay compatible with existing drivers
> > > implementing everything in save_state ?
> > 
> > And why are we now suspending device parents before their siblings???
> 
> I didn't notice that on the laptop here (because it's actually harmless
> on this specific machine), but if this is the case, then we are badly
> wrong indeed...

I think the problem is fairly fundamental to the way that we add
devices to the power lists.

When a device "A" is registered with the driver model, we call
device_add().  This adds the device to the bus, which calls any
registered driver methods.  Once the device has been added to the
bus, we add the device to the tail of the device power list.

In the case where a device driver for device "A" registers further
devices, which are siblings of device "A", two things can happen:

 - If a driver is already registered for the device, we call its
   probe method before we have added device "A" to the power lists.
   Therefore, the siblings will be added to the tail of the device
   power list _before_ the device "A" has been added.

 - If the driver registers after the device, the device "A" will be
   added to the power list _before_ the siblings.

So in one case, we have PARENT SIBLING SIBLING SIBLING and in the
other case we have SIBLING SIBLING SIBLING PARENT.

Now, we do have this pm_users thing which seems to imply that it
describes the relationship between two devices.  However, its non-
functional.  It operates on a per-device variable called "pm_users"
which is only ever _written_ !

So, it looks like the new power model is currently half a solution...

Therefore, we need to do one of two things.  Either revert Pat's
changes and return to a power model which for the most part works,
or the new power management model needs a serious work-over.

I stand by my earlier comments that it is too late to be doing this
type of development while we're supposed to be stabilising the kernel.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

