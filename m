Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268609AbRG3OPa>; Mon, 30 Jul 2001 10:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268614AbRG3OPU>; Mon, 30 Jul 2001 10:15:20 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:59396 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S268609AbRG3OPH>;
	Mon, 30 Jul 2001 10:15:07 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200107301414.QAA01744@nbd.it.uc3m.es>
Subject: Re: what's the semaphore in requests for?
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <20010730102418.G1981@suse.de> "from Jens Axboe at Jul 30, 2001
 10:24:18 am"
To: Jens Axboe <axboe@suse.de>
Date: Mon, 30 Jul 2001 16:14:53 +0200 (CEST)
CC: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Jens Axboe wrote:"
> http://asimov.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-30/0165.html

You say there [of the semaphore field in requests]:

  Drivers can use it if they want completion to be signalled for a request 
  (see end_that_request_last). However, see 2.4.7 where it's not ->waiting 
  and the interface changed. 

end_that_request_ up's the semaphore if it's nonnull, but for that to make
sense, someone must down it. Nobody does (in ll_rw_blk.c), So I assume it's
entirely for my use in controlling access to the request.

So I don't believe it's involved in my problem.


> > 2 processors + 1 userspace helper daemon on device = no bug 
> > 2 processors + 2 userspace helper daemon on device = bug  (lockup)
> > 1 processors + 1 userspace helper daemon on device = no bug 
> > 1 processors + 2 userspace helper daemon on device = no bug 

> And I'll restate here what I said then too -- SHOW THE CODE! Or send me
> a crystal ball and I'll be happy to solve your races for you.

Crystal balls would be nice. I'll see if I can get it down to something
sendable. I can confirm the above results since I tried them again. After
about 1.2GB of transfers, one cpu ended up not listening to NMI and the
other was stuck in a spinlock (__down_writelock_failed, from memory),
having called my request fn from the generic_unplug_device function,
which in turn called a write spinlock on the device private request
queue. The spinlocks aren't around sections of code that can sleep.

Peter
