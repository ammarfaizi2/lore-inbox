Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284451AbRLXGWo>; Mon, 24 Dec 2001 01:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284464AbRLXGWZ>; Mon, 24 Dec 2001 01:22:25 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:63248 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284451AbRLXGWT>;
	Mon, 24 Dec 2001 01:22:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org, "H . J . Lu" <hjl@lucon.org>
Subject: Re: How to fix false positives on references to discarded text/data? 
In-Reply-To: Your message of "Sun, 23 Dec 2001 21:44:32 -0800."
             <3C26C0C0.D324D1FC@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Dec 2001 17:22:04 +1100
Message-ID: <28371.1009174924@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001 21:44:32 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>Keith Owens wrote:
>> gcc/as generates worse code for the local branches in the out of line
>> subsection.  With .text.lock we get
>> 
>>    0:   80 bd f8 00 00 00 00    cmpb   $0x0,0xf8(%ebp)
>>    7:   f3 90                   repz nop
>>    9:   7e f5                   jle    0 <.text.lock>           <=== 2 bytes
>>    b:   e9 ca 01 00 00          jmp    1da <.text.lock+0x1da>
>> 
>> With .subsection 1 it generates
>> 
>> .text.lock.es1371:
>> 6387:   80 bd f8 00 00 00 00    cmpb   $0x0,0xf8(%ebp)
>> 638e:   f3 90                   repz nop
>> 6390:   0f 8e f1 ff ff ff       jle    6387 <.text.lock.es1371> <=== 6 bytes
>> 6396:   e9 33 9e ff ff          jmp    1ce <set_adc_rate+0x8e>
>> 
>> The inline code is unchanged, it is only the out of line code that is
>> bigger.  IMHO the subsection difference is a gcc/as bug which should
>> not stop us using this fix.
>
>I don't see this.   With egcs-1.1.2 and assembler 2.11.90.0.25,
>your patch actually (and mysteriously) shrunk the kernel by 500
>bytes - the new .text is a little smaller than the sum of the
>old .text and .text.lock.

That is what I expected, the new code might be smaller because an intra
section branch can use a small PC relative operand, inter section
branches must use full sized branches, worst case it should generate
the same size code.  I was surprised that it generates larger code,
this definitely looks like a gas bug.  The system is RH 7.1, according
to Documentation/Changes this version of gcc 2.96 and binutils should
be OK.

NOTE: The patch had one .previous left in include/asm-i386/spinlock.h,
      which needs to be changed to .subsection 0\n.  But that change
      makes no difference.

cd drivers/sound
gcc -v --save-temps -D__KERNEL__ -I../../include -Wall \
	-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
	-fno-strict-aliasing -fno-common -mpreferred-stack-boundary=2 \
	-march=i686 -DMODULE -DKBUILD_BASENAME=es1371 \
	-c -o es1371.o es1371.c
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)
 /usr/lib/gcc-lib/i386-redhat-linux/2.96/cpp0 -lang-c -v -I../../include -D__GNUC__=2 -D__GNUC_MINOR__=96 -D__GNUC_PATCHLEVEL__=0 -D__ELF__ -Dunix -Dlinux -D__ELF__ -D__unix__ -D__linux__ -D__unix -D__linux -Asystem(posix) -D__OPTIMIZE__ -Wall -Wstrict-prototypes -Wno-trigraphs -Acpu(i386) -Amachine(i386) -Di386 -D__i386 -D__i386__ -D__pentiumpro -D__pentiumpro__ -D__tune_pentiumpro__ -D__KERNEL__ -DMODULE -DKBUILD_BASENAME=es1371 es1371.c es1371.i
GNU CPP version 2.96 20000731 (Red Hat Linux 7.1 2.96-81) (cpplib) (i386 Linux/ELF)
ignoring nonexistent directory "/usr/local/include"
ignoring nonexistent directory "/usr/i386-redhat-linux/include"
#include "..." search starts here:
#include <...> search starts here:
 ../../include
 /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
 /usr/include
End of search list.
 /usr/lib/gcc-lib/i386-redhat-linux/2.96/cc1 es1371.i -quiet -dumpbase es1371.c -mpreferred-stack-boundary=2 -march=i686 -O2 -Wall -Wstrict-prototypes -Wno-trigraphs -version -fomit-frame-pointer -fno-strict-aliasing -fno-common -o es1371.s
GNU C version 2.96 20000731 (Red Hat Linux 7.1 2.96-81) (i386-redhat-linux) compiled by GNU C version 2.96 20000731 (Red Hat Linux 7.1 2.96-81).
 as -V -Qy -o es1371.o es1371.s
GNU assembler version 2.10.91 (i386-redhat-linux) using BFD version 2.10.91.0.2

drivers/sound/es1371.s, first reference to .text.lock

1:      lock ; decb 248(%ebp)
        js 2f
.subsection 1
.ifndef .text.lock.es1371
.text.lock.es1371:
.endif
2:      cmpb $0,248(%ebp)
        rep;nop
        jle 2b
        jmp 1b
.subsection 0

objdump -S drivers/sound/es1371.o

     1ce:       f0 fe 8d f8 00 00 00    lock decb 0xf8(%ebp)
     1d5:       0f 88 ac 61 00 00       js     6387 <.text.lock.es1371>

....

00006387 <.text.lock.es1371>:
    6387:       80 bd f8 00 00 00 00    cmpb   $0x0,0xf8(%ebp)
    638e:       f3 90                   repz nop 
    6390:       0f 8e f1 ff ff ff       jle    6387 <.text.lock.es1371>
    6396:       e9 33 9e ff ff          jmp    1ce <set_adc_rate+0x8e>

jle 2b can be handled by an 8 bit operand but gas is using full 32
bits.

