Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272313AbRIKHcJ>; Tue, 11 Sep 2001 03:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272314AbRIKHb7>; Tue, 11 Sep 2001 03:31:59 -0400
Received: from ns.suse.de ([213.95.15.193]:17672 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272313AbRIKHbp>;
	Tue, 11 Sep 2001 03:31:45 -0400
Mail-Copies-To: never
To: Wolfram Gloger <wg@malloc.de>
Cc: kaz@ashi.footprints.net, brianmc1@us.ibm.com,
        libc-alpha@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: SMP-ix86-threads-fork: Linux 2.4.x kernel problem identified
 [phantom read()]
In-Reply-To: <Pine.LNX.4.33.0109100931190.20444-100000@ashi.FootPrints.net>
	<E15gZyh-00074n-00@mrvdom04.kundenserver.de>
From: Andreas Jaeger <aj@suse.de>
Date: Tue, 11 Sep 2001 09:31:56 +0200
In-Reply-To: <E15gZyh-00074n-00@mrvdom04.kundenserver.de> (Wolfram Gloger's
 message of "Tue, 11 Sep 2001 00:56:31 +0200")
Message-ID: <ho1yletc7n.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Gloger <wg@malloc.de> writes:

> Hi,
>
>> So it's perfectly possible to observe the behavior you are seeing
>> if __libc_read() returns -1. Because then sz_read will acquire the
>> value -1, and the guard expresssion sz_read < sizeof(request) will yield
>> zero, terminating the loop.
>
> Argh!  That indeed seems to be the case, _no_ apparent kernel problem
> is involved, sorry for the false alarm.  read() 'just' returns -1 with
> errno becoming EINTR.  One should never code up a loop like that in
> the last minute (I only found the effect yesterday)..
>
>> Could you recode the test patch to eliminate these suspicions and re-test?
>
> The analysis was nevertheless correct, LinuxThreads gets out of synch
> with disastrous effects.  I was puzzled how read() could return -1,
> however it may make sense with a __pthread_sig_cancel pending in the
> manager thread due to a child exiting (?).  But then, why wasn't this
> possibility discovered before?

Because we never compiled with -DDEBUG so that the ASSERT was
triggered?

There's another such place (line 135) with __libc_read in
__pthread_manager:

  /* Synchronize debugging of the thread manager */
  n = __libc_read(reqfd, (char *)&request, sizeof(request));
  ASSERT(n == sizeof(request) && request.req_kind == REQ_DEBUG);

We should account for a return value of -1 here also, shouldn't we?

> Below is a corrected patch for glibc-2.2.4.  I've run fork-malloc with
> this for a couple of hours.

Is it still running? ;-)  That would be excellent!

Thanks a lot Wolfram,
Andreas

> Thanks,
> Wolfram.
>
> 2001-09-11  Wolfram Gloger  <wg@malloc.de>
>
> 	* manager.c (__pthread_manager): When reading from pipe. account
> 	for possible error return from read().
>
> --- linuxthreads/manager.c.orig	Mon Jul 23 19:54:13 2001
> +++ linuxthreads/manager.c	Tue Sep 11 00:47:48 2001
> @@ -150,8 +150,19 @@
>      }
>      /* Read and execute request */
>      if (n == 1 && (ufd.revents & POLLIN)) {
> -      n = __libc_read(reqfd, (char *)&request, sizeof(request));
> -      ASSERT(n == sizeof(request));
> +      int sz_read = 0;
> +
> +      while (sz_read < sizeof(request)) {
> +	n = __libc_read(reqfd, (char *)&request + sz_read,
> +			sizeof(request) - sz_read);
> +	if (n < 0) {
> +#ifdef DEBUG
> +	  char d[64];
> +	  sprintf(d, "*** read err %d\n", errno);
> +#endif
> +	} else
> +	  sz_read += n;
> +      }
>        switch(request.req_kind) {
>        case REQ_CREATE:
>          request.req_thread->p_retcode =
>

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
