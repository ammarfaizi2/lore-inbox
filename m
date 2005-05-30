Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVE3UGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVE3UGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVE3UGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:06:02 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:45772 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261732AbVE3UFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:05:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=jgZlyLx8KQcZ+c3imNuqgZTLVvmcc0RNhj+ioeY7N+joK+mHDvOx4cUpSuzSY3swMtjNxxC4S7ZmEG2gRg5qFhdtjKhv3OWtxyD6A70Kf2dNWJslar3XkF2uH8RG9sCMgANHg6vZc2qgdA3yVqEmkoK7sSjIt/AjOeNj80jEhU4=
Message-ID: <429B7208.6070804@gmail.com>
Date: Mon, 30 May 2005 22:05:28 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
References: <20050530181626.GA10212@kvack.org> <20050530193823.GD25794@muc.de>
In-Reply-To: <20050530193823.GD25794@muc.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen schrieb:

>>The SSE clear page fuction is almost twice as fast as the kernel's 
>>current clear_page, while the copy_page implementation is roughly a 
>>third faster.  This is likely due to the fact that SSE instructions 
>>can keep the 256 bit wide L2 cache bus at a higher utilisation than 
>>64 bit movs are able to.  Comments?
>>    
>>
>
>Any use of write combining is wrong here because it forces
>the destination out of cache, which causes performance issues later on. 
>Believe me we went through this years ago.
>
>If you can code up a better function for P4 that does not use
>write combining I would be happy to add. I never tuned the functions
>for P4. 
>
>One simple experiment would be to just test if P4 likes the
>simple rep ; movsq / rep ; stosq loops and enable them.
>  
>
No it doesn't like this sample here at all,I'll get segmentationfault on
that run.
RUN 1:

    SSE test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
    buffer = 0x2aaaaade7000
    clear_page() tests
    clear_page function 'warm up run'        took 13516 cycles per page
    clear_page function 'kernel clear'       took 6539 cycles per page
    clear_page function '2.4 non MMX'        took 6354 cycles per page
    clear_page function '2.4 MMX fallback'   took 6205 cycles per page
    clear_page function '2.4 MMX version'    took 6830 cycles per page
    clear_page function 'faster_clear_page'  took 6240 cycles per page
    clear_page function 'even_faster_clear'  took 5746 cycles per page
    clear_page function 'xmm_clear '         took 4580 cycles per page
    Segmentation fault

    xmm64.o[9485] general protection rip:400814 rsp:7fffffc74118 error:0
    xmm64.o[9486] general protection rip:400814 rsp:7fffff8b1498 error:0
    xmm64.o[9487] general protection rip:400814 rsp:7fffffc31848 error:0

RUN 2:
Tell gcc use processor specific flags
    gcc -pipe -march=nocona -O2 -o xmm64.o xmm64.c

    SSE test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
    buffer = 0x2aaaaade7000
    clear_page() tests
    clear_page function 'warm up run'        took 13419 cycles per page
    clear_page function 'kernel clear'       took 6403 cycles per page
    clear_page function '2.4 non MMX'        took 6290 cycles per page
    clear_page function '2.4 MMX fallback'   took 6156 cycles per page
    clear_page function '2.4 MMX version'    took 6605 cycles per page
    clear_page function 'faster_clear_page'  took 5607 cycles per page
    clear_page function 'even_faster_clear'  took 5173 cycles per page
    clear_page function 'xmm_clear '         took 4307 cycles per page
    clear_page function 'xmma_clear '        took 6230 cycles per page
    clear_page function 'xmm2_clear '        took 4908 cycles per page
    clear_page function 'xmma2_clear '       took 6256 cycles per page
    clear_page function 'kernel clear'       took 6506 cycles per page

    copy_page() tests
    copy_page function 'warm up run'         took 10352 cycles per page
    copy_page function '2.4 non MMX'         took 9440 cycles per page
    copy_page function '2.4 MMX fallback'    took 9300 cycles per page
    copy_page function '2.4 MMX version'     took 10238 cycles per page
    copy_page function 'faster_copy'         took 9497 cycles per page
    copy_page function 'even_faster'         took 9229 cycles per page
    copy_page function 'xmm_copy_page_no'    took 7810 cycles per page
    copy_page function 'xmm_copy_page'       took 7397 cycles per page
    copy_page function 'xmma_copy_page'      took 9430 cycles per page
    copy_page function 'v26_copy_page'       took 9234 cycles per page

CPU flags on Intel Pentium 4 640 x86_64 Gentoo GNU/Linux

    flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
    pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
    syscall nx lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr

Greets
    Michael
