Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUGIUeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUGIUeq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUGIUeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:34:46 -0400
Received: from [203.178.140.15] ([203.178.140.15]:47108 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S263851AbUGIUej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:34:39 -0400
Date: Sat, 10 Jul 2004 05:34:40 +0900 (JST)
Message-Id: <20040710.053440.88051135.yoshfuji@linux-ipv6.org>
To: bastian@waldi.eu.org
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org, davem@redhat.com
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040709200445.GD11138@wavehammer.waldi.eu.org>
References: <20040709194753.GB11138@wavehammer.waldi.eu.org>
	<20040710.050028.93186112.yoshfuji@linux-ipv6.org>
	<20040709200445.GD11138@wavehammer.waldi.eu.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040709200445.GD11138@wavehammer.waldi.eu.org> (at Fri, 9 Jul 2004 22:04:45 +0200), Bastian Blank <bastian@waldi.eu.org> says:

> On Sat, Jul 10, 2004 at 05:00:28AM +0900, YOSHIFUJI Hideaki / 吉藤英明 wrote:
> > It is NOT broken at all.
> 
> It does not compile at all.

Okay... Let's remove generate_eui64 part instead.
Something like this. Thanks.

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

Index: drivers/s390/net/Kconfig
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux26/drivers/s390/net/Kconfig,v
retrieving revision 1.1.1.6
diff -u -u -r1.1.1.6 Kconfig
--- linux26/drivers/s390/net/Kconfig	28 Apr 2004 10:12:42 -0000	1.1.1.6
+++ linux26/drivers/s390/net/Kconfig	9 Jul 2004 20:31:06 -0000
@@ -75,7 +75,11 @@
 	help
 	  If CONFIG_QETH is switched on, this option will include IPv6
 	  support in the qeth device driver.
-	
+
+config QETH_IPV6_IFID
+	bool "Broken private inteface identifier support"
+	depends on ((QETH = IPV6) || (QETH && IPV6 = 'y')) && BROKEN
+
 config QETH_VLAN
 	bool "VLAN support for gigabit ethernet"
 	depends on (QETH = VLAN_8021Q) || (QETH && VLAN_8021Q = 'y')
Index: drivers/s390/net/qeth_main.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux26/drivers/s390/net/qeth_main.c,v
retrieving revision 1.1.1.5
diff -u -u -r1.1.1.5 qeth_main.c
--- linux26/drivers/s390/net/qeth_main.c	17 Jun 2004 01:22:21 -0000	1.1.1.5
+++ linux26/drivers/s390/net/qeth_main.c	9 Jul 2004 20:31:07 -0000
@@ -4732,6 +4732,7 @@
 }
 
 #ifdef CONFIG_QETH_IPV6
+#ifdef CONFIG_QETH_IPV6_IFID
 int
 qeth_ipv6_generate_eui64(u8 * eui, struct net_device *dev)
 {
@@ -4751,6 +4752,7 @@
 
 }
 #endif
+#endif
 
 static void
 qeth_get_mac_for_ipm(__u32 ipm, char *mac, struct net_device *dev)
@@ -5159,10 +5161,10 @@
 #ifdef CONFIG_QETH_IPV6
 	/*IPv6 address autoconfiguration stuff*/
 	card->dev->dev_id = card->info.unique_id & 0xffff;
+#ifdef CONFIG_QETH_IPV6_IFID
 	if (!(card->info.unique_id & UNIQUE_ID_NOT_BY_CARD))
 		card->dev->generate_eui64 = qeth_ipv6_generate_eui64;
-
-
+#endif
 #endif
 	dev->hard_header_parse = NULL;
 	dev->set_mac_address = NULL;

--yoshfuji
