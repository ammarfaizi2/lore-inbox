Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154026AbQAYG45>; Tue, 25 Jan 2000 01:56:57 -0500
Received: by vger.rutgers.edu id <S154015AbQAYGpK>; Tue, 25 Jan 2000 01:45:10 -0500
Received: from [151.4.188.55] ([151.4.188.55]:2192 "HELO maticad") by vger.rutgers.edu with SMTP id <S154137AbQAYGnz>; Tue, 25 Jan 2000 01:43:55 -0500
Message-ID: <02e701bf6721$8a1077e0$1f0104c0@maticad>
From: "Davide Libenzi" <davidel@maticad.it>
To: "David Schwartz" <davids@webmaster.com>, <dg50@daimlerchrysler.com>, <linux-kernel@vger.rutgers.edu>
References: <000f01bf66da$872a6730$021d85d1@youwant.to>
Subject: Re: SMP Theory (was: Re: Interesting analysis of linux kernel threading by IBM)
Date: Tue, 25 Jan 2000 11:47:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Sender: owner-linux-kernel@vger.rutgers.edu

Tuesday, January 25, 2000 3:18 AM
David Schwartz <davids@webmaster.com> wrote :

> If you wanted completely separate memory spaces for each processor, the
> current hardware will let you have it. Just separate the address space
into
> logical chunks and code each processor only to use its chunk. The current
> hardware design lets you do exactly what you are suggesting. And if one
> processor does need to acceess the memory earmarked for another, the
current
> hardware provides a fast way to do it.

100% agree, and is faster than an ethernet connection between N separated UP
machines.
Probably the cost of a N way SMP machine is higher than N single UP machines
( at least
for PCs ) but this isn't linux-business, isn't it ?

The cache misses cost that an SMP architecture must sustain is :

CMTc = Nm * F( Np * Ms * WTR )

where :

CMTc = cache misses time cost
Ms = memory size shared between :
Np = number of processes sharing Ms
WTR = write touch rate ( statistical average ) at which the Np processes
write access Ms
F = a probably non linear function depending on architecture, etc ...
Nm = number of memory shares


This is an absolute value that _must_ be compared ( weighted ) with the time
spent by the single processes in computing to ponder if the application
design
we've chosen for SMP is right, or even more, if SMP is the correct target
for
our app.


Take at the rendering pipeline example.
We've each step read a bit of data ( think as from stdin ), do a relatively
long compute on data and write another kind of data ( think as to stdout )
to be processed by the next pipeline step.
The step pattern can be expressed as :

RCCCCCCCCCCCCW

where R = read, C = compute and W = write.
Say we've a six step pipeline, so :

Nm = 5 ( 6 - 1 )
Np = 2
Ms = tipically small ( triangles, scanlines, ...)
WTR = small compared with the computing times

We can think as Ms be a ( relatively big ) object set.
This increase Ms but lengthen the computing path, so the weighted cost
equals.
This is, IMVHO, a good candidate for SMP.


Consider now a typical data centric application in which we've a continuous
read-write cycles along the entire data set :

RCCWRCRWCCRCWC

If we can't split this data set into autonomous chunks of data, we have :

Nm = the number threads we've split the app
Np = typically equal to Nm
Ms = probably the entire data set
WTR = typically high coz the nature of the application

This is not a good candidate for SMP.

Typical examples of these applications are the ones in which the lower steps
of the computing path must access to data computed ( read as
write-accessed ) from
most of previous steps.



Davide.

--
All this stuff is IMVHO



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
