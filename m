Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154184-9022>; Sun, 22 Nov 1998 06:18:43 -0500
Received: from beowulf.ucsd.edu ([132.239.17.2]:63744 "EHLO beowulf.ucsd.edu" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <154027-9022>; Sun, 22 Nov 1998 04:07:51 -0500
Message-Id: <m0zhWa1-00764fC@paola.ucsd.edu>
From: sbelmon2@paola.ucsd.edu (Stephane Belmon)
Subject: Timeout overflow in select()
To: linux-kernel@vger.rutgers.edu
Date: Sun, 22 Nov 1998 02:17:21 -0800 (PST)
Cc: marcs@znep.com, tkorvola@grumpy.hut.fi
Reply-To: sbelmon@cs.ucsd.edu
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

I think there is an overflow in the timeout computation in select().

It is at least in 2.0.34 and 2.1.128-9, and likely in just about any
kernel around. Here's the problem, as was reported by Timo Korvola
<tkorvola@grumpy.hut.fi> on comp.os.linux.development.system:

> It seems that calling select with a very long timeout causes an
> arithmetic overflow in the kernel code and messages like this begin to
> appear:
> schedule_timeout: wrong timeout value bbf81e00 from c0133e15
> I am running 2.1.128.  Admittedly triggering this bug requires rather
> strange use of select but CGoban (1.9.2) actually does it by using a
> timeout of one year instead of just passing a null pointer.

(Thanks, Timo) The cause is easy enough to find:
fs/select.c, sys_select(), in 2.1.129:

222		timeout = ROUND_UP(usec, 1000000/HZ);
223		timeout += sec * (unsigned long) HZ;

Line 223 will cause "timeout" (a long) to overflow when the struct
timeval passed has a large enough "tv_sec" member (a year
qualifies). Depending on the exact value passed, you can get a loong
sleep (but not as looong as intended) or an immediate wakeup.
schedule_timeout() (kernel/sched.c) has enough sanity checks to make
this show up, as above; in 2.0.34, the overflow goes unnoticed.

In any case, this doesn't look proper to me. I guess this is a general
problem when converting from a struct timeval to the internal format;
I must say that I'm still rather unsure this is a real problem, as
this section of code has been posted on this list a couple of times.

Implications: this will break some poorly written code (people who
don't use NULL as the timeout parameter, but instead "a year", to mean
"forever"). Besides that, you could imagine some cron-like daemons
which need to sleep (and still watch some FDs) for a looong time. That
could happen because of the configuration through the "cron-like
tab". The daemon could be woken up immediately, and would probably
start busy looping around the select() call. Not very good.

Security implications: here I'm not sure. 2.1.129's schedule_timeout()
is paranoid enough; nothing bad should happen. The test line 482 in
kernel/sched.c, and the "goto out" a few lines below, prevent
it. However, this might be just a lucky state of affairs. Potentially,
the scheduler could trust the timeout computation, and set a timer in
the past. If this goes off and puts the process in front of the queue
(as should happen in the 2.1.129 scheduler), other processes might not
get a chance to run. In 2.0, I think the process is put last in the
queue.

Proposed solutions: We can't refuse to serve long timeouts: if it fits
in a struct timeval, we have to do it. We could have a loop around the
do_select() call, each time with a timeout value that fits. But that's
messy, error-prone, and will almost never be exercised. Marc Slemko
<marcs@znep.com> found that:

> it is correct to place an upper limit on the timeout.
> From the single unix spec
> (http://www.opengroup.org/publications/catalog/t912.htm):
>  Implementations may place limitations on the maximum timeout interval
>  supported. On all implementations, the maximum timeout interval
>  supported will be at least 31 days. If the timeout argument specifies
>  a timeout interval greater than the implementation-dependent maximum
>  value, the maximum value will be used as the actual timeout value.
>  Implementations may also place limitations on the granularity of
>  timeout intervals. If the requested timeout interval requires a
>  finer granularity than the implementation supports, the actual
>  timeout interval will be rounded up to the next supported value.

(Thanks, Marc) This makes sense: struct timeval is too general
anyway. So it should be enough to insert a few lines to check the
tv_sec value. I propose the following:

--- linux-2.1.129/fs/select.c   Sat Nov 21 01:13:02 1998
+++ linux/fs/select.c   Sun Nov 22 01:23:09 1998
@@ -217,6 +217,10 @@
                    || (ret = __get_user(sec, &tvp->tv_sec))
                    || (ret = __get_user(usec, &tvp->tv_usec)))
                        goto out_nofds;
+               
+               if (sec<0) sec = 0;
+               if (sec>MAX_SCHEDULE_TIMEOUT/2/HZ) 
+                       sec = MAX_SCHEDULE_TIMEOUT/2/HZ; 
 
                timeout = ROUND_UP(usec, 1000000/HZ);
                timeout += sec * (unsigned long) HZ;


BTW, you need it for another reason: if a process uses
MAX_SCHEDULE_TIMEOUT/HZ as its tv_sec, it will _never_ be awaken (see
the scheduler code again); for all we know, maybe it meant "sometime
in the distant future" (granted, it's unlikely).

The patch works fine with me. I haven't seen any undesirable side
effects so far; but I haven't done extensive testing (just your
average desktop: X, Netscape, ...). I don't see how it could go wrong,
though.

--
Stephane Belmon <sbelmon@cs.ucsd.edu>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
