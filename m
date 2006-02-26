Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWBZKmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWBZKmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 05:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWBZKmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 05:42:19 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:62727 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750765AbWBZKmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 05:42:18 -0500
Date: Sun, 26 Feb 2006 11:42:07 +0100
From: Willy TARREAU <willy@w.ods.org>
To: Paul Rolland <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux.nics@intel.com,
       cramerj@intel.com, john.ronciak@intel.com, Ganesh.Venkatesan@intel.com
Subject: Re: [2.4.32 - 2.6.15.4] e1000 - Fix mii interface
Message-ID: <20060226104206.GA11434@w.ods.org>
References: <20060225085409.GA22456@infradead.org> <007801c639f3$79388060$2001a8c0@cortex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007801c639f3$79388060$2001a8c0@cortex>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Sat, Feb 25, 2006 at 11:08:49AM +0100, Paul Rolland wrote:
> Hello,
> 
> This patch is based on Linux 2.4.32, and I've verified the same problem
> exists on 2.6.15.4.

it's mangled, tabs have been turned into whitespaces. I fixed it so please
use the appended one.

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
> ...
> and
> int
> e1000_set_spd_dplx(struct e1000_adapter *adapter, uint16_t spddplx)
> {
>         adapter->hw.autoneg = 0;
> 
>         switch(spddplx) {
>         case SPEED_10 + DUPLEX_HALF:
>                 adapter->hw.forced_speed_duplex = e1000_10_half;
>                 break;
> ....
> when the constants don't have the same value.
> 
> This patch is simply changing the code in the e1000_set_spd_dplx to use the
> same constants as does the caller of the function : FULL_DUPLEX and
> HALF_DUPLEX
> whose values are not 0, to make sure we have had a successfull init
> (DUPLEX_HALF value is 0, and the DUPLEX_xxx are defined in ethtool.h, thus
> are probably not meant to be used in the mii interface).
> 
> Signed-off-by: Paul Rolland <rol@as2917.net>
> 
> diff -urN linux-2.4.32-orig/drivers/net/e1000/e1000_main.c
> linux-2.4.32/drivers/net/e1000/e1000_main.c
> --- linux-2.4.32-orig/drivers/net/e1000/e1000_main.c    Mon Apr  4 01:42:19
> 2005
> +++ linux-2.4.32/drivers/net/e1000/e1000_main.c Sat Feb 25 09:36:23 2006
> @@ -2944,23 +2944,23 @@
>         adapter->hw.autoneg = 0;
>  
>         switch(spddplx) {
> -       case SPEED_10 + DUPLEX_HALF:
> +       case SPEED_10 + HALF_DUPLEX:
>                 adapter->hw.forced_speed_duplex = e1000_10_half;
>                 break;
> -       case SPEED_10 + DUPLEX_FULL:
> +       case SPEED_10 + FULL_DUPLEX:
>                 adapter->hw.forced_speed_duplex = e1000_10_full;
>                 break;
> -       case SPEED_100 + DUPLEX_HALF:
> +       case SPEED_100 + HALF_DUPLEX:
>                 adapter->hw.forced_speed_duplex = e1000_100_half;
>                 break;
> -       case SPEED_100 + DUPLEX_FULL:
> +       case SPEED_100 + FULL_DUPLEX:
>                 adapter->hw.forced_speed_duplex = e1000_100_full;
>                 break;
> -       case SPEED_1000 + DUPLEX_FULL:
> +       case SPEED_1000 + FULL_DUPLEX:
>                 adapter->hw.autoneg = 1;
>                 adapter->hw.autoneg_advertised = ADVERTISE_1000_FULL;
>                 break;
> -       case SPEED_1000 + DUPLEX_HALF: /* not supported */
> +       case SPEED_1000 + HALF_DUPLEX: /* not supported */
>         default:
>                 DPRINTK(PROBE, ERR, 
>                         "Unsupported Speed/Duplexity configuration\n");
> 
> 
> Paul Rolland, rol(at)as2917.net
> ex-AS2917 Network administrator and Peering Coordinator

Regards,
Willy


diff -urN linux-2.4.32-orig/drivers/net/e1000/e1000_main.c linux-2.4.32/drivers/net/e1000/e1000_main.c
--- linux-2.4.32-orig/drivers/net/e1000/e1000_main.c    Mon Apr  4 01:42:19 2005
+++ linux-2.4.32/drivers/net/e1000/e1000_main.c Sat Feb 25 09:36:23 2006
@@ -2944,23 +2944,23 @@
 	adapter->hw.autoneg = 0;
 
 	switch(spddplx) {
-	case SPEED_10 + DUPLEX_HALF:
+	case SPEED_10 + HALF_DUPLEX:
 		adapter->hw.forced_speed_duplex = e1000_10_half;
 		break;
-	case SPEED_10 + DUPLEX_FULL:
+	case SPEED_10 + FULL_DUPLEX:
 		adapter->hw.forced_speed_duplex = e1000_10_full;
 		break;
-	case SPEED_100 + DUPLEX_HALF:
+	case SPEED_100 + HALF_DUPLEX:
 		adapter->hw.forced_speed_duplex = e1000_100_half;
 		break;
-	case SPEED_100 + DUPLEX_FULL:
+	case SPEED_100 + FULL_DUPLEX:
 		adapter->hw.forced_speed_duplex = e1000_100_full;
 		break;
-	case SPEED_1000 + DUPLEX_FULL:
+	case SPEED_1000 + FULL_DUPLEX:
 		adapter->hw.autoneg = 1;
 		adapter->hw.autoneg_advertised = ADVERTISE_1000_FULL;
 		break;
-	case SPEED_1000 + DUPLEX_HALF: /* not supported */
+	case SPEED_1000 + HALF_DUPLEX: /* not supported */
 	default:
 		DPRINTK(PROBE, ERR, 
 			"Unsupported Speed/Duplexity configuration\n");



