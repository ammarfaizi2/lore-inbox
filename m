Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVGVVNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVGVVNY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVGVVNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:13:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17674 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262186AbVGVVNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:13:15 -0400
Date: Fri, 22 Jul 2005 23:13:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/8139too.c: rework the debug levels
Message-ID: <20050722211309.GP3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started looking at this driver after seeing the following warnings 
with -Wundef:

<--  snip  -->

...
  CC      drivers/net/8139too.o
drivers/net/8139too.c:1961:5: warning: "RTL8139_DEBUG" is not defined
drivers/net/8139too.c:2047:5: warning: "RTL8139_DEBUG" is not defined
...

<--  snip  -->


Looking at this driver, I wondered why there were two different 
#define's controlling the debug output of the driver.

This patch consolidates this to one debug level, and the default
setting "1" results in exactly the same 8139too.o as with the old 
defaults.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/8139too.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

--- linux-2.6.13-rc3-mm1-full/drivers/net/8139too.c.old	2005-07-22 18:25:11.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/net/8139too.c	2005-07-22 18:32:17.000000000 +0200
@@ -85,7 +85,8 @@
 	Submitting bug reports:
 
 		"rtl8139-diag -mmmaaavvveefN" output
-		enable RTL8139_DEBUG below, and look at 'dmesg' or kernel log
+		set RTL8139_DEBUG to a higher debug level below,
+		and look at 'dmesg' or kernel log
 
 */
 
@@ -126,21 +127,18 @@
 #define USE_IO_OPS 1
 #endif
 
-/* define to 1 to enable copious debugging info */
-#undef RTL8139_DEBUG
+/* debug levels: 0-4 */
+#define RTL8139_DEBUG 1
 
-/* define to 1 to disable lightweight runtime debugging checks */
-#undef RTL8139_NDEBUG
 
-
-#ifdef RTL8139_DEBUG
+#if RTL8139_DEBUG > 1
 /* note: prints function name for you */
 #  define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
 #else
 #  define DPRINTK(fmt, args...)
 #endif
 
-#ifdef RTL8139_NDEBUG
+#if RTL8139_DEBUG == 0
 #  define assert(expr) do {} while (0)
 #else
 #  define assert(expr) \
@@ -1794,13 +1792,13 @@
 		tx_left--;
 	}
 
-#ifndef RTL8139_NDEBUG
+#if RTL8139_DEBUG > 0
 	if (tp->cur_tx - dirty_tx > NUM_TX_DESC) {
 		printk (KERN_ERR "%s: Out-of-sync dirty pointer, %ld vs. %ld.\n",
 		        dev->name, dirty_tx, tp->cur_tx);
 		dirty_tx += NUM_TX_DESC;
 	}
-#endif /* RTL8139_NDEBUG */
+#endif /* RTL8139_DEBUG > 0 */
 
 	/* only wake the queue if we did work, and the queue is stopped */
 	if (tp->dirty_tx != dirty_tx) {
@@ -1958,7 +1956,7 @@
 			printk(KERN_DEBUG "%s:  rtl8139_rx() status %4.4x, size %4.4x,"
 				" cur %4.4x.\n", dev->name, rx_status,
 			 rx_size, cur_rx);
-#if RTL8139_DEBUG > 2
+#if RTL8139_DEBUG > 3
 		{
 			int i;
 			DPRINTK ("%s: Frame contents ", dev->name);
@@ -2044,7 +2042,7 @@
 	if (unlikely(!received || rx_size == 0xfff0))
 		rtl8139_isr_ack(tp);
 
-#if RTL8139_DEBUG > 1
+#if RTL8139_DEBUG > 2
 	DPRINTK ("%s: Done rtl8139_rx(), current %4.4x BufAddr %4.4x,"
 		 " free to %4.4x, Cmd %2.2x.\n", dev->name, cur_rx,
 		 RTL_R16 (RxBufAddr),

