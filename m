Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265114AbUD3IaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUD3IaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 04:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbUD3IaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 04:30:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41490 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265114AbUD3IaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 04:30:18 -0400
Date: Fri, 30 Apr 2004 09:30:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Todd Poynor <tpoynor@mvista.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hotplug for device power state changes
Message-ID: <20040430093012.A30928@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Todd Poynor <tpoynor@mvista.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	linux-hotplug-devel@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20040429202654.GA9971@dhcp193.mvista.com> <20040429224243.L16407@flint.arm.linux.org.uk> <40918375.2090806@mvista.com> <1083286226.20473.159.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1083286226.20473.159.camel@gaston>; from benh@kernel.crashing.org on Fri, Apr 30, 2004 at 10:50:26AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 10:50:26AM +1000, Benjamin Herrenschmidt wrote:
> This is dangerous.
> 
> If the device you are suspending is on the VM path in any way,
> beeing synchronous with a userland call can deadlock you solid.

And not being synchronous means that there's no point in calling
userland, because userland won't run before the machine has
suspended, so there's no point in calling it in the first place.
Also consider the case where you suspend, and asynchronously queue
up all these suspend scripts to run.  Then you resume and queue up
the resume scripts to run.  What order do the suspend and resume
scripts ultimately end up being run?

What if the scripts have side effects like releasing and re-acquiring
your DHCP allocation - what would be the effect of the suspend script
completing after the resume script?

What about the case where suspend/resume scripts bring up/tear down
any communication protocol?

Maybe we should have a two-pass approach, where the first pass
synchronously tells userspace about the suspend, and the second
pass does the actual suspend.  Then for resume the opposite.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
