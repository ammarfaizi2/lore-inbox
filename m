Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTEWI4H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTEWI4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:56:07 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39961 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263962AbTEWI4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:56:01 -0400
Date: Fri, 23 May 2003 02:12:04 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rmk@arm.linux.org.uk, LW@KARO-electronics.de, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
Message-Id: <20030523021204.4e3a4954.akpm@digeo.com>
In-Reply-To: <1053676924.30675.2.camel@rth.ninka.net>
References: <16076.50160.67366.435042@ipc1.karo>
	<20030522151156.C12171@flint.arm.linux.org.uk>
	<1053676924.30675.2.camel@rth.ninka.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2003 09:09:07.0188 (UTC) FILETIME=[F6E1AB40:01C3210A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> On Thu, 2003-05-22 at 07:11, Russell King wrote:
> > We seem to have flush_icache_page() in install_page() - I wonder whether
> > we should also have flush_dcache_page() in there as well.
> ...
> > Maybe someone more knowledgeable of the VM layer can comment.
> 
> I am not sure of the exact environment install_page() is meant
> to run in, does it always know that no mapping exists at that
> address?

No, it does not - there could have been a different page mapped at that
virtual address.

> If not, something (either there or higher up) needs to be doing
> a flush_cache_page(...) at a minimum.

install_page() did a flush_cache_page() in zap_pte(), if it found there was
already a page mapped by the pte.

That flush_cache_page() was added 28 March 2003.  2.5.30 does not have it.

What's that flush_icache_page() doing in there?  The fine document makes
one suspect it is wrong.


install_page() is prefaulting pages into pagetables, so perhaps it should
have an update_mmu_cache()?

diff -puN mm/fremap.c~install_page-flushing mm/fremap.c
--- 25/mm/fremap.c~install_page-flushing	2003-05-23 02:01:52.000000000 -0700
+++ 25-akpm/mm/fremap.c	2003-05-23 02:09:03.000000000 -0700
@@ -84,7 +84,7 @@ int install_page(struct mm_struct *mm, s
 	pte_unmap(pte);
 	if (flush)
 		flush_tlb_page(vma, addr);
-
+	update_mmu_cache(vma, addr, *pte);
 	spin_unlock(&mm->page_table_lock);
 	pte_chain_free(pte_chain);
 	return 0;

_

