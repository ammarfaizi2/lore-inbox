Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263112AbVCXMaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbVCXMaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 07:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVCXMaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 07:30:15 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:8846 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S263112AbVCXM37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 07:29:59 -0500
Date: Thu, 24 Mar 2005 22:28:40 +1000
From: David McCullough <davidm@snapgear.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jmorris@redhat.com, cryptoapi@lists.logix.cz, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 2.6.12-rc1] API for true Random Number Generators to add entropy
Message-ID: <20050324122840.GA7115@beast>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323203856.17d650ec.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Here is a revised patch for 2.6.12-rc1 that adds a routine:

    add_true_randomness(__u32 *buf, int nwords);

so that true random number generator device drivers can add a entropy
to the system.

Cheers,
Davidm

Signed-off-by: David McCullough <davidm@snapgear.com>

--- linux-2.6.12-rc1.orig/drivers/char/random.c	2005-03-18 11:33:49.000000000 +1000
+++ linux-2.6.12-rc1/drivers/char/random.c	2005-03-24 16:16:40.000000000 +1000
@@ -1148,6 +1148,36 @@
 EXPORT_SYMBOL(generate_random_uuid);
 
 /********************************************************************
+ * provide a mechanism for HW to add entropy that is of
+ * very good quality from a true random number generator
+ ***************************************************************/
+
+void add_true_randomness(__u32 *buf, int nwords)
+{
+	struct entropy_store *r;
+	int wakeup_check = 0;
+
+	/*
+	 * if we have too much entropy, put some in the secondary pool
+	 */
+	r = &blocking_pool;
+	if (r->entropy_count >= r->poolinfo->POOLBITS)
+		r = &nonblocking_pool;
+	else
+		wakeup_check = (r->entropy_count < random_read_wakeup_thresh);
+
+	add_entropy_words(r, buf, nwords);
+	credit_entropy_store(r, nwords * 32);
+
+	/*
+	 * wakeup if we added enough entropy to cross the threshold
+	 */
+	if (wakeup_check && r->entropy_count >= random_read_wakeup_thresh)
+		wake_up_interruptible(&random_read_wait);
+}
+EXPORT_SYMBOL(add_true_randomness);
+
+/********************************************************************
  *
  * Sysctl interface
  *
--- linux-2.6.12-rc1.orig/include/linux/random.h	2005-03-18 11:34:37.000000000 +1000
+++ linux-2.6.12-rc1/include/linux/random.h	2005-03-24 15:59:42.000000000 +1000
@@ -48,6 +48,8 @@
 				 unsigned int value);
 extern void add_interrupt_randomness(int irq);
 
+extern void add_true_randomness(__u32 *buf, int nwords);
+
 extern void get_random_bytes(void *buf, int nbytes);
 void generate_random_uuid(unsigned char uuid_out[16]);
 

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
