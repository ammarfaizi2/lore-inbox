Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVHTOnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVHTOnn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 10:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVHTOnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 10:43:43 -0400
Received: from ns1.iitis.gliwice.pl ([212.106.181.5]:18854 "EHLO
	intel.iitis.gliwice.pl") by vger.kernel.org with ESMTP
	id S1751246AbVHTOnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 10:43:42 -0400
Message-ID: <4440.144.82.192.113.1124549018.squirrel@mail.iitis.gliwice.pl>
Date: Sat, 20 Aug 2005 16:43:38 +0200 (CEST)
Subject: CLOCK_TICK_RATE for slowing down the system clock?
From: ijs@iitis.gliwice.pl
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
X-IITiS-MailScanner-Information: Please contact the ISP for more information
X-IITiS-MailScanner: Found to be clean
X-MailScanner-From: ijs@iitis.gliwice.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For my own purpose I would like to slow down the clock maintained by
the Linux kernel.

I want to simulate 10Gb/s network connection with roughly 10000 TCP
connections.  For this I want to use two (perhaps dual processor if
need be) PC computers connected with 1Gb/s Ethernet.  To achieve this
goal I need to trick the Linux TCP implementation that it's running on
a 10x faster setup.

Therefore I have the following idea, which I partially tested.  So far
I have not tested the TCP performance, but only some general system
performance.  I did some simple tests with Linux 2.6.12 on my laptop
with Pentium 4, 2.8 GHz, no hyperthreading.

The idea is to slow down 10 times the clock maintained by the Linux
kernel.  Software that relies on the system clock (such as the TCP
Linux kernel implementation, and other software such as the top
command) should be tricked to think that it runs on a 10 times faster
computer with a 10Gb/s link.

The simplest hack I have came up with to slow down the clock is to
compile the kernel with a different frequency of the hardware clock as
defined in the linux-2.6.12/include/asm-i386/timex.h file:

#  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */

I multiplied this value by 10:

#  define CLOCK_TICK_RATE 11931820 /* Underlying HZ */

I recompiled and installed the new kernel.  Once we are running (with
the noapic option at boot time) the new kernel, a simple way of making
sure the system clock is running slower is to use the date command and
see how slow the time is passing.  And yes, the system clock was
running 10 times slower.  But unfortunately, not only the system clock
was running slower...

Some tasks were running slower.  Linux would boot 5 times slower, and
it would shut down 5 times slower, which might be caused by the sleep
and usleep commands used in the /etc/init.d scripts.  Naturally, I
expected some software to run 10 times slower, such as the top
command, which is supposed to report results every 3 seconds.

My simple test was to copy a 1GB file between two disc partitions.  On
a regular kernel I ran:

~ >time cp 1GB /jaguar/ijs/
real    1m50.529s
user    0m0.185s
sys     0m6.869s

Then on the slow kernel I ran:

~ >time cp 1GB /jaguar/ijs/

real    0m10.444s
user    0m0.013s
sys     0m0.578s

Sometimes I had an impression that on the slow kernel some things
worked slightly slower, such as logging in.

Overall, however, it seems that the system was performing 10 times
faster when measured with the slowed down system clock.  Therefore my
simple tests give me some courage to pursue this path.  But before I
start working on this and spend more time on testing and implementing
my software, I want to make sure that I hope for too much and that my
plan is viable.

MY QUESTION IS: Are there some pitfalls or problems which I failed to
notice?

Thanks for reading!


Best,
Irek

