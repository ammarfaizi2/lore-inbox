Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265664AbUATTXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUATTWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:22:49 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:43566 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S265664AbUATTWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:22:20 -0500
Date: Tue, 20 Jan 2004 20:22:16 +0100
From: Haakon Riiser <haakon.riiser@fys.uio.no>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-ID: <20040120192216.GA7685@s.chello.no>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040120021353.39e9155e.akpm@osdl.org> <400D746D.7030409@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400D746D.7030409@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Manfred Spraul]

> What drains the fifo?
> As far as I can see the fifo is filled by the write syscalls, and 
> drained by chance if both the reader and the writer have closed their 
> handles.

That's correct, and that was my intention since this is apparently
how it works in Qmail.  Every time the listener's select() returns,
the FIFO is immediately close()d and the first thing the writer
does after writing it's single trigger byte is also to close() its
end of the FIFO.

>>      for (;;) {
>>               while ((fd = open("test.fifo", O_WRONLY | O_NONBLOCK)) < 0)
>>                       ;
>>               gettimeofday(&tv1, NULL);
>>               if (write(fd, &fd, 1) == 1) {
>>
> xxx now a thread switch
> 
>>                       gettimeofday(&tv2, NULL);
>>                       fprintf(stderr, "dt = %f ms\n",
>>                               (tv2.tv_sec - tv1.tv_sec) * 1000.0 +
>>                               (tv2.tv_usec - tv1.tv_usec) / 1000.0);
>>               }
>>               if (close(fd) < 0) {
>>                       perror("close");
>> 
>>
> If a thread switch happens in the indicated line, then the reader will 
> loop, until it's timeslice expires - one full timeslice delay between 
> the two gettimeofday() calls.

Exactly.  But on 2.6, the delay between the two gettimeofday()
calls are sometimes up to 300 ms, which is 300 timeslices in
2.6, right?  I have never observed more than _one_ timeslice
delay in 2.4.

> Running the reader with nice -20 resulted in delays of 200-1000 ms for 
> each write call, nice 20 resulted in no slow calls. In both cases 100% 
> cpu load.

But when the listener and the writer have the same nice value,
how is it possible to have a delay of 300 ms?  Both the writer
and the listener are ready to run, so wouldn't a 300 ms delay
mean that the listener was given the CPU 300 times in a row?

-- 
 Haakon
