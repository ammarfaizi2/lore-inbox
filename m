Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUAJSm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUAJSm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:42:56 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:62436 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S265325AbUAJSmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:42:44 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Bart Samwel <bart@samwel.tk>, Tim Cambrant <tim@cambrant.com>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to 0x37ffffff" warning.
Date: Sat, 10 Jan 2004 13:42:40 -0500
User-Agent: KMail/1.5.1
Cc: Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <40001CEE.5050206@bluewin.ch> <20040110155626.GA20684@cambrant.com> <40003655.3010702@samwel.tk>
In-Reply-To: <40003655.3010702@samwel.tk>
Organization: Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101342.40728.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.61.108] at Sat, 10 Jan 2004 12:42:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 12:28, Bart Samwel wrote:
>Tim Cambrant wrote:
>> On Sat, Jan 10, 2004 at 04:40:30PM +0100, Mario Vanoni wrote:
>>>Compiling the kernel under 2.6.1-mm2, gcc-3.3.2
>>>(same messages as under 2.6.1-rc1-mm1, re-tested),
>>>
>>>arch/i386/boot/setup.S: Assembler messages:
>>>arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
>>>0x37ffffff
>>
>> This is apparently a known problem and has existed for a long
>> time, but no-one has fixed it for some reason. I asked the exacly
>> same question a few months ago, and someone told me that this
>> issue has been around forever, but is noticed under 2.6, since it
>> is less verbose during the compilation. I'll pass the message that
>> was told to me: If you've got a fix, it would surely be included
>> in the kernel.
>
>The problem is in the MAXMEM macro. This macro takes the inverse of
> a positive number, subtracts another number, and the negative
> result overflows the negative range of a 32-bit integer. The
> assembler truncates it, but apparently it can't print overly
> negative numbers correctly, that's why it looks so strange.
>
>My proposed fix is attached: change the macro to subtract the
> numbers from 0xFFFFFFFF, and then add 1 at the end. That yields the
> same result, but without going through a negative intermediate
> value that needs to be truncated.
>
>-- Bart
>
>
>
>--- page.h.orig	2004-01-10 18:15:17.000000000 +0100
>+++ page.h	2004-01-10 18:15:47.000000000 +0100
>@@ -123,7 +123,7 @@
>
>  #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
>  #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
>-#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
>+#define MAXMEM			(0xFFFFFFFF-__PAGE_OFFSET-__VMALLOC_RESERVE+1)
>  #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
>  #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
>  #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)

This looks like a neat fix, faint praise from someone who doesn't know 
THAT much about it.  However, the question folks like me are going to 
ask is which of the approximately 24 page.h's in the kernel tree (for 
2.6.1-mm1 anyway) does this actually apply to?

Ahh, grep to the rescue, its include/asm/page.h

However, on checking my copy, I find a different fix there:

#define MAXMEM       ((unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE))

Which I note doesn't use the PAGE_OFFSET defined a few lines up
Which is correct?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

