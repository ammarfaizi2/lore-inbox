Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270663AbRHJWlV>; Fri, 10 Aug 2001 18:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270664AbRHJWlK>; Fri, 10 Aug 2001 18:41:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1285 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270663AbRHJWlA>; Fri, 10 Aug 2001 18:41:00 -0400
Subject: Re: free_task_struct() called too early?
To: kenneth.w.chen@intel.com (Chen, Kenneth W)
Date: Fri, 10 Aug 2001 23:43:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <no.id> from "Chen, Kenneth W" at Aug 10, 2001 11:13:53 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VKzz-0001md-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When a process terminates, it appears that the task structure is freed too
> early.  There are memory references to the kernel task area (task_struct and
> stack space) after free_task_struct(p) is called.
> 
> If I modify the following line in include/asm-i386/processor.h
> 
> #define free_task_struct(p)   free_pages((unsigned long) (p), 1) to
> #define free_task_struct(p)   memset((void*) (p), 0xf, PAGE_SIZE*2);
> free_pages((unsigned long) (p), 1)
> then kernel will boot to init and lockup on when first task terminates.
> 
> Has anyone looked into or aware of this issue?

2.4.8pre fixed a case with semaphores on the stack. It might not be the only
one. Your #define is wrong though, if a single free_task_struct path is an
if you will not do what you expect

	do { memset(), free_pages } while(0);

would be safer. 

I'd like to know if 2.4.8pre8 does it except on module unload (where it is
still buggy)

Alan
