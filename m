Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136073AbREBXEb>; Wed, 2 May 2001 19:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136058AbREBXEV>; Wed, 2 May 2001 19:04:21 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:4102 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S136069AbREBXEG>;
	Wed, 2 May 2001 19:04:06 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200105022303.f42N36825429@oboe.it.uc3m.es>
Subject: Re: [OT] Interrupting select.
In-Reply-To: <E14v4zq-0004Sy-00@the-village.bc.nu> from "Alan Cox" at "May 2,
 2001 11:21:19 pm"
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Date: Thu, 3 May 2001 01:03:06 +0200 (MET DST)
CC: ptb@it.uc3m.es, lar@cs.york.ac.uk,
        "Linux Kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=UNKNOWN-8BIT
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Alan Cox wrote:"
> > What IS the magic combination that makes select interruptible
> > by honest-to-goodness non-blocked signals!
> man
> 
> [seriously man sigaction]

Equally seriously .. all signals are unblocked in my code and always
have been. The processes receive signals vurrrrry happily. Except when
they are in a select-with-timeout loop, when they keep going round the
loop poking their head out of the select every 5s, and taking no notice
of the murderous hail of die die die die die stuff being slammed at
them.

You can see stuff such as the following early on in my code:

           // handle every s¡ngle signal in one "sighandler"
           for (k = 1; k < 30; k++) {
             struct sigaction sa = { {sighandler}, {{0}}, SA_RESTART, NULL };
             sigfillset(& sa.sa_mask);
             sigaction(k, & sa, NULL);
           }
                                                     
But does select come out of this loop?

             while (1) {
                 int res = select(n,rfds,wfds,efds,&timeout);
                 if (res > 0)
                    return res;    // data or error is expected
                 if (res == 0) {
                    return -ETIME; // timeo in select
                 }
             }

A resounding "no". kill -9 hurts it but it's invulnerable to everything
else.

Looking at the kernel code in select.c. I see it's implemented by poll
(I knew that). sys_select calls do_select and I can't for the life of
me see where anyone sets a signal mask. OTOH if all signals are
masked by default when syscalls are made (I don't know, but it seems
possible) then I can't see where interrupts are allowed again.

The man page for select says nothing about it being interruptible, or
not. 

This has been in the back of my mind for months. I'm glad somebody
asked about it!


Peter
