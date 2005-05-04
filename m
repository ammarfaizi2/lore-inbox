Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVEDJAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVEDJAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 05:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVEDJAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 05:00:30 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:51125 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261505AbVEDJAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 05:00:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: avoid infinite loop in x86_64 interrupt return
Date: Wed, 4 May 2005 11:00:32 +0200
User-Agent: KMail/1.8
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050504050132.GA3899@opteron.random>
In-Reply-To: <20050504050132.GA3899@opteron.random>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_x8IeC1X/WVGb5j9"
Message-Id: <200505041100.33099.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_x8IeC1X/WVGb5j9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Wednesday, 4 of May 2005 07:01, Andrea Arcangeli wrote:
> Hello,
> 
> A few minutes ago I've got an unkillable task in R state with vanilla
> 2.6.12-rc3 on x86_64, luckily system was still up with the other cpu (on
> the desktop, so I had no kgdb environment set). Debugging revelaed rdi
> corrupt when entering retint_signal (not set to $_TIF_WORK_MASK as
> expected). This lead the rdx&rdi to return 0x20000 -> infinite loop.
> Precisely rdi is set to ffff810030923f58 instead of $_TIF_WORK_MASK. So
> it was the combination of ...2xxxx as rsp with TIF_IA32 in the task
> flags. After noticing the rdi screwup the bug was quite clear: rdi was
> set to pt_regs instead of $_TIF_WORK_MASK. Of course rsp is set to
> ffff810030923f58 too (which also means do_notify_resume didn't clobber
> rdi even if it could).
> 
> The below should fix the problem, I've no idea how to reproduce the
> problem but it works on basic testing. The task looping was java (32bit,
> that's where the 0x20000 come from), but it wasn't me starting java, it
> must have been some random website (java was hanging around with 100%
> system time for half an hour once I noticed it).
> 
> Signed-off-by: Andrea Arcangeli <andrea@suse.de>
> 
> --- 2.6.12-rc3/arch/x86_64/kernel/entry.S.orig	2005-05-04 06:47:02.000000000 +0200
> +++ 2.6.12-rc3/arch/x86_64/kernel/entry.S	2005-05-04 06:50:34.000000000 +0200
> @@ -489,6 +489,7 @@ retint_signal:
>  	movq %rsp,%rdi		# &pt_regs
>  	call do_notify_resume
>  	RESTORE_REST
> +	movl $_TIF_WORK_MASK,%edi
>  	cli
>  	GET_THREAD_INFO(%rcx)	
>  	jmp retint_check
> -

You also need to add two missing clis.  Please have a look at the attached
patch from Andi.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_x8IeC1X/WVGb5j9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.12-rc3-unkillable-java-ak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.12-rc3-unkillable-java-ak.patch"

Signed-off-by: Andi Kleen <ak@suse.de>


diff -u linux-2.6.12rc3/arch/x86_64/kernel/entry.S-o linux-2.6.12rc3/arch/x86_64/kernel/entry.S
--- linux-2.6.12rc3/arch/x86_64/kernel/entry.S-o	2005-04-22 12:48:11.000000000 +0200
+++ linux-2.6.12rc3/arch/x86_64/kernel/entry.S	2005-04-27 15:52:49.305183345 +0200
@@ -296,6 +296,7 @@
 	call syscall_trace_leave
 	popq %rdi
 	andl $~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edi
+	cli	
 	jmp int_restore_rest
 	
 int_signal:
@@ -307,6 +308,7 @@
 1:	movl $_TIF_NEED_RESCHED,%edi	
 int_restore_rest:
 	RESTORE_REST
+	cli	
 	jmp int_with_check
 	CFI_ENDPROC
 		
@@ -490,7 +492,8 @@
 	call do_notify_resume
 	RESTORE_REST
 	cli
-	GET_THREAD_INFO(%rcx)	
+	GET_THREAD_INFO(%rcx)
+	movl $_TIF_WORK_MASK,%edi	
 	jmp retint_check
 
 #ifdef CONFIG_PREEMPT



--Boundary-00=_x8IeC1X/WVGb5j9--
