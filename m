Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293432AbSCSBYV>; Mon, 18 Mar 2002 20:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293445AbSCSBYM>; Mon, 18 Mar 2002 20:24:12 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:47501 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293432AbSCSBXy>; Mon, 18 Mar 2002 20:23:54 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Mar 2002 17:28:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "David S. Miller" <davem@redhat.com>
cc: cort@fsmlabs.com, <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <20020318.163838.29962146.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0203181721480.1606-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, David S. Miller wrote:

>    From: Cort Dougan <cort@fsmlabs.com>
>    Date: Mon, 18 Mar 2002 17:36:35 -0700
>
>    The structure of the program you suggested with more portable timing.
>
> Oh, just something like:
>
>
> 	gettimeofday(&stamp1);
> 	for (A MILLION TIMES) {
> 		TLB miss;
> 	}
> 	gettimeofday(&stamp2);

This make the measure stable on my machine :

#define rdtsc(low) \
   __asm__ __volatile__("rdtsc" : "=A" (low) : )


            unsigned long long start, end;

            rdtsc(start);
            access(buffer[i]);
            rdtsc(end);



processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 999.561
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
		pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1992.29



$ gcc -o tlb_test tlb_test.c

#APP
    rdtsc
#NO_APP
    movl    %eax, -24(%ebp)
    movl    %edx, -20(%ebp)
    movl    -4(%ebp), %eax
    addl    -12(%ebp), %eax
    movl    (%eax), %eax
#APP
    rdtsc


  11.89: 18
   4.70: 20
  81.90: 23



$ gcc -O2 -o tlb_test tlb_test.c

#APP
    rdtsc
#NO_APP
    movl    %edx, -28(%ebp)
    movl    -24(%ebp), %edx
    movl    %eax, -32(%ebp)
    movl    (%esi,%edx), %ecx
#APP
    rdtsc
#NO_APP


  87.70: 20
  11.24: 25




- Davide


