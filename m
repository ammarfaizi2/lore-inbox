Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUJFDVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUJFDVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUJFDVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:21:09 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:61701 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S266805AbUJFDVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:21:00 -0400
Message-ID: <4163645F.3030403@vmware.com>
Date: Tue, 05 Oct 2004 20:19:59 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Riley@Williams.Name, davej@codemonkey.org.uk,
       hpa@zytor.com, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] i386/gcc bug with do_test_wp_bit
References: <41634E21.6020808@vmware.com> <Pine.LNX.4.58.0410051903090.8290@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410051903090.8290@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2004 03:20:05.0944 (UTC) FILETIME=[604BEB80:01C4AB53]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.3; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree the code obviously looks ok, I will verify against 2.6.9-rc3 
anyways and send an updated patch that gets a non-tweaked gcc 3.3.3 
build to boot.  Additional fixes are needed for regparm compliance 
between prototypes and functions; I've done these for i386, but may have 
missed some in other architectures.  I'd also like to get rid of the 
apparently harmless lvalue warnings I get from gcc 3.3.3.

I checked the gcc docs but couldn't find any versions where noinline was 
unsupported, although I should have assumed otherwise.

Zach

Linus Torvalds wrote:

>On Tue, 5 Oct 2004, Zachary Amsden wrote:
>  
>
>>I've included a small trivial fix that is harmless for users not using 
>>gcc 3.3.3.  Testing: my 2.6 kernel now boots when compiled with gcc 
>>3.3.3 compiler.
>>    
>>
>
>Thanks. However, it really should use the "noinline" define that we have 
>for this, and that doesn't upset older versions of gcc that don't 
>understand the "noinline" attribute. 
>
>Also, declaration and definition should match, even if gcc doesn't seem to 
>catch that.
>
>So here's the version I committed. It should be obviously ok, but it's 
>still a good idea to verify..
>
>		Linus
>
>---
># This is a BitKeeper generated diff -Nru style patch.
>#
># ChangeSet
>#   2004/10/05 18:51:53-07:00 torvalds@evo.osdl.org 
>#   i386: mark do_test_wp_bit() noinline
>#   
>#   As reported by Zachary Amsden <zach@vmware.com>,
>#   some gcc versions will inline the function even when
>#   it is declared after the call-site. This particular
>#   function must not be inlined, since the exception
>#   recovery doesn't like __init sections (which the caller
>#   is in).
># 
># arch/i386/mm/init.c
>#   2004/10/05 18:51:43-07:00 torvalds@evo.osdl.org +2 -2
>#   i386: mark do_test_wp_bit() noinline
>#   
>#   As reported by Zachary Amsden <zach@vmware.com>,
>#   some gcc versions will inline the function even when
>#   it is declared after the call-site. This particular
>#   function must not be inlined, since the exception
>#   recovery doesn't like __init sections (which the caller
>#   is in).
># 
>diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
>--- a/arch/i386/mm/init.c	2004-10-05 19:04:53 -07:00
>+++ b/arch/i386/mm/init.c	2004-10-05 19:04:53 -07:00
>@@ -45,7 +45,7 @@
> DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
> unsigned long highstart_pfn, highend_pfn;
> 
>-static int do_test_wp_bit(void);
>+static int noinline do_test_wp_bit(void);
> 
> /*
>  * Creates a middle page table and puts a pointer to it in the
>@@ -673,7 +673,7 @@
>  * This function cannot be __init, since exceptions don't work in that
>  * section.  Put this after the callers, so that it cannot be inlined.
>  */
>-static int do_test_wp_bit(void)
>+static int noinline do_test_wp_bit(void)
> {
> 	char tmp_reg;
> 	int flag;
>  
>

