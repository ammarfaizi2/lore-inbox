Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbUCJM2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUCJM2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:28:17 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:5007 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262589AbUCJM1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:27:53 -0500
Message-ID: <404F09C6.7030200@softhome.net>
Date: Wed, 10 Mar 2004 13:27:50 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: stack allocation and gcc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All!

    [ please cc: me ]

    I have observed funny behaviour of both gcc 2.95/322 on ppc32 and 
i686 platforms.

    Have written this routine and compiled it with 'gcc -O2':

int a(int v)
{
         char buf[32];

         if (v > 5) {
                 char buf2[32];
                 printf( buf, buf2 );
         } else {
                 char buf2[32];
                 printf( buf, buf2 );
         }
         return 1;
}

    I expected that stack on every branch of 'if(v>5)' will be allocated 
later - but seems that gcc allocate stack space once and in this case it 
will 'overallocate' 32 bytes - 'char buf2' will be allocated twice for 
every branch. On i686 gcc allocates 108 bytes, on ppc32 it allocates 116 
bytes. (additional space seems to be induced by printf() call)
    Adding to this routine something like 'do { char a[32]; } while(0);' 
several times shows that stack buffers are not reused - and allocated 
for every this kind of context separately.

    As to my understanding - since this buffers do live in different 
mutually exclusive contextes - they can be reused. But this seems to be 
not case. Waste of precious kernel stack space - and waste of d-cache.

    I have read 'info gcc' - but found nothing relevant to this.
    I've checked ppc abi - but found no limitations to reuse of stack space.

    Is it expected behaviour of compiler? gcc feature?

    [ I have created macro which opens into inline function call which 
utilizes va_list - on ppc32 va_list adds at least 32 bytes to stack use. 
Seems to be bad idea for kernel-space, since every use if macro adds to 
stack use (10 macro calls == 320 bytes). Easy to rewrite to not to use 
va_list - but have I *NO* stack allocation check script in place - this 
stuff could easily get into production release. Not nice. ]

    disassembling outputs:

--- objdump/ix86 -------------------
00000000 <a>:
    0:   55                      push   %ebp
    1:   89 e5                   mov    %esp,%ebp
    3:   83 ec 68                sub    $0x68,%esp
    6:   83 7d 08 05             cmpl   $0x5,0x8(%ebp)
    a:   7e 1c                   jle    28 <a+0x28>
    c:   83 ec 08                sub    $0x8,%esp
    f:   8d 45 b8                lea    0xffffffb8(%ebp),%eax
   12:   50                      push   %eax
   13:   8d 45 d8                lea    0xffffffd8(%ebp),%eax
   16:   50                      push   %eax
   17:   e8 fc ff ff ff          call   18 <a+0x18>
                         18: R_386_PC32  printf
   1c:   83 c4 10                add    $0x10,%esp
   1f:   b8 01 00 00 00          mov    $0x1,%eax
   24:   c9                      leave
   25:   c3                      ret
   26:   89 f6                   mov    %esi,%esi
   28:   83 ec 08                sub    $0x8,%esp
   2b:   8d 45 98                lea    0xffffff98(%ebp),%eax
   2e:   eb e2                   jmp    12 <a+0x12>
------------------------------------

--- objdump/ppc82xx ----------------
00000000 <a>:
    0:   94 21 ff 90     stwu    r1,-112(r1)
    4:   7c 08 02 a6     mflr    r0
    8:   90 01 00 74     stw     r0,116(r1)
    c:   2c 03 00 05     cmpwi   r3,5
   10:   40 81 00 18     ble     28 <a+0x28>
   14:   38 61 00 08     addi    r3,r1,8
   18:   38 81 00 28     addi    r4,r1,40
   1c:   4c c6 31 82     crclr   4*cr1+eq
   20:   48 00 00 01     bl      20 <a+0x20>
                         20: R_PPC_REL24 printf
   24:   48 00 00 14     b       38 <a+0x38>
   28:   38 61 00 08     addi    r3,r1,8
   2c:   38 81 00 48     addi    r4,r1,72
   30:   4c c6 31 82     crclr   4*cr1+eq
   34:   48 00 00 01     bl      34 <a+0x34>
                         34: R_PPC_REL24 printf
   38:   38 60 00 01     li      r3,1
   3c:   80 01 00 74     lwz     r0,116(r1)
   40:   7c 08 03 a6     mtlr    r0
   44:   38 21 00 70     addi    r1,r1,112
   48:   4e 80 00 20     blr
------------------------------------

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|
