Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTEWRfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTEWRfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:35:19 -0400
Received: from palrel13.hp.com ([156.153.255.238]:45979 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264077AbTEWRfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:35:16 -0400
Message-ID: <75A9FEBA25015040A761C1F74975667D01442101@hplex4.hpl.hp.com>
From: "Boehm, Hans" <hans_boehm@hp.com>
To: "'Arjan van de Ven'" <arjanv@redhat.com>, Hans Boehm <Hans.Boehm@hp.com>
Cc: "MOSBERGER, DAVID (HP-PaloAlto,unix3)" <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: RE: [Linux-ia64] Re: web page on O(1) scheduler
Date: Fri, 23 May 2003 10:48:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C32153.7EF2CF30"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C32153.7EF2CF30
Content-Type: text/plain;
	charset="iso-8859-1"

Sorry about the typo and misnaming for the test program.  I attached the correct version that prints the right labels.

The results I posted did not use NPTL.  (Presumably OpenMP wasn't targeted at NPTL either.)  I don't think that NPTL has any bearing on the underlying issues that I mentioned, though path lengths are probably a bit shorter.  It should also handle contention substantially better, but that wasn't tested.

I did rerun the test case on a 900 MHz Itanium 2 machine with a more recent Debian installation with NPTL.  I get 200msecs (20nsecs/iter) with the custom lock, and 768 for pthreads.  (With static linking that decreases to 658 for pthreads.)  Pthreads (and/or some of the other infrastructure) is clearly getting better, but I don't think the difference will disappear.

I don't have a Xeon with NPTL handy.  On an old PPro, the results were 1133 and 4379 msecs for custom and NPTL respectively.

Hans

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjanv@redhat.com]
> Sent: Friday, May 23, 2003 1:31 AM
> To: Hans Boehm
> Cc: Arjan van de Ven; davidm@hpl.hp.com; linux-kernel@vger.kernel.org;
> linux-ia64@linuxia64.org
> Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
> 
> 
> On Thu, May 22, 2003 at 06:07:46PM -0700, Hans Boehm wrote:
> > case.
> > 
> > On a 1GHz Itanium 2 I get
> > 
> > Custom lock: 180 msecs
> > Custom lock: 1382 msecs
> > 
> > On a 2GHz Xeon, I get
> > 
> > Custom lock: 646 msecs
> > Custom lock: 1659 msecs
> 
> is the pthreads one with nptl ?
> 


------_=_NextPart_000_01C32153.7EF2CF30
Content-Type: application/octet-stream;
	name="time_lock.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="time_lock.c"

#include <pthread.h>=0A=
#include <stdio.h>=0A=
#include <sys/time.h>=0A=
#include "atomic_ops.h"=0A=
=0A=
/* Timing code stolen from Ellis/Kovac/Boehm GCBench.			*/=0A=
#define currentTime() stats_rtclock()=0A=
#define elapsedTime(x) (x)=0A=
=0A=
unsigned long=0A=
stats_rtclock( void )=0A=
{=0A=
  struct timeval t;=0A=
  struct timezone tz;=0A=
=0A=
  if (gettimeofday( &t, &tz ) =3D=3D -1)=0A=
    return 0;=0A=
  return (t.tv_sec * 1000 + t.tv_usec / 1000);=0A=
}=0A=
=0A=
AO_TS_T my_spin_lock =3D AO_TS_INITIALIZER;=0A=
=0A=
pthread_mutex_t my_pthread_lock =3D PTHREAD_MUTEX_INITIALIZER;=0A=
=0A=
void spin_lock_ool(AO_TS_T *lock)=0A=
{=0A=
  /* Should repeatly retry the AO_test_and_set_acquire, perhaps		*/=0A=
  /* after trying a plain read.  Should "exponentially" back off	*/=0A=
  /* between tries.  For short time periods it should spin, for 	*/=0A=
  /* medium ones it should use sched_yield, and for longer ones usleep. =
*/=0A=
=0A=
  /* For now we punt, since this is a contention-free test.		*/=0A=
      abort();=0A=
}=0A=
=0A=
inline void spin_lock(AO_TS_T *lock)=0A=
{=0A=
  if (__builtin_expect(AO_test_and_set_acquire(lock) !=3D AO_TS_CLEAR, =
0))=0A=
    spin_lock_ool(lock);=0A=
}=0A=
=0A=
inline void spin_unlock(AO_TS_T *lock)=0A=
{=0A=
  AO_CLEAR(lock);=0A=
}=0A=
=0A=
int main()=0A=
{=0A=
  unsigned long start_time, end_time;=0A=
  int i;=0A=
  =0A=
  start_time =3D currentTime();=0A=
  for (i =3D 0; i < 10000000; ++i) {=0A=
    spin_lock(&my_spin_lock);=0A=
    spin_unlock(&my_spin_lock);=0A=
  }=0A=
  end_time =3D currentTime();=0A=
  fprintf(stderr, "Custom lock: %lu msecs\n",=0A=
	  elapsedTime(end_time - start_time));=0A=
  start_time =3D currentTime();=0A=
  for (i =3D 0; i < 10000000; ++i) {=0A=
    pthread_mutex_lock(&my_pthread_lock);=0A=
    pthread_mutex_unlock(&my_pthread_lock);=0A=
  }=0A=
  end_time =3D currentTime();=0A=
  fprintf(stderr, "Pthread lock: %lu msecs\n",=0A=
	  elapsedTime(end_time - start_time));=0A=
  return 0;=0A=
}=0A=

------_=_NextPart_000_01C32153.7EF2CF30--
