Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVETPJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVETPJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVETPJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:09:28 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:43219 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261468AbVETPJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:09:18 -0400
Date: Fri, 20 May 2005 10:09:02 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [updated patch 4/7] BSD Secure Levels: memory alloc failure check
Message-ID: <20050520150902.GC5534@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us> <20050519205525.GB16215@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050519205525.GB16215@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is applies cleanly against the new printk() patch. It adds
a check for a memory allocation failure condition.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-20 09:09:03.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-20 09:09:07.000000000 -0500
@@ -317,7 +317,7 @@
 static int
 plaintext_to_sha1(unsigned char *hash, const char *plaintext, int len)
 {
-	char *pgVirtAddr;
+	char *pg_virt_addr;
 	struct crypto_tfm *tfm;
 	struct scatterlist sg[1];
 	if (len > PAGE_SIZE) {
@@ -334,16 +334,21 @@
 	}
 	// Just get a new page; don't play around with page boundaries
 	// and scatterlists.
-	pgVirtAddr = (char *)__get_free_page(GFP_KERNEL);
-	sg[0].page = virt_to_page(pgVirtAddr);
+	pg_virt_addr = (char *)__get_free_page(GFP_KERNEL);
+	if (!pg_virt_addr) {
+		seclvl_printk(0, KERN_ERR, "Out of memory\n" );
+		crypto_free_tfm(tfm);
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
 
