Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUFAT6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUFAT6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUFAT6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:58:10 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:4245 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265195AbUFAT5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:57:40 -0400
Date: Tue, 1 Jun 2004 21:56:48 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.6 w83627hf_wdt.c-patch
Message-ID: <20040601215648.G30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/w83627hf_wdt.c |   66 ++++++++++++++++++++++++++++-------
 1 files changed, 54 insertions(+), 12 deletions(-)

through these ChangeSets:

<P@draigBrady.com> (04/06/01 1.1818)
   [WATCHDOG] v2.6.6 w83627hf_wdt.c-patch
   
   Add w83627hf_select_wd_register and w83627hf_unselect_wd_register.
   Add w83627hf_init to fix initialization problem on certain motherboards.
   Make ping and disable code return 0 (int) on success.
   Extract set_heartbeat code to seperate function.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
--- a/drivers/char/watchdog/w83627hf_wdt.c	Tue Jun  1 21:48:45 2004
+++ b/drivers/char/watchdog/w83627hf_wdt.c	Tue Jun  1 21:48:45 2004
@@ -72,7 +72,7 @@
 #define WDT_EFDR (WDT_EFIR+1) /* Extended Function Data Register */
 
 static void
-wdt_ctrl(int timeout)
+w83627hf_select_wd_register(void)
 {
 	outb_p(0x87, WDT_EFER); /* Enter extended function mode */
 	outb_p(0x87, WDT_EFER); /* Again according to manual */
@@ -81,23 +81,64 @@
 	outb_p(0x08, WDT_EFDR); /* select logical device 8 (GPIO2) */
 	outb_p(0x30, WDT_EFER); /* select CR30 */
 	outb_p(0x01, WDT_EFDR); /* set bit 0 to activate GPIO2 */
+}
+
+static void
+w83627hf_unselect_wd_register(void)
+{
+	outb_p(0xAA, WDT_EFER); /* Leave extended function mode */
+}
+
+/* tyan motherboards seem to set F5 to 0x4C ?
+ * So explicitly init to appropriate value. */
+static void
+w83627hf_init(void)
+{
+	unsigned char t;
+
+	w83627hf_select_wd_register();
+
+	outb_p(0xF5, WDT_EFER); /* Select CRF5 */
+	t=inb_p(WDT_EFDR);      /* read CRF5 */
+	t&=~0x0C;               /* set second mode & disable keyboard turning off watchdog */
+	outb_p(t, WDT_EFDR);    /* Write back to CRF5 */
+
+	w83627hf_unselect_wd_register();
+}
+
+static void
+wdt_ctrl(int timeout)
+{
+	w83627hf_select_wd_register();
 
 	outb_p(0xF6, WDT_EFER);    /* Select CRF6 */
 	outb_p(timeout, WDT_EFDR); /* Write Timeout counter to CRF6 */
 
-	outb_p(0xAA, WDT_EFER); /* Leave extended function mode */
+	w83627hf_unselect_wd_register();
 }
 
-static void
+static int
 wdt_ping(void)
 {
 	wdt_ctrl(timeout);
+	return 0;
 }
 
-static void
+static int
 wdt_disable(void)
 {
 	wdt_ctrl(0);
+	return 0;
+}
+
+static int
+wdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 63))
+		return -EINVAL;
+
+	timeout = t;
+	return 0;
 }
 
 static ssize_t
@@ -134,7 +175,7 @@
 	static struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
-		.identity = "Advantech WDT",
+		.identity = "W83627HF WDT",
 	};
 
 	switch (cmd) {
@@ -154,9 +195,8 @@
 	case WDIOC_SETTIMEOUT:
 	  if (get_user(new_timeout, (int *)arg))
 		  return -EFAULT;
-	  if ((new_timeout < 1) || (new_timeout > 63))
+	  if (wdt_set_heartbeat(new_timeout))
 		  return -EINVAL;
-	  timeout = new_timeout;
 	  wdt_ping();
 	  /* Fall */
 
@@ -211,8 +251,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		wdt_ping();
 	}
-	clear_bit(0, &wdt_is_open);
 	expect_close = 0;
+	clear_bit(0, &wdt_is_open);
 	return 0;
 }
 
@@ -266,10 +306,10 @@
 
 	printk(KERN_INFO "WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.\n");
 
-	if (timeout < 1 || timeout > 63) {
-		timeout = WATCHDOG_TIMEOUT;
-		printk (KERN_INFO PFX "timeout value must be 1<=x<=63, using %d\n",
-			timeout);
+	if (wdt_set_heartbeat(timeout)) {
+		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk (KERN_INFO PFX "timeout value must be 1<=timeout<=63, using %d\n",
+			WATCHDOG_TIMEOUT);
 	}
 
 	if (!request_region(wdt_io, 1, WATCHDOG_NAME)) {
@@ -278,6 +318,8 @@
 		ret = -EIO;
 		goto out;
 	}
+
+	w83627hf_init();
 
 	ret = register_reboot_notifier(&wdt_notifier);
 	if (ret != 0) {
