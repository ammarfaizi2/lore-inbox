Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318200AbSGaM5F>; Wed, 31 Jul 2002 08:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318294AbSGaM5E>; Wed, 31 Jul 2002 08:57:04 -0400
Received: from sunny.pacific.net.au ([203.25.148.40]:18120 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S318200AbSGaM5C>; Wed, 31 Jul 2002 08:57:02 -0400
From: "David Luyer" <david@luyer.net>
To: <linux-kernel@vger.kernel.org>
Subject: FW: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Date: Wed, 31 Jul 2002 23:00:26 +1000
Message-ID: <00c301c23892$3d2dfd40$638317d2@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(re-send, initially sent from wrong address)

Alan Cox wrote:
> > procps version is 2.0.7 (Debian 3.0).
> > 
> > Where's the mistake -- should timer interrupts be on both
> > CPUs (I think this is the problem), or is procps miscalculating
> > Hz (seems less likely, someone would have noticed by now...)?
> 
> HZ on x86 for user space is defined as 100. Its a procps problem

Slight error in my initial diagnosis of why procps is getting Hertz
wrong tho.  It's not because timer interrupts are only happening
on one CPU.  It's because it thinks I have 4 CPUs per system, when
really I only have 2 CPUs per system.

It's taking jiffies from the sum of the figures on the first line
of /proc/stat and dividing by the uptime in seconds from /proc/uptime
multiplied by the number of CPUs.  The system has two CPUs, #0 and #1,
and is reporting _SC_NPROCESSORS_CONF as 4 (the count used by procps
as the number of CPUs).

Looks like even if it is procps's fault for not just using HZ==100,
the kernel is leading it astray by claiming I have twice as many
CPUs as I really do.

uyer@praxis8:~$ make cpus
cc     cpus.c   -o cpus
luyer@praxis8:~$ cat cpus.c
#include <unistd.h>

main () {
  printf("%d\n", sysconf(_SC_NPROCESSORS_CONF));
}
luyer@praxis8:~$ ./cpus
4
luyer@praxis8:~$ grep 'processor        ' /proc/cpuinfo
processor       : 0
processor       : 1
luyer@praxis8:~$ dmesg | grep -E 'Initializing CPU|CPU #. not
responding'
Initializing CPU#0
Initializing CPU#1
CPU #3 not responding - cannot use it.

David.

