Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWBPVtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWBPVtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWBPVtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:49:19 -0500
Received: from fmr18.intel.com ([134.134.136.17]:12674 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932358AbWBPVtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:49:18 -0500
Date: Thu, 16 Feb 2006 13:49:12 -0800 (PST)
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
X-X-Sender: jbrandeb@lindenhurst-2.jf.intel.com
To: skraw@ithnet.com, linux-kernel@vger.kernel.org
cc: jesse.brandeburg@intel.com
Subject: Re: Severe problem with e1000 driver in 2.4.31/32 (at least)
In-Reply-To: <4807377b0602161342l4b46fa3cu26a007789ba08443@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0602161344240.5564@lindenhurst-2.jf.intel.com>
References: <20060216203948.5953a1e9.skraw@ithnet.com>
 <4807377b0602161342l4b46fa3cu26a007789ba08443@mail.gmail.com>
ReplyTo: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ---------- Forwarded message ----------
> From: Stephan von Krawczynski <skraw@ithnet.com>
> today we had to experience a bug in e1000 network driver on this type of
> network card (a current PCI e1000 sold everywhere):
>
> 02:07.0 Ethernet controller: Intel Corp.: Unknown device 107c (rev 05)
>        Subsystem: Intel Corp.: Unknown device 1376
>        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
>        Memory at f9000000 (32-bit, non-prefetchable) [size=128K]
>        Memory at f9020000 (32-bit, non-prefetchable) [size=128K]
>        I/O ports at a800 [size=64]
>        Expansion ROM at <unassigned> [disabled] [size=128K]
>        Capabilities: [dc] Power Management version 2
>        Capabilities: [e4] PCI-X non-bridge device.
>
> We can simply crash the box (2.4.32 stock kernel, 2.4.31 is the same) by
> performing this:
>
> 1) Boot box with network physically disconnected
> 2) start pinging some host somewhere, you get "unreachable", let it run
> 3) connect the network and await some ping replies.
> 4) disconnect the network again
> 5) box is dead
>
> The box runs into a BUG in e1000_hw.c line 5052. The BUG shows up because the
> code is obviously executed inside an interrupt, which seems not intended.
> As this BUG is always reproducable and pretty annoying we made this pretty bad
> workaround:

Please try this patch, compile tested.  It matches up this particular code 
to what is currently in 2.6.16-rc

e1000: fix BUG reported due to calling msec_delay in irq context

There are some functions that are called in irq context that need to use
msec_delay_irq instead to avoid a BUG.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

---

  drivers/net/e1000/e1000_hw.c |    8 ++++----
  1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/e1000/e1000_hw.c b/drivers/net/e1000/e1000_hw.c
--- a/drivers/net/e1000/e1000_hw.c
+++ b/drivers/net/e1000/e1000_hw.c
@@ -5049,7 +5049,7 @@ e1000_config_dsp_after_link_change(struc
              if(ret_val)
                  return ret_val;

-            msec_delay(20);
+            msec_delay_irq(20);

              ret_val = e1000_write_phy_reg(hw, 0x0000,
                                            IGP01E1000_IEEE_FORCE_GIGA);
@@ -5073,7 +5073,7 @@ e1000_config_dsp_after_link_change(struc
              if(ret_val)
                  return ret_val;

-            msec_delay(20);
+            msec_delay_irq(20);

              /* Now enable the transmitter */
              ret_val = e1000_write_phy_reg(hw, 0x2F5B, phy_saved_data);
@@ -5098,7 +5098,7 @@ e1000_config_dsp_after_link_change(struc
              if(ret_val)
                  return ret_val;

-            msec_delay(20);
+            msec_delay_irq(20);

              ret_val = e1000_write_phy_reg(hw, 0x0000,
                                            IGP01E1000_IEEE_FORCE_GIGA);
@@ -5114,7 +5114,7 @@ e1000_config_dsp_after_link_change(struc
              if(ret_val)
                  return ret_val;

-            msec_delay(20);
+            msec_delay_irq(20);

              /* Now enable the transmitter */
              ret_val = e1000_write_phy_reg(hw, 0x2F5B, phy_saved_data);
