Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRDMUQE>; Fri, 13 Apr 2001 16:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDMUPy>; Fri, 13 Apr 2001 16:15:54 -0400
Received: from bigD.kappa.ro ([194.102.255.132]:55817 "EHLO bigD.kappa.ro")
	by vger.kernel.org with ESMTP id <S131666AbRDMUPr>;
	Fri, 13 Apr 2001 16:15:47 -0400
Date: Fri, 13 Apr 2001 23:15:40 +0300 (EEST)
From: Doru Petrescu <pdoru@kappa.ro>
Reply-To: pdoru@kappa.ro
To: linux-kernel@vger.kernel.org
cc: Mircea Damian <dmircea@kappa.ro>
Subject: Re: problem with the timers ?!? (was: No one wants to help me)
In-Reply-To: <20010413222334.B3758@linux.kappa.ro>
Message-ID: <Pine.LNX.4.21.0104132243060.6025-100000@bigD.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ok, here are some more info on this issue. BTW, I am the other guy Mircea
is talking about, and I wrote the paranoia timer.c that call
debug_timer_list() all the time to check the integrity of the timer lists.
That file was a test of mine and it wasn't initialy intended for public
release, so SORRY for // comments and so. it happens that I like them and
the problem is with the timers not with the comments. let's stay focused.
the final patch will look nice. I promise.

so,

1. first of all this is not a hardware problem. the memory is OK. CPU is
OK. BTW it is a dual PIII 733, 512 RAM. IDE ATA 100.

2. this problem happens only in internal_add_timer() especialy it happens
when it calls "list_add(&timer->list, vec->prev);" at the end of
internal_add_timer()

I analized a crash and the problem is that vec->prev is NULL. So someone
is reseting the next/prev pointers of a timer that is in use.

3. there is chance that because of the patch the race condition that used
to cause the crash does not happen any more. after 2 days, there is no
crash. so SORRY, but there is no aditional info i can post, no pointers no
functions, no nothing. it works just fine right now ... :-)

4. if you look at the debug_timer_list() function you will notice that
when it finds a bad cell in the list, it will print the current cell and
also the next/prev cell and the chain index that contains the bad cell.
for each cell it will print the next/prev pointers, also the data and the
function pointer.

Also it will try to find the other loose end and repair the list by
connecting them back togher, bypassing the bad cell. this is a disperate
measure I know, but it is better then just crashing.

5. I don't think there is an obvious problem in detach_timer() as Brian
Gerst <bgerst@didntduck.org> is saying ...

static inline int detach_timer (struct timer_list *timer)
{
  if (!timer_pending(timer)) return 0;
  list_del(&timer->list);
  return 1;
}

timer_pending(timer) check if the next/prev pointers are NULL.
if they are NULL, then the timer is already REMOVED and IS NOT PENDING, so
there is nothing to detach so detach_timer() just exit and does
nothing. CORRECT. i don't see anything wrong with this.
the upper function can reset the next/prev pointers again. there is simply
no problem, if the timer was already dleeted, they were already set to
NULL. if the timer was just deleted, then is OK too to reset the
pointers since it is deleted.

also it doesn't matter if that timer is running or not. if it is running
then it is already removed, so again there is nothing to do. and again
there is no problem with reseting the next/prev pointers there were
already been NULL :-)

also I don't understand how a race condition can occour since all
functions that play with the lists has a spin_lock() arround them.
Maybe is not someting wrong in the timers, maybe some other part of the
kernel is doing the bad thing.

6. Also I have a strange feeling that this is caused by the networking.
OFC, it could be because networking has a lot of timers and the race
condition just has a biger chance to be triggered by the networking ...

7. Could it be possible that some function add a timer, and BEFORE it
expires, the function forgets to delete it, and just call init_timer again?

6. some history about this crashing thing ... 
2.4.0 - I did not noticed it to crash. maybe because the system was
        rebooted quite often because of other reasons.
2.4.1 - it worked for about 2 weeks, no problem. then i upgraded the
        kernel.
2.4.2 - nightmare starts. first crash after 1 week.
      - i upgrade to various pre something patches, no good. it keep
        crashing.
2.4.3 - crashed twice in the same day, last time after only 2h.

I downgraded to 2.4.1 - it worked fine for 1 week, and when i was finnaly
happy it crashes. some problem. 
This is when i wrote that modified timer.c 
FYI, timer.c didn't changed a BIT since 2.4.0 till now. so you can apply
the patch no matter your kernel version.


Now I am running the paranoia timer.c on a 2.4.4-pre2 kernel. and nothing
happened after 2 days. If it will find a broken cell I will post the
relevant info to LK ...


Best regards,
------
Doru Petrescu
KappaNet - Senior Software Engineer
E-mail: pdoru@kappa.ro		 LINUX - the choice of the GNU generation





