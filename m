Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129461AbQKBUIA>; Thu, 2 Nov 2000 15:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129439AbQKBUHu>; Thu, 2 Nov 2000 15:07:50 -0500
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:37637 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129495AbQKBUHg>; Thu, 2 Nov 2000 15:07:36 -0500
Message-ID: <3A01CA20.707AFC1A@mvista.com>
Date: Thu, 02 Nov 2000 12:10:08 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Possible cause of SegFaults
Content-Type: multipart/mixed;
 boundary="------------89626D65258CEC11D3133211"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------89626D65258CEC11D3133211
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Linus,

In doing the full preemption testing we found and fixed this little
segfault window.  Seems that interrupts are left on for the page fault. 
This allows an interrupt prior to fetching the faulting info from CR2. 
Result, illegal memory reference, i.e. segfault. I don't know what
interrupt code might touch CR2, but better safe than sorry.  Of course,
preemption in this window _IS_ a problem.

Attached find a patch to fix the problem.  The patch is on 2.4.0-test9
but should apply to most of 2.4.0 versions.

George
--------------89626D65258CEC11D3133211
Content-Type: text/plain; charset=iso-8859-15;
 name="segfault.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="segfault.patch"

diff -urP -X patch.exclude linux-2.4.0-test9-kb-rts/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux-2.4.0-test9-kb-rts/arch/i386/kernel/traps.c	Mon Oct 30 21:04:29 2000
+++ linux/arch/i386/kernel/traps.c	Wed Nov  1 12:42:40 2000
@@ -1028,7 +1028,7 @@
 	set_trap_gate(11,&segment_not_present);
 	set_trap_gate(12,&stack_segment);
 	set_trap_gate(13,&general_protection);
-	set_trap_gate(14,&page_fault);
+	set_intr_gate(14,&page_fault);
 	set_trap_gate(15,&spurious_interrupt_bug);
 	set_trap_gate(16,&coprocessor_error);
 	set_trap_gate(17,&alignment_check);
diff -urP -X patch.exclude linux-2.4.0-test9-kb-rts/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- linux-2.4.0-test9-kb-rts/arch/i386/mm/fault.c	Mon Oct 30 21:04:29 2000
+++ linux/arch/i386/mm/fault.c	Thu Nov  2 09:57:02 2000
@@ -130,7 +130,7 @@
 
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
-
+        __sti();
 	tsk = current;
 	mm = tsk->mm;
 	info.si_code = SEGV_MAPERR;

--------------89626D65258CEC11D3133211--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
