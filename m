Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbUKTJut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbUKTJut (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 04:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUKTJut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 04:50:49 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:65510 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261456AbUKTJud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 04:50:33 -0500
Message-ID: <419F136B.8010308@free.fr>
Date: Sat, 20 Nov 2004 10:50:35 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee> <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee> <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>
Content-Type: multipart/mixed;
 boundary="------------090002060204090107060501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090002060204090107060501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Meelis Roos wrote:
> 
> I tried it with pnpbios (acpi=off) and it started to work after auto and 
> activate (but not with auto alone):
> 
> nartsiss:/# modprobe smsc-ircc2
> found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
> smsc_superio_flat(): IrDA not enabled
> smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02
> FATAL: Error inserting smsc_ircc2 
> (/lib/modules/2.6.10-rc2/kernel/drivers/net/irda/smsc-ircc2.ko): No such 
> device
> nartsiss:/# echo activate > resources
> pnp: Device 00:0f activated.
> nartsiss:/# modprobe smsc-ircc2
> found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
> smsc_superio_flat(): fir: 0x2e8, sir: 0x100, dma: 03, irq: 5, mode: 0x0e
> SMsC IrDA Controller found
>  IrCC version 2.0, firport 0x2e8, sirport 0x100 dma=3, irq=5
> No transceiver found. Defaulting to Fast pin select
> IrDA: Registered device irda0
> 
>>>> Could you send me the result of : "for i in /sys/bus/pnp/devices/*; 
>>>> do cat $i/id $i/options; done" in order to see if other devices have 
>>>> missing resources ?
> 
> 
> The output with pnpbios is below for comparision.
> 
[..]

Ok, I have catch the problem : the pnpacpi parser supposed that are no 
resource after EndDependentFn.

Could you try this patch with pnpacpi?


Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>


--------------090002060204090107060501
Content-Type: text/x-patch;
 name="pnpacpi_parser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_parser.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/rsparser.c.old	2004-11-12 22:55:10.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/rsparser.c	2004-11-20 10:44:36.000000000 +0100
@@ -443,6 +443,7 @@
 
 struct acpipnp_parse_option_s {
 	struct pnp_option *option;
+	struct pnp_option *independent_option;
 	struct pnp_dev *dev;
 };
 
@@ -506,7 +507,15 @@
 			parse_data->option = option;	
 			break;
 		case ACPI_RSTYPE_END_DPF:
-			return AE_CTRL_TERMINATE;
+			//return AE_CTRL_TERMINATE;
+			//only one EndDependentFn is allowed
+			if (!parse_data->independent_option) {
+				pnp_warn("PnPACPI: more than one EndDependentFn");
+				return AE_ERROR;
+			}
+			parse_data->option = parse_data->independent_option;
+			parse_data->independent_option = NULL;
+			break;
 		default:
 			pnp_warn("PnPACPI:Option type: %d not handle", res->id);
 			return AE_ERROR;
@@ -524,6 +533,7 @@
 	parse_data.option = pnp_register_independent_option(dev);
 	if (!parse_data.option)
 		return AE_ERROR;
+	parse_data.independent_option = parse_data.option;
 	parse_data.dev = dev;
 	status = acpi_walk_resources(handle, METHOD_NAME__PRS, 
 		pnpacpi_option_resource, &parse_data);

--------------090002060204090107060501--
