Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265201AbUFMQsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUFMQsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 12:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUFMQsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 12:48:10 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:16715 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265201AbUFMQsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 12:48:06 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: anton@au.ibm.com, linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ppc64 out_be64
References: <521xkk77xh.fsf@topspin.com> <1087141822.8210.176.camel@gaston>
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: 13 Jun 2004 09:48:01 -0700
In-Reply-To: <1087141822.8210.176.camel@gaston>
Message-ID: <52llir5rr2.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Jun 2004 16:48:01.0153 (UTC) FILETIME=[30448F10:01C45166]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Benjamin> Ugh ? The syntax of std is std rS, ds(rA), so your fix
    Benjamin> doesn't look good to me, and it definitely builds with
    Benjamin> the current syntax, though I agree the type is indeed
    Benjamin> wrong. I also spotted another bug where we forgot to
    Benjamin> change an eieio into sync in there though.

Although the kernel builds, it's only because no one actually uses
out_be64.  You can try the old version and see:

    > cat foo.c
    static inline void out_be64(volatile unsigned long *addr, unsigned
    long val)
    {
            __asm__ __volatile__("std %1,0(%0); eieio" : "=m" (*addr) :
    "r" (val));
    }

    void foo(void *x, unsigned long y)
    {
            out_be64(x, y);
    }
    $ ${CROSS_COMPILE}gcc -save-temps -c foo.c
    foo.s: Assembler messages:
    foo.s:49: Error: syntax error; found `(' but expected `)'
    foo.s:49: Error: junk at end of line: `(9))'

Looking at foo.s, it's pretty obvious that %0 is already in the ds(rA)
form, and adding 0() around it breaks things.  out_be64 expands to:

    #APP
            std 0,0(0(9)); eieio
    #NO_APP

It's possible this is an artifact of my cross-toolchain (gcc
3.4.0/binutils 2.15 built with Dan Kegel's crosstool), 

    Benjamin> Does this totally untested patch works for you ?

Yes, that looks fine (after fixing val to be unsigned long in
out_be64).  You know infinitely more about ppc64 asm than I do so I'm
sure your version is better.

Thanks,
  Roland
