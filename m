Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSLCPto>; Tue, 3 Dec 2002 10:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSLCPtn>; Tue, 3 Dec 2002 10:49:43 -0500
Received: from fmr01.intel.com ([192.55.52.18]:26356 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261624AbSLCPtm>;
	Tue, 3 Dec 2002 10:49:42 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4001070ED28@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Calin A. Culianu" <calin@ajvar.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: SMP Pentium4 -- PAUSE Instruction
Date: Tue, 3 Dec 2002 07:57:09 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That one is for tight loops. Spin locks are inlined, and PAUSE is used like:

#define spin_lock_string \
        "\n1:\t" \
        "lock ; decb %0\n\t" \
        "js 2f\n" \
        LOCK_SECTION_START("") \
        "2:\t" \
        "cmpb $0,%0\n\t" \
        "rep;nop\n\t" \ <---
        "jle 2b\n\t" \
        "jmp 1b\n" \
        LOCK_SECTION_END

Also take a look at arch/i386/kernel/semaphore.c for read/write_locks.

Jun

> -----Original Message-----
> From: Calin A. Culianu [mailto:calin@ajvar.org]
> Sent: Tuesday, December 03, 2002 7:42 AM
> To: Linux Kernel Mailing List
> Subject: SMP Pentium4 -- PAUSE Instruction
> 
> 
> I as wondering -- according to Intel's docs they recommend that on a P4
> processor to use the PAUSE instruction (aka rep followed by a nop) inside
> any spin loop (such as one used in SMP spinlock code) in order to both
> improve processor performance and reduce power consumption.
> 
> Is this instruction being used in spin-wait loops?  For some reason, I am
> having a hard time figuring out whether or not it is being used.  There is
> a rep_nop() in processor.h.. but I can't determine if that is being called
> for spin lock lock/unlock code.
> 
> 
> -Calin
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
