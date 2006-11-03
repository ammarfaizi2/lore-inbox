Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753383AbWKCRJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbWKCRJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbWKCRJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:09:58 -0500
Received: from pop-tawny.atl.sa.earthlink.net ([207.69.195.67]:30199 "EHLO
	pop-tawny.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1753383AbWKCRJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:09:57 -0500
Date: Fri, 3 Nov 2006 12:09:50 -0500 (EST)
From: Brent Baccala <cosine@freesoft.org>
X-X-Sender: baccala@debian.freesoft.org
To: Jens Axboe <jens.axboe@oracle.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
In-Reply-To: <20061103160212.GK13555@kernel.dk>
Message-ID: <Pine.LNX.4.64.0611031204110.20496@debian.freesoft.org>
References: <Pine.LNX.4.64.0611030311430.25096@debian.freesoft.org>
 <20061103122055.GE13555@kernel.dk> <Pine.LNX.4.64.0611031049120.7173@debian.freesoft.org>
 <20061103160212.GK13555@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006, Jens Axboe wrote:

> On Fri, Nov 03 2006, Brent Baccala wrote:
>>
>> ...
>>
>> The enqueues still take a noticable amount of time, though, just a lot
>> less than before.  They average 1 second total.  That's 100 one-MB
>> reads, broken down into 128 KB blocks, I suppose, for a total of 800
>> low-level reads.  Setting nr_requests higher (2048) doesn't seem to do
>> any more good.
>>
>> I can see that you've put me on the right track, but I am still
>> puzzling... any idea what the remaining second is being used for?
>
> Try to time it (visual output of the app is not very telling, and it's
> buffered) and then apply some profiling.
>

Yeah, I did time it.  I bracketed the enqueues with calls to
gettimeofday().  It takes them about a second to run, and I made sure
that the fprintfs were outside the timing checks.  Here's the actual code:


     fprintf(stderr, "Enqueues starting\n");
     gettimeofday(&tv1, NULL);

     for (i=0; i<NUMAIOS; i++) {

         memset(&iocb[i], 0, sizeof(struct iocb));

         iocb[i].aio_lio_opcode = IOCB_CMD_PREAD;
         iocb[i].aio_fildes = fd;
         iocb[i].aio_buf = (unsigned long) buffer[i];
         iocb[i].aio_nbytes = BUFFER_BYTES;
         iocb[i].aio_offset = BUFFER_BYTES * i;
         /* aiocb[i].aio_offset = 0; */

         iocbp[0] = &iocb[i];
         if (io_submit(aio_default_context, 1, iocbp) != 1) {
             perror("");
             fprintf(stderr, "Can't enqueue aio_read %d\n", i);
         }
     }

     gettimeofday(&tv2, NULL);
     subtract_timeval(&tv2, &tv1);
     sprint_timeval(strbuf, &tv2);
     fprintf(stderr, "Enqueues complete in %s\n", strbuf);


And the output:


baccala@debian ~/src/endgame$ time ./testaio
Enqueues starting
Enqueues complete in 1.187s

real    0m5.335s
user    0m0.001s
sys     0m0.760s
baccala@debian ~/src/endgame$


What kind of profiling did you have in mind?  Kernel profiling?  As
you can see, its user time is basically nil.



 					-bwb

 					Brent Baccala
 					cosine@freesoft.org
