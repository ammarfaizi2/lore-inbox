Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVFUNOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVFUNOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFUNMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:12:44 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:7656 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261380AbVFUNIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:08:24 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>, "Jesper Juhl" <juhl-lkml@dif.dk>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 16:06:59 +0300
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Domen Puncer" <domen@coderock.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost> <200506211402.48554.vda@ilport.com.ua> <004c01c57662$5eacc260$2800000a@pc365dualp2>
In-Reply-To: <004c01c57662$5eacc260$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506211606.59233.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 16:08, cutaway@bellsouth.net wrote:
> Memory is memory.  Pushed from the stack or as a 4 byte immediate value you
> still have to get those 4 bytes somewhere  although with the pointer you DO
> actually stand a chance GCC might enregister the pointer variable.
> 
> Sure you don't think instruction bytes fetching is free ;->

I think that instruction fetch is deeply prefetched, thus
	push	immediate
do not need to wait for operand, no AGU to allocate, nothing,
while
	push	N(%ebp)
depends on %ebp value, on (%ebp+N) value, will need AGU.
 
> BTW, I don't give a shit about the size advantage.  Put the 3 byte EBP ref
> and the 5 byte push imm32 in a loop and measure them - I know what the
> answer will be.

You know wrong.

# cat t.c
#define rdtscl(low) asm volatile("rdtsc" : "=a" (low) : : "edx")
#define NL "\n"

#include <stdio.h>

int main() {
    int i,k,start,end;
    int v = 1234;

for(k=0; k<6; k++) {
    rdtscl(start);
    for(i=0; i<1000; i++) {
        asm(NL
        "       push    %0" NL
        "       pop     %%eax" NL
        "       push    %0" NL
        "       pop     %%eax" NL
        "       push    %0" NL
        "       pop     %%eax" NL
        "       push    %0" NL
        "       pop     %%eax" NL
        : /* outputs */
        : "m" (v) /* inputs */
        : "ax" /* clobbers */
        );
    }
    rdtscl(end);
    printf("Took %u CPU cycles ", end-start);

    rdtscl(start);
    for(i=0; i<1000; i++) {
        asm(NL
        "       push    %%ebx" NL
        "       pop     %%eax" NL
        "       push    %%ebx" NL
        "       pop     %%eax" NL
        "       push    %%ebx" NL
        "       pop     %%eax" NL
        "       push    %%ebx" NL
        "       pop     %%eax" NL
        : /* outputs */
        : /* inputs */
        : "ax" /* clobbers */
        );
    }
    rdtscl(end);
    printf("Took %u CPU cycles\n", end-start);
}
    return 0;
}

# gcc -O2 -falign-loops=64 t.c
# ./a.out
Took 9574 CPU cycles Took 8068 CPU cycles
Took 9575 CPU cycles Took 8058 CPU cycles
Took 9134 CPU cycles Took 8061 CPU cycles
Took 9134 CPU cycles Took 8043 CPU cycles
Took 9134 CPU cycles Took 8043 CPU cycles
Took 9134 CPU cycles Took 8043 CPU cycles
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Celeron(TM) CPU                1200MHz
stepping        : 1
cpu MHz         : 1196.207
cache size      : 256 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 2359.29

# gcc -O2 -falign-loops=64 -c t.c
# objdump -d -r t.o

t.o:     file format elf32-i386

Disassembly of section .text:

00000000 <main>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   53                      push   %ebx
   4:   50                      push   %eax
   5:   83 e4 f0                and    $0xfffffff0,%esp
   8:   83 ec 10                sub    $0x10,%esp
   b:   c7 45 f8 d2 04 00 00    movl   $0x4d2,0xfffffff8(%ebp)
  12:   31 db                   xor    %ebx,%ebx
  14:   0f 31                   rdtsc
  16:   ba e7 03 00 00          mov    $0x3e7,%edx
  1b:   89 c1                   mov    %eax,%ecx
  1d:   90                      nop
  1e:   90                      nop
  1f:   90                      nop
  20:   90                      nop
  21:   90                      nop
  22:   90                      nop
  23:   90                      nop
  24:   90                      nop
  25:   90                      nop
  26:   90                      nop
  27:   90                      nop
  28:   90                      nop
  29:   90                      nop
  2a:   90                      nop
  2b:   90                      nop
  2c:   90                      nop
  2d:   90                      nop
  2e:   90                      nop
  2f:   90                      nop
  30:   90                      nop
  31:   90                      nop
  32:   90                      nop
  33:   90                      nop
  34:   90                      nop
  35:   90                      nop
  36:   90                      nop
  37:   90                      nop
  38:   90                      nop
  39:   90                      nop
  3a:   90                      nop
  3b:   90                      nop
  3c:   90                      nop
  3d:   90                      nop
  3e:   90                      nop
  3f:   90                      nop
  40:   ff 75 f8                pushl  0xfffffff8(%ebp)
  43:   58                      pop    %eax
  44:   ff 75 f8                pushl  0xfffffff8(%ebp)
  47:   58                      pop    %eax
  48:   ff 75 f8                pushl  0xfffffff8(%ebp)
  4b:   58                      pop    %eax
  4c:   ff 75 f8                pushl  0xfffffff8(%ebp)
  4f:   58                      pop    %eax
  50:   4a                      dec    %edx
  51:   79 ed                   jns    40 <main+0x40>
  53:   0f 31                   rdtsc
  55:   83 ec 08                sub    $0x8,%esp
  58:   29 c8                   sub    %ecx,%eax
  5a:   50                      push   %eax
  5b:   68 00 00 00 00          push   $0x0
                        5c: R_386_32    .rodata.str1.1
  60:   e8 fc ff ff ff          call   61 <main+0x61>
                        61: R_386_PC32  printf
  65:   0f 31                   rdtsc
  67:   ba e7 03 00 00          mov    $0x3e7,%edx
  6c:   89 c1                   mov    %eax,%ecx
  6e:   83 c4 10                add    $0x10,%esp
  71:   eb 0d                   jmp    80 <main+0x80>
  73:   90                      nop
  74:   90                      nop
  75:   90                      nop
  76:   90                      nop
  77:   90                      nop
  78:   90                      nop
  79:   90                      nop
  7a:   90                      nop
  7b:   90                      nop
  7c:   90                      nop
  7d:   90                      nop
  7e:   90                      nop
  7f:   90                      nop
  80:   53                      push   %ebx
  81:   58                      pop    %eax
  82:   53                      push   %ebx
  83:   58                      pop    %eax
  84:   53                      push   %ebx
  85:   58                      pop    %eax
  86:   53                      push   %ebx
  87:   58                      pop    %eax
  88:   4a                      dec    %edx
  89:   79 f5                   jns    80 <main+0x80>
  8b:   0f 31                   rdtsc
  8d:   83 ec 08                sub    $0x8,%esp
  90:   29 c8                   sub    %ecx,%eax
  92:   50                      push   %eax
  93:   68 14 00 00 00          push   $0x14
                        94: R_386_32    .rodata.str1.1
  98:   43                      inc    %ebx
  99:   e8 fc ff ff ff          call   9a <main+0x9a>
                        9a: R_386_PC32  printf
  9e:   83 c4 10                add    $0x10,%esp
  a1:   83 fb 05                cmp    $0x5,%ebx
  a4:   0f 8e 6a ff ff ff       jle    14 <main+0x14>
  aa:   31 c0                   xor    %eax,%eax
  ac:   8b 5d fc                mov    0xfffffffc(%ebp),%ebx
  af:   c9                      leave
  b0:   c3                      ret
--
vda

