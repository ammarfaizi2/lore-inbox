Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269973AbRHJSwR>; Fri, 10 Aug 2001 14:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269971AbRHJSv5>; Fri, 10 Aug 2001 14:51:57 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:42762 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269973AbRHJSvw>; Fri, 10 Aug 2001 14:51:52 -0400
Message-ID: <3B742EAF.8DC816D0@zip.com.au>
Date: Fri, 10 Aug 2001 11:57:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: free_task_struct() called too early?
In-Reply-To: <794826DE8867D411BAB8009027AE9EB91011431F@FMSMSX38>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" wrote:
> 
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

free_pages will not actually free the page if its reference count
is greater than one - you're poisoning the page before it has actually
ceased to be used.

You should zap the page in __free_pages(), after the put_page_testzero()
call has succeeded.
