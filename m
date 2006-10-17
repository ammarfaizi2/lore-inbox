Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWJQQrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWJQQrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWJQQrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:47:51 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:37836 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1751322AbWJQQru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:47:50 -0400
Date: Tue, 17 Oct 2006 09:47:25 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] x86_64 add missing enter_idle() calls
Message-ID: <20061017164725.GA18637@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061006081607.GB8793@frankl.hpl.hp.com> <200610161208.13628.ak@suse.de> <20061016141342.GF15540@frankl.hpl.hp.com> <200610161636.52721.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610161636.52721.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Mon, Oct 16, 2006 at 04:36:52PM +0200, Andi Kleen wrote:
> 
> > With the original code, the number of callbacks you see for IDLE_START and
> > IDLE_STOP is not too obvious.
> > 
> > On an idle system Opteron 250 with HZ=250, one would expect to see for a 10s duration:
> > 	- for CPU0      : IDLE_START = IDLE_STOP = about 5000 calls
> > 	- for other CPUs: IDLE_START = IDLE_STOP = about 2500  calls
> 
> Yes.
> 
> Hmm, the last time I fixed this when you complained (post .18) i added a counter for 
> entry/exit and verified that it was balanced. I haven't rechecked since then.
> I don't know why your numbers are off. You're using the latest git tree, right?
>  
i have nowupgraded to 2.6.19-rc2 from GIT. It is slightly better but far from 
the expected counts as shown above. I have intrumented the idle notifier to
get to the bottom of this. I have modified the code as follows:

static void enter_idle(void)
{
        pfm_enter_idle++;
        write_pda(isidle, 1);
        atomic_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
}

static void __exit_idle(void)
{
        pfm_exit_idle1++;
        if (read_pda(isidle) == 0)
                return;
        pfm_exit_idle2++;
        write_pda(isidle, 0);
        atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
}

/* Called from interrupts to signify idle end */
void exit_idle(void)
{
        /* idle loop has pid 0 */
        if (current->pid)
                return;
        pfm_exit_idle3++;
        __exit_idle();
}

I export the counters via /sys. I run the following test:
	reset-counters; sleep 10; print counters for CPU0

Here is what I get on CPU0 on an idle system after 10s:
	enter_idle = 37 calls
	exit_idle1 = 5209
	exit_idle2 = 37 actual notifier calls (match enter_idle)
	exit_idle3 = 5172

That means that the notifier was only called 37 times, far from 5000 expected.

Based on where the counts are for for idle1 and idle2, it appears that a lot of
calls for exit_idle() are blocked by 'if (read_pda(isidle) == 0) return' which
indicates that by the time we get to the interrupt handler, we are not in the low
level idle function anymore. In other words, we get interrupted before we get a
chance to go back to idle loop. The number of calls to exit_idle() is as expected
though. This means that in the idle loop, somehow, we do not loop very much. It is
as if we were interrupted a lot before we enter it and at the tail of the loop
(after __exit_idle).

I must admit I am still puzzled by the results and I do not have a good explanation
so far.

-- 
-Stephane
