Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291027AbSBGB0M>; Wed, 6 Feb 2002 20:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291044AbSBGB0D>; Wed, 6 Feb 2002 20:26:03 -0500
Received: from f243.law11.hotmail.com ([64.4.17.243]:42766 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S291027AbSBGBZq>;
	Wed, 6 Feb 2002 20:25:46 -0500
X-Originating-IP: [156.153.254.10]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: balbir_soni@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: Need help with changing stack size (attn parisc folks)
Date: Wed, 06 Feb 2002 17:25:40 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F243guA8M6XQQez1enA00002851@hotmail.com>
X-OriginalArrivalTime: 07 Feb 2002 01:25:40.0441 (UTC) FILETIME=[5A9E4C90:01C1AF76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got it to work finally.
I will post a document on that soon

Balbir

>From: "Balbir Singh" <balbir_soni@hotmail.com>
>To: linux-kernel@vger.kernel.org
>CC: balbir_soni@hotmail.com
>Subject: Re: Need help with changing stack size (attn parisc folks)
>Date: Wed, 06 Feb 2002 16:57:49 -0800
>
>I also made changes to lgetuser.S and entry.S, for entries
>I missed.
>
>Balbir
>
>
>>From: "Balbir Singh" <balbir_soni@hotmail.com>
>>To: linux-kernel@vger.kernel.org
>>CC: balbir_soni@hotmail.com
>>Subject: Need help with changing stack size (attn parisc folks)
>>Date: Wed, 06 Feb 2002 16:12:12 -0800
>>
>>I have some legacy code and I think I run into some
>>kind of stack overflow with it. To verify that, I tried
>>increasing the stack size from 8K to 16K. I changed
>>the following files
>>
>>processor.h
>>current.h
>>vmlinux.lds
>>head.S
>>
>>The changes were kind of obvious. I know the PARISC guys
>>have done something similar. Is there something missing
>>with my changes, since the kernel does not come up,
>>it is unable to start even kswapd. The diffs have been
>>include below. Please cc to me in your reply since
>>I am not hooked onto lkml.
>>
>>All help appreciated,
>>
>>Thanks,
>>Balbir
>>
>>--- processor.h.org     Wed Feb  6 15:10:37 2002
>>+++ processor.h Wed Feb  6 15:53:10 2002
>>@@ -447,9 +447,9 @@
>>#define KSTK_EIP(tsk)  (((unsigned long *)(4096+(unsigned 
>>long)(tsk)))[1019])
>>#define KSTK_ESP(tsk)  (((unsigned long *)(4096+(unsigned 
>>long)(tsk)))[1022])
>>
>>-#define THREAD_SIZE (2*PAGE_SIZE)
>>-#define alloc_task_struct() ((struct task_struct *) 
>>__get_free_pages(GFP_KERNEL,1))
>>-#define free_task_struct(p) free_pages((unsigned long) (p), 1)
>>+#define THREAD_SIZE (4*PAGE_SIZE)
>>+#define alloc_task_struct() ((struct task_struct *) 
>>__get_free_pages(GFP_KERNEL,2))
>>+#define free_task_struct(p) free_pages((unsigned long) (p), 2)
>>#define get_task_struct(tsk)      atomic_inc(&virt_to_page(tsk)->count)
>>
>>#define init_task      (init_task_union.task)
>>
>>--- current.h.org       Wed Feb  6 15:11:51 2002
>>+++ current.h   Wed Feb  6 15:52:12 2002
>>@@ -6,7 +6,7 @@
>>static inline struct task_struct * get_current(void)
>>{
>>        struct task_struct *current;
>>-       __asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
>>+       __asm__("andl %%esp,%0; ":"=r" (current) : "0" (~(THREAD_SIZE - 
>>1)));
>>        return current;
>>  }
>>
>>
>>--- vmlinux.lds.org     Wed Feb  6 15:41:07 2002
>>+++ vmlinux.lds Wed Feb  6 15:41:15 2002
>>@@ -36,7 +36,7 @@
>>
>>   _edata = .;                  /* End of data section */
>>
>>-  . = ALIGN(8192);             /* init_task */
>>+  . = ALIGN(16384);            /* init_task */
>>   .data.init_task : { *(.data.init_task) }
>>
>>   . = ALIGN(4096);             /* Init code and data */
>>
>>--- head.S.org  Wed Feb  6 16:21:47 2002
>>+++ head.S      Wed Feb  6 16:22:21 2002
>>@@ -320,7 +320,7 @@
>>        ret
>>
>>ENTRY(stack_start)
>>-       .long SYMBOL_NAME(init_task_union)+8192
>>+       .long SYMBOL_NAME(init_task_union)+16384
>>        .long __KERNEL_DS
>>
>>/* This is the default interrupt "handler" :-) */
>>
>
>
>




_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

