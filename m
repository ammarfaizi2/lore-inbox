Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267867AbUHSCIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267867AbUHSCIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUHSCIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:08:20 -0400
Received: from fmr05.intel.com ([134.134.136.6]:50916 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267867AbUHSCIQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:08:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: PATCH futex on fusyn (Was: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1)
Date: Wed, 18 Aug 2004 19:07:26 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F9422@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH futex on fusyn (Was: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1)
Thread-Index: AcR67KSkq2pUMRq9QeihuSVc82SjGgKme+Mw
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Ulrich Drepper" <drepper@redhat.com>
X-OriginalArrivalTime: 19 Aug 2004 02:07:45.0768 (UTC) FILETIME=[51859E80:01C48591]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ingo Molnar [mailto:mingo@elte.hu]
>
> i believe the key to integration of this feature is to try to make it
> used by normal (non-RT) apps as much as possible. I.e. try to make
> current futexes a subset of fusyn.c and to merge the two APIs if
> possible (essentially renaming your fusyn.c to futex.c and implementing
> the futex API). Is this possible without noticeable performance overhead
> (and without too many special-cases)?

Ok, here we go with a first cut -- sorry for the time it took, came
back from vacation and had the usual big-pile-o-crap waiting for me.

There are two patches, first one, fusyn-2.3.1-00-misc-requeue (-p1) 
contains the few fixes on top of  2.3.1 that are needed to be able to 
map futexes on top of fusyn. Mainly is adding fuqueue_requeue() [before 
I only had fulock requeue from a fuqueue], splitting sys_ufuqueue_wake() 
and fixing some stupid mistakes.

Second patch, fusyn-2.3.1-01-futex-switch.patch implements a sysctl-based
futex switch. Echo 1 to /proc/sys/kernel/futex_uses_fusyn and new futexes
will be based on fusyns. Echo 0 and we are back to normal.

caveat emperors:

- 01-futex-switch is a crappy quick hack. If there where applications waiting
  on futexes and you flip the switch, they will wait for ever in there...
  a 'kill -CONT' might help.

- FUTEX_FD is not implemented--too much work for a proof of concept.

- ufuqueue_requeue() is more limited than futex's in that it will always 
  requeue everybody, not just the number of passed waiters. There is a 
  reason for it, and is it is only used for broadcast and broadcast means
  everybody. It makes it simpler to do it in a O(1) way [that by the way,
  I had to hack around because it was broken--fix in the works...someday].

  So, there are WARN_ONs to catch cases of calls not doing the args as
  expected--but so far, I haven't caught any.

Performance:

I used my favorite stress microbenchmark, str03 [1] which is a program I
stole I don't remember where from that does a lot of conditional variable
and mutexing. Running it like:

$ (ulimit -s 32; /usr/bin/time -f %e ./str03 -b 5 -d 5)

creates a good 3900 threads that need to talk among them to finish and
communicate via mutexes and condvars.

In my test machine, 2xP3 (Coppermine) 933MHz w/ 2 GiB Ram, I get the
average of ten runs as:

Environment                       Seconds (10 continuous runs averaged)
-----------                       -------------------
plain NPTL and futexes            0.97
plain NPTL, futexes use fuqueues  1.15
Under RTNPTL, using fulocks       1.48

So using fuqueues instead of fusyns is slightly slower on heavy use--I 
expected it due to the extra overhead. I am off to do a full Volanomark 
run, see how it behaves [this takes more time--won't be ready until
tomorrow].

Patches inlined below in two following messages. They should also show
up at the CVS snapshots that we get at our OSDL site.

[1] http://developer.osdl.org/dev/robustmutexes/fusyn/2.3.1/
    rtnptl-test-misc-2.3.tar.gz, in src/

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
