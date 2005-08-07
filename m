Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752639AbVHGTns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbVHGTns (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbVHGTns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:43:48 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18438 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752638AbVHGTnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:43:47 -0400
Date: Sun, 7 Aug 2005 21:43:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Avuton Olrich <avuton@gmail.com>, jgarzik@pobox.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [-mm patch] fix PHYCONTROL=n compilation
Message-ID: <20050807194342.GK3513@stusta.de>
References: <20050807014214.45968af3.akpm@osdl.org> <3aa654a4050807115128ba35de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa654a4050807115128ba35de@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 11:51:23AM -0700, Avuton Olrich wrote:
> On 8/7/05, Andrew Morton <akpm@osdl.org> wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc5/2.6.13-rc5-mm1/
> 
> I probably don't need/want phy stuff anyhow, but when I tried it:
> 
> Problem:
> drivers/built-in.o: In function `phy_start_machine':
> : undefined reference to `phy_timer'
> drivers/built-in.o: In function `phy_stop_machine':
> : undefined reference to `phy_stop_interrupts'
> make: *** [.tmp_vmlinux1] Error 1
>...

Thanks for this report, it seems noone aactually tried whether 
CONFIG_PHYCONTROL=n compiles...

A possible patch is below.


<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/phy/phy.c |  141 +++++++++++++++++++++---------------------
 1 files changed, 71 insertions(+), 70 deletions(-)

--- linux-2.6.13-rc5-mm1/drivers/net/phy/phy.c.old	2005-08-07 21:18:29.000000000 +0200
+++ linux-2.6.13-rc5-mm1/drivers/net/phy/phy.c	2005-08-07 21:29:33.000000000 +0200
@@ -39,7 +39,6 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
-static void phy_change(void *data);
 static void phy_timer(unsigned long data);
 
 /* Convenience function to print out the current phy status
@@ -273,31 +272,6 @@
 }
 EXPORT_SYMBOL(phy_sanitize_settings);
 
-/* phy_force_reduction
- *
- * description: Reduces the speed/duplex settings by
- *   one notch.  The order is so:
- *   1000/FULL, 1000/HALF, 100/FULL, 100/HALF,
- *   10/FULL, 10/HALF.  The function bottoms out at 10/HALF.
- */
-static void phy_force_reduction(struct phy_device *phydev)
-{
-	int idx;
-
-	idx = phy_find_setting(phydev->speed, phydev->duplex);
-	
-	idx++;
-
-	idx = phy_find_valid(idx, phydev->supported);
-
-	phydev->speed = settings[idx].speed;
-	phydev->duplex = settings[idx].duplex;
-
-	pr_info("Trying %d/%s\n", phydev->speed,
-			DUPLEX_FULL == phydev->duplex ?
-			"FULL" : "HALF");
-}
-
 /* phy_ethtool_sset:
  * A generic ethtool sset function.  Handles all the details
  *
@@ -464,7 +438,6 @@
 	phydev->adjust_state = NULL;
 }
 
-#ifdef CONFIG_PHYCONTROL
 /* phy_error:
  *
  * Moves the PHY to the HALTED state in response to a read
@@ -479,6 +452,75 @@
 	spin_unlock(&phydev->lock);
 }
 
+/* Disable the PHY interrupts from the PHY side */
+int phy_disable_interrupts(struct phy_device *phydev)
+{
+	int err;
+
+	/* Disable PHY interrupts */
+	err = phy_config_interrupt(phydev, PHY_INTERRUPT_DISABLED);
+
+	if (err)
+		goto phy_err;
+
+	/* Clear the interrupt */
+	err = phy_clear_interrupt(phydev);
+
+	if (err)
+		goto phy_err;
+
+	return 0;
+
+phy_err:
+	phy_error(phydev);
+
+	return err;
+}
+EXPORT_SYMBOL(phy_disable_interrupts);
+
+int phy_stop_interrupts(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_disable_interrupts(phydev);
+
+	if (err)
+		phy_error(phydev);
+
+	free_irq(phydev->irq, phydev);
+
+	return err;
+}
+EXPORT_SYMBOL(phy_stop_interrupts);
+
+/* phy_force_reduction
+ *
+ * description: Reduces the speed/duplex settings by
+ *   one notch.  The order is so:
+ *   1000/FULL, 1000/HALF, 100/FULL, 100/HALF,
+ *   10/FULL, 10/HALF.  The function bottoms out at 10/HALF.
+ */
+static void phy_force_reduction(struct phy_device *phydev)
+{
+	int idx;
+
+	idx = phy_find_setting(phydev->speed, phydev->duplex);
+	
+	idx++;
+
+	idx = phy_find_valid(idx, phydev->supported);
+
+	phydev->speed = settings[idx].speed;
+	phydev->duplex = settings[idx].duplex;
+
+	pr_info("Trying %d/%s\n", phydev->speed,
+			DUPLEX_FULL == phydev->duplex ?
+			"FULL" : "HALF");
+}
+
+#ifdef CONFIG_PHYCONTROL
+
+static void phy_change(void *data);
 /* phy_interrupt
  *
  * description: When a PHY interrupt occurs, the handler disables
@@ -515,32 +557,6 @@
 }
 EXPORT_SYMBOL(phy_enable_interrupts);
 
-/* Disable the PHY interrupts from the PHY side */
-int phy_disable_interrupts(struct phy_device *phydev)
-{
-	int err;
-
-	/* Disable PHY interrupts */
-	err = phy_config_interrupt(phydev, PHY_INTERRUPT_DISABLED);
-
-	if (err)
-		goto phy_err;
-
-	/* Clear the interrupt */
-	err = phy_clear_interrupt(phydev);
-
-	if (err)
-		goto phy_err;
-
-	return 0;
-
-phy_err:
-	phy_error(phydev);
-
-	return err;
-}
-EXPORT_SYMBOL(phy_disable_interrupts);
-
 /* phy_start_interrupts
  *
  * description: Request the interrupt for the given PHY.  If
@@ -572,21 +588,6 @@
 }
 EXPORT_SYMBOL(phy_start_interrupts);
 
-int phy_stop_interrupts(struct phy_device *phydev)
-{
-	int err;
-
-	err = phy_disable_interrupts(phydev);
-
-	if (err)
-		phy_error(phydev);
-
-	free_irq(phydev->irq, phydev);
-
-	return err;
-}
-EXPORT_SYMBOL(phy_stop_interrupts);
-
 
 /* Scheduled by the phy_interrupt/timer to handle PHY changes */
 static void phy_change(void *data)
@@ -672,6 +673,8 @@
 EXPORT_SYMBOL(phy_stop);
 EXPORT_SYMBOL(phy_start);
 
+#endif /* CONFIG_PHYCONTROL */
+
 /* PHY timer which handles the state machine */
 static void phy_timer(unsigned long data)
 {
@@ -858,5 +861,3 @@
 
 	mod_timer(&phydev->phy_timer, jiffies + PHY_STATE_TIME * HZ);
 }
-
-#endif /* CONFIG_PHYCONTROL */

