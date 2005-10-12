Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVJLPUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVJLPUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVJLPUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:20:39 -0400
Received: from spirit.analogic.com ([204.178.40.4]:52236 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964809AbVJLPUi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:20:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <81b0412b0510120810o6d06a678q1d4a9787687b9bfa@mail.gmail.com>
References: <434CC144.6000504@boi.at> <81b0412b0510120548k3464d355ne75cce4e5edcce1a@mail.gmail.com> <1129127947.8561.44.camel@lade.trondhjem.org> <81b0412b0510120810o6d06a678q1d4a9787687b9bfa@mail.gmail.com>
X-OriginalArrivalTime: 12 Oct 2005 15:20:27.0779 (UTC) FILETIME=[79C5CD30:01C5CF40]
Content-class: urn:content-classes:message
Subject: Re: blocking file lock functions (lockf,flock,fcntl) do not return after timer signal
Date: Wed, 12 Oct 2005 11:20:26 -0400
Message-ID: <Pine.LNX.4.61.0510121112060.4302@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: blocking file lock functions (lockf,flock,fcntl) do not return after timer signal
Thread-Index: AcXPQHnPC8tIdzYqQ4KpwSNAwqwfmg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
Cc: "Trond Myklebust" <trond.myklebust@fys.uio.no>, <boi@boi.at>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Oct 2005, Alex Riesen wrote:

> On 10/12/05, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>> on den 12.10.2005 Klokka 14:48 (+0200) skreiv Alex Riesen:
>>> On 10/12/05, "Dieter Müller (BOI GmbH)" <dieter.mueller@boi.at> wrote:
>>>> bug description:
>>>>
>>>> flock, lockf, fcntl do not return even after the signal SIGALRM  has
>>>> been raised and the signal handler function has been executed
>>>> the functions should return with a return value EWOULDBLOCK as described
>>>> in the man pages
>>
>> Works for me on a local filesystem.
>>
>> Desktop$ ./gnurr gnarg
>> locking...
>> timeout
>> timeout
>> timeout
>> timeout
>> timeout
>
> Doesn't look so. I'd expect "flock: EWOULDBLOCK" and "sleeping" after
> the first timeout.

As I told you, you use sigaction(). Also flock() will not block
unless there is another open on the file. The code will run to
your blocking read(), wait 10 seconds, get your "timeout" from
the signal handler, then read() will return with -1 and ERESTARTSYS
in errno as required.

Also, using a 'C' runtime library call like write() in a signal-
handler is a bug.


#include <unistd.h>
#include <sys/time.h>
#include <sys/file.h>
#include <time.h>
#include <signal.h>

void alrm(int sig)
{
     write(2, "timeout\n", 8);
}

int main(int argc, char* argv[])
{
     struct sigaction sa;
     struct itimerval tv = {
         .it_interval = {.tv_sec = 10, .tv_usec = 0},
         .it_value = {.tv_sec = 10, .tv_usec = 0},
     };
     struct itimerval otv;

     sigaction(SIGALRM, NULL, &sa);
     sa.sa_handler = alrm;
     sa.sa_flags = 0;
     sigaction(SIGALRM, &sa, NULL);


//    signal(SIGALRM, alrm);
     setitimer(ITIMER_REAL, &tv, &otv);
     int fd = open(argv[1], O_RDWR);
     if ( fd < 0 )
     {
         perror(argv[1]);
         return 1;
     }
     printf("locking...\n");
     if ( flock(fd, LOCK_EX) < 0 )
     {
         perror("flock");
         return 1;
     }
     printf("sleeping...\n");
     int ch;
     read(0, &ch, 1);
     close(fd);
     return 0;
}

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
