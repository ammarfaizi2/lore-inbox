Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVBGTqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVBGTqL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVBGTpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:45:38 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:30375 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261262AbVBGTdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:33:15 -0500
Date: Mon, 7 Feb 2005 13:32:48 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [PATCH] BSD Secure Levels: memory alloc failure check, 2.6.11-rc2-mm1 (4/8)
Message-ID: <20050207193248.GC834@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050207192108.GA776@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20050207192108.GA776@halcrow.us>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the fourth in a series of eight patches to the BSD Secure
Levels LSM.  It adds a check for a memory allocation failure
condition.  Thanks to Vesa-Matti J Kari for pointing out this problem.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="seclvl_mem_alloc_check.patch"

Index: linux-2.6.11-rc2-mm1-modules/security/seclvl.c
===================================================================
--- linux-2.6.11-rc2-mm1-modules.orig/security/seclvl.c	2005-02-03 15:37:26.231252048 -0600
+++ linux-2.6.11-rc2-mm1-modules/security/seclvl.c	2005-02-03 15:39:35.786556648 -0600
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
 

--uXxzq0nDebZQVNAZ--
