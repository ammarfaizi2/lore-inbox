Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbVLMIZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVLMIZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVLMIZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:6020 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932560AbVLMIZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:01 -0500
Date: Tue, 13 Dec 2005 00:23:23 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [patch 18/26] [AGPGART] Fix serverworks TLB flush.
Message-ID: <20051213082323.GR5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-serverworks-tlb-flush..patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Dave Jones <davej@redhat.com>

[AGPGART] Fix serverworks TLB flush.
Go back to what 2.4 kernels used to do here, as if this hits,
the kernel just hangs indefinitly.

Actually an improvement over 2.4 - we now break; out of the loop
instead of just printing messages on timeouts.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/agp/sworks-agp.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- linux-2.6.14.3.orig/drivers/char/agp/sworks-agp.c
+++ linux-2.6.14.3/drivers/char/agp/sworks-agp.c
@@ -242,13 +242,27 @@ static int serverworks_fetch_size(void)
  */
 static void serverworks_tlbflush(struct agp_memory *temp)
 {
+	unsigned long timeout;
+
 	writeb(1, serverworks_private.registers+SVWRKS_POSTFLUSH);
-	while (readb(serverworks_private.registers+SVWRKS_POSTFLUSH) == 1)
+	timeout = jiffies + 3*HZ;
+	while (readb(serverworks_private.registers+SVWRKS_POSTFLUSH) == 1) {
 		cpu_relax();
+		if (time_after(jiffies, timeout)) {
+			printk(KERN_ERR PFX "TLB post flush took more than 3 seconds\n");
+			break;
+		}
+	}
 
 	writel(1, serverworks_private.registers+SVWRKS_DIRFLUSH);
-	while(readl(serverworks_private.registers+SVWRKS_DIRFLUSH) == 1)
+	timeout = jiffies + 3*HZ;
+	while (readl(serverworks_private.registers+SVWRKS_DIRFLUSH) == 1) {
 		cpu_relax();
+		if (time_after(jiffies, timeout)) {
+			printk(KERN_ERR PFX "TLB Dir flush took more than 3 seconds\n");
+			break;
+		}
+	}
 }
 
 static int serverworks_configure(void)

--
