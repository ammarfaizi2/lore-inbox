Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRDDVjR>; Wed, 4 Apr 2001 17:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132485AbRDDVjI>; Wed, 4 Apr 2001 17:39:08 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:38448 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S132484AbRDDVjA>; Wed, 4 Apr 2001 17:39:00 -0400
Date: Wed, 4 Apr 2001 22:21:29 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel/sched.c questions
In-Reply-To: <oupzodwxvr7.fsf@pigdrop.muc.suse.de>
Message-ID: <Pine.LNX.3.96.1010404221044.20959C-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Apr 2001, Andi Kleen wrote:
> > >>	Hello, I would like to know why you put this two functions:
> > >>	void scheduling_functions_start_here(void) { }
> > >>	...
> > >>	void scheduling_functions_end_here(void) { }

> This is needed for a very bad hack to get the EIP information in ps -lax:
> most programs would be shown as hanging in schedule(), which would not be 
> very useful to show the user. To avoid this sched.c is always compiled with 
> frame pointers and if the EIP is inside these two functions the proc code 
> goes back one level in the stack frame.

That sure is a very bad hack :) (For the original poster: search for
get_wchan in the various ports)

There is no comment anywhere near it that says what it is MEANT to do. You
can guess from the code and the usage that it has to do with stack-frames
and special-casing the scheduler functions..  Thanks for the 
clarification.. now I can go and fix it in arch/cris :) (I had never seen
the WCHAN field in ps before actually)

Just as a reference (everyone should get their daily dose of headache)
here is the i386 version:

unsigned long get_wchan(struct task_struct *p)
{
        unsigned long ebp, esp, eip;
        unsigned long stack_page;
        int count = 0;
        if (!p || p == current || p->state == TASK_RUNNING)
                return 0;
        stack_page = (unsigned long)p;
        esp = p->thread.esp;
        if (!stack_page || esp < stack_page || esp > 8188+stack_page)
                return 0;
        /* include/asm-i386/system.h:switch_to() pushes ebp last. */
        ebp = *(unsigned long *) esp;
        do {
                if (ebp < stack_page || ebp > 8184+stack_page)
                        return 0;
                eip = *(unsigned long *) (ebp+4);
                if (eip < first_sched || eip >= last_sched)
                        return eip;
                ebp = *(unsigned long *) ebp;
        } while (count++ < 16);
        return 0;
}

-BW


