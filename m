Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUJJJXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUJJJXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 05:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUJJJXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 05:23:39 -0400
Received: from fep03fe.ttnet.net.tr ([212.156.4.134]:17619 "EHLO
	fep03.ttnet.net.tr") by vger.kernel.org with ESMTP id S268212AbUJJJXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 05:23:35 -0400
Message-ID: <4168FF34.2080007@ttnet.net.tr>
Date: Sun, 10 Oct 2004 12:21:56 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.28-pre4] e1000 driver, gcc-3.4 inlining fix
Content-Type: multipart/mixed;
	boundary="------------030306030204000800040607"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306030204000800040607
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Marcelo:
The changes to e1000_main.c introduced in -pre4 via the cset:
"e1000 - white space corrections, other cleanups" results in
the compiler failure below:

e1000_main.c: In function `e1000_up':
e1000_main.c:132: sorry, unimplemented: inlining failed in call to 
'e1000_irq_enable': function body not available
e1000_main.c:277: sorry, unimplemented: called from here

The attached patch, taken from 2.6, fixes it.

Ozkan Sezer


--------------030306030204000800040607
Content-Type: text/plain;
	name="e1000_gcc34.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="e1000_gcc34.diff"

--- 28p4/drivers/net/e1000/e1000_main.c.BAK	2004-10-09 14:45:37.000000000 +0300
+++ 28p4/drivers/net/e1000/e1000_main.c	2004-10-10 12:15:15.000000000 +0300
@@ -128,8 +128,8 @@
 static struct net_device_stats * e1000_get_stats(struct net_device *netdev);
 static int e1000_change_mtu(struct net_device *netdev, int new_mtu);
 static int e1000_set_mac(struct net_device *netdev, void *p);
-static inline void e1000_irq_disable(struct e1000_adapter *adapter);
-static inline void e1000_irq_enable(struct e1000_adapter *adapter);
+static void e1000_irq_disable(struct e1000_adapter *adapter);
+static void e1000_irq_enable(struct e1000_adapter *adapter);
 static irqreturn_t e1000_intr(int irq, void *data, struct pt_regs *regs);
 static boolean_t e1000_clean_tx_irq(struct e1000_adapter *adapter);
 #ifdef CONFIG_E1000_NAPI
@@ -146,9 +146,9 @@
 void set_ethtool_ops(struct net_device *netdev);
 static void e1000_enter_82542_rst(struct e1000_adapter *adapter);
 static void e1000_leave_82542_rst(struct e1000_adapter *adapter);
-static inline void e1000_rx_checksum(struct e1000_adapter *adapter,
-                                     struct e1000_rx_desc *rx_desc,
-                                     struct sk_buff *skb);
+static void e1000_rx_checksum(struct e1000_adapter *adapter,
+                              struct e1000_rx_desc *rx_desc,
+                              struct sk_buff *skb);
 static void e1000_tx_timeout(struct net_device *dev);
 static void e1000_tx_timeout_task(struct net_device *dev);
 static void e1000_smartspeed(struct e1000_adapter *adapter);
@@ -2063,7 +2063,7 @@
  * @adapter: board private structure
  **/
 
-static inline void
+static void
 e1000_irq_disable(struct e1000_adapter *adapter)
 {
 	atomic_inc(&adapter->irq_sem);
@@ -2077,7 +2077,7 @@
  * @adapter: board private structure
  **/
 
-static inline void
+static void
 e1000_irq_enable(struct e1000_adapter *adapter)
 {
 	if(likely(atomic_dec_and_test(&adapter->irq_sem))) {
@@ -2582,7 +2582,7 @@
  * @sk_buff: socket buffer with received data
  **/
 
-static inline void
+static void
 e1000_rx_checksum(struct e1000_adapter *adapter,
                   struct e1000_rx_desc *rx_desc,
                   struct sk_buff *skb)

--------------030306030204000800040607--
