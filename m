Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266130AbUF2Wxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbUF2Wxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbUF2Wxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:53:35 -0400
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:63649 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266130AbUF2Wxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:53:30 -0400
References: <313680C9A886D511A06000204840E1CF08F42FA3@whq-msgusr-02.pit.comms.marconi.com>
Message-ID: <cone.1088549572.329112.11374.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: =?ISO-8859-1?Q?Povolotsky=2C?= Alexander 
	<Alexander.Povolotsky@marconi.com>
Cc: =?ISO-8859-1?B?J2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcn?= 
	<linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?B?J2FuZHJlYmFsc2FAYWx0ZXJuLm9yZyc=?= 
	<andrebalsa@altern.org>,
       =?ISO-8859-1?B?J1JpY2hhcmQgRS4gR29vY2gn?= <rgooch@atnf.csiro.au>,
       =?ISO-8859-1?B?J0luZ28gTW9sbmFyJw==?= <mingo@elte.hu>,
       =?ISO-8859-1?B?J3JtbEB0ZWNoOS5uZXQn?= <rml@tech9.net>,
       =?ISO-8859-1?B?J2FrcG1Ab3NkbC5vcmcn?= <akpm@osdl.org>
Subject: Re: Linux scheduler (scheduling) questions
Date: Wed, 30 Jun 2004 08:52:52 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-11374-1088549572-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-11374-1088549572-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Povolotsky, Alexander writes:

> I  have "general"  Linux  OS scheduling  questions, especially with regards
> as those apply to the (latest) Linux  2.6  scheduler features (would really
> appreciate if whether/when/while answering those questions listed  below,
> you could pinpoint differences between Linux 2.6 and Linux 2.4 !): 
> 
> 0.  I was told that the Linux kernel could be configured with one of the 3
> (? ) different scheduling policies - could someone describe       
>      those to me in details ?

Three different policies are currently supported:
SCHED_NORMAL (also known as SCHED_OTHER) has a soft priority mechanism 
over the 'nice' range of -20 to +19 (static priority of 100-139) which 
decides according to the priority which task goes first, and how much 
timeslice it gets. This system dynamically alters the priority to allow 
interactive tasks to go first, and is designed to prevent starvation of 
lower priority tasks with an expiration policy. 

SCHED_RR is a fixed real time policy over the static range of 0-99 where a 
lower number (higher priority) task will repeatedly go ahead of _any_ tasks 
lower priority than itself. It is called RR because if multiple tasks are at 
the same priority it will Round Robin between those tasks. 

SCHED_FIFO is a fixed real time policy the static range of 0-99 where a
lower number (higher priority) task will repeatedly go ahead of _any_ tasks
lower priority than itself. Unlike RR, if a task does not give up the cpu it 
will run indefinitely even if other tasks are the same static priority as 
itself.

Unprivileged users are not allowed to set SCHED_RR or SCHED_FIFO because of 
the real risk of these tasks causing starvation.

> 1.   How rescheduling is "induced" in above scheduling policies ?
>       Does at least one of above mentioned scheduling policies uses "clock
> tick" as a scheduling event ?

Preemption is built into this mechanism where any higher priority task will 
preempt the current running task at any time. SCHED_NORMAL tasks have a 
timeout policy based on scheduler_tick that allows other tasks of the same 
priority to run and considers that task for expiration. SCHED_RR tasks have 
a timeout policy also based on scheduler tick that allows tasks of the same 
priority to run. SCHED_FIFO tasks never time out.

> 2.  Linux 2.6 (I was told it is the same for Linux 2.4.21-15) has priorities
> 0-99 for RT priorities and 100-139 for normal   (SCHED_NORMAL)   tasks.
> 
>> I presume that priorities 0-99 are "recommended" (or enforced ?) for
>> Linux kernel "native" tasks ... and "out or reach" for application
>> tasks (unless one dares to merge application into the Linux kernel,
>> masquerading it as a "system level command" - did anyone tried this ? -
>> I presume it is not recommended ...  )  ?

See above.

> Under what priority the OS system calls are executed ?

The kernel threads run at different priorities dependent on what they do. 
Run 'top -b -n 1' and you'll see a list of different tasks with the name k* 
that are kernel threads. On SMP systems, the migration thread is SCHED_FIFO 
priority 0 which means it always goes ahead of everything else. The rest of 
the kernel threads vary between SCHED_NORMAL 'nice' -20 to +19 (static 
priority 100-139).

> 3.  Is  priority inversion and its prevention (priority inheritance or
> priority ceilings) applicable to Linux ) for application/user-space tasks (
> with priorities in the range 100-139) ?

There is no intrinsic mechanism in the kernel to prevent priority inversion. 
Generic anti-starvation mechanims minimise the harm that priority inversion 
can do but there can be a lot of wasted cpu cycles for poorly coded 
applications. This is more true of 2.6 than 2.4 because the cpu scheduler 
does far more 'out of order' scheduling where a task can run many many times 
dependent on priority before another task will ever run.

Hope this helps,
Cheers,
Con


--=_mimegpg-pc.kolivas.org-11374-1088549572-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA4fLEZUg7+tp6mRURAvTjAJ97dvbQwFGf17sSn+ubIwFW+D98NACeOSv6
mOzqyZgnc9QCwzg2ddnZskw=
=Q9Ax
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-11374-1088549572-0001--
