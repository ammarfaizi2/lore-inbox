Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314471AbSEUM62>; Tue, 21 May 2002 08:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSEUM61>; Tue, 21 May 2002 08:58:27 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:15002 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314471AbSEUM61>;
	Tue, 21 May 2002 08:58:27 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15594.17227.311046.740703@argo.ozlabs.ibm.com>
Date: Tue, 21 May 2002 22:53:31 +1000 (EST)
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Make 2.5.17 TLB even more friendlier
In-Reply-To: <20020521.051031.56144279.davem@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> You get called via pte_free_tlb() and pmd_free_tlb() for every
> operation performed by clear_page_tables().  The PTEs themselves are
> all cleared out at the point that clear_page_tables, so you can't
> possibly need the PTE contents.  I am assuming therefore you just
> need to get at the linkage, and those two pte/pmd hooks give you
> that.

I have a bit in the PTE that tells me if there is an MMU hash table
entry for the virtual address represented by the PTE.  This bit is not
affected by set_pte or ptep_get_and_clear etc. and it is not part of
the swap-entry fields of the PTE.  Thus I need to have the PTE page
still around at the point where I flush stuff from the MMU hash
table, even though all the PTEs in it have been cleared, so that I can
avoid searching the hash table for PTEs for virtual addresses for
which I have not put a PTE in the hash table.

Now I could of course try to come up with some other way to store this
information, such as a bitmap associated with the mmu context.  The
bitmap would be 96kB in size for a 3GB userspace, though.  It could be
allocated on a page-by-page basis, I guess.  But all the schemes I
have thought of so far end up being more complex than using a special
bit in the PTE.

Regards,
Paul.
