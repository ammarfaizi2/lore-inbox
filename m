Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVAKVZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVAKVZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVAKVZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:25:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:13506 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262841AbVAKVV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:21:57 -0500
Date: Tue, 11 Jan 2005 22:21:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111212139.GA22817@elte.hu>
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <20050107221059.GA17392@infradead.org> <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzvkxxck.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> The numbers I reported yesterday were so bad I couldn't figure out why
> anyone even thought it was worth trying.  Now I realize why. 
> 
> When Ingo said to try "nice -20", I took him literally, forgetting
> that the stupid command to achieve a nice value of -20 is `nice --20'.
> So I was actually testing with a nice value of 19.  Bah!  No wonder it
> sucked.
> 
> Running `nice --20' is still significantly worse than SCHED_FIFO, but
> not the unmitigated disaster shown in the middle column.  But, this
> improved performance is still not adequate for audio work.  The worst
> delay was absurdly long (~1/2 sec).
> 
> Here are the corrected results...
> 
>                                  With -R        Without -R      Without -R
>                                (SCHED_FIFO)     (nice -20)      (nice --20)
> 
> ************* SUMMARY RESULT ****************
> Total seconds ran . . . . . . :   300
> Number of clients . . . . . . :    20
> Ports per client  . . . . . . :     4
> Frames per buffer . . . . . . :    64
> *********************************************
> Timeout Count . . . . . . . . :(    1)          (    1)          (    1)
> XRUN Count  . . . . . . . . . :     2             2837               43
> Delay Count (>spare time) . . :     0                0                0
> Delay Count (>1000 usecs) . . :     0                0                0
> Delay Maximum . . . . . . . . :  3130 usecs    5038044 usecs   501374 usecs
> Cycle Maximum . . . . . . . . :   960 usecs      18802 usecs     1036 usecs
> Average DSP Load. . . . . . . :    34.3 %           44.1 %         34.3 %    

what kind of non-audio workload was there during this test? 43 xruns
arent nice but arent that bad either.

plus, is it 100% sure that all audio threads inherited the nice --20
priority - including the client threads? Nornally jackd does a
setscheduler for the client threads so that they get boosted to
SCHED_FIFO, but there is no parallel to that in the nice --20 case, did
you do that manually (or did you start the clients up from the nice --20
shell too?))

If the nice --20 priority setup is perfect and there are still xruns
then could you try the following hack, change this line in
kernel/sched.c:

 #define STARVATION_LIMIT        (MAX_SLEEP_AVG)

to:

 #define STARVATION_LIMIT        0

this will turn off starvation checking, for testing purposes. (to see
whether there's anything else but anti-starvation causing xruns.)

	Ingo
