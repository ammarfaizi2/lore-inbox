Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbTFSFwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 01:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265457AbTFSFwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 01:52:37 -0400
Received: from fmr06.intel.com ([134.134.136.7]:13250 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265444AbTFSFwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 01:52:31 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DD16DB0@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Andrew Morton'" <akpm@digeo.com>,
       "'george anzinger'" <george@mvista.com>
Cc: "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>, "Li, Adam" <adam.li@intel.com>
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	sks
Date: Wed, 18 Jun 2003 23:06:25 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C33628.EA41FA10"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C33628.EA41FA10
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi All

I have another test case that is showing this behavior.
It is very similar to George's, however, it is a simplification
of another one using threads that a co-worker, Adam Li found
a few days ago.

Parent (FIFO 5) forks child that sets itself to FIFO 4 and=20
busy loops, then it sleeps five seconds and kills the child.=20

Doing SysRq + T after a while shows the parent'd call trace=20
to be at sys_rt_sigaction+0xd1, that is just inside the final=20
copy_to_user() in signal.c:sys_rt_sigaction().

Reprioritizing events/0 to FIFO 5+ fixes the inversion.=20

If I call nanosleep directly (with system() instead of
glibc's sleep(), so I avoid all the rt_sig calls),
I get the parent process always stuck in work_resched+0x5,
in entry.S:work_resched, just after the call to the
scheduler - however, I cannot trace what is happening
inside the scheduler.

My point here is: I am trying to trace where this program
is making use of workqueues inside of the kernel, and I
can find none. The only place where I need to look some
more is inside the timer code, but in a quick glance,
it seems it is not being used, so why is it affected by
the reprioritization of the events/0 thread? George, can
you help me here?

kernel is 2.5.67, SMP and PREEMPT with maxcpus=3D1; tomorrow
I will try .72 ...=20

I=F1aky P=E9rez-Gonz=E1lez -- Not speaking for Intel -- all opinions =
are my own
(and my fault)



------_=_NextPart_000_01C33628.EA41FA10
Content-Type: application/octet-stream;
	name="sched-hang.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sched-hang.c"

#include <signal.h>=0A=
#include <unistd.h>=0A=
#include <linux/unistd.h>=0A=
#include <stdlib.h>=0A=
#include <sched.h>=0A=
#include <stdio.h>=0A=
#include <time.h>=0A=
=0A=
volatile int dummy;=0A=
volatile int child_run =3D 1;=0A=
=0A=
/* #define DPRINTF(a...) fprintf(stderr, a) */=0A=
#define DPRINTF(a...) do { } while (0)=0A=
=0A=
void child_signal_handler (int signum)=0A=
{=0A=
  child_run =3D 0;=0A=
}=0A=
=0A=
int main (void)=0A=
{=0A=
  int child;=0A=
  struct timespec tp =3D { 5, 0 };=0A=
  struct sched_param param;=0A=
  param.sched_priority =3D 5;=0A=
  sched_setscheduler (0, SCHED_FIFO, &param);=0A=
  child =3D fork();=0A=
  switch (child)=0A=
  {=0A=
   case 0:=0A=
    DPRINTF("Child starts\n");=0A=
    signal (SIGTERM, child_signal_handler);=0A=
    param.sched_priority =3D 4;=0A=
    sched_setscheduler (0, SCHED_FIFO, &param);=0A=
    for (; child_run;)=0A=
      dummy =3D dummy + 1;=0A=
    DPRINTF("Child dies\n");=0A=
    break;=0A=
   case -1:=0A=
    perror ("fork failed");=0A=
    abort();=0A=
    break;    =0A=
   default:=0A=
/*     sleep (5); */=0A=
    syscall (__NR_nanosleep, &tp, NULL);=0A=
    kill (child, SIGTERM);=0A=
   break;=0A=
  }=0A=
  return 0;=0A=
}=0A=
=0A=
    =0A=
  =0A=

------_=_NextPart_000_01C33628.EA41FA10--
