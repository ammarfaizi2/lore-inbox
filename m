Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVAPBsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVAPBsU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 20:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVAPBsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 20:48:19 -0500
Received: from mail.joq.us ([67.65.12.105]:26752 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262379AbVAPBsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 20:48:13 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	<1105132348.20278.88.camel@krustophenia.net>
	<20050107134941.11cecbfc.akpm@osdl.org>
	<20050107221059.GA17392@infradead.org>
	<20050107142920.K2357@build.pdx.osdl.net>
	<87mzvkxxck.fsf@sulphur.joq.us> <20050111212139.GA22817@elte.hu>
	<87ekgnwaqx.fsf@sulphur.joq.us> <20050115144302.GG10114@elte.hu>
	<87r7kmuw3i.fsf@sulphur.joq.us>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 15 Jan 2005 19:48:15 -0600
In-Reply-To: <87r7kmuw3i.fsf@sulphur.joq.us> (Jack O'Quin's message of "Sat,
 15 Jan 2005 17:10:57 -0600")
Message-ID: <87r7kmf8kg.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ingo Molnar <mingo@elte.hu> writes:
>> could you try the patch below? The above patch wasnt enough. With the
>> patch below we turn off the starvation limits for nice --20 tasks only. 
>> This is still a hack only. If we cannot make nice --20 perform like
>> RT-prio-1 then there's some problem with SCHED_OTHER scheduling.

I made your suggested sched.c change.  It works much better.  I was
not able to modify JACK (for reasons explained in an earlier message).
So, this test has the same interference problems with non-realtime
threads.  Of course, I don't know for sure that they are the source of
our xruns and long delays, but that's my suspicion.

I didn't have the same problems with normal processes being
unresponsive (compared to the previous sched.c patch).  The test ran
normally, with about the same results we saw before for the nice --20
experiments.

*** Terminated Sat Jan 15 18:15:13 CST 2005 ***
************* SUMMARY RESULT ****************
Total seconds ran . . . . . . :   300
Number of clients . . . . . . :    20
Ports per client  . . . . . . :     4
Frames per buffer . . . . . . :    64
*********************************************
Timeout Count . . . . . . . . :(    1)
XRUN Count  . . . . . . . . . :    47
Delay Count (>spare time) . . :     0
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . : 500544   usecs
Cycle Maximum . . . . . . . . :  1086   usecs
Average DSP Load. . . . . . . :    36.1 %
Average CPU System Load . . . :     8.2 %
Average CPU User Load . . . . :    26.3 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.4 %
Average CPU IRQ Load  . . . . :     0.7 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1703.3 /sec
Average Context-Switch Rate . : 11600.6 /sec
*********************************************

I think this means the starvation test was not the problem.  So far,
I've seen no proof that there is any problem with the 2.6.10
scheduler, just some evidence that nice --20 does not work for
multi-threaded realtime audio.

If someone can suggest a way to run certain threads of a process with
a different nice value than the others, I can probably hack that into
JACK in some crude way.  That should tell us whether my intuition is
right about the source of scheduling interference.  

Otherwise, I'm out of ideas at the moment.  I don't think SCHED_RR
will be any different from SCHED_FIFO in this test.  Even if it were,
I'm not sure what that would prove.
-- 
  joq
