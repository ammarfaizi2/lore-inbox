Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318180AbSHDQx6>; Sun, 4 Aug 2002 12:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSHDQx6>; Sun, 4 Aug 2002 12:53:58 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39808 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318180AbSHDQx4>; Sun, 4 Aug 2002 12:53:56 -0400
Date: Sun, 4 Aug 2002 12:57:30 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Small problem with pmd_page in 2.5
Message-ID: <20020804125730.A1113@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:

I was looking a little bit at sparc(32) and ran into a difficulty
with pmd_page. The 2.5 version returns struct page*, presumably
to support page tables in highmem. Unfortunately, sparc (sun4m
actually) cannot do that, because its page tables are smaller
than memory pages.

This is the only code fragment that makes use of pmd_page:
mm/memory.c:

static inline void free_one_pmd(mmu_gather_t *tlb, pmd_t * dir)
{
        struct page *pte;

        if (pmd_none(*dir))
                return;
        if (pmd_bad(*dir)) {
                pmd_ERROR(*dir);
                pmd_clear(dir);
                return;
        }
        pte = pmd_page(*dir);
        pmd_clear(dir);
        pte_free_tlb(tlb, pte);
}

Has anyone got an idea how to fix this? I've got some, but all seem bad:

 a) Use 2 lower bits of the page pointer to store an index and
    have pte_free to mask it out (possibly change pmd_page to return void*),
 b) Map the page table temporarily in pmd_page,
 c) Create a new architecture function pmd_zap which contains
    the sequence { tmp = pmd_page(); pmd_clear(); pte_free_tlb(tmp); }
    on all architectures except sparc,
 d) Copy *dir into tmp instead of pte as we do now explicitly,
    if that can work, say, on s390

-- Pete
