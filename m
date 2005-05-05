Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVEEIQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVEEIQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 04:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVEEIQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 04:16:21 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:16108 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261994AbVEEIQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 04:16:17 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.current Oops: strace + waitpid()?
From: Alexander Nyberg <alexn@telia.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <m3mzrapm3w.fsf@defiant.localdomain>
References: <m3mzrapm3w.fsf@defiant.localdomain>
Content-Type: text/plain
Date: Thu, 05 May 2005 10:16:11 +0200
Message-Id: <1115280971.933.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> intrepid:~$ cat test.pl
> #!/usr/bin/perl
> 
> open my $fd, "-|", "/bin/true";
> 
> intrepid:~$ strace -f ./test.pl
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> 00000000
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> Modules linked in: binfmt_misc ohci1394 ieee1394 pci200syn hdlc syncppp
> emu10k1_gp snd_cmipci gameport snd_opl3_lib snd_mpu401_uart epic100 sg
> sym53c8xx scsi_transport_spi evdev
> CPU:    0
> EIP:    0060:[<00000000>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.12-rc3) 
> EIP is at 0x0
> eax: ca476000   ebx: 01200011   ecx: 00000000   edx: 00000000
> esi: cfbd3060   edi: 00000000   ebp: ca476000   esp: ca476fc4
> ds: 007b   es: 007b   ss: 0068
> Process test.pl (pid: 3168, threadinfo=ca476000 task=cfbd3060)
> Stack: 01202011 00000000 00000000 00000000 b7c9a708 bfea12cc 00000000 0000007b 
>        0000007b 00000078 ffffe410 00000073 00000282 bfea121c 0000007b 
> Call Trace:
> Code:  Bad EIP value.
> 
> 2.6.12-rc3 (current), gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.fc3),
> Athlon XP.
> 
> The machine is still alive, oops is 100% reproducible.
> 
>  3174 ?        Ss     0:00 \_ xterm -rv
>  3176 pts/1    Ss     0:00     \_ bash
>  3210 pts/1    S+     0:00         \_ strace -f ./test.pl
>  3211 pts/1    T+     0:00             \_ /usr/bin/perl ./test.pl
>  3212 pts/1    Z+     0:00                 \_ [test.pl] <defunct>
> 
> Any idea?

Ok tested here, it's the ptrace scribbles the return address due to
incorrect esp0 at fork time (it's in -mm currently).

Could you please verify that this fixes it

Index: latest/arch/i386/kernel/process.c
===================================================================
--- latest.orig/arch/i386/kernel/process.c	2005-04-30 15:44:02.000000000 +0200
+++ latest/arch/i386/kernel/process.c	2005-05-03 12:54:16.000000000 +0200
@@ -400,11 +400,6 @@
 	int err;
 
 	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
-	*childregs = *regs;
-	childregs->eax = 0;
-	childregs->esp = esp;
-
-	p->thread.esp = (unsigned long) childregs;
 	/*
 	 * The below -8 is to reserve 8 bytes on top of the ring0 stack.
 	 * This is necessary to guarantee that the entire "struct pt_regs"
@@ -415,7 +410,13 @@
 	 * "struct pt_regs" is possible, but they may contain the
 	 * completely wrong values.
 	 */
-	p->thread.esp0 = (unsigned long) (childregs+1) - 8;
+	childregs = (struct pt_regs *) ((unsigned long) childregs - 8);
+	*childregs = *regs;
+	childregs->eax = 0;
+	childregs->esp = esp;
+
+	p->thread.esp = (unsigned long) childregs;
+	p->thread.esp0 = (unsigned long) (childregs+1);
 
 	p->thread.eip = (unsigned long) ret_from_fork;
 


