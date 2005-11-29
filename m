Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVK2IYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVK2IYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 03:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbVK2IYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 03:24:43 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:61356 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750896AbVK2IYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 03:24:42 -0500
Message-ID: <438C1080.3070705@m1k.net>
Date: Tue, 29 Nov 2005 03:25:36 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C0124.3030700@m1k.net> <438C0695.2050808@yahoo.com.au>
In-Reply-To: <438C0695.2050808@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Michael Krufky wrote:
>
>> Unable to handle kernel NULL pointer dereference at virtual address 
>
>> EFLAGS: 00010202   (2.6.15-rc3) EIP is at vm_normal_page+0x17/0x60
>
>> Process gdb (pid: 5628, threadinfo=f488e000 task=f7239a30)
>
>> [<c014a8f5>] get_user_pages+0x29f/0x309
>
> The clues point to the following patch. Can you give it a test
> please?
>
> Thanks,
> Nick

Nick-

Thank you, this patch fixed the oops, and it also fixed another bug that 
I didnt yet report:

2.6.15-rc3 would hang when rebooting, just after it says, "Sending all 
processes the TERM signal...."

Your patch below fixes this as well.  I've noticed that akpm has already 
applied this to his tree.  :-D

Cheers,

Michael Krufky

>vm_normal_page can be called with a NULL vma. This can be replaced with
>gate_vma, and no problem because none of the gate vmas use VM_PFNMAP
>(if they did they would need to set vm_pgoff).
>
>Signed-off-by: Nick Piggin <npiggin@suse.de>
>
>Index: linux-2.6/mm/memory.c
>===================================================================
>--- linux-2.6.orig/mm/memory.c
>+++ linux-2.6/mm/memory.c
>@@ -988,7 +988,8 @@ int get_user_pages(struct task_struct *t
> 				return i ? : -EFAULT;
> 			}
> 			if (pages) {
>-				struct page *page = vm_normal_page(vma, start, *pte);
>+				struct page *page;
>+				page = vm_normal_page(gate_vma, start, *pte);
> 				pages[i] = page;
> 				if (page)
> 					get_page(page);
>  
>

