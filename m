Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbVCXE1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbVCXE1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 23:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVCXE1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 23:27:33 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:57228 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S262015AbVCXE1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 23:27:18 -0500
Date: Thu, 24 Mar 2005 14:27:08 +1000
From: David McCullough <davidm@snapgear.com>
To: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050324042708.GA2806@beast>
References: <20050315133644.GA25903@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315133644.GA25903@beast>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Here is a small patch for 2.6.11 that adds a routine:

	add_true_randomness(__u32 *buf, int nwords);

so that true random number generator device drivers can add a entropy
to the system.  Drivers that use this can be found in the latest release
of ocf-linux,  an asynchronous crypto implementation for linux based on
the *BSD Cryptographic Framework.

	http://ocf-linux.sourceforge.net/

Adding this can dramatically improve the performance of /dev/random on
small embedded systems which do not generate much entropy.

Cheers,
Davidm

Signed-off-by: David McCullough <davidm@snapgear.com>

Index: linux-2.6.11/include/linux/random.h
===================================================================
RCS file: linux-2.6.11/include/linux/random.h,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 random.h
--- linux-2.6.11/include/linux/random.h	3 Mar 2005 00:45:49 -0000	1.1.1.6
+++ linux-2.6.11/include/linux/random.h	18 Mar 2005 01:46:16 -0000
@@ -48,6 +48,8 @@
 				 unsigned int value);
 extern void add_interrupt_randomness(int irq);
 
+extern void add_true_randomness(__u32 *buf, int nwords);
+
 extern void get_random_bytes(void *buf, int nbytes);
 void generate_random_uuid(unsigned char uuid_out[16]);
 
Index: linux-2.6.11/drivers/char/random.c
===================================================================
RCS file: linux-2.6.x/drivers/char/random.c,v
retrieving revision 1.1.1.28
diff -u -r1.1.1.28 random.c
--- linux-2.6.11/drivers/char/random.c	3 Mar 2005 00:45:31 -0000	1.1.1.28
+++ linux-2.6.11/drivers/char/random.c	18 Mar 2005 01:46:16 -0000
@@ -902,6 +902,39 @@
 
 EXPORT_SYMBOL(add_disk_randomness);
 
+/*
+ * provide a mechanism for HW to add entropy that is of
+ * very good quality from a true random number generator
+ */
+void add_true_randomness(__u32 *buf, int nwords)
+{
+	struct entropy_store *r;
+	int wakeup_check = 0;
+
+
+	if (!random_state || !sec_random_state)
+		return;
+
+	/*
+	 * if we have too much entropy, put some in the secondary pool
+	 */
+	r = random_state;
+	if (r->entropy_count >= r->poolinfo.POOLBITS)
+		r = sec_random_state;
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
 /******************************************************************
  *
  * Hash function definition

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
