Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbUK1STu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbUK1STu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbUK1STu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:19:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13328 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261548AbUK1ST3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:19:29 -0500
Date: Sun, 28 Nov 2004 18:19:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: typeof(dev->power.saved_state)
Message-ID: <20041128181925.B18354@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/arm/common/sa1111.c: In function `sa1111_suspend':
arch/arm/common/sa1111.c:816: warning: assignment from incompatible pointer type

This is a rather annoying, and IMHO pointless warning.  First
question: what is the reasoning for using an array of unsigned
bytes here?  Are we expecting to power manage devices which only
have byte wide registers?

In reality, devices have half-word and word sized registers as
well, which means that dev->power.saved_state actually points to
device specific data (or even device driver specific data) for
the device.  As such, it makes far more sense for this to be
a 'void *'.

I'd rather not go around the ARM kernel tree adding pointless
casts to 'u8 *' and back again because the wrong type for this
was picked in the structure definition, so here's a patch which
changes this to void *.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/include/linux/pm.h linux/include/linux/pm.h
--- orig/include/linux/pm.h	Mon Nov 15 09:17:10 2004
+++ linux/include/linux/pm.h	Sun Nov 28 18:15:57 2004
@@ -226,7 +226,7 @@ struct dev_pm_info {
 	u32			power_state;
 #ifdef	CONFIG_PM
 	u32			prev_state;
-	u8			* saved_state;
+	void			* saved_state;
 	atomic_t		pm_users;
 	struct device		* pm_parent;
 	struct list_head	entry;


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
