Return-Path: <linux-kernel-owner+w=401wt.eu-S1161554AbWLPWCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161554AbWLPWCU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 17:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161555AbWLPWCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 17:02:20 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:54934 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161554AbWLPWCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 17:02:19 -0500
Date: Sat, 16 Dec 2006 22:58:53 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Riku Voipio <riku.voipio@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061216215853.GC21446@electric-eye.fr.zoreil.com>
References: <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com> <20061122231656.GA9991@electric-eye.fr.zoreil.com> <20061215132740.GD11579@xi.wantstofly.org> <20061215201522.GA11288@electric-eye.fr.zoreil.com> <20061215210329.GB14860@xi.wantstofly.org> <20061216005439.GB11288@electric-eye.fr.zoreil.com> <20061216020910.GB15310@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216020910.GB15310@xi.wantstofly.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek <buytenh@wantstofly.org> :
> On Sat, Dec 16, 2006 at 01:54:39AM +0100, Francois Romieu wrote:
[...]
> I'm thinking that the entire option is just wrong.  It sucks for
> distributors to have to make the choice between having it always on
> and having it always off.  It sucks for end users compiling their
> own kernels, because their ethernet won't work out of the box, and
> they will have no idea what's wrong and what to do.

I would have hoped that it was distributors's job to figure the details
of the configuration at run time from userspace when their package manager
updates the kernel. From there they can set whatever runtime option is
necessary in the configuration file of the modutils package.

However you are right that users may get screwed when they compile their
own kernel though. What about something like the patch below:

Date: Sat, 16 Dec 2006 22:36:06 +0100
Subject: [PATCH] r8169: Aunt Tillie got a Thecus N2100 for Xmas

She compiles kernel again. If only she had been offered an Internet
connexion and an introductory guide to Google too...

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
---
 drivers/net/Kconfig |   11 +++++++++++
 drivers/net/r8169.c |    4 ++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9de0eed..57432d9 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2085,6 +2085,17 @@ config R8169_VLAN
 	  
 	  If in doubt, say Y.
 
+config R8169_SYSERR_DISABLE
+	bool "Disable reporting of the PCI SysErr"
+	depends on R8169 && ARCH_IOP32X
+	---help---
+	  Without this option, the driver reports a lot of PCI SysErr and
+	  is completely unusable with the Thecus N2100. As an alternate
+	  solution, you can use the 'ignore_parity_err' parameter of the
+	  r8169 module to cure the problem at runtime.
+
+	  If in doubt, say N.
+
 config SIS190
 	tristate "SiS190/SiS191 gigabit ethernet support"
 	depends on PCI
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index f83b41d..5e4149e 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -225,7 +225,11 @@ MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl
 
 static int rx_copybreak = 200;
 static int use_dac;
+#ifdef CONFIG_R8169_SYSERR_DISABLE
+static int ignore_parity_err = 1;
+#else
 static int ignore_parity_err;
+#endif
 static struct {
 	u32 msg_enable;
 } debug = { -1 };
-- 
1.4.4.1

