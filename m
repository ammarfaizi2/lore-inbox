Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290578AbSAYHR5>; Fri, 25 Jan 2002 02:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290577AbSAYHRl>; Fri, 25 Jan 2002 02:17:41 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:27400 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S290310AbSAYHRS>; Fri, 25 Jan 2002 02:17:18 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Fri, 25 Jan 2002 08:15:24 +0100
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-22409
Subject: patch: sysctl.h (allocating new number)
Message-ID: <3C51146F.6774.15F75C@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/Sophos-3.53+2.6+2.03.083+07 January 2002+71226@20020125.070336Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-22409
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

Hello,

I have attached a patch (1kB) against sysctl.h of 2.4.16. The patch 
allocates a new number for a directory /proc/sys/kernel/time.

I use that sysctl in the kernel add-on named PPSkit for some time now 
(since 2.2.13). However as the number was never officially allocated, I 
had to change it from 42 to 50, and from 50 to 55 for 2.4.16.

Therefore I'd like to allocate the number permanently.

So is there any benefit? Yes, because there's a problem with 
adjtimex(). Historically it was a bad design descision to use one 
adjtimex() to implement three different routines:

1) adjtime()
2) ntp_adjtime(), ntp_gettime()
3) controlling internal kernel variables like ``tick''

Actually the current implementation is a cul de sac: The current 
reference implementation for the NTP routines uses the same bit 
patterns as some Linux-specific extensions to adjtimex(). Partially 
it's possible to remap the bits in the kernel to do a new 
implementation, but sysctl is the better way to do it.

I have implemented sysctl extensions to read/write the ``tick'' and 
slew rate of adjtime() (among others) for my new kernel clock model 
using nanoseconds (PPSkit-2.0.1). If there's demand to a back-merge to 
the main stream sources, plese say what you would like. As the project 
was sponsored a little bit recently, I'm willing to donate a few 
working hours for that.

The sysctl part looks like this (older kernel):
tick1b:/proc/sys/kernel/time # ll
total 0
dr-xr-xr-x   2 root     root            0 Jan 25 08:10 .
dr-xr-xr-x   3 root     root            0 Jan 25 08:10 ..
-r--r--r--   1 root     root            0 Jan 25 08:10 pps
-rw-r--r--   1 root     root            0 Jan 25 08:10 
rtc_runs_localtime
-rw-r--r--   1 root     root            0 Jan 25 08:10 rtc_update
-rw-r--r--   1 root     root            0 Jan 25 08:10 tickadj
-rw-r--r--   1 root     root            0 Jan 25 08:10 time_tick
-rw-r--r--   1 root     root            0 Jan 25 08:10 timezone

Except for the first entry (experimental for debugging) the contents 
are:
0		(rtc_runs_localtime)
660		(rtc_update)
500000		(tickadj [ns])
10000000	(time_tick [ns])
-60     0	(timezone)

IMHO it's time to make a turn in the cul de sac before the truck hits 
the end of the road.

Regards
Ulrich
NOTE: Not subscribed to linux-kernel, so make sure that I'll get your 
replies...



--Message-Boundary-22409
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'sysctl.h.diff'

Index: include/linux/sysctl.h
===================================================================
RCS file: /root/LinuxCVS/Kernel/include/linux/sysctl.h,v
retrieving revision 1.1.1.6
retrieving revision 1.1.1.6.2.1
diff -u -r1.1.1.6 -r1.1.1.6.2.1
--- include/linux/sysctl.h	2001/12/13 18:56:49	1.1.1.6
+++ include/linux/sysctl.h	2001/12/29 14:59:21	1.1.1.6.2.1
@@ -124,8 +124,19 @@
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
+	KERN_TIME=55,		/* directory: time */
 };
 
+/* KERN_TIME names: */
+enum
+{
+	KERN_TIME_TIMEZONE=1,		/* struct: timezone */
+	KERN_TIME_RTC_UPDATE=2,		/* int: rtc_update */
+	KERN_TIME_RTC_RUNS_LOCALTIME=3,	/* int: rtc_runs_localtime */
+	KERN_TIME_TIME_TICK=4,		/* int: time_tick */
+	KERN_TIME_TICKADJ=5,		/* int: tickadj */
+	KERN_TIME_PPS_VAR=99,		/* struct pps_var: pps */
+};
 
 /* CTL_VM names: */
 enum

--Message-Boundary-22409--
