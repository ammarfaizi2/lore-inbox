Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292466AbSCRXta>; Mon, 18 Mar 2002 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291401AbSCRXtL>; Mon, 18 Mar 2002 18:49:11 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:19596 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S291148AbSCRXs6> convert rfc822-to-8bit; Mon, 18 Mar 2002 18:48:58 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Mar 2002 15:53:32 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203181434440.10517-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0203181541360.1606-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Linus Torvalds wrote:

>
> On Mon, 18 Mar 2002, Dieter [iso-8859-15] Nützel wrote:
> >
> > it seems to be that it depends on gcc and flags.
>
> That instability doesn't seem to show up on a PII. Interesting. Looks like
> the athlon may be reordering TLB accesses, while the PII apparently
> doesn't.
>
> Or maybe the program is just flawed, and the interesting 1/8 pattern comes
> from something else altogether.


Umhh, something magic should happen inside the Athlon p/line to explain this :


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
    movl    %eax, -16(%ebp)
    movl    -4(%ebp), %eax
    addl    -12(%ebp), %eax
    movl    (%eax), %eax
#APP
    rdtsc
#NO_APP
    movl    %eax, -20(%ebp)


98.76: 21



$ gcc -O2 -o tlb_test tlb_test.c

#APP
    rdtsc
#NO_APP
    movl    -16(%ebp), %edx
    movl    %eax, %ecx
    movl    (%ebx,%edx), %eax
#APP
    rdtsc
#NO_APP
    subl    %ecx, %eax


97.59: 94


The only thing i can think is that stuff is moved between the two rdtsc
... maybe a barrier should help to have more consistent results.




- Davide


