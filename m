Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVAUQ12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVAUQ12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVAUQ10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:27:26 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:30437 "EHLO vana")
	by vger.kernel.org with ESMTP id S262415AbVAUQ0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:26:02 -0500
Date: Fri, 21 Jan 2005 17:26:01 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Chris Bruner <cryst@golden.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: Something very strange on x86_64 2.6.X kernels
Message-ID: <20050121162601.GA8469@vana.vc.cvut.cz>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de> <41F01A50.1040109@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F01A50.1040109@cosmosbay.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 09:53:36PM +0100, Eric Dumazet wrote:
> 
> Examining linux sources, I found that 0xffffe000 is 'special' (ia 32 
> vsyscall) and 0xffffe600 is about sigreturn subsection of this special area.
> 
> Is it possible some vm trick just kicks in and corrupts my true 64bits 
> program ?

Maybe I already missed answer, but try patch below.  It is definitely bad
to mark syscall page as global one...

When you build program below, once as 64bit and once as 32bit, 32bit one
should print 464C457F and 64bit one should die with SIGSEGV.  But when
you run both in parallel, 64bit one sometime gets SIGSEGV as it should,
sometime it gets 464C457F. (actually results below are from SMP system;
I believe that on UP you'll get reproducible 464C457F on UP system...)

vana:~/64bit-test# ./tpg32
Memory at ffffe000 is 464C457F
vana:~/64bit-test# ./tpg
Segmentation fault
vana:~/64bit-test# ./tpg32 & ./tpg
[1] 8450
Memory at ffffe000 is 464C457F
Memory at ffffe000 is 464C457F
[1]+  Exit 31                 ./tpg32
vana:~/64bit-test# ./tpg32 & ./tpg
[1] 8454
Memory at ffffe000 is 464C457F
[1]+  Exit 31                 ./tpg32
Segmentation fault
vana:~/64bit-test# ./tpg32 & ./tpg
[1] 8456
Memory at ffffe000 is 464C457F
Memory at ffffe000 is 464C457F
[1]+  Exit 31                 ./tpg32
vana:~/64bit-test# ./tpg32 & ./tpg
[1] 8458
Memory at ffffe000 is 464C457F
Memory at ffffe000 is 464C457F
[1]+  Exit 31                 ./tpg32
vana:~/64bit-test#


void main(void) {
	int acc;
	int i;

	for (i = 0; i < 100000000; i++) ;
	acc = *(volatile unsigned long*)(0xffffe000);
	printf("Memory at ffffe000 is %08X\n", acc);
}

								Petr


diff -urdN linux/arch/x86_64/ia32/syscall32.c linux/arch/x86_64/ia32/syscall32.c
--- linux/arch/x86_64/ia32/syscall32.c	2005-01-17 12:29:05.000000000 +0000
+++ linux/arch/x86_64/ia32/syscall32.c	2005-01-21 16:15:04.000000000 +0000
@@ -55,7 +55,7 @@
  			if (pte_none(*pte)) {
  				set_pte(pte,
  					mk_pte(virt_to_page(syscall32_page),
- 					       PAGE_KERNEL_VSYSCALL));
+ 					       PAGE_KERNEL_VSYSCALL32));
  			}
  			/* Flush only the local CPU. Other CPUs taking a fault
  			   will just end up here again
diff -urdN linux/include/asm-x86_64/pgtable.h linux/include/asm-x86_64/pgtable.h
--- linux/include/asm-x86_64/pgtable.h	2005-01-17 12:29:11.000000000 +0000
+++ linux/include/asm-x86_64/pgtable.h	2005-01-21 16:14:44.000000000 +0000
@@ -182,6 +182,7 @@
 #define PAGE_KERNEL_EXEC MAKE_GLOBAL(__PAGE_KERNEL_EXEC)
 #define PAGE_KERNEL_RO MAKE_GLOBAL(__PAGE_KERNEL_RO)
 #define PAGE_KERNEL_NOCACHE MAKE_GLOBAL(__PAGE_KERNEL_NOCACHE)
+#define PAGE_KERNEL_VSYSCALL32 __pgprot(__PAGE_KERNEL_VSYSCALL)
 #define PAGE_KERNEL_VSYSCALL MAKE_GLOBAL(__PAGE_KERNEL_VSYSCALL)
 #define PAGE_KERNEL_LARGE MAKE_GLOBAL(__PAGE_KERNEL_LARGE)
 #define PAGE_KERNEL_VSYSCALL_NOCACHE MAKE_GLOBAL(__PAGE_KERNEL_VSYSCALL_NOCACHE)
