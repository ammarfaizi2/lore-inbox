Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUDNVOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUDNVOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:14:41 -0400
Received: from smtp1.jazztel.es ([62.14.3.161]:6313 "EHLO smtp1.jazztel.es")
	by vger.kernel.org with ESMTP id S261718AbUDNVOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:14:38 -0400
To: linux-kernel@vger.kernel.org
Subject: patch-2.4.26.bz2, it wastes unnecessary 2 TIMES get_one_pte(mm, old_addr);
Message-ID: <1081977275.407da9bc023e4@webmail.jazznet.es>
Date: Wed, 14 Apr 2004 23:14:36 +0200 (CEST)
From: jc-nospam@jr-pizarro.jazztel.es
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Webmail
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ;)

>From mm/mremap.c of patch-2.4.26.bz2: "It wastes unnecessary 2 TIMES
get_one_pte(mm, old_addr);"

diff -urN linux-2.4.25/mm/mremap.c linux-2.4.26/mm/mremap.c
--- linux-2.4.25/mm/mremap.c	2004-02-18 05:36:32.000000000 -0800
+++ linux-2.4.26/mm/mremap.c	2004-04-14 06:05:41.000000000 -0700
@@ -77,12 +77,16 @@
 static int move_one_page(struct mm_struct *mm, unsigned long old_addr, unsigned
long new_addr)
 {
 	int error = 0;
-	pte_t * src;
+	pte_t * src, * dst;
 
 	spin_lock(&mm->page_table_lock);
 	src = get_one_pte(mm, old_addr);
-	if (src)
-		error = copy_one_pte(mm, src, alloc_one_pte(mm, new_addr));
+	if (src) {
+		dst = alloc_one_pte(mm, new_addr);
+		src = get_one_pte(mm, old_addr);
+		if (src) 
+			error = copy_one_pte(mm, src, dst);
+	}
 	spin_unlock(&mm->page_table_lock);
 	return error;
 }

