Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbVCXEap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbVCXEap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 23:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVCXEap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 23:30:45 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:58764 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S262400AbVCXEa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 23:30:26 -0500
Date: Thu, 24 Mar 2005 14:30:23 +1000
From: David McCullough <davidm@snapgear.com>
To: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] API for true Random Number Generators to add entropy (2.4.29)
Message-ID: <20050324043023.GB2806@beast>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324042708.GA2806@beast>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Here is a small patch for 2.4.29 that adds a routine:

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

Index: linux-2.4.29/include/linux/random.h
===================================================================
RCS file: /cvs/sw/linux-2.4.29/include/linux/random.h,v
retrieving revision 1.1.1.1
retrieving revision 1.3
diff -u -r1.1.1.1 -r1.3
--- linux-2.4.29/include/linux/random.h	9 Jul 2001 00:39:16 -0000	1.1.1.1
+++ linux-2.4.29/include/linux/random.h	18 Mar 2005 04:33:35 -0000	1.3
@@ -52,6 +52,7 @@
 extern void add_mouse_randomness(__u32 mouse_data);
 extern void add_interrupt_randomness(int irq);
 extern void add_blkdev_randomness(int major);
+extern void add_true_randomness(__u32 *buf, int nwords);
 
 extern void get_random_bytes(void *buf, int nbytes);
 void generate_random_uuid(unsigned char uuid_out[16]);
Index: linux-2.4.29/drivers/char/random.c
===================================================================
RCS file: /cvs/sw/linux-2.4.29/drivers/char/random.c,v
retrieving revision 1.1.1.9
retrieving revision 1.11
diff -u -r1.1.1.9 -r1.11
--- linux-2.4.29/drivers/char/random.c	4 Feb 2005 00:28:36 -0000	1.1.1.9
+++ linux-2.4.29/drivers/char/random.c	18 Mar 2005 04:33:35 -0000	1.11
@@ -842,6 +837,39 @@
 	add_timer_randomness(blkdev_timer_state[major], 0x200+major);
 }
 
+/*
+ * provide a mechanism for HW RNG's to add entropy that is of
+ * very good quality.
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
