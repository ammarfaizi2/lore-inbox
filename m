Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTJKLMH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 07:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTJKLMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 07:12:07 -0400
Received: from pop.gmx.de ([213.165.64.20]:50875 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263277AbTJKLMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 07:12:01 -0400
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 11 Oct 2003 13:15:52 +0200
To: Manfred Spraul <manfred@colorfullife.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.0-test7 DEBUG_PAGEALLOC oops
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3F87CF3D.8080402@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_17672734==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_17672734==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 11:37 AM 10/11/2003 +0200, Manfred Spraul wrote:
>Mike wrote:
>
>>Unable to handle kernel paging request at virtual address c034a000
>>printing eip:
>>c0134d5a
>>*pde = 00102027
>>*pte = 0034a000
>Fault trying to read from address 0xc034a000: the page is not mapped.
>
>>Oops: 0000 [#1]
>>CPU:    0
>>EIP:    0060:[<c0134d5a>]    Not tainted
>>EFLAGS: 00010002
>>EIP is at store_stackinfo+0x4e/0x80
>In store_stackinfo: the function stores a backtrace of the last 
>kmem_cache_free caller in the object - might be useful, and the memory is 
>not used.
>
>>eax: 00000000   ebx: c7802f98   ecx: c0301390   edx: c030138c
>>esi: c0349ffe   edi: 017e0008   ebp: c0349da6   esp: c0349d96
>>ds: 007b   es: 007b   ss: 0068
>>Process swapper (pid: 0, threadinfo=c0348000 task=c02fcbe0)
>The esp value is sane, the stack is at 0xc0348000, and the fault is at 
>'a000: just behind the end of the stack.
>I assume the fauling line is
>                        svalue = *sptr++;

Exactly.

>It looks like store stackinfo accesses memory behind the end of the stack.

Yeah, I'm trying to figure out why.  The below (if dang mailer actually 
inlines it) kludge allows me to boot, so I suppose I need to ponder addr 
wrt _stext and _etext.

>Which gcc version do you use? Could you send me mm/slab.o?

gcc-2.95.3.  slab.o coming via private mail.

         -Mike 
--=====================_17672734==_
Content-Type: text/plain; charset="us-ascii"

--- mm/slab.c.org	Sat Oct 11 12:25:24 2003
+++ mm/slab.c	Sat Oct 11 12:26:02 2003
@@ -864,12 +864,11 @@
 
 		while (((long) sptr & (THREAD_SIZE-1)) != 0) {
 			svalue = *sptr++;
-			if (kernel_text_address(svalue)) {
+			if (kernel_text_address(svalue))
 				*addr++=svalue;
-				size -= sizeof(unsigned long);
-				if (size <= sizeof(unsigned long))
-					break;
-			}
+			size -= sizeof(unsigned long);
+			if (size <= sizeof(unsigned long))
+				break;
 		}
 
 	}

--=====================_17672734==_--

