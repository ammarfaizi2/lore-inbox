Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbRCZLbV>; Mon, 26 Mar 2001 06:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132424AbRCZLbL>; Mon, 26 Mar 2001 06:31:11 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38547 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S132416AbRCZLbA>; Mon, 26 Mar 2001 06:31:00 -0500
Date: Mon, 26 Mar 2001 20:30:16 +0900
Message-ID: <3dc0ojhz.wl@frostrubin.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] vmalloc_area_pages() in 2.4.2-ac25
In-Reply-To: <E14hQaE-0001AK-00@the-village.bc.nu>
In-Reply-To: <E14hQaE-0001AK-00@the-village.bc.nu>
User-Agent: Wanderlust/2.4.0 (Rio) EMY/1.13.9 (Art is long, life is short)
 SLIM/1.14.3 (篠原ともえ) APEL/10.2 MULE
 XEmacs/21.2 (beta46) (Urania) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  vmalloc_area_pages() in 2.4.2-ac25 seems to be broken. It calls
spin_lock(&init_mm.page_table_lock) twice and causes system hang.



inline int vmalloc_area_pages (unsigned long address, unsigned long size,
                               int gfp_mask, pgprot_t prot)
{
	pgd_t * dir;
	unsigned long end = address + size;
	int ret;

	dir = pgd_offset_k(address);
	flush_cache_all();
>>>>	spin_lock(&init_mm.page_table_lock);	
	do {
		pmd_t *pmd;
		
>>>>		spin_lock(&init_mm.page_table_lock);	/* pmd_alloc requires this */
		pmd = pmd_alloc(&init_mm, dir, address);
		spin_unlock(&init_mm.page_table_lock);
		ret = -ENOMEM;
