Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129353AbQKDFJD>; Sat, 4 Nov 2000 00:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132321AbQKDFIx>; Sat, 4 Nov 2000 00:08:53 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:60919 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129353AbQKDFIm>; Sat, 4 Nov 2000 00:08:42 -0500
Message-ID: <3A0399CD.8B080698@uow.edu.au>
Date: Sat, 04 Nov 2000 16:08:29 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of 
 lock_kernel()?(Was:Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39FD8D0B.B6C0C772@uow.edu.au> <Pine.LNX.4.21.0010301518290.18636-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> 
> On Tue, 31 Oct 2000, Andrew Morton wrote:
> 
> > Dean,  it looks like the same problem will occur with flock()-based
> > serialisation.  Does Apache/Linux ever use that option?
> 
> from apache/src/include/ap_config.h in the linux section there's
> this:
> 
> /* flock is faster ... but hasn't been tested on 1.x systems */
> /* PR#3531 indicates flock() may not be stable, probably depends on
>  * kernel version.  Go back to using fcntl, but provide a way for
>  * folks to tweak their Configuration to get flock.
>  */
> #ifndef USE_FLOCK_SERIALIZED_ACCEPT
> #define USE_FCNTL_SERIALIZED_ACCEPT
> #endif
> 
> so you should be able to -DUSE_FLOCK_SERIALIZED_ACCEPT to try it.
> 

Dean,

neither flock() nor fcntl() serialisation are effective
on linux 2.2 or linux 2.4.  This is because the file
locking code still wakes up _all_ waiters.  In my testing
with fcntl serialisation I have seen a single Apache
instance get woken and put back to sleep 1,500 times
before the poor thing actually got to service a request.

For kernel 2.2 I recommend that Apache consider using
sysv semaphores for serialisation. They use wake-one. 

For kernel 2.4 I recommend that Apache use unserialised
accept.

This means that you'll need to make a runtime decision
on whether to use unserialised, serialised with sysv or
serialised with fcntl (if sysv IPC isn't installed).


In my testing I launched 3, 10, 30 or 150 Apache instances and then used

	httperf --num-conns=2000 --num-calls=1 --uri=/index.html

to open, use and close 2000 connections.

Here are the (terrible) results on 2.4 SMP with fcntl
serialisation:

fcntl accept, 3 servers, vanilla: 938.0 req/s
fcntl accept, 30 servers, vanilla: 697.1 req/s
fcntl accept, 150 servers, vanilla: 99.9 req/s         (sic)

2.4 SMP with no serialisation:

unserialised accept, 3 servers, vanilla: 1049.0 req/s
unserialised accept, 10 servers, vanilla: 968.8 req/s
unserialised accept, 30 servers, vanilla: 1040.2 req/s
unserialised accept, 150 servers, vanilla: 1091.4 req/s

2.4 SMP with no serialisation and my patch to the
wakeup and waitqueue code:

unserialised accept, 3 servers, task_exclusive: 1117.4 req/s
unserialised accept, 10 servers, task_exclusive: 1118.6 req/s
unserialised accept, 30 servers, task_exclusive: 1105.6 req/s
unserialised accept, 150 servers, task_exclusive: 1077.1 req/s

2.4 SMP with sysv semaphore serialisation:

sysvsem accept, 3 servers: 1001.2 req/s
sysvsem accept, 10 servers: 1061.0 req/s
sysvsem accept, 30 servers: 1021.2 req/s
sysvsem accept, 150 servers: 943.6 req/s

2.2.14 SMP with fcntl serialisation:

fcntl accept, 3 servers: 1053.8 req/s
fcntl accept, 10 servers: 996.2 req/s
fcntl accept, 30 servers: 934.3 req/s
fcntl accept, 150 servers: 141.4 req/s                (sic)

2.2.14 SMP with no serialisation:

unserialised accept, 3 servers: 1039.9 req/s
unserialised accept, 10 servers: 983.1 req/s
unserialised accept, 30 servers: 775.7 req/s
unserialised accept, 150 servers: 220.7 req/s         (sic)

2.2.14 SMP with sysv sem serialisation:

sysv accept, 3 servers: 932.2 req/s
sysv accept, 10 servers: 910.6 req/s
sysv accept, 30 servers: 1026.6 req/s
sysv accept, 150 servers: 927.2 req/s


Note that the first test (2.4 with fcntl serialisation) was
with an unpatched 2.4.0-test10-pre5.  Once the simple
flock.patch is applied, the performance with 150 servers
doubles.  But it's still sucky.  The flock.patch change
is effective in increasing scalability wiht a large number
of CPUs, not a large number of httpd's.

Here's the silly patch I used to turn on sysv sem serialisation
in Apache.  There's probably a better way than this :)

--- apache_1.3.14.orig/src/main/http_main.c	Fri Sep 29 00:32:36 2000
+++ apache_1.3.14/src/main/http_main.c	Sat Nov  4 15:01:41 2000
@@ -172,6 +172,13 @@
 
 #include "explain.h"
 
+/* AKPM */
+#if 1
+#define NEED_UNION_SEMUN
+#define USE_SYSVSEM_SERIALIZED_ACCEPT
+#define USE_FCNTL_SERIALIZED_ACCEPT
+#endif
+
 #if !defined(max)
 #define max(a,b)        (a > b ? a : b)
 #endif
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
