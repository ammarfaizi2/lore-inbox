Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVF0Xx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVF0Xx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVF0Xx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:53:26 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:54454 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262002AbVF0XxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:53:13 -0400
From: Andreas Kies <andikies@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: Re: A Bug in gcc or asm/string.h ?
Date: Tue, 28 Jun 2005 01:53:04 +0200
User-Agent: KMail/1.8
Cc: Paolo Ornati <ornati@fastwebnet.it>
References: <200506270105.28782.andikies@t-online.de> <200506272059.20477.andikies@t-online.de> <20050627214315.4b8850f5@localhost>
In-Reply-To: <20050627214315.4b8850f5@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506280153.04620.andikies@t-online.de>
X-ID: rCkngrZGoeIs7OWbN3f3mCsyHTEnOjzF+YazukaoOSV2pJI3QLRIoD
X-TOI-MSGID: 461d4dd6-50ba-44a3-b06b-fee57df376cb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 June 2005 21:43, Paolo Ornati wrote:
> PS: I've readded LKML to CC, since I think that this is a problem with the
> ASM template

Yes, you are right, it is not a compiler bug.
My apologies to the GCC team, in case anyone has read it.

[...]

> A little better workaround would be to add "memory" to clobbered registers
> in the asm template:
>
> static inline int strcmp(const char * cs,const char * ct)
> {
> int d0, d1;
> register int __res;
> __asm__ __volatile__(
>         "1:\tlodsb\n\t"
>         "scasb\n\t"
>         "jne 2f\n\t"
>         "testb %%al,%%al\n\t"
>         "jne 1b\n\t"
>         "xorl %%eax,%%eax\n\t"
>         "jmp 3f\n"
>         "2:\tsbbl %%eax,%%eax\n\t"
>         "orb $1,%%al\n"
>         "3:"
>
>         :"=a" (__res), "=&S" (d0), "=&D" (d1)
>         :
>                      :"1" (cs),"2" (ct)
>                      : "memory"); // <--- workaround
>
> return __res;
> }
>
>
> In this way GCC puts everything is cached in register back to memory when
> you call strcmp()... but you can argue that this isn't optimal.

Indeed the compiler has to assume that any memory location has changed.

> I don't know if there is a better way... basically you need to tell GCC to
> NOT cache these values.

There is one, it says that cs and ct address structures with 4 gigabyte size.
This is anyway not 64 bit clean.

static inline int strcmp(const char * cs,const char * ct)
{
        int d0, d1;
        register int __res;
        __asm__ __volatile__(
                        "1:\tlodsb\n\t"
                        "scasb\n\t"
                        "jne 2f\n\t"
                        "testb %%al,%%al\n\t"
                        "jne 1b\n\t"
                        "xorl %%eax,%%eax\n\t"
                        "jmp 3f\n"
                        "2:\tsbbl %%eax,%%eax\n\t"
                        "orb $1,%%al\n"
                        "3:"
                        :"=a" (__res), "=&S" (d0), "=&D" (d1)
                        :"1" (cs),"2" (ct),
                        "m" ( *(struct { char __x[0xfffffff]; } *)cs),
                        "m" ( *(struct { char __x[0xfffffff]; } *)ct));
        return __res;
}


Now, how do i formally submit this as a bug report ?

Andreas.
