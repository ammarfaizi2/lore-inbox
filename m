Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280143AbRJaKvz>; Wed, 31 Oct 2001 05:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280145AbRJaKvq>; Wed, 31 Oct 2001 05:51:46 -0500
Received: from aloha.egartech.com ([62.118.81.133]:15112 "HELO
	mx02.egartech.com") by vger.kernel.org with SMTP id <S280143AbRJaKvh>;
	Wed, 31 Oct 2001 05:51:37 -0500
Message-ID: <3BDFD866.E6E997CC@egartech.com>
Date: Wed, 31 Oct 2001 13:54:30 +0300
From: Kirill Ratkin <kratkin@egartech.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Call kernel function from module
In-Reply-To: <01103112311302.00794@nemo>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2001 10:52:07.0076 (UTC) FILETIME=[1555FE40:01C161FA]
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:
> 
> Linus, Alan,
> 
> This patch to i386 setup.S resulted from my attempts to load big
> bzImages from DOS. Loadlin fails at aroung 1020000 bytes, I didn't
> want to mess with that much asm in loadlin src and wrote new
> loader from scratch mostly in c.
> 
> I had a problem booting from DOS on pc with 196 mb or ram. It turned
> out int15/e801 and int15/88 reported zero ext mem -> "Less than 4MB"
> type hang. Digging in loadlin sources turned out some horrors
> (loadlin hooks itself on int 15/88 and reads CMOS)
> 
> I think it's cleaner to do this in setup.S rather than jump thru the
> hoops in DOS loader. Attached patch does that *only if* int15 methods
> fail. It does not break existing practice, only adds just another
> fallback in case of brain damage.
> 
> Tested on three boxes. Works for me. Applies cleanly to 2.4.13.
> If something is wrong with this patch, let me know about it.
> --
> vda
> 
> diff -ubB setup.S.orig setup.S
> --- setup.S.orig        Mon Sep 24 00:58:58 2001
> +++ setup.S     Wed Oct 31 12:21:45 2001
> @@ -39,9 +39,13 @@
>   * from Ralf Brown interrupt list seem to indicate AX/BX should be used
>   * anyway.  So to avoid breaking many machines (presumably there was a reason
>   * to orginally use CX/DX instead of AX/BX), we do a kludge to see
> - * if CX/DX have been changed in the e801 call and if so use AX/BX .
> + * if CX/DX have been changed in the e801 call and if so use AX/BX.
>   * Michael Miller, April 2001 <michaelm@mjmm.org>
>   *
> + * Even more fixes for memory detection when started from DOS
> + * TODO: maybe we can just resort to memory scan on our own
> + * to stop using int15/e820,int15/e801,int15/88,cmos once and for all?
> + * <vda@port.imtp.ilyichevsk.odessa.ua> october 2001
>   */
> 
>  #include <linux/config.h>
> @@ -297,13 +301,13 @@
> 
>  #define SMAP  0x534d4150
> 
> -meme820:
> +mem_e820:
>         xorl    %ebx, %ebx                      # continuation counter
>         movw    $E820MAP, %di                   # point into the whitelist
>                                                 # so we can have the bios
>                                                 # directly write into it.
> 
> -jmpe820:
> +jmp820:
>         movl    $0x0000e820, %eax               # e820, upper word zeroed
>         movl    $SMAP, %edx                     # ascii 'SMAP'
>         movl    $20, %ecx                       # size of the e820rec
> @@ -327,12 +331,10 @@
>         jnl     bail820
> 
>         incb    (E820NR)
> -       movw    %di, %ax
> -       addw    $20, %ax
> -       movw    %ax, %di
> +       addw    $20, %di
>  again820:
> -       cmpl    $0, %ebx                        # check to see if
> -       jne     jmpe820                         # %ebx is set to EOF
> +       testl   %ebx, %ebx                      # check to see if
> +       jnz     jmp820                          # %ebx is set to EOF
>  bail820:
> 
> @@ -344,10 +346,10 @@
>  # alternative new memory detection scheme, and it's sensible
>  # to write everything into the same place.)
> 
> -meme801:
> +mem_e801:
>         stc                                     # fix to work around buggy
> -       xorw    %cx,%cx                         # BIOSes which dont clear/set
> -       xorw    %dx,%dx                         # carry on pass/error of
> +       xorw    %cx, %cx                        # BIOSes which dont clear/set
> +       xorw    %dx, %dx                        # carry on pass/error of
>                                                 # e801h memory size call
>                                                 # or merely pass cx,dx though
>                                                 # without changing them.
> @@ -355,28 +357,62 @@
>         int     $0x15
>         jc      mem88
> 
> -       cmpw    $0x0, %cx                       # Kludge to handle BIOSes
> -       jne     e801usecxdx                     # which report their extended
> -       cmpw    $0x0, %dx                       # memory in AX/BX rather than
> -       jne     e801usecxdx                     # CX/DX.  The spec I have read
> +       testw   %cx, %cx                        # Kludge to handle BIOSes
> +       jnz     e801use_cxdx                    # which report their extended
> +       testw   %dx, %dx                        # memory in AX/BX rather than
> +       jnz     e801use_cxdx                    # CX/DX.  The spec I have read
>         movw    %ax, %cx                        # seems to indicate AX/BX
>         movw    %bx, %dx                        # are more reasonable anyway...
> 
> -e801usecxdx:
> -       andl    $0xffff, %edx                   # clear sign extend
> +e801use_cxdx:
> +       movzwl  %dx, %edx                       # clear sign extend
>         shll    $6, %edx                        # and go from 64k to 1k chunks
> -       movl    %edx, (0x1e0)                   # store extended memory size
> -       andl    $0xffff, %ecx                   # clear sign extend
> -       addl    %ecx, (0x1e0)                   # and add lower memory into
> -                                               # total size.
> +       movzwl  %cx, %ecx                       # clear sign extend
> +       addl    %ecx, %edx                      # add lower memory to
> +       movl    %edx, (0x1e0)                   # extended, store
> 
>  # Ye Olde Traditional Methode.  Returns the memory size (up to 16mb or
>  # 64mb, depending on the bios) in ax.
>  mem88:
> 
>  #endif
> +       #stc                    # guard against brain damage -
> +                               #   int 15 must clear cf to indicate success
> +       clc                     # unbelievable: some BIOSes/DOSes can leave
> +                               #   cf as is so I had to abandon stc trick
>         movb    $0x88, %ah
>         int     $0x15

Hi! Could somebody help me? I added several functions (not sys calls) to
kernel as hardcoded part. Then I write modules which will be call these
functions. But when I load module insmod says me 'can't resolve symbol
my_func_name'.
I exported all my functions in netsyms.c file. Do you know how I can see
my function?

Regards,
Niktar.
