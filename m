Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992894AbWJUJTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992894AbWJUJTB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 05:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992896AbWJUJTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 05:19:01 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:34013 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S2992894AbWJUJTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 05:19:00 -0400
Date: Sat, 21 Oct 2006 02:18:37 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: [PATCH] x86_64 add missing enter_idle() calls
Message-ID: <20061021091837.GA24670@frankl.hpl.hp.com>
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
> > With the original code, the number of callbacks you see for IDLE_START and
> > IDLE_STOP is not too obvious.
> > 
> > On an idle system Opteron 250 with HZ=250, one would expect to see for a 10s duration:
> > 	- for CPU0      : IDLE_START = IDLE_STOP = about 5000 calls
> > 	- for other CPUs: IDLE_START = IDLE_STOP = about 2500  calls
> 
> Yes.
> 
> > With the original code, you get the following number of calls:
> > 
> > CPU0.IDLE_START = 44 (enter_idle)
> > CPU0.IDLE_STOP  = 5206 (exit_idle)
> > 
> > CPU1.IDLE_START = 27 (enter_idle)
> > CPU1.IDLE_STOP  = 2528 (exit_idle)
> > 
> 
> Hmm, the last time I fixed this when you complained (post .18) i added a counter for 
> entry/exit and verified that it was balanced. I haven't rechecked since then.
> I don't know why your numbers are off. You're using the latest git tree, right?

As I reported earlier, going to the Git kernel did not really change the
number of invocations of the idle notifier. I was very puzzled by this, so I
chased it some more.

I finally found the culprit for this. The current code is wrong for the
simple reason that the cpu_idle() function is NOT always the lowest level
idle loop function. For enter_idle()/__exit_idle() to work correctly they
must be placed in the lowest-level idle loop. The cpu_idle() eventually ends
up in the idle() function, but this one may have a loop in it! This is the
case when idle()=cpu_default_idle() and idle()=poll_idle(), for instance. 

The reason why the idle notifier was called so few times, even though we had
the right number of interrupts, is simply because we were not getting out of
the idle() function. So I can, indeed, confirm that an interrupt in HLT
instruction gets you out, but HLT is in a loop from which you do not get out
unless you need to reschedule. By moving enter_idle()/__exit_idle() to
cpu_default_idle() I got the right number of calls for the idle notifier.

I see two solutions to this:
	- move enter_idle()/__exit_idle() to the actual lowest-level loop,
	  in cpu_default_idle() and not in cpu_idle(). We would also have
	  to do something similar to poll_idle(), or any similar idle function
	  which contains a loop.

	- add exit_idle() to all the local interrupt handlers, like my
	  initial patch was doing and leave the ente_idle()/__exit_idle()
	  where they are today.

-- 
-Stephane
