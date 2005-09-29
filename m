Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVI2Hyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVI2Hyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVI2Hyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:54:33 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.19]:41811 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932145AbVI2Hyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:54:32 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostdt@goodmis.org>
Cc: Jeff Dike <jdike@addtoit.com>
In-Reply-To: <20050820212446.GA9822@ccure.user-mode-linux.org>
References: <20050818060126.GA13152@elte.hu>
	 <1124470574.17311.4.camel@twins> <1124476205.17311.8.camel@twins>
	 <20050819184334.GG1298@us.ibm.com> <1124566045.17311.11.camel@twins>
	 <20050820212446.GA9822@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 09:54:23 +0200
Message-Id: <1127980463.14695.6.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-20 at 17:24 -0400, Jeff Dike wrote:
> On Sat, Aug 20, 2005 at 09:27:25PM +0200, Peter Zijlstra wrote:
> > Jeff, could you help us out here?
> > What exactly does uml need to get out of the calibrate delay loop?
> 
> Interrupts, it's not too demanding :-)
> 
> If it's not seeing VTALRM, then it will never leave the calibration loop.
> 
> Try stracing it and see what it's getting.

Sorry for the late reply.

Yes, that does seem to be the problem.

Even with a current -rt (2.6.14-rc2-rt5) UML does not run. The issue is
indeed (as jeff pointed out) that VTALRM is never send. The small test
programm below illustrates this.

On a non-rt kernel it completed in 1 second.
On a -rt kernel it waits at infinitum.

Kind regards,

Peter Zijlstra

---------------------------

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>
#include <signal.h>

volatile int quit = 0;

void sig_vtalrm(int signr, siginfo_t * si, void * arg)
{
        if (signr == SIGVTALRM) quit = 1;
}

int main()
{
        struct itimerval ival = {{0,0}, {1, 0}};

        struct sigaction sa;
        sa.sa_sigaction = sig_vtalrm;
        sigemptyset(&sa.sa_mask);
        sa.sa_flags = 0;
        sigaction(SIGVTALRM, &sa, NULL);

        setitimer(ITIMER_VIRTUAL, &ival, NULL);

        printf("wait\n");
        while (!quit) ;
        printf("done\n");
}


-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

