Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUAJR3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUAJR3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:29:13 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:64837 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265230AbUAJR3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:29:05 -0500
Message-ID: <40003655.3010702@samwel.tk>
Date: Sat, 10 Jan 2004 18:28:53 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Cambrant <tim@cambrant.com>
CC: Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to 0x37ffffff"
 warning.
References: <40001CEE.5050206@bluewin.ch> <20040110155626.GA20684@cambrant.com>
In-Reply-To: <20040110155626.GA20684@cambrant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Cambrant wrote:
> On Sat, Jan 10, 2004 at 04:40:30PM +0100, Mario Vanoni wrote:
> 
>>Compiling the kernel under 2.6.1-mm2, gcc-3.3.2
>>(same messages as under 2.6.1-rc1-mm1, re-tested),
>>
>>arch/i386/boot/setup.S: Assembler messages:
>>arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 
>>0x37ffffff
> 
> This is apparently a known problem and has existed for a long time,
> but no-one has fixed it for some reason. I asked the exacly same
> question a few months ago, and someone told me that this issue has
> been around forever, but is noticed under 2.6, since it is less
> verbose during the compilation. I'll pass the message that was told
> to me: If you've got a fix, it would surely be included in the kernel.

The problem is in the MAXMEM macro. This macro takes the inverse of a 
positive number, subtracts another number, and the negative result 
overflows the negative range of a 32-bit integer. The assembler 
truncates it, but apparently it can't print overly negative numbers 
correctly, that's why it looks so strange.

My proposed fix is attached: change the macro to subtract the numbers 
from 0xFFFFFFFF, and then add 1 at the end. That yields the same result, 
but without going through a negative intermediate value that needs to be 
truncated.

-- Bart



--- page.h.orig	2004-01-10 18:15:17.000000000 +0100
+++ page.h	2004-01-10 18:15:47.000000000 +0100
@@ -123,7 +123,7 @@

  #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
  #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
-#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define MAXMEM			(0xFFFFFFFF-__PAGE_OFFSET-__VMALLOC_RESERVE+1)
  #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
  #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
  #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)


