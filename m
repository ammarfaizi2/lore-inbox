Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbQLNAFe>; Wed, 13 Dec 2000 19:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbQLNAFY>; Wed, 13 Dec 2000 19:05:24 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:65302 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S129460AbQLNAFL>; Wed, 13 Dec 2000 19:05:11 -0500
Message-ID: <3A38077E.EA04B3C7@metabyte.com>
Date: Wed, 13 Dec 2000 15:34:22 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: test1[12] + sparc + bind 9.1.0b1 == bad things
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2000 23:34:43.0456 (UTC) FILETIME=[45400000:01C0655D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this the first OOPS it prints out? I don't think so. I am 
> very sure it printed out messages from die_if_kernel first and 
> we need that initial OOPS to diagnose this bug and fix it. 
> 
> All the rest of the OOPS messages are useless and won't tell 
> us what the real problem is. 

> Later, 
> David S. Miller 

Bad news about recursive Oops is that too often the system
cannot continue and oopsen never reach /var/log/messages.

This problem was so common on sparc(32) that I run all my
kernels with the attached patch. I think an application
of a similar change should be mandatory if you are insterested
in any sort of debugging.

The alternative is to use a serial console, captured at all times.

--Pete

diff -u -r1.63 traps.c
--- arch/sparc/kernel/traps.c   2000/06/04 06:23:52     1.63
+++ arch/sparc/kernel/traps.c   2000/06/26 18:19:10
@@ -114,18 +116,23 @@
 		 * bound in case our stack is trashed and we loop.
 		 */
 		while(rw                                        &&
-		      count++ < 30                              &&
+		      count++ < 10                              && /* P3 30 */
 		       (((unsigned long) rw) >= PAGE_OFFSET)    &&
 		      !(((unsigned long) rw) & 0x7)) {
 			printk("Caller[%08lx]\n", rw->ins[7]);
 			rw = (struct reg_window *)rw->ins[6];
 		}
 	}
+#if 0
 	printk("Instruction DUMP:");
 	instruction_dump ((unsigned long *) regs->pc);
 	if(regs->psr & PSR_PS)
		do_exit(SIGKILL);
 	do_exit(SIGSEGV);
+#else
+	printk("Looping...");
+	for (;;) { }
+#endif
 }
 
 void do_hw_interrupt(unsigned long type, unsigned long psr, unsigned long pc)
Index: arch/sparc/mm/fault.c
===================================================================
RCS file: /vger-cvs/linux/arch/sparc/mm/fault.c,v
retrieving revision 1.116
diff -u -r1.116 fault.c
--- arch/sparc/mm/fault.c       2000/05/03 06:37:03     1.116
+++ arch/sparc/mm/fault.c       2000/06/26 18:19:11
@@ -146,11 +146,15 @@
 		printk(KERN_ALERT "Unable to handle kernel paging request "
 			"at virtual address %08lx\n", address);
 	}
+	if (tsk->active_mm == NULL) {
+		printk(KERN_ALERT "tsk->active_mm = NULL\n");
+	} else {
 	printk(KERN_ALERT "tsk->{mm,active_mm}->context = %08lx\n",
 		(tsk->mm ? tsk->mm->context : tsk->active_mm->context));
 	printk(KERN_ALERT "tsk->{mm,active_mm}->pgd = %08lx\n",
 		(tsk->mm ? (unsigned long) tsk->mm->pgd :
 			(unsigned long) tsk->active_mm->pgd));
+	}
 	die_if_kernel("Oops", regs);
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
