Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966278AbWK2IdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966278AbWK2IdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966222AbWK2IdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:33:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2568 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966278AbWK2IdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:33:05 -0500
Date: Wed, 29 Nov 2006 09:33:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: A commit between 2.6.16.4 and 2.6.16.5 failed crashme
Message-ID: <20061129083310.GC11084@stusta.de>
References: <ac8af0be0611290018y70c68a66r5a3199f08e6417d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <ac8af0be0611290018y70c68a66r5a3199f08e6417d5@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2006 at 12:18:18AM -0800, Zhao Forrest wrote:
> On 11/28/06, Andi Kleen <ak@suse.de> wrote:
> >
> >> I first need to contact the author of test case if we could send the
> >> test case to open source. The test case is called "crashme",
> >
> >Is that the classical crashme as found in LTP or an enhanced one?
> >Do you run it in a special way? Is the crash reproducible?
> >
> >We normally run crashme regularly as part of LTP, Cerberus etc.
> >so at least any obvious bugs should in theory be caught.
> >
> 
> Let me change the subject of this thread.
> I just read our private version of crashme. It's based on crashme
> version 2.4 and add some logging capability, no other enhancement. So
> it should be the same as crashme in LTP.
> 
> It is solidly reproducible within 3 minutes of running crashme.
> 
> The current status is: we know it's a commit between 2.6.16.4 and
> 2.6.16.5 that introduce this bug.
> 
> Our network is very slow(only 5-6K/second). So we'll start the
> git-bisect tomorrow after finishing downloading the 2.6.16 stable git
> tree.

Thanks for your report.

A git-bisect might be a bit of overkill considering that there were only 
two patches applied beween 2.6.16.4 and 2.6.16.5:

Andi Kleen (2):
      x86_64: Clean up execve
      x86_64: When user could have changed RIP always force IRET (CVE-2006-0744)

I've attached both patches.

Could you manually bisect first applying "x86_64: Clean up execve" 
(patch-2.6.16.4-5-1) against 2.6.16.4?

Then we'll know which of Andi's pacthes caused this bug.

> Thanks,
> Forrest

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.16.4-5-1"

commit 59b2832a31ae2f3279bb5b16ae9b1c4e38e40dea
Author: Andi Kleen <ak@suse.de>
Date:   Wed Apr 12 08:18:46 2006 +0200

    [PATCH] x86_64: Clean up execve
    
    Just call IRET always, no need for any special cases.
    
    Needed for the next bug fix.
    
    Signed-off-by: Andi Kleen <ak@suse.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
index 7c10e90..25dcb77 100644
--- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -408,25 +408,9 @@ ENTRY(stub_execve)
 	CFI_ADJUST_CFA_OFFSET -8
 	CFI_REGISTER rip, r11
 	SAVE_REST
-	movq %r11, %r15
-	CFI_REGISTER rip, r15
 	FIXUP_TOP_OF_STACK %r11
 	call sys_execve
-	GET_THREAD_INFO(%rcx)
-	bt $TIF_IA32,threadinfo_flags(%rcx)
-	CFI_REMEMBER_STATE
-	jc exec_32bit
 	RESTORE_TOP_OF_STACK %r11
-	movq %r15, %r11
-	CFI_REGISTER rip, r11
-	RESTORE_REST
-	pushq %r11
-	CFI_ADJUST_CFA_OFFSET 8
-	CFI_REL_OFFSET rip, 0
-	ret
-
-exec_32bit:
-	CFI_RESTORE_STATE
 	movq %rax,RAX(%rsp)
 	RESTORE_REST
 	jmp int_ret_from_sys_call

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.16.4-5-2"

commit 6b12095a4a0e1f21bbf83f95f13299ca99d758fe
Author: Andi Kleen <ak@suse.de>
Date:   Wed Apr 12 08:19:29 2006 +0200

    [PATCH] x86_64: When user could have changed RIP always force IRET (CVE-2006-0744)
    
    Intel EM64T CPUs handle uncanonical return addresses differently from
    AMD CPUs.
    
    The exception is reported in the SYSRET, not the next instruction.
    Thgis leads to the kernel exception handler running on the user stack
    with the wrong GS because the kernel didn't expect exceptions on this
    instruction.
    
    This version of the patch has the teething problems that plagued an
    earlier version fixed.
    
    This is CVE-2006-0744
    
    Thanks to Ernie Petrides and Asit B. Mallick for analysis and initial
    patches.
    
    Signed-off-by: Andi Kleen <ak@suse.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
index 25dcb77..ab6e44d 100644
--- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -180,6 +180,10 @@ rff_trace:
  *
  * XXX	if we had a free scratch register we could save the RSP into the stack frame
  *      and report it properly in ps. Unfortunately we haven't.
+ *
+ * When user can change the frames always force IRET. That is because
+ * it deals with uncanonical addresses better. SYSRET has trouble
+ * with them due to bugs in both AMD and Intel CPUs.
  */ 			 		
 
 ENTRY(system_call)
@@ -254,7 +258,10 @@ sysret_signal:
 	xorl %esi,%esi # oldset -> arg2
 	call ptregscall_common
 1:	movl $_TIF_NEED_RESCHED,%edi
-	jmp sysret_check
+	/* Use IRET because user could have changed frame. This
+	   works because ptregscall_common has called FIXUP_TOP_OF_STACK. */
+	cli
+	jmp int_with_check
 	
 badsys:
 	movq $-ENOSYS,RAX-ARGOFFSET(%rsp)
@@ -280,7 +287,8 @@ tracesys:
 	call syscall_trace_leave
 	RESTORE_TOP_OF_STACK %rbx
 	RESTORE_REST
-	jmp ret_from_sys_call
+	/* Use IRET because user could have changed frame */
+	jmp int_ret_from_sys_call
 	CFI_ENDPROC
 		
 /* 

--T4sUOijqQbZv57TR--
