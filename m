Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757168AbWKVXRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbWKVXRg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbWKVXRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:17:36 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:33504 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1756011AbWKVXRf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:17:35 -0500
Date: Thu, 23 Nov 2006 00:16:56 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
       Riku Voipio <riku.voipio@iki.fi>, linux-kernel@vger.kernel.org
Subject: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061122231656.GA9991@electric-eye.fr.zoreil.com>
References: <20061107115940.GA23954@unjust.cyrius.com> <20061108203546.GA32247@kos.to> <20061109221338.GA17722@electric-eye.fr.zoreil.com> <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121204527.GA13549@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> :
[scrouitch]

You can apply the patch below and 'modprobe r8169 ignore_parity_err=1'.

It apparently does the job and it is not much too intrusive.

diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 27f90b2..2b8c057 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -225,6 +225,7 @@ MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl
 
 static int rx_copybreak = 200;
 static int use_dac;
+static int ignore_parity_err;
 static struct {
 	u32 msg_enable;
 } debug = { -1 };
@@ -469,6 +470,8 @@ module_param(use_dac, int, 0);
 MODULE_PARM_DESC(use_dac, "Enable PCI DAC. Unsafe on 32 bit PCI slot.");
 module_param_named(debug, debug.msg_enable, int, 0);
 MODULE_PARM_DESC(debug, "Debug verbosity level (0=none, ..., 16=all)");
+module_param_named(ignore_parity_err, ignore_parity_err, bool, 0);
+MODULE_PARM_DESC(ignore_parity_err, "Ignore PCI parity error as target. Default: false");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(RTL8169_VERSION);
 
@@ -2332,12 +2335,17 @@ static void rtl8169_pcierr_interrupt(str
 	/*
 	 * The recovery sequence below admits a very elaborated explanation:
 	 * - it seems to work;
-	 * - I did not see what else could be done.
+	 * - I did not see what else could be done;
+	 * - it makes iop3xx happy.
 	 *
 	 * Feel free to adjust to your needs.
 	 */
-	pci_write_config_word(pdev, PCI_COMMAND,
-			      pci_cmd | PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
+	if (ignore_parity_err)
+		pci_cmd &= ~PCI_COMMAND_PARITY;
+	else
+		pci_cmd |= PCI_COMMAND_SERR | PCI_COMMAND_PARITY;
+
+	pci_write_config_word(pdev, PCI_COMMAND, pci_cmd);
 
 	pci_write_config_word(pdev, PCI_STATUS,
 		pci_status & (PCI_STATUS_DETECTED_PARITY |
@@ -2351,10 +2359,11 @@ static void rtl8169_pcierr_interrupt(str
 		tp->cp_cmd &= ~PCIDAC;
 		RTL_W16(CPlusCmd, tp->cp_cmd);
 		dev->features &= ~NETIF_F_HIGHDMA;
-		rtl8169_schedule_work(dev, rtl8169_reinit_task);
 	}
 
 	rtl8169_hw_reset(ioaddr);
+
+	rtl8169_schedule_work(dev, rtl8169_reinit_task);
 }
 
 static void
