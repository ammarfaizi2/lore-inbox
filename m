Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbTCRPPQ>; Tue, 18 Mar 2003 10:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbTCRPPQ>; Tue, 18 Mar 2003 10:15:16 -0500
Received: from mm01snlnto.sandia.gov ([132.175.109.20]:16902 "EHLO
	MM01SNLNTO.sandia.gov") by vger.kernel.org with ESMTP
	id <S262436AbTCRPPO>; Tue, 18 Mar 2003 10:15:14 -0500
Message-ID: <3E773A39.2090403@sandia.gov>
Date: Tue, 18 Mar 2003 07:24:41 -0800
From: "Kevin Pedretti" <ktpedre@sandia.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3)
 Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 350] New: i386 context switch very slow compared to
 2.4 due to wrmsr (performance)
References: <629040000.1045013743@flay>
 <20030212041848.GA9273@bjl1.jlokier.co.uk>
 <b2cnit$7e6$1@penguin.transmeta.com>
In-Reply-To: <b2cnit$7e6$1@penguin.transmeta.com>
X-WSS-ID: 1269E51A42589-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
    I wasn't aware of what you state below but it makes sense.  What I 
haven't been able to figure out, and nobody seems to know, is why the 
rodata section of an executable is placed in the text section and is not 
page aligned.  This seems to be a mixing of code and data on the same 
page.  Maybe it doesn't matter since it is read only?

Example:

 11 .text         000000e8  08048244  08048244  00000244  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 12 .fini         0000001c  0804832c  0804832c  0000032c  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 13 .rodata       0000000c  08048348  08048348  00000348  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 14 .data         0000000c  08049354  08049354  00000354  2**2
                  CONTENTS, ALLOC, LOAD, DATA

Thanks,
Kevin


torvalds@transmeta.com wrote:

>In article <20030212041848.GA9273@bjl1.jlokier.co.uk>,
>Jamie Lokier  <jamie@shareable.org> wrote:
>  
>
>>A cute and wonderful hack is to use the 6 words in the TSS prior to
>>&tss->es as the trampoline. Now that __switch_to is done in software,
>>those words are not used for anything else.
>>    
>>
>
>No!! 
>
>That's not cute and wonderful, that's _horrible_.
>
>Mixing data and code on the same page is very very slow on a P4 (well, I
>think it's "same half-page", but the point is that you should not EVER
>mix data and code - it ends up being slow on modern CPU's).
>
>  
>
>>Other fixed offsets from &tss->esp0 are possible - especially nice
>>would be to share a cache line with the GDT's hot cache line.  (To do
>>this, place GDT before TSS, make KERNEL_CS near the end of the GDT,
>>and then the accesses to GDT, trampoline and tss->esp0 will all touch
>>the same cache line if you're lucky).
>>    
>>
>
>Since almost all x86 CPU's have some kind of cacheline exclusion policy
>between the I$ and the D$ (to handle the strict x86 I$ coherency
>requirements), your "if you're lucky" is completely bogus.  In fact,
>you'd be the _pessimal_ cache behaviour for something like that, ie you
>get lines that ping-pong between the L2 and the two instruction caches. 
>
>Don't do it. Keep data and code on separate pages.
>
>			Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>



