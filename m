Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRALLgQ>; Fri, 12 Jan 2001 06:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRALLgH>; Fri, 12 Jan 2001 06:36:07 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:54993 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129383AbRALLf5>; Fri, 12 Jan 2001 06:35:57 -0500
Message-ID: <3A5EED14.88D8D9AF@uow.edu.au>
Date: Fri, 12 Jan 2001 22:40:04 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware 
 related?
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au> <20010111201819.B3269@unternet.org> <3A5E0849.EB428D70@mandrakesoft.com>,
		<3A5E0849.EB428D70@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jan 11, 2001 at 02:23:53PM -0500 <20010112012839.A11091@unternet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank de Lange wrote:
> 
> Quick and dirty conclusion: as soon as the apic comes in to play, things get
> messy...

Yup.

Frank, for over a year there have been sporadic reports
of APIC's forgetting how to deliver interrupts.  Not only
on BP6's.  Often with 3com NICs, so I've never been 100% sure
that it's not a failure in the NIC.

In your case, you have three devices on the same IRQ and
they all go to lunch at the same time.  That's pretty
convincing.

Nobody has been able to repeat this frequently enough
for any useful debugging to be done. Don't go away!

Here is a debugging patch.  Could you please apply this,
rebuild and:

1: Type ALT-SYSRQ-A when everything is good
2: Type ALT-SYSRQ-A when everything is bad
3: send the resulting logs.

I've Cc'ed Maciej, who understands this stuff.





--- linux-2.4.0-test11.macro/arch/i386/kernel/io_apic.c	Thu Oct  5 21:08:17 2000
+++ linux-2.4.0-test11/arch/i386/kernel/io_apic.c	Sun Nov 26 12:39:01 2000
@@ -692,7 +692,7 @@ void __init UNEXPECTED_IO_APIC(void)
 	printk(KERN_WARNING "          to linux-smp@vger.kernel.org\n");
 }
 
-void __init print_IO_APIC(void)
+void /*__init*/ print_IO_APIC(void)
 {
 	int apic, i;
 	struct IO_APIC_reg_00 reg_00;
diff -up --recursive --new-file linux-2.4.0-test11.macro/drivers/char/sysrq.c linux-2.4.0-test11/drivers/char/sysrq.c
--- linux-2.4.0-test11.macro/drivers/char/sysrq.c	Tue Nov 14 10:24:52 2000
+++ linux-2.4.0-test11/drivers/char/sysrq.c	Sun Nov 26 12:42:11 2000
@@ -72,6 +72,15 @@ void handle_sysrq(int key, struct pt_reg
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq: ");
 	switch (key) {
+	case 'a':
+		printk("\n");
+		printk("print_PIC()\n");
+		print_PIC();
+		printk("print_IO_APIC()\n");
+		print_IO_APIC();
+		printk("print_all_local_APICs()\n");
+		print_all_local_APICs();
+		break;
 	case 'r':					    /* R -- Reset raw mode */
 		if (kbd) {
 			kbd->kbdmode = VC_XLATE;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
