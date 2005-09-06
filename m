Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVIFOcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVIFOcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 10:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVIFOcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 10:32:54 -0400
Received: from mail4.zigzag.pl ([217.11.136.106]:49348 "HELO mail4.zigzag.pl")
	by vger.kernel.org with SMTP id S964852AbVIFOcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 10:32:53 -0400
Message-ID: <431DA887.2010008@zabrze.zigzag.pl>
Date: Tue, 06 Sep 2005 16:32:39 +0200
From: Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050827)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Patch for link detection for R8169
Content-Type: multipart/mixed;
 boundary="------------090105050307070501070907"
X-BitDefender-Scanner: Clean, Agent: BitDefender Qmail 1.6.2 on
 mail4.zigzag.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090105050307070501070907
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

There is a patch to driver of RLT8169 network card. This match make 
possible detection of the link status even if network interface is down.
This is usefull for laptop users.




--------------090105050307070501070907
Content-Type: text/plain;
 name="r8169.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="r8169.diff"

--- r8169.c	2005-09-02 15:34:52.000000000 +0200
+++ linux/drivers/net/r8169.c	2005-09-05 21:11:15.000000000 +0200
@@ -538,14 +538,27 @@
 
 static unsigned int rtl8169_tbi_link_ok(void __iomem *ioaddr)
 {
-	return RTL_R32(TBICSR) & TBILinkOk;
+	return (RTL_R32(TBICSR) & TBILinkOk) == TBILinkOk ? 1:0;
 }
 
 static unsigned int rtl8169_xmii_link_ok(void __iomem *ioaddr)
 {
-	return RTL_R8(PHYstatus) & LinkStatus;
+	return (RTL_R8(PHYstatus) & LinkStatus) == LinkStatus ? 1:0;
 }
 
+static u32 rtl8169_get_link(struct net_device *dev)
+{
+	struct rtl8169_private *np = netdev_priv(dev);
+	unsigned int result;
+	unsigned long flags;
+  
+	spin_lock_irqsave(&np->lock, flags);
+	result = np->link_ok(np->mmio_addr);
+	spin_unlock_irqrestore(&np->lock, flags);
+	return result;
+}
+
+
 static void rtl8169_tbi_reset_enable(void __iomem *ioaddr)
 {
 	RTL_W32(TBICSR, RTL_R32(TBICSR) | TBIReset);
@@ -577,6 +590,8 @@
 	spin_unlock_irqrestore(&tp->lock, flags);
 }
 
+
+
 static void rtl8169_link_option(int idx, u8 *autoneg, u16 *speed, u8 *duplex)
 {
 	struct {
@@ -1010,7 +1025,7 @@
 static struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_drvinfo		= rtl8169_get_drvinfo,
 	.get_regs_len		= rtl8169_get_regs_len,
-	.get_link		= ethtool_op_get_link,
+	.get_link		= rtl8169_get_link,/*              ethtool_op_get_link,*/
 	.get_settings		= rtl8169_get_settings,
 	.set_settings		= rtl8169_set_settings,
 	.get_msglevel		= rtl8169_get_msglevel,

--------------090105050307070501070907--

