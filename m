Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264564AbRGNPCj>; Sat, 14 Jul 2001 11:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264461AbRGNPCU>; Sat, 14 Jul 2001 11:02:20 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:12982 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S263346AbRGNPCR>; Sat, 14 Jul 2001 11:02:17 -0400
Message-ID: <3B506005.7C6D2982@kegel.com>
Date: Sat, 14 Jul 2001 08:06:45 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Winters <cwinters@atl.lmco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Number of File descriptors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck wrote:
> Will select be ultra slow trying to select on 3000 file descriptors? 

Note that using select in a program that uses more than 1024 file 
descriptors is not completely portable; you have to redefine __FD_SETSIZE.
I have heard people say that's easy, but as recently as March 2000,
Ulrich Depper advised against it:
http://sources.redhat.com/ml/bug-glibc/2000-03/msg00051.html
As far as I can see, it's not easy on Red Hat 6.2 or 7.1.

But that's ok; you can use poll() instead.

See http://www.kegel.com/dkftpbench/Poller_bench.html for
some measurements on the speed of select() and poll() for large numbers
of file descriptors.  Here's an excerpt:

Time to select or poll n file descriptors, in microseconds,
on 650 MHz dual Pentium III with kernel 2.4.0-test10-pre4 smp:

               file descriptors
              100    1000   10000 
    select     52       -       - 
      poll     49    1184   14660 

So poll() is indeed slow at 1000 to 10000 file descriptors; whether 
it's too slow depends on your application.

> Also, what is the clarification on the kernel doing a sequential 
> search through the open file descriptors?

Yep, that's where the slowness comes from.  Linux offers several ways
around it: 
  * RT signal stuff that comes standard with 2.4
  * Provos' /dev/poll patch
  * Vitaly Luban's enhanced RT signal patch
  * Davide Libenzi's enhanced /dev/epoll patch
You can read about all of these at http://www.kegel.com/c10k.html#nb

The first has the advantage of being part of the 2.4 kernel already,
but is a bit of a pain to use (you have to handle signal overflow).
The second still has one linear scan in it, so it doesn't scale well.
The third and fourth are the top contenders for 'fastest replacement for 
select()' on Linux, but aren't part of the standard kernel yet.

- Dan
