Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVDBMTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVDBMTV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 07:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVDBMTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 07:19:21 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:24324 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261408AbVDBMS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 07:18:57 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jan Hubicka <hubicka@ucw.cz>
Subject: Re: memcpy(a,b,CONST) is not inlined by gcc 3.4.1 in Linux kernel
Date: Sat, 2 Apr 2005 15:18:49 +0300
User-Agent: KMail/1.5.4
Cc: Gerold Jury <gerold.ml@inode.at>, jakub@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gcc@gcc.gnu.org
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu> <200503300916.00781.vda@ilport.com.ua> <20050401214322.GA7175@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050401214322.GA7175@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504021518.49479.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >         childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
> >         *childregs = *regs;
> >         ^^^^^^^^^^^^^^^^^^^
> >         childregs->eax = 0;
> >         childregs->esp = esp;
> > 
> > # make arch/i386/kernel/process.s
> > 
> > copy_thread:
> >         pushl   %ebp
> >         movl    %esp, %ebp
> >         pushl   %edi
> >         pushl   %esi
> >         pushl   %ebx
> >         subl    $20, %esp
> >         movl    24(%ebp), %eax
> >         movl    4(%eax), %esi
> >         pushl   $60
> >         leal    8132(%esi), %ebx
> >         pushl   28(%ebp)
> >         pushl   %ebx
> >         call    memcpy  <=================
> >         movl    $0, 24(%ebx)
> > 
> > Jakub, is there a way to instruct gcc to inine this copy, or better yet,
> > to use user-supplied inline version of memcpy?
> 
> You can't inline struct copy as it is not function call at first place.
> You can experiment with -minline-all-stringops where GCC will use it's
> own memcpy implementation for this.

No luck. Actually, memcpy calls are produced with -Os. Adding
-minline-all-stringops changes nothing.

-O2 compile does inline copying, however, suboptimally.
Pushing/popping esi/edi on the stack is not needed.
Also "mov $1,ecx; rep; movsl" is rather silly.

Here what did I test:

t.c:
#define STRUCT1(n) struct s##n { char c[n]; } v##n, w##n; void f##n(void) { v##n = w##n; }
#define STRUCT(n) STRUCT1(n)

STRUCT(1)
STRUCT(2)
STRUCT(3)
STRUCT(4)
STRUCT(5)
STRUCT(6)
STRUCT(7)
STRUCT(8)
STRUCT(9)
STRUCT(10)
STRUCT(11)
STRUCT(12)
STRUCT(13)
STRUCT(14)
STRUCT(15)
STRUCT(16)
STRUCT(17)
STRUCT(18)
STRUCT(19)
STRUCT(20)

mk.sh:
#!/bin/sh

# yeah yeah. push/pop + 1 repetition 'rep movsl'
#  88:   55                      push   %ebp
#  89:   89 e5                   mov    %esp,%ebp
#  8b:   57                      push   %edi
#  8c:   56                      push   %esi
#  8d:   fc                      cld
#  8e:   bf 00 00 00 00          mov    $0x0,%edi
#                        8f: R_386_32    v7
#  93:   be 00 00 00 00          mov    $0x0,%esi
#                        94: R_386_32    w7
#  98:   b9 01 00 00 00          mov    $0x1,%ecx
#  9d:   f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
#  9f:   66 a5                   movsw  %ds:(%esi),%es:(%edi)
#  a1:   a4                      movsb  %ds:(%esi),%es:(%edi)
#  a2:   5e                      pop    %esi
#  a3:   5f                      pop    %edi
#  a4:   c9                      leave
#  a5:   c3                      ret
#  a6:   89 f6                   mov    %esi,%esi
if false; then
gcc -O2 \
falign-functions=1 -falign-labels=1 -falign-loops=1 -falign-jumps=1 \
-c t.c
echo Done; read junk
objdump -d -r t.o | $PAGER
exit
fi

# -Os: emits memcpy
if false; then
gcc -nostdinc -isystem /.share/usr/app/gcc-3.4.1/bin/../lib/gcc/i386-pc-linux-gnu/3.4.1/include \
-Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing \
-fno-common -ffreestanding -Os -falign-functions=1 -falign-labels=1 \
-falign-loops=1 -falign-jumps=1 -fno-omit-frame-pointer -pipe -msoft-float \
-mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=i486 \
-Wdeclaration-after-statement -c t.c
echo Done; read junk
objdump -d -r t.o | $PAGER
exit
fi

# -march=486: emits horrible tail:
# 271:   f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
# 273:   5e                      pop    %esi
# 274:   66 a1 10 00 00 00       mov    0x10,%ax
#                        276: R_386_32   w19
# 27a:   5f                      pop    %edi
# 27b:   66 a3 10 00 00 00       mov    %ax,0x10
#                        27d: R_386_32   v19
# 281:   5d                      pop    %ebp
# 282:   a0 12 00 00 00          mov    0x12,%al
#                        283: R_386_32   w19
# 287:   a2 12 00 00 00          mov    %al,0x12
#                        288: R_386_32   v19
# 28c:   c3                      ret
if false; then
gcc \
-fno-common -ffreestanding -O2 -falign-functions=1 -falign-labels=1 \
-falign-loops=1 -falign-jumps=1 -fno-omit-frame-pointer -pipe -msoft-float \
-mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=i486 \
-Wdeclaration-after-statement \
-c t.c
echo Done; read junk
objdump -d -r t.o | $PAGER
exit
fi

# -Os -minline-all-stringops: still emits memcpy
if true; then
gcc -nostdinc -isystem /.share/usr/app/gcc-3.4.1/bin/../lib/gcc/i386-pc-linux-gnu/3.4.1/include \
-Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing \
-fno-common -ffreestanding -Os -minline-all-stringops -falign-functions=1 -falign-labels=1 \
-falign-loops=1 -falign-jumps=1 -fno-omit-frame-pointer -pipe -msoft-float \
-mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=i486 \
-Wdeclaration-after-statement -c t.c
echo Done; read junk
objdump -d -r t.o | $PAGER
exit
fi

--
vda

