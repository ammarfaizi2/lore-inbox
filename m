Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVC2Ohh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVC2Ohh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 09:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVC2Ohh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 09:37:37 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:1284 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262299AbVC2OhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 09:37:18 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: memcpy(a,b,CONST) is not inlined by gcc 3.4.1 in Linux kernel
Date: Tue, 29 Mar 2005 17:37:06 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503291737.06356.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try testcase below the sig.

This causes nearly one thousand calls to memcpy in my kernel
(not an allyesconfig one):

# objdump -d vmlinux | grep -F '<memcpy>' | wc -l
    959

# gcc -O2 -c t.c
# objdump -r -d t.o

t.o:     file format elf32-i386

Disassembly of section .text:

00000000 <f3>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   83 ec 0c                sub    $0xc,%esp
   6:   6a 03                   push   $0x3
   8:   ff 75 0c                pushl  0xc(%ebp)
   b:   ff 75 08                pushl  0x8(%ebp)
   e:   e8 fc ff ff ff          call   f <f3+0xf>
                        f: R_386_PC32   memcpy
  13:   83 c4 10                add    $0x10,%esp
  16:   c9                      leave
  17:   c3                      ret

00000018 <f3b>:
  18:   55                      push   %ebp
  19:   89 e5                   mov    %esp,%ebp
  1b:   8b 55 0c                mov    0xc(%ebp),%edx
  1e:   66 8b 02                mov    (%edx),%ax
  21:   8b 4d 08                mov    0x8(%ebp),%ecx
  24:   66 89 01                mov    %ax,(%ecx)
  27:   8a 42 02                mov    0x2(%edx),%al
  2a:   88 41 02                mov    %al,0x2(%ecx)
  2d:   c9                      leave
  2e:   c3                      ret
  2f:   90                      nop

00000030 <f3k>:
  30:   55                      push   %ebp
  31:   89 e5                   mov    %esp,%ebp
  33:   57                      push   %edi
  34:   56                      push   %esi
  35:   8b 7d 08                mov    0x8(%ebp),%edi
  38:   8b 75 0c                mov    0xc(%ebp),%esi
  3b:   b9 ee 02 00 00          mov    $0x2ee,%ecx
  40:   f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
  42:   5e                      pop    %esi
  43:   5f                      pop    %edi
  44:   c9                      leave
  45:   c3                      ret


--
vda


typedef unsigned int size_t;

static inline void * __memcpy(void * to, const void * from, size_t n)
{
int d0, d1, d2;
__asm__ __volatile__(
        "rep ; movsl\n\t"
        "testb $2,%b4\n\t"
        "je 1f\n\t"
        "movsw\n"
        "1:\ttestb $1,%b4\n\t"
        "je 2f\n\t"
        "movsb\n"
        "2:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        :"0" (n/4), "q" (n),"1" ((long) to),"2" ((long) from)
        : "memory");
return (to);
}

/*
 * This looks horribly ugly, but the compiler can optimize it totally,
 * as the count is constant.
 */
static inline void * __constant_memcpy(void * to, const void * from, size_t n)
{
        if (n <= 128)
                return __builtin_memcpy(to, from, n);

#define COMMON(x) \
__asm__ __volatile__( \
        "rep ; movsl" \
        x \
        : "=&c" (d0), "=&D" (d1), "=&S" (d2) \
        : "0" (n/4),"1" ((long) to),"2" ((long) from) \
        : "memory");
{
        int d0, d1, d2;
        switch (n % 4) {
                case 0: COMMON(""); return to;
                case 1: COMMON("\n\tmovsb"); return to;
                case 2: COMMON("\n\tmovsw"); return to;
                default: COMMON("\n\tmovsw\n\tmovsb"); return to;
        }
}

#undef COMMON
}

#define memcpy(t, f, n) \
(__builtin_constant_p(n) ? \
 __constant_memcpy((t),(f),(n)) : \
 __memcpy((t),(f),(n)))

int f3(char *a, char *b) { memcpy(a,b,3); }
int f3b(char *a, char *b) { __builtin_memcpy(a,b,3); }
int f3k(char *a, char *b) { memcpy(a,b,3000); }

