Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbULFWPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbULFWPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbULFWPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:15:48 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:6556 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261678AbULFWPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:15:36 -0500
Message-ID: <41B4D9F8.6000309@colorfullife.com>
Date: Mon, 06 Dec 2004 23:15:20 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <lethal@Linux-SH.ORG>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCH_SLAB_MINALIGN for 2.6.10-rc3
References: <41B37E06.3030702@colorfullife.com> <20041205222001.GB25689@linux-sh.org>
In-Reply-To: <20041205222001.GB25689@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt wrote:

>Hi Manfred,
>
>On Sun, Dec 05, 2004 at 10:30:46PM +0100, Manfred Spraul wrote:
>  
>
>>>--- orig/include/asm-sh64/uaccess.h
>>>+++ mod/include/asm-sh64/uaccess.h
>>>@@ -313,6 +313,12 @@
>>>  sh64 at the moment). */
>>>#define ARCH_KMALLOC_MINALIGN 8
>>>
>>>+/*
>>>+ * We want 8-byte alignment for the slab caches as well, otherwise we have
>>>+ * the same BYTES_PER_WORD (sizeof(void *)) min align in 
>>>kmem_cache_create().
>>>+ */
>>>+#define ARCH_SLAB_MINALIGN 8
>>>+
>>>
>>>
>>>      
>>>
>>Could you make that dependant on !CONFIG_DEBUG_SLAB? Setting align to a 
>>non-zero value disables some debug code.
>>
>>    
>>
>align is only being set to ARCH_SLAB_MINALIGN in kmem_cache_create()
>where it is otherwise being set to BYTES_PER_WORD as a default. Unless I
>am missing something, that will always set it non-zero irregardless of
>whether ARCH_SLAB_MINALIGN is set.
>
>  
>
No, you are right. I didn't read the source carefully enough.
Now that I have reread it, I see one problem:
ARCH_KMALLOC_MINALIGN is a hard limit: It's always honored, the only 
exception is that values larger than the kmalloc block size are ignored. 
I.e. _MINALIGN 32 guarantees that the objects are 32-byte aligned (since 
the smallest block size is 32-bytes). The define was added, because some 
archs really need a certain alignment, otherwise they won't boot. The 
normal alignment for kmalloc caches is cache line alignment, except with 
CONFIG_DEBUG_SLAB, then it's word alignment.

With your patch, ARCH_SLAB_MINALIGN is not a hard limit: A few lines 
further down align is reset to word size if SLAB_RED_ZONE is set. I 
don't like the asymmetry - it just asks for trouble.

I must think about it. Perhaps just rename ARCH_SLAB_MINALIGN to 
ARCH_SLAB_DEFAULTALIGN.

--
    Manfred
