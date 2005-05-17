Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVEQP3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVEQP3C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVEQP2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:28:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11211 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261644AbVEQP14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:27:56 -0400
Date: Tue, 17 May 2005 10:27:51 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [patch 4/7] BSD Secure Levels: memory alloc failure check
Message-ID: <20050517152750.GC2944@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517152303.GA2814@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fourth in a series of seven patches to the BSD Secure
Levels LSM.  It adds a check for a memory allocation failure
condition.  Thanks to Vesa-Matti J Kari for pointing out this problem.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-16 16:28:19.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-16 16:28:29.000000000 -0500
@@ -310,7 +310,7 @@
 static int
 plaintext_to_sha1(unsigned char *hash, const char *plaintext, int len)
 {
-	char *pgVirtAddr;
+	char *pg_virt_addr;
 	struct crypto_tfm *tfm;
 	struct scatterlist sg[1];
 	if (len > PAGE_SIZE) {
@@ -327,16 +327,20 @@
 	}
 	// Just get a new page; don't play around with page boundaries
 	// and scatterlists.
-	pgVirtAddr = (char *)__get_free_page(GFP_KERNEL);
-	sg[0].page = virt_to_page(pgVirtAddr);
+	pg_virt_addr = (char *)__get_free_page(GFP_KERNEL);
+	if (!pg_virt_addr) {
+		seclvl_printk(0, KERN_ERR "%s: Out of memory\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	sg[0].page = virt_to_page(pg_virt_addr);
 	sg[0].offset = 0;
 	sg[0].length = len;
-	strncpy(pgVirtAddr, plaintext, len);
+	strncpy(pg_virt_addr, plaintext, len);
 	crypto_digest_init(tfm);
 	crypto_digest_update(tfm, sg, 1);
 	crypto_digest_final(tfm, hash);
 	crypto_free_tfm(tfm);
-	free_page((unsigned long)pgVirtAddr);
+	free_page((unsigned long)pg_virt_addr);
 	return 0;
 }
 
