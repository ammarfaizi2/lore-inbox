Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVFVPbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVFVPbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFVP2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:28:10 -0400
Received: from opersys.com ([64.40.108.71]:48908 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261542AbVFVPUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:20:42 -0400
Message-ID: <42B9845B.8030404@opersys.com>
Date: Wed, 22 Jun 2005 11:31:39 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com>
In-Reply-To: <20050622011931.GF1324@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney wrote:
> Probably just my not fully understanding I-PIPE (to say nothing of
> not fully understanding your test setup!), but I would have expected
> I-PIPE to be able to get somewhere in the handfuls of microseconds of
> interrupt latency.  Looks like it prevents Linux from ever disabling
> real interrupts -- my first guess after reading your email was that
> Linux was disabling real interrupts and keeping I-PIPE from getting
> there in time.

Have a look at the announcement just made by Kristian about the LRTBF.
There's a tarball with all the code for the drivers, scripts and
configs we used.

Nevertheless, maybe it's worth that I clarify the setup further.
Here's what we had:

                     +----------+
                     |   HOST   |
                     +----------+
                          |
                          |
                          | Ethernet LAN
                          |
                         / \
                        /   \
                       /     \
                      /       \
                     /         \
                    /           \
                   /             \
            +--------+  SERIAL  +--------+
            | LOGGER |----------| TARGET |
            +--------+          +--------+

The logger sends an interrupt to the target every 1ms. Here's the
path travelled by this interrupt (L for logger, T for target):

1- L:adeos-registered handler is called at timer interrupt
2- L:record TSC for transmission
3- L:write out to parallel port
4- T:ipipe-registered handler called to receive interrupt
5- T:write out to parallel port
6- L:adeos-registered handler called to receive interrupt
7- L:record TSC for receipt

The response times obtained include all that goes on from 2 to
7, including all hardware-related delays. The target's true
response time is from 3.5 to 5.5 (the .5 being the actual
time it takes for the signal to reache the pins on the actual
physical parallel port outside the computer.)

The time from 2 to 3.5 includes the execution time for a few
instructions (record TSC value to RAM and outb()) and the delay
for the hardware to put the value out on the parallel port.

The time from 5.5 to 7 includes an additional copy of adeos'
interrupt response time. IOW, in all cases, we're at least
recording adeos' interrupt response time at least once. Like
we explained in our first posting (and as backed up by the
data found in both postings) the adeos-to-adeos setup shows
that this delay is bound. In fact, we can safely assume that
2*max_ipipe_delay ~= 55us and that 2*average_ipipe_delay
~= 14us. And therefore:

max_ipipe_delay = 27.5us
average_ipipe_delay = 7us
max_preempt_delay = 55us - max_ipipe_delay = 27.5us
average_preempt_delay = 14 us - average_ipipe_delay = 7us

Presumably the 7us above should fit the "handful" you refer
to. At least I hope.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
