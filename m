Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422949AbWJRVJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422949AbWJRVJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWJRVJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:09:26 -0400
Received: from mx03.stofanet.dk ([212.10.10.13]:20688 "EHLO mx03.stofanet.dk")
	by vger.kernel.org with ESMTP id S1751514AbWJRVJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:09:25 -0400
Date: Wed, 18 Oct 2006 23:07:35 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@frodo.shire
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.18-rt6
In-Reply-To: <20061018083921.GA10993@elte.hu>
Message-ID: <Pine.LNX.4.64.0610182257590.13930@frodo.shire>
References: <20061018083921.GA10993@elte.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-22478338-1043458859-1161205655=:13930"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---22478338-1043458859-1161205655=:13930
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Wed, 18 Oct 2006, Ingo Molnar wrote:

>
> i've released the 2.6.18-rt6 tree, which can be downloaded from the
> usual place:
>
>  http://redhat.com/~mingo/realtime-preempt/
>
> this is a fixes-mostly release. Changes since -rt4:
>
> - fix for module loading / symbol table crash (John Stultz)
> - scheduler fix (Mike Galbraith)
> - fix x86_64 NMI watchdog & preempt-rcu interaction
> - fix time-warp false positives
> - jiffies_to_timespec export fix (Steven Rostedt)
> - ll_rw_block.c warning fix (Mike Galbraith)
> - PPC updates (Daniel Walker)
> - MIPS updates (Manish Lachwani)
> - ARM oprofile fix (Kevin Hilman)
> - traditional futexes queued via plists (S=E9stien Dugu=E9se)
> - (various other smaller fixes)

I assume this goes under small fixes:

I see that
 =09spin_lock(&pi_state->pi_mutex.wait_lock);
is added in futex.c:570 in wake_futex_pi().
I do but I see some missing unlocks at returns.

I have a totally untested (it compiles) patch below.

Esben

  kernel/futex.c |    8 ++++++--
  1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rt/kernel/futex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.18-rt.orig/kernel/futex.c
+++ linux-2.6.18-rt/kernel/futex.c
@@ -590,10 +590,14 @@ static int wake_futex_pi(u32 __user *uad
  =09=09inc_preempt_count();
  =09=09curval =3D futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
  =09=09dec_preempt_count();
-=09=09if (curval =3D=3D -EFAULT)
+=09=09if (curval =3D=3D -EFAULT) {
+=09=09=09spin_unlock(&pi_state->pi_mutex.wait_lock);
  =09=09=09return -EFAULT;
-=09=09if (curval !=3D uval)
+=09=09}
+=09=09if (curval !=3D uval) {
+=09=09=09spin_unlock(&pi_state->pi_mutex.wait_lock);
  =09=09=09return -EINVAL;
+=09=09}
  =09}

  =09spin_lock_irq(&pi_state->owner->pi_lock);
---22478338-1043458859-1161205655=:13930--
