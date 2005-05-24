Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVEXJTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVEXJTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVEXJSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:18:39 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:52157 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261901AbVEXJPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:15:19 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091512.3AF11FA17@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:15:12 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 8F97FFB6E

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:44 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261343AbVEXCtD (ORCPT <rfc822;chiakotay@nexlab.it>);

	Mon, 23 May 2005 22:49:03 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVEXCtC

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Mon, 23 May 2005 22:49:02 -0400

Received: from holomorphy.com ([66.93.40.71]:36253 "EHLO holomorphy.com")

	by vger.kernel.org with ESMTP id S261343AbVEXCsx (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Mon, 23 May 2005 22:48:53 -0400

Received: from wli by holomorphy.com with local (Exim 3.36 #1 (Debian))

	id 1DaPTN-0001dX-00; Mon, 23 May 2005 19:48:49 -0700

Date:	Mon, 23 May 2005 19:48:49 -0700

From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
	Hugh Dickins <hugh@veritas.com>
Subject: Re: [bugfix] try_to_unmap_cluster() passes out-of-bounds pte to pte_unmap()

Message-ID: <20050524024849.GH2057@holomorphy.com>

References: <20050516021302.13bd285a.akpm@osdl.org> <20050522212734.GF2057@holomorphy.com> <20050523171406.483cdf69.akpm@osdl.org>

Mime-Version: 1.0

Content-Type: text/plain; charset=us-ascii

Content-Disposition: inline

In-Reply-To: <20050523171406.483cdf69.akpm@osdl.org>

Organization: The Domain of Holomorphy

User-Agent: Mutt/1.5.9i

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



William Lee Irwin III <wli@holomorphy.com> wrote:
>> --- ./mm/rmap.c.orig	2005-05-20 01:29:14.066467151 -0700
>> +++ ./mm/rmap.c	2005-05-20 01:30:06.620649901 -0700
[...]

On Mon, May 23, 2005 at 05:14:06PM -0700, Andrew Morton wrote:
> I must say that I continue to find this approach a bit queazifying.
> After some reading of the code I'd agree that yes, it's not possible for us
> to get here with `pte' pointing at the first slot of the pte page, but it's
> not 100% obvious and it's possible that someone will come along later and
> will change things in try_to_unmap_cluster() which cause this unmap to
> suddenly do the wrong thing in rare circumstances.
> IOW: I'd sleep better at night if we took a temporary and actually unmapped
> the thing which we we got back from pte_offset_map()..  Am I being silly?

Not at all. I merely attempt to minimize diffsize by default. An
alternative implementation follows (changelog etc. to be taken
from the prior patch) in case it saves the time (however short) needed
to write it yourself.


-- wli

Index: mm2-2.6.12-rc4/mm/rmap.c
===================================================================
--- mm2-2.6.12-rc4.orig/mm/rmap.c	2005-05-20 01:44:18.000000000 -0700
+++ mm2-2.6.12-rc4/mm/rmap.c	2005-05-23 19:13:29.000000000 -0700
@@ -626,7 +626,7 @@
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte, *original_pte;
 	pte_t pteval;
 	struct page *page;
 	unsigned long address;
@@ -658,7 +658,7 @@
 	if (!pmd_present(*pmd))
 		goto out_unlock;
 
-	for (pte = pte_offset_map(pmd, address);
+	for (original_pte = pte = pte_offset_map(pmd, address);
 			address < end; pte++, address += PAGE_SIZE) {
 
 		if (!pte_present(*pte))
@@ -694,7 +694,7 @@
 		(*mapcount)--;
 	}
 
-	pte_unmap(pte);
+	pte_unmap(original_pte);
 out_unlock:
 	spin_unlock(&mm->page_table_lock);
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

