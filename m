Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVAESSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVAESSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVAESSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:18:16 -0500
Received: from mail.joq.us ([67.65.12.105]:37550 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262521AbVAESRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:17:36 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1104374603.9732.32.camel@krustophenia.net>
	<20050103140359.GA19976@infradead.org>
	<1104862614.8255.1.camel@krustophenia.net>
	<20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us>
	<1104865198.8346.8.camel@krustophenia.net>
	<1104878646.17166.63.camel@localhost.localdomain>
	<20050104175043.H469@build.pdx.osdl.net>
	<1104890131.18410.32.camel@krustophenia.net>
	<20050105115213.GA17816@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 05 Jan 2005 12:18:27 -0600
In-Reply-To: <20050105115213.GA17816@elte.hu> (Ingo Molnar's message of
 "Wed, 5 Jan 2005 12:52:13 +0100")
Message-ID: <87vfabd9jg.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> the RT-LSM thing is a bit dangerous because it doesnt really protect
> against a runaway, buggy app. So i think the right way to approach this
> problem is to not apply RT-LSM for the time being, but to provide an
> 'advanced latency needs' scheduling class that is _still_ safe even if
> the task is runaway, but behaves with near-RT priorities if the task is
> 'nice' (i.e. doesnt use up large amount of CPU time.)

You are right that a runaway SCHED_FIFO application can freeze the
system.  But, this really has nothing to do with the permissions
problem addressed by the realtime-lsm.  In fact, it is needed by
non-root users for running `nice -20', just as for SCHED_FIFO.

I have no objection to creating a "better" RT scheduling class than
SCHED_FIFO.  The "much-maligned" Mac OS X has a deadline scheduler
that works quite well for running JACK and its applications.

> so, could you try vanilla 2.6.10 (without LSM and without jackd running
> with RT priorities), with jackd set to nice -20? Make sure the
> jack-client process gets this priority too. Best to achieve this is to
> renice a shell to -20 and start up everything from there - the nice
> settings will be inherited. How does such an audio test compare to a
> test done with jackd running at SCHED_FIFO with RT priority 1?

For a quick comparison, I used a slightly modified version of the
jack_test3.2 script, that runs jackd without the -R (--realtime)
option...

                                 With -R        Without -R
                               (SCHED_FIFO)     (nice -20)

************* SUMMARY RESULT ****************
Total seconds ran . . . . . . :   300
Number of clients . . . . . . :    20
Ports per client  . . . . . . :     4
Frames per buffer . . . . . . :    64
*********************************************
Timeout Count . . . . . . . . :(    1)          (    1)         
XRUN Count  . . . . . . . . . :     2             2837          
Delay Count (>spare time) . . :     0                0          
Delay Count (>1000 usecs) . . :     0                0          
Delay Maximum . . . . . . . . :  3130   usecs    5038044   usecs
Cycle Maximum . . . . . . . . :   960   usecs    18802   usecs
Average DSP Load. . . . . . . :    34.3 %           44.1 %    
Average CPU System Load . . . :     8.7 %            7.5 %    
Average CPU User Load . . . . :    29.8 %            5.2 %    
Average CPU Nice Load . . . . :     0.0 %           20.3 %    
Average CPU I/O Wait Load . . :     3.2 %            5.2 %    
Average CPU IRQ Load  . . . . :     0.7 %            0.7 %    
Average CPU Soft-IRQ Load . . :     0.0 %            0.2 %    
Average Interrupt Rate  . . . :  1707.6 /sec      1677.3 /sec 
Average Context-Switch Rate . : 11914.9 /sec     11197.6 /sec 
*********************************************

This was not exactly the test you requested.  The LSM is still
present.  But, it makes no difference.  In fact, I used it to grant
nice privileges, since I didn't feel like running it as root.

But this is otherwise vanilla 2.6.10, and the two scheduling
algorithms are fairly represented.  Try it yourself, I think you'll
see similarly dramatic differences.

Note that 2.6.10 has by far the best realtime performance of any
vanilla Linux kernel I have ever tried.  Although, much better results
can be obtained with your Realtime Preemption patches, this is still a
very creditable result, quite usable for many relatively low-latency
applications.  Kudos to you and the many others who contributed to
this achievement.

> if this works out well then we could achieve something comparable to
> RT-LSM, via nice levels alone.

As you see, it does not work at all.
-- 
  joq
