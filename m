Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbSJDXsj>; Fri, 4 Oct 2002 19:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262155AbSJDXsi>; Fri, 4 Oct 2002 19:48:38 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:11279 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S262147AbSJDXsh>;
	Fri, 4 Oct 2002 19:48:37 -0400
Message-ID: <3D9E2B8A.653BEF9D@tv-sign.ru>
Date: Sat, 05 Oct 2002 04:00:10 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>, Rohit Seth <rohit.seth@intel.com>
Subject: Re: [patch] futex-2.5.40-B5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:
>   the new lookup code first does a lightweight follow_page(), then if no
>   page is present we do the get_user_pages() thing.

What if futex placed in VM_HUGETLB area?
Then follow_page() return garbage.

I beleive in i386 case it can be fixed something like this:

--- mm/memory.c.orig	Sat Oct  5 01:08:54 2002
+++ mm/memory.c		Sat Oct  5 03:31:28 2002
@@ -480,6 +480,17 @@ follow_page(struct mm_struct *mm, unsign
 	if (pmd_none(*pmd) || pmd_bad(*pmd))
 		goto out;
 
+#ifdef	CONFIG_HUGETLB_PAGE
+	if (pmd_large(pmd)) {
+		ptep = (pte_t *) pmd;
+
+		if (write && !pte_write(*ptep))
+			return NULL;
+
+		return pte_page(*ptep) + ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
+	}
+#endif
+
 	ptep = pte_offset_map(pmd, address);
 	if (!ptep)
 		goto out;


Then follow_hugetlb_page() hook can be killed.

Oleg.
