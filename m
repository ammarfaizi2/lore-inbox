Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268696AbUJPLLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268696AbUJPLLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 07:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268697AbUJPLLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 07:11:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52876 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268696AbUJPLLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 07:11:20 -0400
Date: Sat, 16 Oct 2004 13:12:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041016111244.GA4808@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <1097888438.6737.63.camel@krustophenia.net> <1097894120.31747.1.camel@krustophenia.net> <20041016064205.GA30371@elte.hu> <1097917325.1424.13.camel@krustophenia.net> <20041016103608.GA3548@elte.hu> <32787.192.168.1.5.1097924629.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32787.192.168.1.5.1097924629.squirrel@192.168.1.5>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Ingo Molnar wrote:
> >
> > it seems that SMP + PREEMPT_TIMING is not stable though, somehow the
> > latency printk's cause a crash sooner or later. I'm still debugging this
> > problem. Without PREEMPT_TIMING the SMP kernel is stable.
> >
> 
> How true!
> 
> My first successful SMP/HT PREEMPT_REALTIME has been achieved, by just
> turning off PREEMPT_TIMING. So you won't get any latency trace dumps
> from here ;)

meanwhile i've mostly debugged the problem: it's an illegal recursion
into the timer code caused by PREEMPT_TIMING printks from within the
timer code calling do_poke_blanked_console() which in turn calls
del_timer() ...

this bug has been in the PREEMPT_TIMING code for almost forever, it's
just that under PREEMPT_REALTIME all the other latency sources are gone,
only the few places that still use raw spinlocks are remaining, amongst
them the timer code ...

> Actual .config.gz attached.
> 
> But now I have my two prime machines on full-RT-throttle, yeepee! :)

great! :) I strongly suspect this bug is the one Lee and Mark are seeing
too.

	Ingo
