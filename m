Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTGGTPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTGGTPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:15:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12221 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264257AbTGGTPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:15:47 -0400
Date: Mon, 7 Jul 2003 12:30:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: smiler@lanil.mine.nu, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Message-Id: <20030707123012.47238055.akpm@osdl.org>
In-Reply-To: <200307071734.01575.schlicht@uni-mannheim.de>
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
	<200307071734.01575.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
>  +#if defined(pmd_offset_map)
>  +#define NV_PMD_OFFSET(address, pg_dir, pg_mid_dir) \
>  +    { \
>  +        pmd_t *pg_mid_dir__ = pmd_offset_map(pg_dir, address); \
>  +        pg_mid_dir = *pg_mid_dir__; \
>  +        pmd_unmap(pg_mid_dir__); \
>  +    }
>  +#else
>  +#define NV_PMD_OFFSET(address, pg_dir, pg_mid_dir) \
>  +    pg_mid_dir = *pmd_offset(pg_dir, address)
>  +#endif
>  +

Well that will explode if someone enables highpmd and has highmem.
This would be better:

--- nv.c.orig	2003-07-05 22:55:10.000000000 -0700
+++ nv.c	2003-07-05 22:55:58.000000000 -0700
@@ -2105,11 +2105,14 @@
     if (pgd_none(*pg_dir))
         goto failed;
 
-    pg_mid_dir = pmd_offset(pg_dir, address);
-    if (pmd_none(*pg_mid_dir))
+    pg_mid_dir = pmd_offset_map(pg_dir, address);
+    if (pmd_none(*pg_mid_dir)) {
+	pmd_unmap(pg_mid_dir);
         goto failed;
+    }
 
     NV_PTE_OFFSET(address, pg_mid_dir, pte);
+    pmd_unmap(pg_mid_dir);
 
     if (!pte_present(pte))
         goto failed;

