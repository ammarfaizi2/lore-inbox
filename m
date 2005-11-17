Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVKQQzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVKQQzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVKQQzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:55:17 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:53513 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932398AbVKQQzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:55:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051117163047.30293.qmail@dag.newtech.fi>
References: <20051117163047.30293.qmail@dag.newtech.fi>
X-OriginalArrivalTime: 17 Nov 2005 16:55:07.0105 (UTC) FILETIME=[A9C92D10:01C5EB97]
Content-class: urn:content-classes:message
Subject: Re: nanosleep with small value
Date: Thu, 17 Nov 2005 11:55:06 -0500
Message-ID: <Pine.LNX.4.61.0511171146310.9422@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: nanosleep with small value
Thread-Index: AcXrl6nV5lcIhCGQR9GXx0EUQwwqiw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Dag Nygren" <dag@newtech.fi>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Nov 2005, Dag Nygren wrote:

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
>        static struct timespec time;
>        int err;
>        {
>                time.tv_sec = 0;
>                time.tv_nsec = dly;
>                err = nanosleep(&time, NULL);
>                if (err) {
>                        perror( "nanosleep failed" );
>                }
>        }
> }
>
>
> main()
> {
>        int i;
>
>        struct sched_param mysched;
>        int err;
>
>        if ( sched_getparam( 0, &mysched ) != 0 )
>                perror( "" );
>        else {
>                mysched.sched_priority = sched_get_priority_max(SCHED_FIFO);
>                err = sched_setscheduler(0, SCHED_FIFO, &mysched);
>                if( err != 0 ) {
>                        fprintf (stderr,"sched_setscheduler returned: %d\n",
> err );
>                        perror( "" );
>                }
>        }
>
>        for (i=0; i < 1000; i++)
>                delay_ns(1000UL);
> }
> ==================================
> The result running this is:
> % time ./tst
>
> real    0m8.000s
> user    0m0.000s
> sys     0m0.000s

On an unprivilged account, I get this with
version 2.6.13.4

Script started on Thu 17 Nov 2005 11:44:47 AM EST
LINUX> time ./xxx
sched_setscheduler returned: -1
Operation not permitted

real	0m2.000s
user	0m0.000s
sys	0m0.001s
LINUX> uname -r
2.6.13.4
LINUX> exit
Script done on Thu 17 Nov 2005 11:45:07 AM EST

>From the root account where the scheduler could be set:

Script started on Thu 17 Nov 2005 11:45:29 AM EST
[root@chaos root]# time /tmp/xxx

real	0m2.001s
user	0m0.000s
sys	0m0.001s
[root@chaos root]# exit

Script done on Thu 17 Nov 2005 11:45:53 AM EST

... essentially the same thing. And 2 seconds, not 8.

The HZ value for my kernel is 1000. It you are at 100 HZ,
that might explain it.

Note that nanosleep() doesn't claim to be able to sleep
less than the resolution of some kernel timer. It just takes
parameters in seconds and nanoseconds.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
