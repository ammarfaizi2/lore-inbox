Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263067AbSIPVL3>; Mon, 16 Sep 2002 17:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263070AbSIPVL2>; Mon, 16 Sep 2002 17:11:28 -0400
Received: from smtpout.mac.com ([204.179.120.87]:23546 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S263067AbSIPVL1>;
	Mon, 16 Sep 2002 17:11:27 -0400
Date: Mon, 16 Sep 2002 23:16:20 +0200
Subject: Re: Oops in sched.c on PPro SMP
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
To: Andrea Arcangeli <andrea@suse.de>
From: Peter Waechtler <pwaechtler@mac.com>
In-Reply-To: <20020916154446.GI11605@dualathlon.random>
Message-Id: <8BA3FD1E-C9B9-11D6-8873-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag den, 16. September 2002, um 17:44, schrieb Andrea Arcangeli:

> On Mon, Sep 16, 2002 at 03:49:27PM +0100, Alan Cox wrote:
>> Also does turning off the nmi watchdog junk make the box stable ?
>
> good idea, I didn't though about this one since I only heard the nmi to
> lockup hard boxes after hours of load, never to generate any
> malfunction, but certainly the nmi handling isn't probably one of the
> most exercised hardware paths in the cpus, so it's a good idea to
> reproduce with it turned off (OTOH I guess you probably turned it on
> explicitly only after you got these troubles, in order to debug them).
>

I only turned the nmi watchdog on, on the one "unknown" version Oops.

This box was running fine with 2.4.18-SuSE with uptimes 40+days. _Now_
I am almost sure, that it's _not_ a hardware problem (FENCE counting
here as software - since there is a software workaround).

I had 3 lockups in 2 days, when I switched to 2.4.19 - and even lower
room temperature. No, there _must_ be a bug :)

With the relocation you are right - I thought it would test against 
NULL :-(

I think that the tasklist is broken inbetween - either due to broken
readlocks (no working EFENCE on PPRO)

Can someone explain me the difference for label 1 and 2?
Why is the "js 2f" there? This I don't understand fully -
it looks broken to me.

include/asm-i386/rwlock.h

#define __build_read_lock_ptr(rw, helper)   \
     asm volatile(LOCK "subl $1,(%0)\n\t" \
              "js 2f\n" \
              "1:\n" \
              LOCK_SECTION_START("") \
              "2:\tcall " helper "\n\t" \
              "jmp 1b\n" \
              LOCK_SECTION_END \
              ::"a" (rw) : "memory")

