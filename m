Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUDUACU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUDUACU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbUDUACU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:02:20 -0400
Received: from gprs214-107.eurotel.cz ([160.218.214.107]:62082 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263850AbUDUACR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:02:17 -0400
Date: Wed, 21 Apr 2004 02:02:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: b44 needs to reclaim its interrupt after swsusp
Message-ID: <20040421000208.GA3160@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

b44 needs to free/reclaim its interrupt across suspend in order to
work. This patch makes it work, but I'm not quite sure why its
needed. Interrupt is listed as IO-APIC-level in /proc/interupts.

							Pavel

--- clean/drivers/net/b44.c	2004-04-21 01:32:52.000000000 +0200
+++ linux/drivers/net/b44.c	2004-04-21 01:53:18.000000000 +0200
@@ -1251,7 +1251,7 @@
 }
 
 #if 0
-/*static*/ void b44_dump_state(struct b44 *bp)
+void b44_dump_state(struct b44 *bp)
 {
 	u32 val32, val32_2, val32_3, val32_4, val32_5;
 	u16 val16;
@@ -1874,6 +1874,8 @@
 	b44_free_rings(bp);
 
 	spin_unlock_irq(&bp->lock);
+
+	free_irq(dev->irq, dev);
 	return 0;
 }
 
@@ -1887,6 +1889,9 @@
 
 	pci_restore_state(pdev, bp->pci_cfg_state);
 
+	if (request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev))
+		printk("b44: request_irq failed\n");
+
 	spin_lock_irq(&bp->lock);
 
 	b44_init_rings(bp);


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
