Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTIRXk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTIRXk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:40:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:33499 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262232AbTIRXkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:40:07 -0400
Date: Thu, 18 Sep 2003 16:40:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: kai.germaschewski@gmx.de, torvalds@osdl.org
Subject: [PATCH 10/13] use cpu_relax() in busy loop
Message-ID: <20030918164006.N16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net> <20030918163311.I16499@osdlab.pdx.osdl.net> <20030918163408.J16499@osdlab.pdx.osdl.net> <20030918163523.K16499@osdlab.pdx.osdl.net> <20030918163645.L16499@osdlab.pdx.osdl.net> <20030918163757.M16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918163757.M16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:37:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace busy loop nop with cpu_relax().

===== drivers/isdn/hardware/avm/avmcard.h 1.17 vs edited =====
--- 1.17/drivers/isdn/hardware/avm/avmcard.h	Wed Sep  3 03:09:05 2003
+++ edited/drivers/isdn/hardware/avm/avmcard.h	Thu Sep 18 11:17:09 2003
@@ -233,7 +233,8 @@
 static inline unsigned char b1_get_byte(unsigned int base)
 {
 	unsigned long stop = jiffies + 1 * HZ;	/* maximum wait time 1 sec */
-	while (!b1_rx_full(base) && time_before(jiffies, stop));
+	while (!b1_rx_full(base) && time_before(jiffies, stop))
+		cpu_relax();
 	if (b1_rx_full(base))
 		return inb(base + B1_READ);
 	printk(KERN_CRIT "b1lli(0x%x): rx not full after 1 second\n", base);
@@ -264,7 +265,8 @@
 static inline int b1_save_put_byte(unsigned int base, unsigned char val)
 {
 	unsigned long stop = jiffies + 2 * HZ;
-	while (!b1_tx_empty(base) && time_before(jiffies,stop));
+	while (!b1_tx_empty(base) && time_before(jiffies,stop))
+		cpu_relax();
 	if (!b1_tx_empty(base)) return -1;
 	b1outp(base, B1_WRITE, val);
 	return 0;

