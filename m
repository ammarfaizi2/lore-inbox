Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTELOy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTELOy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:54:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:2779 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262161AbTELOy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:54:26 -0400
Message-ID: <3EBFB82B.8040509@us.ibm.com>
Date: Mon, 12 May 2003 08:05:15 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.69-mjb1
References: <9380000.1052624649@[10.10.2.4]> <20030512132939.GF19053@holomorphy.com> <21850000.1052743254@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --On Monday, May 12, 2003 06:29:39 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:
> 
> 
>>On Sat, May 10, 2003 at 08:44:09PM -0700, Martin J. Bligh wrote:
>>
>>>thread_info_cleanup (4K stacks pt 1)		Dave Hansen / Ben LaHaise
>>>	Prep work to reduce kernel stacks to 4K
>>>interrupt_stacks    (4K stacks pt 2)		Dave Hansen / Ben LaHaise
>>>	Create a per-cpu interrupt stack.
>>>stack_usage_check   (4K stacks pt 3)		Dave Hansen / Ben LaHaise
>>>	Check for kernel stack overflows.
>>>4k_stack            (4K stacks pt 4)		Dave Hansen
>>>	Config option to reduce kernel stacks to 4K
>>
>>
>>diff -urpN linux-2.5.69/include/asm-i386/processor.h kstk-2.5.69-1/include/asm-i386/processor.h
>>--- linux-2.5.69/include/asm-i386/processor.h	2003-05-04 16:53:00.000000000 -0700
>>+++ kstk-2.5.69-1/include/asm-i386/processor.h	2003-05-12 06:05:39.000000000 -0700
>>@@ -470,8 +470,8 @@ extern int kernel_thread(int (*fn)(void 
>> extern unsigned long thread_saved_pc(struct task_struct *tsk);
>> 
>> unsigned long get_wchan(struct task_struct *p);
>>-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
>>-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1022])
>>+#define KSTK_EIP(task)	(((unsigned long *)(task)->thread_info)[THREAD_SIZE/sizeof(unsigned long) - 5])
>>+#define KSTK_ESP(task)	(((unsigned long *)(task)->thread_info)[THREAD_SIZE/sizeof(unsigned long) - 2])
>> 
>> struct microcode {
>> 	unsigned int hdrver;
> 
> Can I get some sort of vague explanation please? ;-)

Wow, that's intuitive :)

They're trying to access the variables that have been pushed onto the
top of the stack.  The thread_info field points to the bottom of the
kernel's stack (no matter how big it is).  I don't know where the -5 and
-2 come from.  It needs a big, fat stinking comment.

-- 
Dave Hansen
haveblue@us.ibm.com

