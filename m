Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVFIVRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVFIVRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVFIVRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:17:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47634 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262476AbVFIVRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:17:06 -0400
Date: Thu, 9 Jun 2005 22:16:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Adam Belay <ambx1@neo.rr.com>, matthieu castet <castet.matthieu@free.fr>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
Message-ID: <20050609221657.C14513@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Tokarev <mjt@tls.msk.ru>,
	Adam Belay <ambx1@neo.rr.com>,
	matthieu castet <castet.matthieu@free.fr>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <429FA1F3.9000001@tls.msk.ru> <42A2D37A.5050408@free.fr> <42A46551.9010707@tls.msk.ru> <20050606211855.GA3289@neo.rr.com> <42A4D1AB.3090508@tls.msk.ru> <1118224334.3245.89.camel@localhost.localdomain> <42A75525.3050704@tls.msk.ru> <1118274762.29855.2.camel@localhost.localdomain> <42A8AFA5.3090703@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42A8AFA5.3090703@tls.msk.ru>; from mjt@tls.msk.ru on Fri, Jun 10, 2005 at 01:07:49AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 01:07:49AM +0400, Michael Tokarev wrote:
> And this 8250 vs 8250_pnp (and 8250_pci etc, but
> especially 8250_pnp as it is the most interesting one).
> When loading 8250 alone (note that 8250_pnp depends
> on 8250, so 8250 gets loaded first), it detects standard
> serial port(s) just fine.  8250_pnp "redetects" them again
> (see first `modprobe 8250_pnp' above: each ttySN line
> gets repeated twice). But when unloading 8250_pnp, both
> standard ttySNs are deactivated, even when 8250 is still
> here.  More, when unloading both 8250_pnp and 8250, and
> loading *only* 8250 after that, no standard ports gets
> detected until 8250_pnp will be loaded (as the devices
> are disabled, and 8250_pnp re-enables them).  Ie, this
> whole stuff does not look right.  Probably a nitpicking,
> but a bit.. strange.  Probably if 8250_pnp will stop
> deactivating the devices (as per above), everything will
> look ok here too.  Or, maybe it's a good idea to just
> combine 8250 and 8250_pnp modules (and maybe 8250_serial
> too), esp, since the latter is very small anyway ?

The idea is that 8250 handles those serial ports.  8250_pnp, 8250_pci
and 8250_acorn etc are all probe modules which register with 8250,
know how the bus type works and tells 8250 where the ports are.

It's a cleaner design rather than stuffing multiple bus types into one
driver.

The reason that 8250 first detects your ports is that they're found
via the legacy method which is independent of PnP.  As you correctly
sumise, when you unload 8250_pnp, it disables the device so when you
re-load 8250, it's unable to detect your ports using the legacy method.

But the legacy method needs to continue to exist for systems which
don't have PnP enabled.

So, the above behaviour is completely expected and isn't a sign of
a deeper problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
