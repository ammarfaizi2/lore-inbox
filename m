Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUGBNUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUGBNUt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUGBNSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:18:49 -0400
Received: from sampa1.prodam.sp.gov.br ([200.230.190.2]:3849 "EHLO
	netlab96.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264500AbUGBNQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:16:58 -0400
Date: Fri, 2 Jul 2004 10:07:19 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: mcalinux@acc.umu.se, tao@acc.umu.se, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: Re: [2.6 patch] more MCA_LEGACY dependencies
Message-ID: <20040702130719.GC13384@lorien.prodam>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>, mcalinux@acc.umu.se,
	tao@acc.umu.se, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	linux-net@vger.kernel.org, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org
References: <20040702002459.GI28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702002459.GI28324@fs.tum.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello Adrian,

Em Fri, Jul 02, 2004 at 02:25:00AM +0200, Adrian Bunk escreveu:

| The patch below against 2.6.7-mm5 fixes more compile errors with 
| MCA_LEGACY=n .
| 
| diffstat output:
|  drivers/net/Kconfig           |    2 +-
|  drivers/net/at1700.c          |   12 ++++++------
|  drivers/net/eexpress.c        |    4 ++--
|  drivers/net/tokenring/Kconfig |    4 ++--
|  drivers/net/tokenring/smctr.c |   12 ++++++------
|  drivers/scsi/Kconfig          |    4 ++--
|  drivers/scsi/aha1542.c        |    2 +-
|  7 files changed, 20 insertions(+), 20 deletions(-)

[...]

|  static int __init smctr_chk_mca(struct net_device *dev)
|  {
| -#ifdef CONFIG_MCA
| +#ifdef CONFIG_MCA_LEGACY
|  	struct net_local *tp = netdev_priv(dev);
|  	int current_slot;
|  	__u8 r1, r2, r3, r4, r5;
| @@ -626,7 +626,7 @@
|  	return (0);
|  #else
|  	return (-1);
| -#endif /* CONFIG_MCA */
| +#endif /* CONFIG_MCA_LEGACY */
|  }

 what about doing things like that for #ifdef/#endif inside
functions? (not compiled):

diffstat:=
 drivers/net/tokenring/smctr.c |    6 ++----
 drivers/net/tokenring/smctr.h |    5 +++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff -X dontdiff -Nparu a/drivers/net/tokenring/smctr.c a~/drivers/net/tokenring/smctr.c
--- a/drivers/net/tokenring/smctr.c	2004-04-05 14:41:56.000000000 -0300
+++ a~/drivers/net/tokenring/smctr.c	2004-07-02 09:34:14.000000000 -0300
@@ -477,9 +477,9 @@ static int smctr_checksum_firmware(struc
         return (0);
 }
 
+#ifdef CONFIG_MCA_LEGACY
 static int __init smctr_chk_mca(struct net_device *dev)
 {
-#ifdef CONFIG_MCA
 	struct net_local *tp = netdev_priv(dev);
 	int current_slot;
 	__u8 r1, r2, r3, r4, r5;
@@ -624,10 +624,8 @@ static int __init smctr_chk_mca(struct n
         }
 
 	return (0);
-#else
-	return (-1);
-#endif /* CONFIG_MCA */
 }
+#endif /* CONFIG_MCA_LEGACY */
 
 static int smctr_chg_rx_mask(struct net_device *dev)
 {
diff -X dontdiff -Nparu a/drivers/net/tokenring/smctr.h a~/drivers/net/tokenring/smctr.h
--- a/drivers/net/tokenring/smctr.h	2003-10-08 16:24:14.000000000 -0300
+++ a~/drivers/net/tokenring/smctr.h	2004-07-02 09:56:56.000000000 -0300
@@ -9,6 +9,11 @@
 
 #ifdef __KERNEL__
 
+/* when !CONFIG_MCA_LEGACY */
+#ifndef CONFIG_MCA_LEGACY
+static inline smctr_chk_mca(struct net_device *dev) { return (-1); }
+#endif
+
 #define MAX_TX_QUEUE 10
 
 #define SMC_HEADER_SIZE 14

PS: It's a janitorial work, if you is a busy person, I can do
that.

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
