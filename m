Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132431AbRCZMvt>; Mon, 26 Mar 2001 07:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132432AbRCZMvi>; Mon, 26 Mar 2001 07:51:38 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:5804 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132431AbRCZMvY>; Mon, 26 Mar 2001 07:51:24 -0500
Message-ID: <3ABF3B82.E6E3BBBA@uow.edu.au>
Date: Mon, 26 Mar 2001 22:52:18 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] vmalloc_area_pages() in 2.4.2-ac25
In-Reply-To: <E14hQaE-0001AK-00@the-village.bc.nu>,
			<E14hQaE-0001AK-00@the-village.bc.nu> <3dc0ojhz.wl@frostrubin.open.nm.fujitsu.co.jp> <3ABF34B8.C1909C60@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Tachino Nobuhiro wrote:
> >
> >   vmalloc_area_pages() in 2.4.2-ac25 seems to be broken. It calls
> > spin_lock(&init_mm.page_table_lock) twice and causes system hang.
> >
> 
> Yes, it would.  Delete the innermost lock and unlock.
> 

And the other one.

--- linux-2.4.2-ac25/mm/vmalloc.c	Mon Mar 26 21:38:38 2001
+++ ac/mm/vmalloc.c	Mon Mar 26 22:49:29 2001
@@ -126,9 +126,7 @@
 	do {
 		pte_t * pte;
 
-		spin_lock(&init_mm.page_table_lock);	/* pte_alloc requires this */
 		pte = pte_alloc(&init_mm, pmd, address);
-		spin_unlock(&init_mm.page_table_lock);
 		if (!pte)
 			return -ENOMEM;
 		if (alloc_area_pte(pte, address, end - address, gfp_mask, prot))
@@ -152,9 +150,7 @@
 	do {
 		pmd_t *pmd;
 		
-		spin_lock(&init_mm.page_table_lock);	/* pmd_alloc requires this */
 		pmd = pmd_alloc(&init_mm, dir, address);
-		spin_unlock(&init_mm.page_table_lock);
 		ret = -ENOMEM;
 		if (!pmd)
 			break;
