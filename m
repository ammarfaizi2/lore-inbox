Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272227AbTGYRF4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272226AbTGYRFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:05:38 -0400
Received: from dhcp538.linuxsymposium.org ([209.151.10.36]:15488 "EHLO gaston")
	by vger.kernel.org with ESMTP id S272227AbTGYRFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:05:33 -0400
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dominik Brugger <ml.dominik83@gmx.net>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059153629.528.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 25 Jul 2003 13:20:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think the hub driver's power management code may be at fault.  It needs
> to cancel the status interrupt URB when suspending and resubmit it when
> waking up; right now it probably does neither one.
> 
> Or maybe I'm wrong about that.  Perhaps it's okay to leave the URB active.  
> If that's the case, then the root hub power management code needs to be 
> changed to restart the status URB timer after a wakeup.
> 
> I'm not sure how the design is intended to work, but either way something 
> needs to be fixed.

Could well be. I need to spend some time auditing power management
in the USB drivers in general. The idea here is that a sub-driver
(USB device driver) should make sure it has no more pending URBs
when returning from suspend() and the HCD driver should just cancel
pending URBs if still any and reject any one that would be submited
before it's woken up. It's especially very important on OHCI to not
touch chip registers (like enabling bulk queue etc...) after the chip
have been put to suspend state. On some chips, that can cause random
bus mastering to main memory during sleep, which can cause all sorts
of interesting results especially when the north bridge is asleep...

Ben.

