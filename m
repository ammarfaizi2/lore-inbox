Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbUATSgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUATSf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:35:56 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:13504 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265680AbUATSdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:33:23 -0500
Message-ID: <400D746D.7030409@colorfullife.com>
Date: Tue, 20 Jan 2004 19:33:17 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: haakon.riiser@fys.uio.no
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux
 2.6
References: <20040120021353.39e9155e.akpm@osdl.org>
In-Reply-To: <20040120021353.39e9155e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haakon Riiser <haakon.riiser@fys.uio.no> wrote:

>What Qmail did was basically to use a named pipe as a trigger,
>where one program select()s on the FIFO file descriptor, waiting
>for another program to write() the FIFO.  Once select() returns,
>the listener close()s the FIFO (the data was not important,
>it was only used as a signal), does some work, then re-open()s
>the FIFO file, and ends up in the same select() waiting for the
>whole thing to happen again.
>
What drains the fifo?
As far as I can see the fifo is filled by the write syscalls, and 
drained by chance if both the reader and the writer have closed their 
handles.

>       for (;;) {
>                while ((fd = open("test.fifo", O_WRONLY | O_NONBLOCK)) < 0)
>                        ;
>                gettimeofday(&tv1, NULL);
>                if (write(fd, &fd, 1) == 1) {
>
xxx now a thread switch

>                        gettimeofday(&tv2, NULL);
>                        fprintf(stderr, "dt = %f ms\n",
>                                (tv2.tv_sec - tv1.tv_sec) * 1000.0 +
>                                (tv2.tv_usec - tv1.tv_usec) / 1000.0);
>                }
>                if (close(fd) < 0) {
>                        perror("close");
>  
>
If a thread switch happens in the indicated line, then the reader will 
loop, until it's timeslice expires - one full timeslice delay between 
the two gettimeofday() calls.

Running the reader with nice -20 resulted in delays of 200-1000 ms for 
each write call, nice 20 resulted in no slow calls. In both cases 100% 
cpu load.

--
    Manfred

