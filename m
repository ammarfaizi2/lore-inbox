Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264663AbRGQFgB>; Tue, 17 Jul 2001 01:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265003AbRGQFfw>; Tue, 17 Jul 2001 01:35:52 -0400
Received: from pc245.edi.nunet.net ([199.249.165.245]:1532 "EHLO
	syzygy.sourcelight.com") by vger.kernel.org with ESMTP
	id <S264663AbRGQFfj>; Tue, 17 Jul 2001 01:35:39 -0400
Date: Tue, 17 Jul 2001 00:35:35 -0500
From: Henry Cejtin <henry@sourcelight.com>
Message-Id: <200107170535.f6H5ZZt20785@syzygy.sourcelight.com>
To: linux-kernel@vger.kernel.org
Subject: race in getrusage()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for sending this bug report out to this broad an audience, but there is
an old bug in getrusage() (it  has  been  there  since  at  least  2.2.5  and
probably way before that and is still in 2.4.6).  Depending on the cleverness
of the C compiler, when you do
    getrusage(RUSAGE_SELF, &rbuf)
you can get one of the following:

    A rbuf.ru_stime which is 1 second too small.  (In  particular,  1  second
        smaller than you got from a previous call in the same process.)
    rbuf.ru_stime.tv_usec = 10^6 (i.e., larger than should be possible).

The  bug  is  caused  by  the  fact  that in kernel/sys.c, in the getrusage()
function, the p->times.tms_stime might change  while  the  code  is  running.
Since  it  isn't marked as being volatile, if the compiler optimizes the code
by  subtracting  the  r.ru_stime.tv_sec  *  HZ  from   a   second   load   of
p->times.tms_stime  then  you  get the r.ru_stime.tv_usec set to 10^6.  If it
reloads p->times.tms_stime then you get the lost second.  I  have  seen  both
behaviors,  depending  on the compiler being used.  In particular, the kernel
distributed with Red Hat 7.1 shows the lost second phenomenon, and  the  10^6
value for ru_stime.tv_usec on Red Hat 6.0's kernel.

The fix is to just load p->times.tms_stime into a local variable and then use
the local copy for setting both the tv_sec and tv_usec fields of  r.ru_stime.

Only  r.ru_stime  is  vulnerable since the process is in a system call at the
time.

Note, to force the compiler to  actually  fetch  p->times.tms_stime,  and  to
fetch it only once, requires something like this:
    clock_t tmp;

    tmp = *(volatile clock_t *)&p->times.tms_stime;
    r.ru_utime.tv_sec = CT_TO_SECS(tmp);
    r.ru_utime.tv_usec = CT_TO_USECS(tmp);
otherwise  the  compiler is quite free to ignore the load and to simply fetch
p->times.tms_stime twice.
