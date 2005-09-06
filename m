Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVIFXur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVIFXur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVIFXur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:50:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20726 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751147AbVIFXur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:50:47 -0400
Message-ID: <431E2B23.40509@mvista.com>
Date: Tue, 06 Sep 2005 16:49:55 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org, akpm@osdl.org
Subject: Re: [PATCH]  PPC64: large INITRD causes kernel not to boot [UPDATE]
References: <431E1D1A.2090601@mvista.com> <17182.10581.159598.839256@cargo.ozlabs.ibm.com>
In-Reply-To: <17182.10581.159598.839256@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:

>Mark Bellon writes:
>
>  
>
>>Simply put the existing code has a fixed reservation (claim) address and 
>>once the kernel plus initrd image are large enough to pass this address 
>>all sorts of bad things occur. The fix is the dynamically establish the 
>>first claim address above the loaded kernel plus initrd (plus some 
>>"padding" and rounding). If PROG_START is defined this will be used as 
>>the minimum safe address - currently known to be 0x01400000 for the 
>>firmwares tested so far.
>>    
>>
>
>The idea is fine, but I have some questions about the actual patch:
>
>  
>
>>-void *claim(unsigned int, unsigned int, unsigned int);
>>+void *claim(unsigned long, unsigned long, unsigned long);
>>    
>>
>
>What was the motivation for this change?  Since the zImage wrapper is
>a 32-bit executable, int and long are both 32 bits.  I would prefer to
>leave the parameters as unsigned int to force people to realize that
>the parameters are 32 bits (even if said people have been working on
>64-bit programs recently).
>
>  
>
The function, claim, is found in prom.c uses longs. The long is the 
usual idiom for hiding a pointer, not an int, so I fixed accordingly. 
I'm open to further discussion of course.

On a 64 bit machine long and int are different sizes. This would make 
things "proper" if things changed in the future.

>>+	claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
>>+
>>+#if defined(PROG_START)
>>+	/*
>>+	 * Maintain a "magic" minimum address. This keeps some older
>>+	 * firmware platforms running.
>>+	 */
>>+
>>+	if (claim_base < PROG_START)
>>+		claim_base = PROG_START;
>>+#endif
>>    
>>
>
>This appears to be the meat of the patch, the rest is "cleanup", right?
>  
>

Correct. The preceding comment explains what is going on. Removing the 
magic numbers seemed like a good idea.

mark

>Paul.
>  
>

