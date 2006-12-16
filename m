Return-Path: <linux-kernel-owner+w=401wt.eu-S1422864AbWLPXws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWLPXws (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 18:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbWLPXws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 18:52:48 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:60002 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422864AbWLPXwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 18:52:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:in-reply-to:user-agent;
	b=EpTheGoq8/vnoR7XASWHwAgxuKq2fqWZAmFGB6AjikjGdwd0YhmWQAoOpuAML
	XM/UAYdIWmpMi0JjzUB6UoYww==
Date: Sun, 17 Dec 2006 00:52:45 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Martin Michlmayr <tbm@cyrius.com>, Riku Voipio <riku.voipio@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061216235245.GA23238@xi.wantstofly.org>
References: <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com> <20061122231656.GA9991@electric-eye.fr.zoreil.com> <20061215132740.GD11579@xi.wantstofly.org> <20061215201522.GA11288@electric-eye.fr.zoreil.com> <20061215210329.GB14860@xi.wantstofly.org> <20061215211435.GB10367@flint.arm.linux.org.uk> <20061216230901.GA23143@xi.wantstofly.org> <20061216233134.GA25177@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216233134.GA25177@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2006 at 12:31:34AM +0100, Francois Romieu wrote:

> > Sounds good.  How about something like the patch below plus the
> > corresponding r8169 diff?
> 
> Go wild.

Martin/Riku, I'm pretty busy with other stuff at the moment, can you
give this (on top of 2.6.20-rc1) a spin?  


Index: linux-2.6.19/arch/arm/mach-iop32x/n2100.c
===================================================================
--- linux-2.6.19.orig/arch/arm/mach-iop32x/n2100.c
+++ linux-2.6.19/arch/arm/mach-iop32x/n2100.c
@@ -123,9 +123,13 @@ static struct hw_pci n2100_pci __initdat
 
 static int __init n2100_pci_init(void)
 {
-	if (machine_is_n2100())
+	if (machine_is_n2100()) {
 		pci_common_init(&n2100_pci);
 
+		pci_get_bus_and_slot(0, 0x08)->broken_parity_status = 1;
+		pci_get_bus_and_slot(0, 0x10)->broken_parity_status = 1;
+	}
+
 	return 0;
 }
 
Index: linux-2.6.19/drivers/net/r8169.c
===================================================================
--- linux-2.6.19.orig/drivers/net/r8169.c
+++ linux-2.6.19/drivers/net/r8169.c
@@ -225,7 +225,6 @@ MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl
 
 static int rx_copybreak = 200;
 static int use_dac;
-static int ignore_parity_err;
 static struct {
 	u32 msg_enable;
 } debug = { -1 };
@@ -471,8 +470,6 @@ module_param(use_dac, int, 0);
 MODULE_PARM_DESC(use_dac, "Enable PCI DAC. Unsafe on 32 bit PCI slot.");
 module_param_named(debug, debug.msg_enable, int, 0);
 MODULE_PARM_DESC(debug, "Debug verbosity level (0=none, ..., 16=all)");
-module_param_named(ignore_parity_err, ignore_parity_err, bool, 0);
-MODULE_PARM_DESC(ignore_parity_err, "Ignore PCI parity error as target. Default: false");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(RTL8169_VERSION);
 
@@ -2388,7 +2385,7 @@ static void rtl8169_pcierr_interrupt(str
 	 *
 	 * Feel free to adjust to your needs.
 	 */
-	if (ignore_parity_err)
+	if (pdev->broken_parity_status)
 		pci_cmd &= ~PCI_COMMAND_PARITY;
 	else
 		pci_cmd |= PCI_COMMAND_SERR | PCI_COMMAND_PARITY;
