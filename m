Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267213AbTALP5P>; Sun, 12 Jan 2003 10:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTALP5P>; Sun, 12 Jan 2003 10:57:15 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:52160 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267213AbTALP5N>;
	Sun, 12 Jan 2003 10:57:13 -0500
Date: Sun, 12 Jan 2003 17:05:59 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301121605.RAA02995@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: Re: 2.5.55/.56 instant reboot problem on 486
Cc: bgerst@didntduck.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003 20:17:19 -0800 (PST), Linus Torvalds wrote:
>On Sun, 12 Jan 2003, Mikael Pettersson wrote:
>>
>> My '94 vintage 486 has problems booting 2.5.55 and 2.5.56.
>
>Should I take it that 2.5.54 works? Or you haven't tested?
>...
>Ho humm.. Sounds like the non-PSE case is broken. Which should probably
>mean that even newer CPU's should show the same thing if we boot with
>"mem=nopentium". Can you verify that with your other machine that
>otherwise boots the same kernel fine?

2.5.54 works, but since the bug in 2.5.55/.56 is dependent on
kernel size, and since I couldn't find anything in patch-2.5.55
to explain the change in behaviour, I suspected that the bug has
been around a bit longer: I just didn't manage to trigger it.

mem=nopentium made no difference for the other machine: it still
managed to boot the same kernel the 486 failed to boot.

However, with the patch to one_page_table_init() that Brian Gerst
posted earlier today (included below), my 486 boots 2.5.56 Ok.

/Mikael

diff -urN linux-2.5.56/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.5.56/arch/i386/mm/init.c	Sun Jan 12 00:16:22 2003
+++ linux/arch/i386/mm/init.c	Sun Jan 12 01:48:28 2003
@@ -71,12 +71,16 @@
  */
 static pte_t * __init one_page_table_init(pmd_t *pmd)
 {
-	pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-	set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
-	if (page_table != pte_offset_kernel(pmd, 0))
-		BUG();	
+	if (pmd_none(*pmd)) {
+		pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
+		if (page_table != pte_offset_kernel(pmd, 0))
+			BUG();	
 
-	return page_table;
+		return page_table;
+	}
+	
+	return pte_offset_kernel(pmd, 0);
 }
 
 /*

