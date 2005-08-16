Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVHPAFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVHPAFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 20:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVHPAFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 20:05:13 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:55813 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964923AbVHPAFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 20:05:11 -0400
Message-ID: <43012DCA.2080701@vmware.com>
Date: Mon, 15 Aug 2005 17:05:30 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 5/6] i386 virtualization - Make generic set wrprotect
 a macro
References: <200508152300.j7FN0dD7005336@zach-dev.vmware.com> <20050815232502.GG3614@stusta.de>
In-Reply-To: <20050815232502.GG3614@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 00:05:30.0242 (UTC) FILETIME=[36BEAE20:01C5A1F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Mon, Aug 15, 2005 at 04:00:39PM -0700, zach@vmware.com wrote:
>
>  
>
>>Make the generic version of ptep_set_wrprotect a macro.  This is good for
>>code uniformity, and fixes the build for architectures which include pgtable.h
>>through headers into assembly code, but do not define a ptep_set_wrprotect
>>function.
>>    
>>
>
>
>This against the kernel coding style.
>In fact, we are usually doing exactly the opposite. 
>
>What exactly is the technical problem this patch is trying to solve, IOW 
>which architectures are breaking for you?
>  
>

The generic pgtable.h include is special and apparently deliberately 
against kernel coding style.  Look at the rest of the file.  All 
"functions" here are purely macros, or encapsulated with:

#ifndef __ASSEMBLY__
static inline void foo()
#endif

This is because asm-generic/pgtable.h can get included in assembler 
files via a number of ways.

Now, if you have a header file that gets conditionally excluded based on 
#ifndef __ASSEMBLY__,  as asm-i386/pgtable.h does to 
pgtable-{2|3}level.h you must do one of the following:

1) move all  __HAVE_ARCH_PTEP_XXX definitions out of the !__ASSEMBLY__ 
clause
2) protect all inline assembler functions in asm-generic/pgtable.h with 
!__ASSEMBLY
3) use macros instead of inline functions in asm-generic

Having the ability to redefine page table accessors at the sub-arch 
level is necessary to have a paravirtualized sub-arch of i386.  My third 
attempt at this (the first was a horror unthinkable to even publish) is 
trying to make the code as clean and consistent as possible.  #1 above 
makes maintaing compile time PAE for i386 with a paravirtualized 
sub-arch cumbersome, since one must either isolate the __HAVE_ARCH _XXX 
defines from the XXX function definition itself, surround each 
individual function with !__ASSEMBLY__, or switch to macros instead of 
inline functions for include/asm-i386/pgtable-{2|3}level.h.  Ugly and 
difficult to maintain.

Thus, I chose the default convention of following the surrounding code.  
There are 6 C inline functions in the generic pgtable.h and 37 macros.  
Converting to and from macros and inline functions here is rather 
tedious and error prone, all of these functions are conditionally 
defined based on the architecture, and I don't want to risk introducing 
yet another regression for an architecture that I don't have a 
cross-compile set up for.

If you have a better approch, I'd be interested in hearing it.

Zach
