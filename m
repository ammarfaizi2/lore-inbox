Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWB1CcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWB1CcH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 21:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWB1CcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 21:32:07 -0500
Received: from fmr19.intel.com ([134.134.136.18]:25218 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750712AbWB1CcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 21:32:05 -0500
Date: Mon, 27 Feb 2006 18:31:52 -0800 (Pacific Standard Time)
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: rol@as2917.net, linux-kernel@vger.kernel.org
cc: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, netdev@vger.kernel.org,
       john.ronciak@intel.com
Subject: Re: [2.4.32 - 2.6.15.4] e1000 - Fix mii interface
In-Reply-To: <4807377b0602271234v4b6cdeecpbcf8d4a6ac51cd20@mail.gmail.com>
Message-ID: <Pine.WNT.4.63.0602271818570.284@jbrandeb-desk.amr.corp.intel.com>
References: <20060225085409.GA22456@infradead.org> <007801c639f3$79388060$2001a8c0@cortex>
 <4807377b0602271234v4b6cdeecpbcf8d4a6ac51cd20@mail.gmail.com>
ReplyTo: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
X-X-Sender: jbrandeb@orsmsx408.amr.corp.intel.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Paul Rolland <rol@as2917.net>
> 
> Hello,
> 
> This patch is based on Linux 2.4.32, and I've verified the same problem
> exists on 2.6.15.4.
> Working on a machine with a 2.4.32 kernel, I was surprised to see the driver
> complaining when setting the speed to 100FD using mii-tool, but accepting
> the setting with ethtool.
> Digging into the code, I found that there is some confusion with :
>  - DUPLEX_FULL and FULL_DUPLEX,
>  - DUPLEX_HALF and HALF_DUPLEX
> in the code :
> ...
>                            spddplx += (mii_reg & 0x100)
>                                        ? FULL_DUPLEX :
>                                        HALF_DUPLEX;
>                            retval = e1000_set_spd_dplx(adapter,
>                                                        spddplx);

Please try this patch:

e1000: fix mii-tool access to setting speed and duplex

Paul Rolland reported that e1000 was having a hard time using mii-tool to
set speed and duplex.  This patch fixes the issue on both newer hardware as
well as fixing the code issue that originally caused the problem.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
CC: Paul Rolland <rol@as2917.net>

---

  drivers/net/e1000/e1000_main.c |    6 +++---
  1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 31e3329..9730c2e 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -4269,7 +4269,7 @@ e1000_mii_ioctl(struct net_device *netde
  			spin_unlock_irqrestore(&adapter->stats_lock, flags);
  			return -EIO;
  		}
-		if (adapter->hw.phy_type == e1000_phy_m88) {
+		if (adapter->hw.media_type == e1000_media_type_copper) {
  			switch (data->reg_num) {
  			case PHY_CTRL:
  				if (mii_reg & MII_CR_POWER_DOWN)
@@ -4285,8 +4285,8 @@ e1000_mii_ioctl(struct net_device *netde
  					else
  						spddplx = SPEED_10;
  					spddplx += (mii_reg & 0x100)
-						   ? FULL_DUPLEX :
-						   HALF_DUPLEX;
+						   ? DUPLEX_FULL :
+						   DUPLEX_HALF;
  					retval = e1000_set_spd_dplx(adapter,
  								    spddplx);
  					if (retval) {
