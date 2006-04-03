Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWDCOso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWDCOso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 10:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWDCOso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 10:48:44 -0400
Received: from mail.ccur.com ([66.10.65.12]:60057 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S1751631AbWDCOsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 10:48:43 -0400
Message-ID: <443135C9.7070008@ccur.com>
Date: Mon, 03 Apr 2006 10:48:41 -0400
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ak@suse.de, bugsy@ccur.com
Subject: [PATCH] arch/x86_64/kernel/process.c do_arch_prctl() ARCH_GET_GS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Apr 2006 14:48:42.0733 (UTC) FILETIME=[B3BD99D0:01C6572D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

In linux-2.6.16, we have noticed a problem where the gs base value
returned from an arch_prtcl(ARCH_GET_GS, ...) call will be incorrect if:

   - the current/calling task has NOT set its own gs base yet to a
     non-zero value,

   - some other task that ran on the same processor previously set their
     own gs base to a non-zero value.

In this situation, the ARCH_GET_GS code will read and return the
MSR_KERNEL_GS_BASE msr register.

However, since the __switch_to() code does NOT load/zero the
MSR_KERNEL_GS_BASE register when the task that is switched IN has a zero
next->gs value, the caller of arch_prctl(ARCH_GET_GS, ...) will get back
the value of some previous tasks's gs base value instead of 0.

I guess that there might be two approaches to fixing this problem:

1. Change the arch_prctl() ARCH_GET_GS code to only read and return
    the MSR_KERNEL_GS_BASE msr register if the 'gs' register of the calling
    task is non-zero.

    Side note: Since in addition to using arch_prctl(ARCH_SET_GS, ...),
    a task can also setup a gs base value by using modify_ldt() and write
    an index value into 'gs' from user space, the patch below reads
    'gs' instead of using thread.gs, since in the modify_ldt() case,
    the thread.gs value will be 0, and incorrect value would be returned
    (the task->thread.gs value).

    When the user has not set its own gs base value and the 'gs'
    register is zero, then the MSR_KERNEL_GS_BASE register will not be
    read and a value of zero will be returned by reading and returning
    'task->thread.gs'.

    The first patch shown below is an attempt at implementing this
    approach.

2. The second approach would would be to the __switch_to() code, and while
    it keeps another task's gs base value from lying around in the
    MSR_KERNEL_GS_BASE msr register after that task has been switched out,
    it does add overhead to __switch_to() when ever the current and/or
    next task has a non-zero gs value.

    In this case, always write the next tasks's next-gs value to the
    MSR_KERNEL_GS_BASE msr register when the previous and/or next task has
    a non-zero gsindex or (prev) gs value.  Thus, the zero gs base value
    will be written into this msr register when ever transitioning from
    a non-zero gs base value to a zero gs base value.

    This approach is shown below in the 2nd patch.


Maybe one of these approaches could be used as a fix.

I have tested both approaches with tasks that have a 0 gs base value
along with tasks that have set their gs base value with 32 and 64 bit
values via the arch_prctl() ARCH_GET_GS interface, and also with the
modify_ldt()/set gs interface.


Thank you for you time and considerations.



============== Approach 1 =================

diff -up linux-2.6.16/arch/x86_64/kernel/process.c 
new/arch/x86_64/kernel/process.c
--- linux-2.6.16/arch/x86_64/kernel/process.c	2006-03-20 
00:53:29.000000000 -0500
+++ new/arch/x86_64/kernel/process.c	2006-04-03 09:27:09.000000000 -0400
@@ -794,10 +794,16 @@ long do_arch_prctl(struct task_struct *t
  	}
  	case ARCH_GET_GS: {
  		unsigned long base;
+		unsigned gsindex;
  		if (task->thread.gsindex == GS_TLS_SEL)
  			base = read_32bit_tls(task, GS_TLS);
-		else if (doit)
-			rdmsrl(MSR_KERNEL_GS_BASE, base);
+		else if (doit) {
+ 			asm("movl %%gs,%0" : "=r" (gsindex));
+			if (gsindex)
+				rdmsrl(MSR_KERNEL_GS_BASE, base);
+			else
+				base = task->thread.gs;
+		}
  		else
  			base = task->thread.gs;
  		ret = put_user(base, (unsigned long __user *)addr);




============== Approach 2 =================

diff -up linux-2.6.16/arch/x86_64/kernel/process.c 
new/arch/x86_64/kernel/process.c
--- linux-2.6.16/arch/x86_64/kernel/process.c	2006-04-03 
09:29:30.000000000 -0400
+++ new/arch/x86_64/kernel/process.c	2006-04-03 09:35:51.000000000 -0400
@@ -579,8 +579,9 @@ __switch_to(struct task_struct *prev_p,
  			load_gs_index(next->gsindex);
  			if (gsindex)
  			prev->gs = 0;				
+			wrmsrl(MSR_KERNEL_GS_BASE, next->gs);
  		}
-		if (next->gs)
+		else if (next->gs)
  			wrmsrl(MSR_KERNEL_GS_BASE, next->gs);
  		prev->gsindex = gsindex;
  	}
