Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262553AbTCRSYF>; Tue, 18 Mar 2003 13:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262554AbTCRSYF>; Tue, 18 Mar 2003 13:24:05 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:4829 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262553AbTCRSYB>;
	Tue, 18 Mar 2003 13:24:01 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200303181834.VAA04953@sex.inr.ac.ru>
Subject: Re: 2.4 delayed acks don't work, fixed
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 18 Mar 2003 21:34:50 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, ak@suse.de
In-Reply-To: <20030317082553.GA1324@dualathlon.random> from "Andrea Arcangeli" at Mar 17, 3 09:25:53 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Apparently linux only waits 0.2 at max,

This is not true, the maximum is 0.5 in your case.


> 1) the delayed ack timer destroy the ato value resetting it to the min
>    value (40msec) and the quickack mode is activated (pingpong = 0)

This is not true, delack timer inflates ato. pingpong=0 is not quickack
mode, it means that the session is unidirectional stream, which
is correct in your case.


> 2) the pingpong is never re-activated,

It MUST NOT. It is activated on transactional sessions only.


> 3) the ato averaging logic during the packet reception will not inflate
>    the ato if "m > ato" which is obviously the case after a delack timer
>    triggered and in turn after the ato is been deflated to its min value

When m > ato, the sample is invalid, apparently it is triggered by
a random delay at sender. When real ato increases, increase
is made in delack timer, not through estimator.



> 4) the logic that bounds the delayed ack to the srtt >> 3 looks also
>    risky, using the rto looks much safer to me there, to be sure
>    those delacks aren't going to trigger too early

It is necessary to provide more or less sane behaviour on interactive
session when ato > 100msec. Clamping by rto just does not make any sense.


> 5) I suspect the current delack algorithm can wait more than 2 packets,

Yes, when window is not opening, it is not required. Delack is send
when window is advanced.


Shortly, I still do not understand what kind of pathalogy happens in your
case (particularly, difference in adevrtised window before and after
applying your patch is confusing _a_ _lot_, I really would like
to look at larger tcpdump, covering beggining of the sssion),
but all the 5 items are surely wrong.

Unnumbered 6th one may be right, the heuristic with expansion twice
have no explanation, I think it can be relaxed even more.

Alexey
