Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbQLaXmb>; Sun, 31 Dec 2000 18:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129992AbQLaXmV>; Sun, 31 Dec 2000 18:42:21 -0500
Received: from adsl-63-206-97-82.dsl.snfc21.pacbell.net ([63.206.97.82]:45039
	"EHLO mail.corp124.com") by vger.kernel.org with ESMTP
	id <S129747AbQLaXmJ>; Sun, 31 Dec 2000 18:42:09 -0500
Message-ID: <3A4FBD2F.D80A7716@corp124.com>
Date: Sun, 31 Dec 2000 15:11:43 -0800
From: Kostas Nikoloudakis <kostas@corp124.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: system call fails with ENOMEM after long operation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is a problem we have been strugling with and we hope someone can
offers us some clues:

We have a server that handles a large number of client requests (approx
200 req/sec) and has a large memory footprint (approx. 1.3GB). From this
1.3GB, 512MB are allocated as a big chunk during startup and are use as
a local memory cache inside the server process and ~700MB are
dynamically allocated for an internal data structure used to serve
requests.
Also, to service each request many small amounts of memory (from a few
bytes to ~10 KB/request)
are allocated using new() and are later released when the request has
been served.

We run this server on a machine with 2GB of physical memory and after
24hr of continuous operation select() and poll fail with ENOMEM (and
without
change in the number of file descriptors that each must handle compared
to earlier in the run). 
At this point top(1) reports (it's a multi-threaded application).

  3:02pm  up 39 days,  1:41,  6 users,  load average: 0.84, 0.66, 0.49
117 processes: 116 sleeping, 1 running, 0 zombie, 0 stopped 
CPU states:  0.2% user, 44.9% system,  0.0% nice, 54.7% idle
Mem:  2074332K av, 2071048K used,    3284K free,   82456K shrd,  134816K
buff
Swap: 2056280K av,    2272K used, 2054008K free                  476800K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME
COMMAND 
12460 root       0   0 1378M 1.3G  1640 S    1.0G  0.0 68.0  1344m myapp
12463 root       0   0 1378M 1.3G  1640 S    1.0G  0.7 68.0   9:16 myapp
12464 root       0   0 1378M 1.3G  1640 S    1.0G  0.7 68.0   9:11 myapp
12465 root       0   0 1378M 1.3G  1640 S    1.0G  0.5 68.0   9:38 myapp
12466 root       0   0 1378M 1.3G  1640 S    1.0G  0.7 68.0   9:24 myapp
12467 root       0   0 1378M 1.3G  1640 S    1.0G  1.2 68.0   9:39 myapp
12468 root       1   0 1378M 1.3G  1640 S    1.0G  0.5 68.0   9:27 myapp
12469 root       0   0 1378M 1.3G  1640 S    1.0G  1.2 68.0   9:26 myapp
12470 root       0   0 1378M 1.3G  1640 S    1.0G  1.2 68.0   9:31 myapp
12471 root       1   0 1378M 1.3G  1640 S    1.0G  1.1 68.0   9:32 myapp
12472 root       0   0 1378M 1.3G  1640 S    1.0G  2.4 68.0   9:37 myapp
12473 root       0   0 1378M 1.3G  1640 S    1.0G  0.7 68.0   9:35 myapp
12474 root       0   0 1378M 1.3G  1640 S    1.0G  1.4 68.0   9:32 myapp
12475 root       1   0 1378M 1.3G  1640 S    1.0G  1.9 68.0   9:33 myapp
12476 root       0   0 1378M 1.3G  1640 S    1.0G  0.5 68.0   9:32 myapp
12477 root       0   0 1378M 1.3G  1640 S    1.0G  0.7 68.0   9:25 myapp
12478 root       0   0 1378M 1.3G  1640 S    1.0G  0.7 68.0   9:36 myapp
12479 root       0   0 1378M 1.3G  1640 S    1.0G  0.0 68.0   9:30 myapp
12480 root       0   0 1378M 1.3G  1640 S    1.0G  0.7 68.0   9:36 myapp
12481 root       0   0 1378M 1.3G  1640 S    1.0G  0.5 68.0   9:27 myapp
12482 root       0   0 1378M 1.3G  1640 S    1.0G  0.7 68.0   9:28 myapp
12483 root       0   0 1378M 1.3G  1640 S    1.0G  0.0 68.0   9:32 myapp
12484 root       1   0 1378M 1.3G  1640 S    1.0G  1.9 68.0   9:23 myapp
12485 root       0   0 1378M 1.3G  1640 S    1.0G  0.4 68.0   9:26 myapp
12486 root       0   0 1378M 1.3G  1640 S    1.0G  0.7 68.0   9:27 myapp
12487 root       0   0 1378M 1.3G  1640 S    1.0G  2.4 68.0   9:23 myapp
12488 root       0   0 1378M 1.3G  1640 S    1.0G  1.1 68.0   9:16 myapp
12489 root       0   0 1378M 1.3G  1640 S    1.0G  1.4 68.0   9:33 myapp
12490 root       0   0 1378M 1.3G  1640 S    1.0G  0.0 68.0   9:23 myapp
12491 root       1   0 1378M 1.3G  1640 S    1.0G  1.2 68.0   9:36 myapp
12492 root       1   0 1378M 1.3G  1640 S    1.0G  3.1 68.0   9:23 myapp
12493 root       0   0 1378M 1.3G  1640 S    1.0G  0.0 68.0   9:27 myapp
12494 root       3   0 1378M 1.3G  1640 S    1.0G  2.4 68.0   9:33 myapp
12495 root       0   0 1378M 1.3G  1640 S    1.0G  0.0 68.0   9:34 myapp
12462 root       0   0 1378M 1.3G  1640 S    1.0G  0.0 68.0   0:42 myapp

So why is the kernel having difficulty allocating memory for its
internal operations? We are suspecting memory fragmentation issues 
(at the application level which might have adverse sideefects for the
kernel). Is it something that we can do so that the kernel will be
able to allocate the needed memory for carrying out the system call?

We are running RH 6.2 (kernel 2.2.14-5.0) Kernel configured with BIGMEM
enabled and CONFIG_1GB (Are those config options even related?)

thanks in advance,

-kostas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
