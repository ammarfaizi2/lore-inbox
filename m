Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbULPOxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbULPOxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbULPOxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:53:01 -0500
Received: from mx1.elte.hu ([157.181.1.137]:64428 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262671AbULPOwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:52:19 -0500
Date: Thu, 16 Dec 2004 15:51:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
Message-ID: <20041216145159.GA3204@elte.hu>
References: <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random> <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu> <20041214224706.GA26853@elte.hu> <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org> <1103157476.3585.33.camel@localhost.localdomain> <Pine.LNX.4.58.0412151756550.3279@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412151756550.3279@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> The irq window should actually be open every alternate instruction, I
> think. Although it's not actually architected, and I thought that
> there was some errata for some CPU about this..

i have generated an instruction-granularity profile of kernel code
executing the following sequence, driven by the NMI watchdog interrupt:

 asm ("cli; cli; sti; cli; sti; cli; sti; cli; sti; cli; sti; ");
 asm ("cli; cli; sti; cli; sti; cli; sti; cli; sti; cli; sti; ");
 asm ("cli; cli; sti; cli; sti; cli; sti; cli; sti; cli; sti; ");

the first CLI is done twice, to prove that the NMI profiling works and
that the kernel can be interrupted in those places. Then i called this
kernel code in a loop. Here's the result:

c0125ee9:     1529 	fa                   	cli    
                 ^---------------------------------- # of profiler hits
c0125eea:      507 	fb                   	sti    
c0125eeb:        0 	fa                   	cli    
c0125eec:     3719 	fb                   	sti    
c0125eed:        0 	fa                   	cli    
c0125eee:     1579 	fb                   	sti    
c0125eef:        0 	fa                   	cli    
c0125ef0:     3317 	fb                   	sti    
c0125ef1:        0 	fa                   	cli    
c0125ef2:     3030 	fb                   	sti    
c0125ef3:        0 	fa                   	cli    
c0125ef4:     2497 	fa                   	cli    
c0125ef5:     1055 	fb                   	sti    
c0125ef6:        0 	fa                   	cli    
c0125ef7:     4674 	fb                   	sti    
c0125ef8:        0 	fa                   	cli    
c0125ef9:     3827 	fb                   	sti    
c0125efa:        0 	fa                   	cli    
c0125efb:     1622 	fb                   	sti    
c0125efc:        0 	fa                   	cli    
c0125efd:     3155 	fb                   	sti    
c0125efe:        0 	fa                   	cli    
c0125eff:     1273 	fa                   	cli    
c0125f00:      512 	fb                   	sti    
c0125f01:        0 	fa                   	cli    
c0125f02:     1312 	fb                   	sti    
c0125f03:        0 	fa                   	cli    
c0125f04:     1426 	fb                   	sti    
c0125f05:        0 	fa                   	cli    
c0125f06:     1507 	fb                   	sti    
c0125f07:        0 	fa                   	cli    
c0125f08:     2720 	fb                   	sti    
c0125f09:        0 	fa                   	cli    
c0125f0a:     2469 	fa                   	cli    
c0125f0b:      787 	fb                   	sti    
c0125f0c:        0 	fa                   	cli    
c0125f0d:     2085 	fb                   	sti    
c0125f0e:        0 	fa                   	cli    

the 'cli' is always a 'black hole' to the NMI, while the second of two
consecutive cli's are not.

i also played a bit with the %ss instructions, and combined them with
the cli/sti instructions and other instructions in various ways, and
with a bit of experimenting found the following, somewhat surprising
results:

c0125f33:     1016 	66 8c d0             	mov    %ss,%ax
c0125f36:     6626 	8e d0                	mov    %eax,%ss
c0125f38:    34715 	8e d0                	mov    %eax,%ss
c0125f3a:    14682 	8e d0                	mov    %eax,%ss
c0125f3c:     4521 	8e d0                	mov    %eax,%ss
c0125f3e:     7564 	8e d0                	mov    %eax,%ss
c0125f40:     3861 	66 8e d0             	mov    %ax,%ss
c0125f43:        0 	66 8c d1             	mov    %ss,%cx
c0125f46:     1061 	66 8c da             	mov    %ds,%dx
c0125f49:     7660 	8e d1                	mov    %ecx,%ss
c0125f4b:    11322 	17                   	pop    %ss
c0125f4c:        0 	fb                   	sti    
c0125f4d:     8935 	8e d1                	mov    %ecx,%ss
c0125f4f:        0 	fa                   	cli    
c0125f50:     2198 	66 8c d1             	mov    %ss,%cx
c0125f53:      735 	66 8c da             	mov    %ds,%dx
c0125f56:        0 	8e da                	mov    %edx,%ds
c0125f58:     6400 	8e d0                	mov    %eax,%ss
c0125f5a:     3062 	8e d0                	mov    %eax,%ss
c0125f5c:     3552 	8e d0                	mov    %eax,%ss
c0125f5e:     4818 	8e d0                	mov    %eax,%ss
c0125f60:        0 	fb                   	sti    
c0125f61:        0 	66 8c da             	mov    %ds,%dx
c0125f64:    17788 	8e d0                	mov    %eax,%ss
c0125f66:    64694 	8e d0                	mov    %eax,%ss
c0125f68:    12837 	8e d0                	mov    %eax,%ss
c0125f6a:     9859 	8e d0                	mov    %eax,%ss
c0125f6c:        0 	fb                   	sti    
c0125f6d:    74506 	8e d0                	mov    %eax,%ss
c0125f6f:        0 	fb                   	sti    
c0125f70:     8589 	fa                   	cli    
c0125f71:    10248 	8e d0                	mov    %eax,%ss
c0125f73:     3825 	8e d0                	mov    %eax,%ss
c0125f75:     4903 	8e d0                	mov    %eax,%ss
c0125f77:    71134 	8e d0                	mov    %eax,%ss
c0125f79:        0 	fb                   	sti    
c0125f7a:        0 	fa                   	cli    
c0125f7b:     7461 	8e d0                	mov    %eax,%ss
c0125f7d:        0 	66 8c d0             	mov    %ss,%ax
c0125f80:    39387 	8e d0                	mov    %eax,%ss
c0125f82:        0 	fa                   	cli    
c0125f83:    41484 	8e d0                	mov    %eax,%ss
c0125f85:        0 	fa                   	cli    
c0125f86:     4490 	8e d0                	mov    %eax,%ss
c0125f88:        0 	fa                   	cli    
c0125f89:     6024 	8e d0                	mov    %eax,%ss
c0125f8b:    15454 	8e d0                	mov    %eax,%ss
c0125f8d:        0 	fb                   	sti    
c0125f8e:        0 	fb                   	sti    
c0125f8f:   115104 	fb                   	sti    
c0125f90:    39061 	fb                   	sti    

it shows a number of interesting effects:

- "mov %eax,%ss" followed by the _same_ instruction cancels the 
  black-hole. This i suspect is done to prevent the lockup in vm86
  mode.

- an %ss black-hole instruction followed by 'sti' cancels sti's
  black-hole. This is unlikely to occur in real kernel code, but we
  might want to add a 'nop' in front of safe_halt()'s sti, to make sure
  the black-hole takes effect.

- in one case a two-instruction blackhole was created - but this might 
  be some prefetch effect.

i played around with the instructions a bit to manufacture combinations
that enlengthen the black-hole but failed :) This was on an Athlon64.

	Ingo
