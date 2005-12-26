Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVLZXWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVLZXWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 18:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVLZXWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 18:22:04 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:3778 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751094AbVLZXWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 18:22:03 -0500
Message-ID: <43B07AFB.5050309@colorfullife.com>
Date: Tue, 27 Dec 2005 00:21:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SLAB - have index_of bug at compile time.
References: <43B01BD7.3040209@colorfullife.com>	 <Pine.LNX.4.58.0512261209060.9622@gandalf.stny.rr.com> <84144f020512261034q356b4484sa6e6528e339e67f5@mail.gmail.com>
In-Reply-To: <84144f020512261034q356b4484sa6e6528e339e67f5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>Hi Steven,
>
>On 12/26/05, Steven Rostedt <rostedt@goodmis.org> wrote:
>  
>
>>Now, maybe NUMA and vmalloc might be a good reason to start a new
>>allocation system along side of slab?
>>    
>>
>
>A better approach would probably be to introduce a vmem layer similar
>to what Solaris has to solve I/O memory and vmalloc issue. What NUMA
>issue are you referring to btw? I don't see any problem with the
>current design (in fact, I stole it for my magazine allocator too).
>It's just that the current implementation is bit hard to understand.
>
>  
>
This is virt_to_page() on i386: the object address is in %esi
     lea    0x40000000(%esi),%eax
     mov    0x0,%edx [0x0 is actually mem_map]
     shr    $0xc,%eax
     shl    $0x5,%eax
Just read the mem_map pointer and a few calculations.
And now retrieve the cachep pointer:
    mov    0x18(%eax,%edx,1),%edx

With NUMA on i386 (GENERIC_ARCH)
    lea    0x40000000(%edi),%eax
    mov    %eax,%ebx
    shr    $0x1c,%eax
    movsbl 0x0(%eax),%eax [ 0x0 is physnode_map]
    shr    $0xc,%ebx
    mov    0x0(,%eax,4),%ecx [0x0 is node_data]
    mov    %ebx,%eax
    mov    0xaa0(%ecx),%edx
    sub    %edx,%eax
    mov    0xa98(%ecx),%edx
    shl    $0x5,%eax
4 memory accesses.
    mov    0x18(%eax,%edx,1),%ebp

--
    Manfred
