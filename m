Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269356AbUIYPyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269356AbUIYPyT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 11:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269357AbUIYPyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 11:54:19 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:973 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S269356AbUIYPyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 11:54:15 -0400
Date: Sat, 25 Sep 2004 17:54:04 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: ptep_establish/establish_pte needs set_pte_atomic and all set_pte must be written in asm
Message-ID: <20040925155404.GL3309@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was discussing an obscure bug with Martin in the COW handling.

After some thoughts on the issue the only thing that I found potentially
buggy in that path is that we're not safe not writing the 8bytes
atomically before flushing the tlb. I'm afraid without set_pte_atomic
the other cpu in another userspace thread could touch the memory with an
empty tlb entry, and load the half-written pte, that may contain the new
high bits for the high part of the pfn number, but the old low bits for
the low part of the pfn number plus the old ro protection. Potentially
giving access to a random physical page to a task (in readonly mode, so
no kernel crash or userspace malfunction except the security
compromise). I don't expect anybody to be able to exploit it though.

Worthy to note is that we're buggy in all set_pte implementations since,
all archs would need to also implement the set_pte in assembler to make
sure the C language doesn't write it byte-by-byte which would break the
SMP in the other thread. On ppc64 where a problem triggered (possibily
unrelated to this) the pte is an unsigned long and it's being updated by
set_pte with this:

	*ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS

(note pte_clear would be fine to be still in C, pte clear is guaranteed
to run on not present ptes, so we don't race with other threads, it's
only set_pte that should always be written in assembler in the last
opcode that writes in the pte)

We don't need an SMP lock, we only need to write 4 or 8 bytes at once (a
plain movl in x86 would do the trick). That's all we need. (and in
theory only for SMP, but UP will not get any slowdown since no lock on
the bus will be necessary, we're the only writer thanks to the
page_table_lock, but there are other readers running in userspace in
SMP, hence the need of atomicity)

pte_clear would not be safe to call inside ptep_establish for the same
reason (pte_clear is not atomic and it doesn't need to be atomic unlike
set_pte), while something like this should be fine:

	ptep_get_and_clear
	set_pte
	flush_tlb

but it doesn't worht it since all other archs supporting SMP in their
architecture will have to change set_pte to an assembly version, so for
them set_pte_atomic will be defined to set_pte.

The x86 set_pte itself should be changed to:

static inline void set_pte(pte_t *ptep, pte_t pte)
{
	ptep->pte_high = pte.pte_high;
	smp_wmb();
	do this in a single not locked movl -> (ptep->pte_low = pte.pte_low);
}

and for x86 the set_pte_atomic will remain the same as today, so the
below patch seems the right long term fix (even if it breaks all archs
but x86).

Comments?

Index: linux-2.5/include/asm-generic/pgtable.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/asm-generic/pgtable.h,v
retrieving revision 1.8
diff -u -p -r1.8 pgtable.h
--- linux-2.5/include/asm-generic/pgtable.h	29 Jul 2004 06:01:30 -0000	1.8
+++ linux-2.5/include/asm-generic/pgtable.h	25 Sep 2004 15:16:50 -0000
@@ -15,7 +15,7 @@
  */
 #define ptep_establish(__vma, __address, __ptep, __entry)		\
 do {				  					\
-	set_pte(__ptep, __entry);					\
+	set_pte_atomic(__ptep, __entry);				\
 	flush_tlb_page(__vma, __address);				\
 } while (0)
 #endif
