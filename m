Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUJHTIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUJHTIy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 15:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270081AbUJHSU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:20:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55311 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269837AbUJHSNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:13:31 -0400
Date: Fri, 8 Oct 2004 19:13:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org,
       jgarzik@pobox.com, marcelo.tosatti@cyclades.com
Subject: Re: [patch 2.4.28-pre3] 3c59x: resync with 2.6
Message-ID: <20041008191324.J17999@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	akpm@osdl.org, jgarzik@pobox.com, marcelo.tosatti@cyclades.com
References: <20041008121307.C14378@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041008121307.C14378@tuxdriver.com>; from linville@tuxdriver.com on Fri, Oct 08, 2004 at 12:13:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 12:13:07PM -0400, John W. Linville wrote:
> Backport of current 3c59x driver (minus EISA/sysfs stuff) from 2.6 to
> 2.4.  This should ease further maintenance in 2.4.
> ---
> I've been chasing some 3c59x driver problems on both 2.4.x and 2.6.x
> kernels.  The 3c59x driver was pretty far out of sync between the two
> trees, so I thought it made sense to sync them back up.

Ah, if someone's looking at the 3c59x driver then please look into the
NWAY autonegotiation code - even maybe update it to use mii.c.

Currently 3c59x is rather buggy - it's a fairly simple bug.  Consider
this:

# mii-tool -v
eth0: negotiated 100baseTx-HD, link ok
  product info: TDK 78Q2120 rev 11
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-HD 10baseT-HD
  advertising:  100baseTx-HD 10baseT-HD
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control

and then wonder why we end up like this:

eth0: Setting full-duplex based on MII #0 link partner capability of 45e1.

Obviously completely bogus.  Luckily, there isn't that much traffic
to this card _and_ it's connected to a switch so it doesn't interfere
much with other network traffic.  However, it is _dog_ slow when doing
large transfers to/from it.

FYI, it's:

04:00.0 Ethernet controller: 3Com Corporation 3c575 [Megahertz] 10/100 LAN CardBus (rev 01)

aka 3CCFE575BT.  The BT version only has a HD-capable MII transceiver,
whereas the CT version has a FD-capable MII transceiver fitted.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
