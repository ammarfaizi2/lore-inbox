Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbUDOPTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbUDOPTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:19:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63245 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264318AbUDOPTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:19:49 -0400
Date: Thu, 15 Apr 2004 16:19:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040415161942.A7909@flint.arm.linux.org.uk>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Maneesh Soni <maneesh@in.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040414064015.GA4505@in.ibm.com> <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk> <20040415091752.A24815@flint.arm.linux.org.uk> <20040415103849.GA24997@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040415103849.GA24997@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Thu, Apr 15, 2004 at 11:38:49AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 11:38:49AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> OTOH, eisa looks worse and the rest of them could be even uglier ;-/
> Sigh...

This also provides enough of a reason to finally go in and fix the
platform_device/driver code to be more reasonable - currently its
left up to platform device drivers to do all the conversion from
struct device to struct platform_device.

Not only that, but they also subscribe to the "PM v1" model (using
struct device_driver suspend/resume methods) whereas sysfs was
updated to "PM v2" a while ago (using the bus_type suspend/resume).

Thankfully, it's only ARM and PCMCIA which make use of platform
devices today, so it wouldn't be that difficult to go around fixing
them up.

So take that as another reason to fix struct device_driver. 8)

However, should I also mention about the possibility of the following
being in the same category; they are also typically statically
allocated...

	struct bus_type
	struct class
	struct platform_device

I think these may be worse than struct device_driver because I don't
see their unregister functions even doing any form of "wait until
unused" - so rather than being deadlock prone, they're oops-prone.

Sigh, sometimes life is <insert your favourite word to describe this>. ;(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
