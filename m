Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVAYSgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVAYSgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVAYSgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:36:24 -0500
Received: from mail.joq.us ([67.65.12.105]:34274 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262054AbVAYSf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:35:56 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Alexander Nyberg <alexn@dsv.su.se>, Ingo Molnar <mingo@elte.hu>,
       linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org>
	<877jm3ljo9.fsf@sulphur.joq.us> <41F44AC2.1080609@kolivas.org>
	<87hdl7v3ik.fsf@sulphur.joq.us> <87651nv356.fsf@sulphur.joq.us>
	<87ekgbqr2a.fsf@sulphur.joq.us> <41F49735.5000400@kolivas.org>
	<873bwrpb4o.fsf@sulphur.joq.us> <41F57D94.4010500@kolivas.org>
	<41F5C347.4030605@kolivas.org> <41F64410.4000702@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 25 Jan 2005 12:36:50 -0600
In-Reply-To: <41F64410.4000702@kolivas.org> (Con Kolivas's message of "Wed,
 26 Jan 2005 00:05:20 +1100")
Message-ID: <87k6q1nynx.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> There were numerous bugs in the SCHED_ISO design prior to now, so it
> really was not performing as expected. What is most interesting is
> that the DSP load goes to much higher levels now if xruns are avoided
> and stay at those high levels. If I push the cpu load too much so that
> they get transiently throttled from SCHED_ISO, after the Xrun the dsp
> load drops to half. Is this expected behaviour?

Yes.

Any xrun is pretty much guaranteed to blow the next audio cycle or
two.  Several together tend to "snowball" into a "avalanche".  Hitting
your CPU limit practically guaranteed that kind of realtime disaster.

If you grep your log file for 'client failure:', you'll probably find
that JACK has reacted to the deteriorating situation by shutting down
some of its clients.  The number of 'client failure:' messages is
*not* the number of clients shut down, there is some repetition (not
sure why).  This will give the actual number...

  $ grep '^client failure:' ${LOGFILE} | cut -f4 -d' ' | sort -u | wc -l

It would help if the test script reported this value.

In extreme cases like the following example, eleven of the twenty
clients were shut down by the JACK server.  You can see that clearly
in the blue line (DSP load) of the graph...

  http://www.joq.us/jack/benchmarks/sched-iso+compile/jack_test3-2.6.11-rc1-exp-200501222329.log
  http://www.joq.us/jack/benchmarks/sched-iso+compile/jack_test3-2.6.11-rc1-exp-200501222329.png

> Anyway the next patch works well in my environment. Jack, while I
> realise you're getting the results you want from Ingo's dropped
> privilege, dropped cpu limit patch I would appreciate you testing this
> patch. It is not clear yet what direction we will take, but even if we
> dont do this, it would be nice just because of the effort on my part.

Will do.  I appreciate your efforts, and want to see them reach a
working point of closure.  

Though I'm somewhat swamped today, I'll run it as soon as I can.

> This version of the patch has full priority support and both ISO_RR
> and ISO_FIFO.
>
> This is the patch to apply to 2.6.11-rc2-mm1:
> http://ck.kolivas.org/patches/SCHED_ISO/2.6.11-rc2-mm1/2.6.11-rc2-mm1-iso-prio-fifo.diff

-- 
  joq
