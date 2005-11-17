Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVKQRM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVKQRM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVKQRM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:12:59 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:6432 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932427AbVKQRM6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:12:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WV391Fr7RSOhjjf/uEfJFuV3jSpboVwQNKQTTBIXBMZHFikqwmdPQPj2aHfH7PhAsi3r4LcZDozu25m/qBpzOGpwDduWzoA8Zi4V6+tN9Gur7K9CB1/qXSonc0gygB4SoS8PZ7Nj/zTGA0wTt1GYu29O9dNnFkIaU33n2KU3kUE=
Message-ID: <29495f1d0511170912x2cceac78w766f0c800ee3f718@mail.gmail.com>
Date: Thu, 17 Nov 2005 09:12:58 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Dag Nygren <dag@newtech.fi>
Subject: Re: nanosleep with small value
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051117163047.30293.qmail@dag.newtech.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117163047.30293.qmail@dag.newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/05, Dag Nygren <dag@newtech.fi> wrote:
>
> Hi,
>
> seeing a strange thing happening here:
> using nanosleep() with a smallish value gives me a very long sleeptime?
>
> Is this because of a context switch being forced?
> Shouldn't the scheduler change affect that?
>
> The test program:
> ===================================
> #include <time.h>
> #include <sched.h>
> #include <stdio.h>
>
> void delay_ns(unsigned long dly)
> {
>         static struct timespec time;
>         int err;
>         {
>                 time.tv_sec = 0;
>                 time.tv_nsec = dly;
>                 err = nanosleep(&time, NULL);
>                 if (err) {
>                         perror( "nanosleep failed" );
>                 }
>         }
> }
>
>
> main()
> {
>         int i;
>
>         struct sched_param mysched;
>         int err;
>
>         if ( sched_getparam( 0, &mysched ) != 0 )
>                 perror( "" );
>         else {
>                 mysched.sched_priority = sched_get_priority_max(SCHED_FIFO);
>                 err = sched_setscheduler(0, SCHED_FIFO, &mysched);
>                 if( err != 0 ) {
>                         fprintf (stderr,"sched_setscheduler returned: %d\n",
> err );
>                         perror( "" );
>                 }
>         }
>
>         for (i=0; i < 1000; i++)
>                 delay_ns(1000UL);
> }
> ==================================
> The result running this is:
> % time ./tst
>
> real    0m8.000s
> user    0m0.000s
> sys     0m0.000s
>
> I would have expected about 1000 * 1 us + overhead,
> but 8 seconds ????

Which kernel, what value of HZ? In either case, it's absurd to assume
that the kernel is going to provide you 1 microsecond resolution in
2.6 mainline, as the best HZ value is 1000 (1 millisecond). And we
don't busy-wait ever in nanosleep(). So the fastest your loop can run
is 1000 * 1 ms = 1 second. That's assuming the only time-consuming
thing is sleeping (minimal overhead). But, in sys_nanosleep(), we
convert nanoseconds to jiffies and add 1 if you requested any sleep
time. So,

HZ = 100
     1000 * (10 + 1 ms) = 11 s
HZ = 250
     1000 * (4 + 1 ms) = 5 s
HZ = 1000
     1000 * (1 + 1 ms) = 2 s (which is what Dick Johnson reported).

Note, that with HZ=250, there might be some extra rounding occurring
timespec_to_jiffies() that I've forgotten.

So 8 s may not be terribly unreasonable. I don't know, though, what's
add the 3 seconds if you're using 250.

Thanks,
Nish
