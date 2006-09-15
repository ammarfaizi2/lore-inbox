Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWIOPsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWIOPsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWIOPsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:48:00 -0400
Received: from dvhart.com ([64.146.134.43]:60130 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932101AbWIOPr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:47:59 -0400
Message-ID: <450ACAF8.6020107@mbligh.org>
Date: Fri, 15 Sep 2006 08:47:04 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>	 <20060915132052.GA7843@localhost.usen.ad.jp>	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>	 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>	 <20060915142836.GA9288@localhost.usen.ad.jp>  <450ABCBB.4090001@mbligh.org> <1158333723.29932.88.camel@localhost.localdomain>
In-Reply-To: <1158333723.29932.88.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-09-15 am 07:46 -0700, ysgrifennodd Martin J. Bligh:
>> Moreover, subsystem experts know what needs to be traced in order to
>> give useful information, and the users may not. It's a damned sight
>> easier for them to say "oh, please turn on tracing for VM events
>> and send me the output" than custom-construct a set of probes for
>> that user, and send them off. There's a barrier to entry that just
>> won't happen there.
> 
> That has nothing to do with the static or dynamic probe question.
> Scriptable dynamic probes do everything your static probes do and more.

No. The point is that they're not *there* and have to be modified
for every kernel version. And do you mean with or without the markers
in the code to tell the dynamic probes where to hook in, and what data
to fetch? that makes a huge difference.

Suppose, as a very real example, I want to instrument shrink_list.
There are 20 or so places where it can switch what we're doing with
a page for different reasons. Potentially we're scanning through many
thousands of pages. If I can keep counters as I go through the function,
and then do one trace entry at the end, that's fairly efficient. If I
have to create 20 separate hooks that all jump out of line, it's going
to be a lot slower. If I log a tracepoint at every damned page every
time it switches, it's going to be a nightmare.

Most things can be done with dynamic probes. Some things will require
markers in the code to tell us sustainably over time where to attatch
them. A few things (like the above) probably require some explicit
code.

>> Hell, look at all the debug printks in the kernel for example, and
>> the various small add-hoc tracing facilities. If all we do is unite
>> those, it'll still be a step forwards.
> 
> Look how many there are, look how they spread, tracepoints will do the
> same.

As long as they all use the same infrastructure, that's an improvement.

>> Dynamic probes do NOT reduce maintenance, they increase it.
> 
> Thats a logical fallacy to begin with. A dynamic probe can probe
> anything a static probe can. So a static probe can be implemented with a
> dynamic probe.

In the absence of the markers, I don't think that's true - there's the
maintenance of exactly where they go, plus access to local data. If you
mean with markers, then yes, that's fine. The markers + dynamic probes
seems to be a reasonable compromise between the two. Exactly what we
call that combo, static or dynamic, I don't really care ;-)

> In other words if you like static probe lists and your subsystem happens
> to be one where it is useful then you can script it with the same effect
> and send people the script.
> 
> With kprobes you've got a passably good chance (ie if Distros can be
> persuaded to package the debug data) that you can say "run this
> systemtap script". With static tracepoints its "recompile your vendor
> kernel in your vendor manner with your vendor initrd and add it to the
> boot loader"

You're thinking of one situation where you can't recompile. I'm thinking
of a situation where it's trivial to recompile. Both exist, neither is
invalid. Of course, where possible, we'd like to be able to add stuff
on the fly, but it's not a panacea.

Without the markers, maintaining a usable set of dynamic probe points
that's always available for every kernel version seems infeasible.
With them, I think it'll cover 99% of the cases, and would be pretty
useful. If people agree on putting tags in there, perhaps we can
discuss things like the logging mechanism, format, and readout.
If not, I suppose we have to drag this debate out even longer.

M.

