Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284124AbRLXFra>; Mon, 24 Dec 2001 00:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284254AbRLXFrV>; Mon, 24 Dec 2001 00:47:21 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:35346 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284124AbRLXFrL>; Mon, 24 Dec 2001 00:47:11 -0500
Message-ID: <3C26C0C0.D324D1FC@zip.com.au>
Date: Sun, 23 Dec 2001 21:44:32 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org, "H . J . Lu" <hjl@lucon.org>
Subject: Re: How to fix false positives on references to discarded text/data?
In-Reply-To: Your message of "Sun, 23 Dec 2001 16:15:47 -0800."
	             <3C2673B3.78E21527@zip.com.au> <27651.1009169580@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> gcc/as generates worse code for the local branches in the out of line
> subsection.  With .text.lock we get
> 
>    0:   80 bd f8 00 00 00 00    cmpb   $0x0,0xf8(%ebp)
>    7:   f3 90                   repz nop
>    9:   7e f5                   jle    0 <.text.lock>           <=== 2 bytes
>    b:   e9 ca 01 00 00          jmp    1da <.text.lock+0x1da>
> 
> With .subsection 1 it generates
> 
> .text.lock.es1371:
> 6387:   80 bd f8 00 00 00 00    cmpb   $0x0,0xf8(%ebp)
> 638e:   f3 90                   repz nop
> 6390:   0f 8e f1 ff ff ff       jle    6387 <.text.lock.es1371> <=== 6 bytes
> 6396:   e9 33 9e ff ff          jmp    1ce <set_adc_rate+0x8e>
> 
> The inline code is unchanged, it is only the out of line code that is
> bigger.  IMHO the subsection difference is a gcc/as bug which should
> not stop us using this fix.

I don't see this.   With egcs-1.1.2 and assembler 2.11.90.0.25,
your patch actually (and mysteriously) shrunk the kernel by 500
bytes - the new .text is a little smaller than the sum of the
old .text and .text.lock.

As you say, if the assembler is generating long-form branches for
the `jle' in the below sequence, we have a problem.

#APP
        
1:      lock ; decb timerlist_lock
        js 2f
.subsection 1
.ifndef .text.lock.bust_spinlocks
.text.lock.bust_spinlocks:
.endif
2:      cmpb $0,timerlist_lock
        rep;nop
        jle 2b
        jmp 1b
.previous

Keith, perhaps you could ship a .s file and a version number to HJ?

-
