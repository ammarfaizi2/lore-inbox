Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136077AbREGKnO>; Mon, 7 May 2001 06:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136082AbREGKnE>; Mon, 7 May 2001 06:43:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18184 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136077AbREGKmv>; Mon, 7 May 2001 06:42:51 -0400
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 7 May 2001 11:45:34 +0100 (BST)
Cc: bgerst@didntduck.org (Brian Gerst), alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105061750010.11175-100000@penguin.transmeta.com> from "Linus Torvalds" at May 06, 2001 05:53:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wiWH-0003KR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, we'll get a clobbered value, but we'll get a _valid_ clobbered value,
> and we'll just end up doing the fixups twice (and returning to the user
> process that didn't get the page it wanted, which will end up re-doing the
> page fault).

I dont see that we will get a valid value in both cases.

	get_user
		fault - set %cr2
					IRQ
					vmalloc
					fault
						set %cr2
						fixup runs
					end IRQ
		cr2 is corrupt

At this point the Linus tree suffers from one problem because it gets parallel
fixups wrong, and the -ac tree suffers from a different problem because
it gets parallel fixups right and to handle that case wont allow a vmalloc
fixup on a fault from userspace (or you get infinite loops)

> [ Looks closer.. ]
> 
> Actually, the second time we'd do the fixup we'd be unhappy, because it
> has already been done. That test should probably be removed. Hmm.

There are a whole set of races with the vmalloc fixups. Most are I think fixed
in the -ac bits if you want a look (I've not submitted them as they are not
too pretty). What I don't currently see is how you handle this without
looping forever or getting the SMP race fixup wrong.

(The current -ac fix for the double vmalloc races is below. WP test makes it
more complex than is nice)

--- /usr/src/LINUS/LINUX2.4/linux.245p1/arch/i386/mm/fault.c	Wed May  2 13:52:04 2001
+++ /usr/src/LINUS/LINUX2.4/linux.ac/arch/i386/mm/fault.c	Fri May  4 15:03:45 2001
@@ -127,8 +183,11 @@
 	 * be in an interrupt or a critical region, and should
 	 * only copy the information from the master page table,
 	 * nothing more.
+	 *
+	 * Handle kernel vmalloc fill in faults. User space doesn't take
+	 * this path. It isnt permitted to go poking up there.
 	 */
-	if (address >= TASK_SIZE)
+	if (address >= TASK_SIZE && !(error_code & 4))
 		goto vmalloc_fault;
 
 	mm = tsk->mm;
@@ -325,7 +378,11 @@
 		 *
 		 * Do _not_ use "tsk" here. We might be inside
 		 * an interrupt in the middle of a task switch..
+		 *
+		 * Note. There is 1 gotcha here. We may be doing the WP
+		 * test. If so then fixing the pgd/pmd won't help.
 		 */
+		 
 		int offset = __pgd_offset(address);
 		pgd_t *pgd, *pgd_k;
 		pmd_t *pmd, *pmd_k;
@@ -344,7 +401,29 @@
 		pmd = pmd_offset(pgd, address);
 		pmd_k = pmd_offset(pgd_k, address);
 
-		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
+		/* If the pmd is present then we either have two cpus trying
+		 * to fill in the vmalloc entries at once, or we have an
+		 * exception. We can treat the collision as a slow path without
+		 * worry. Its incredibly incredibly rare
+		 *
+		 * If the pte is read only then we know its a fault and we must
+		 * exception or Oops as it would loop forever otherwise
+		 */
+		 
+		if (pmd_present(*pmd))
+		{
+			pte_t *ptep = pte_offset(pmd, address);
+			if ((error_code & 2) && !pte_write(*ptep))
+			{
+				if ((fixup = search_exception_table(regs->eip)) != 0) {
+					regs->eip = fixup;
+					return;
+				}
+				goto bad_area_nosemaphore;
+			}
+			/* SMP race.. continue */
+		}
+		if (!pmd_present(*pmd_k))
 			goto bad_area_nosemaphore;
 		set_pmd(pmd, *pmd_k);
 		return;
