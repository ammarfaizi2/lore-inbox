Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbUD3A6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUD3A6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 20:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUD3A63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 20:58:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:53641 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261942AbUD3A6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 20:58:22 -0400
Subject: Re: [PATCH] Hotplug for device power state changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <40918375.2090806@mvista.com>
References: <20040429202654.GA9971@dhcp193.mvista.com>
	 <20040429224243.L16407@flint.arm.linux.org.uk>
	 <40918375.2090806@mvista.com>
Content-Type: text/plain
Message-Id: <1083286226.20473.159.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Apr 2004 10:50:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I figured system suspend/resume would need to be a separate event and 
> isn't covered by this patch, which is for "runtime" individual device 
> suspend/resume only.  Also, the flood of notifications of all devices 
> suspending/resuming might not be useful -- the single system 
> suspend/resume event could imply these device events, although perhaps 
> in some cases something would want to know exactly which devices were 
> operable at system suspend time.  I can also send a patch for system 
> suspend/resume hotplug if there's interest.
> 
> Now that you mention it, device power hotplug should be synchronous, to 
> make sure the power management application has reacted to the changed 
> state prior to the device going into actual service (in the case of a 
> resume).

This is dangerous.

If the device you are suspending is on the VM path in any way,
beeing synchronous with a userland call can deadlock you solid.

This is even more true for system suspend where we are suspending
all devices including the main swap/storage.

There are various cases where I would have loved to get userland
more involved in the suspend/resume process for various reasons,
but in the end, I always got bitten by that problem. Userland cannot
be relied upon unless the process is made completely resident as soon
as we start the suspend dance.

More to this: If you use the "common" code in kernel/power, which I
don't (yet) use on pmac for suspend-to-ram, you'll also stop all
userland processes before notifying drivers (and suspend-to-disk
expects that).

Ben.

