Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262200AbTCWAMK>; Sat, 22 Mar 2003 19:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262212AbTCWAMK>; Sat, 22 Mar 2003 19:12:10 -0500
Received: from fmr02.intel.com ([192.55.52.25]:12526 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262200AbTCWAMI>; Sat, 22 Mar 2003 19:12:08 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C780B36E0C8@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.64] Real-time futexes (priority inheritance/protection
	/robust support) take 4
Date: Sat, 22 Mar 2003 16:23:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

This is my second try into implementing real-time futex
support. The patch below encloses a proposal on a way to do
real-time futexes that support priority-inheritance,
priority-protection, dead-owner recovery (similar to Sun's Robust
Mutex Extension) and dead lock detection, a sample implementation
(sans priority-protection) and a set of test programs along with a
very simple thread library to test it.

I have been working on this for a while, and got input from many
different people in different companies who are interested in
these features (eg: Intel, Cisco, Montavista, OSDL ...) We are
also working on a way to blend this into NPTL so it can do
real-time. 

I'd love to hear feedback - specially on things where I just screwed 
up big time and could be optimized really well.

Highlights:

- Currently on 2.5.64

- Does not modify original futexes - a new interface is added

Caveats:

- Timings are still a little bit crappy - looking into it.

- Priority protection not yet implemented.

- Many fixmes here and there that require answers

- Hook for properly acting when the priority of a waiting task is
  changed not implemented yet. 

- The tweak in timer.c is kind of ugly, and needs to be done much more
  generic; maybe even moved into wake_up_process().

Check out kernel/rtfutex.c for a quick roadmap;
Documentation/rtfutex.txt for a longer series of rants and a something
more like a proposal or design
reference. Documentation/rtfutex-api.txt describes how to call the
functions.

Pointer to the test library:
http://sost.net/pub/linux/rtfutex-test-4.tar.bz2

Build with:

$ ./configure --with-headers=RTFUTEX-PATCHED-LINUX-TREE/include
$ make

Patch at: http://sost.net/pub/linux/rtfutex-4.patch

 linux/Documentation/rtfutex-api.txt |  136 
 linux/Documentation/rtfutex.txt     |  681 ++++
 linux/include/asm-generic/futex.h   |   64 
 linux/include/asm-i386/futex.h      |  154 +
 linux/include/linux/futex.h         |   36 
 linux/include/linux/list.h          |    2 
 linux/include/linux/plist.h         |  163 +
 linux/include/linux/sched.h         |   12 
 linux/include/linux/vcache.h        |   17 
 linux/kernel/Makefile               |    2 
 linux/kernel/exit.c                 |    8 
 linux/kernel/fork.c                 |   13 
 linux/kernel/futex.c                |   16 
 linux/kernel/rtfutex.c              | 1663 +++++++++++
 linux/kernel/sched.c                |   30 
 linux/kernel/timer.c                |    9 


-- 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

