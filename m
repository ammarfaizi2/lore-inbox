Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVAMFoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVAMFoB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVAMFoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:44:01 -0500
Received: from mail.joq.us ([67.65.12.105]:38576 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261162AbVAMFnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:43:51 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050110212019.GG2995@waste.org>
	<200501111305.j0BD58U2000483@localhost.localdomain>
	<20050111191701.GT2940@waste.org>
	<20050111125008.K10567@build.pdx.osdl.net>
	<20050111205809.GB21308@elte.hu>
	<20050111131400.L10567@build.pdx.osdl.net>
	<20050111212719.GA23477@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 12 Jan 2005 23:44:34 -0600
In-Reply-To: <20050111212719.GA23477@elte.hu> (Ingo Molnar's message of
 "Tue, 11 Jan 2005 22:27:19 +0100")
Message-ID: <87fz15j325.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Chris Wright <chrisw@osdl.org> wrote:
>
>> Hmm, I wonder if this could have anything to do with it.  These are
>> within striking range:
>> 
>>   PID COMMAND          NI PRI
>>     9 events/1        -10  34
>>   931 kcryptd/1       -10  33
>>   930 kcryptd/0       -10  34
>>     8 events/0        -10  34
>>   892 ata/1           -10  34
>>   891 ata/0           -10  34
>>  3747 udevd           -10  33
>>    26 kacpid          -10  31
>>   238 aio/1           -10  34
>>   237 aio/0           -10  31
>>   117 kblockd/1       -10  34
>>   116 kblockd/0       -10  34
>>    10 khelper         -10  34
>
> you are right, i forgot about kernel threads. If they are nice -10 on
> Jack's system too then they are within striking range indeed, especially
> since they are typically idle and if then they are active for short
> bursts of time and get the maximum boost. Jack, could you renice these
> to -5, to make sure they dont interfere?

OK, I reran with just 5 processes reniced from -10 to -5.  On my
system they were: events, khelper, kblockd, aio and reiserfs.  In
addition, I reniced loop0 from -20 to -5.

I made no changes to the kernel, yet.  It's still vanilla 2.6.10 with
realtime-lsm built-in.

A whole bunch of jackd, sh and jack_test3_client processes are ran at
nice -20.

It didn't make any significant difference...

                                 With -R        Without -R        Without -R
                               (SCHED_FIFO)     (nice --20)    (kprocs reniced)

************* SUMMARY RESULT ****************
Total seconds ran . . . . . . :   300
Number of clients . . . . . . :    20
Ports per client  . . . . . . :     4
Frames per buffer . . . . . . :    64
*********************************************
Timeout Count . . . . . . . . :(    1)           (    1)        (    1)	       
XRUN Count  . . . . . . . . . :     2                43             49	       
Delay Count (>spare time) . . :     0                 0              0	       
Delay Count (>1000 usecs) . . :     0                 0              0	       
Delay Maximum . . . . . . . . :  3130 usecs    501374 usecs   501415 usecs
Cycle Maximum . . . . . . . . :   960 usecs      1036 usecs      902 usecs 
Average DSP Load. . . . . . . :    34.3 %          34.3 %         34.7 %     
Average CPU System Load . . . :     8.7 %           7.8 %          8.5 %     
Average CPU User Load . . . . :    29.8 %          25.3 %         23.9 %     
Average CPU Nice Load . . . . :     0.0 %           0.0 %          0.0 %     
Average CPU I/O Wait Load . . :     3.2 %           0.1 %          0.0 %     
Average CPU IRQ Load  . . . . :     0.7 %           0.7 %          0.7 %     
Average CPU Soft-IRQ Load . . :     0.0 %           0.0 %          0.0 %     
Average Interrupt Rate  . . . :  1707.6 /sec     1692.9 /sec    1695.7 /sec  
Average Context-Switch Rate . : 11914.9 /sec    11611.2 /sec   11603.6 /sec  
*********************************************


One major problem: this `nice --20' hack affects every thread, not
just the critical realtime ones.  That's not what we want.  Audio
applications make very conscious choices which threads run with high
priority and which do not.

That JACK scheduling test doesn't have any graphical component, so it
cannot detect the problems of audio applications with GTK or Qt
threads running at nice -20 which will interfere with their own signal
processing loop.  I expect that to cause a horrible mess.

Plus, we maintain JACK for several platforms including GNU/Linux,
FreeBSD, and Mac OS X.  IRIX support is planned soon, possibly Solaris
some day.  I would really prefer for Linux to support genuine POSIX
realtime with SCHED_FIFO scheduling.  Since that is our primary
development platform, it makes our code a lot more portable.

And, this is not just about JACK.  We could change to call nice()
instead of pthread_setschedparam() on Linux, but that about all the
other audio applications?  I don't think this is a reasonable thing to
ask of people.  It would take a year just to get them all changed,
like herding cats.

This whole approach seems like a "dry well" to me.

Tomorrow, I'll try the test again after making a new kernel with
STARVATION_LIMIT set to zero.  

Anything else I should try?
-- 
  joq
