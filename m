Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSKDL7B>; Mon, 4 Nov 2002 06:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264655AbSKDL7B>; Mon, 4 Nov 2002 06:59:01 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62983 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264653AbSKDL66>; Mon, 4 Nov 2002 06:58:58 -0500
Message-Id: <200211041159.gA4Bxop32366@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Re: Improving string.h memcp()y implementation
Date: Mon, 4 Nov 2002 14:51:24 -0200
X-Mailer: KMail [version 1.3.2]
References: <200211041137.gA4Bbip32222@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200211041137.gA4Bbip32222@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 November 2002 14:29, Denis Vlasenko wrote:
> static inline void *
> vda_memcpy3(void * to, const void * from, size_t n)
> {
>         int d0, d1, d2;
>         __asm__ __volatile__(
>         "       rep; movsl\n"
>         "       movl    %4, %%ecx\n"
>         "       rep; movsb\n"
>
>                 : "=&c" (d0), "=&D" (d1), "=&S" (d2)
>                 : "0" (n/4), "g" (n&3), "1" ((long) to), "2" ((long)
>                 : from) "memory"
>
>         );
>         return (to);
> }
......
> void f5() { vda_memcpy3(to,from,sz); }
......
> Disassembly of section ff5:
>
> 00000000 <f5>:
>    0:   8b 0d 00 00 00 00       mov    0x0,%ecx
>    6:   57                      push   %edi
>    7:   89 c8                   mov    %ecx,%eax
>    9:   56                      push   %esi
>    a:   8b 3d 00 00 00 00       mov    0x0,%edi
>   10:   8b 35 00 00 00 00       mov    0x0,%esi
>   16:   83 e0 03                and    $0x3,%eax
>   19:   c1 e9 02                shr    $0x2,%ecx
>   1c:   f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
>   1e:   89 c1                   mov    %eax,%ecx
>   20:   f3 a4                   repz movsb %ds:(%esi),%es:(%edi)
>   22:   5e                      pop    %esi
>   23:   5f                      pop    %edi
>   24:   c3                      ret
>
> I think I shall not look there for a while ;)
> Please somebody stop me... ;) ;)

...before it will be too late:

static inline void *
vda_memcpy3(void * to, const void * from, size_t n)
{
        int d0, d1, d2;
        __asm__ __volatile__(
        "       andb    $3, %b4\n"	// we can save here a byte if %4 == eax
        "       rep; movsl\n"
        "       movb    %b4, %%cl\n"
        "       rep; movsb\n"
                : "=&c" (d0), "=&D" (d1), "=&S" (d2)
                : "0" (n/4), "g" (n), "1" ((long) to), "2" ((long) from)
		: "memory"
        );
        return (to);
}

Disassembly of section ff5:

00000000 <f5>:
   0:   a1 00 00 00 00          mov    0x0,%eax
   5:   57                      push   %edi
   6:   89 c1                   mov    %eax,%ecx
   8:   56                      push   %esi
   9:   8b 3d 00 00 00 00       mov    0x0,%edi
   f:   8b 35 00 00 00 00       mov    0x0,%esi
  15:   c1 e9 02                shr    $0x2,%ecx
  18:   24 03                   and    $0x3,%al
  1a:   f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
  1c:   88 c1                   mov    %al,%cl
  1e:   f3 a4                   repz movsb %ds:(%esi),%es:(%edi)
  20:   5e                      pop    %esi
  21:   5f                      pop    %edi
  22:   c3                      ret

;)))

--
vda
