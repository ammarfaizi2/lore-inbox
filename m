Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265165AbRFUTzc>; Thu, 21 Jun 2001 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265172AbRFUTzV>; Thu, 21 Jun 2001 15:55:21 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:48140 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S265165AbRFUTzN>; Thu, 21 Jun 2001 15:55:13 -0400
Date: Thu, 21 Jun 2001 21:55:08 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Davide Libenzi <davidel@xmailserver.org>
cc: David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Why use threads ( was: Alan Cox quote?)
In-Reply-To: <XFMail.20010621091050.davidel@xmailserver.org>
Message-ID: <Pine.LNX.4.33.0106212039280.6630-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Davide Libenzi wrote:

>
> On 21-Jun-2001 David Schwartz wrote:
> >       Okay, let's compare two servers.
> >
> >       Server one is handling 10 file descriptors. The cost of a single call to
> > poll is 3 microseconds. Assume that the server is coded to get back to
> > 'poll' as quickly as it can, but due to load the code manages to call 'poll'
> > every 100 microseconds, so the overhead of poll is 3% of the available CPU.
>
> Maybe You read a paper by Richard Gooch but I think You read it wrong :
>
> http://www.atnf.csiro.au/~rgooch/linux/docs/io-events.html
>
> <quote>
> The kernel has to scan your array of FDs and check which ones are active. This
> takes approximately 3 microseconds (3 us) per FD on a Pentium 100 running Linux
> 2.1.x. Now you might think that 3 us is quite fast, but consider if you have an
> array of 1000 FDs. This is now 3 milliseconds (3 ms), which is 30% of your
> timeslice (each timeslice is 10 ms). If it happens that there is initially no
> activity and you specified a timeout, the kernel will have to perform a second
> scan after some activity occurs or the syscall times out. Ouch! If you have an
> even bigger application (like a large http server), you can easily have 10000
> FDs. Scanning times will then take 30 ms, which is three timeslices! This is
> just way too much.
> </quote>

Why would you want to call poll() on *every* timeslice? What's wrong
with (assuming 10ms slice):

t0 (10ms): poll(3ms) - some work
t1 (10ms):  more work
t2 (10ms):  more work
...
t9 (10ms):  almost done
t10(10ms): done - poll(3ms) - some other work

that still accounts for 3% overhead. IIRC, David was proposing about
1000 fds/thread so the numbers fit.  Also, keeping *two* pools, one
with 100 fds (which covers 90% of the activity) and the other with
900 fds, you can even lower that (overall) 3%, since you call poll()
on the 100 array more often than you do on the 900 array.
[ BTW, David, do you implement this with two threads or schedule the
two pool()'s into the same one? - I'm just curious B-) ]

David's argument of course fails if there's no work to be done on
all the events (= active fds). But why should one code such an application?
... oh, wait, that reminds me something... (something about scheduler
overhead on large runqueues, .. no no I won't go to that place again!)
[but since sooner or later I'll move my desktop system to a 128 SMP one,
please go on patching the scheduler, Davide]  B-)

> Anyway there's no need to continue this ( quite long ) thread.

Well, I was reading it with pleasure... B-)

>
>
>
>
> - Davide
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it



