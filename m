Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUCUUUN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 15:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUCUUUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 15:20:13 -0500
Received: from dirac.phys.uwm.edu ([129.89.57.19]:19342 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S261220AbUCUUTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 15:19:54 -0500
Date: Sun, 21 Mar 2004 14:19:53 -0600 (CST)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: openlog() ; vsyslog(); closelog() has wrong time
Message-ID: <Pine.GSO.4.21.0403211344560.25561-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smartd runs on my laptop, using openlog() ; vsyslog(); closelog(); to
write to SYSLOG.  It's been running for a few days.  This is stock RH9
Linux lap 2.4.20-30.9 #1 Wed Feb 4 20:44:26 EST 2004 i686 i686 i386
GNU/Linux

I arrived in Berlin yesterday from the USA (dt is seven hours) and copied
/usr/share/zoneinfo/Europe/Berlin into /etc/localtime so that my desktop
would display the right local time.  System clock is UTC.

I just noticed that smartd is logging the WRONG time into SYSLOG.  Here
are the entries, in order, with some comments from me inserted after "***"

Mar 21 04:02:17 localhost syslogd 1.4.1: restart.
Mar 21 11:11:24 localhost su(pam_unix)[21417]: session opened for user
news by (uid=0)
Mar 21 11:11:24 localhost su(pam_unix)[21417]: session closed for user
news
Mar 21 12:10:30 localhost ntpd[3060]: synchronisation lost

*** I run ntpd.

Mar 21 12:11:38 localhost ntpd[3060]: time reset 2.738912 s
Mar 21 12:11:38 localhost ntpd[3060]: synchronisation lost
Mar 21 14:22:45 localhost ntpd[3060]: synchronisation lost
Mar 21 14:29:22 localhost ntpd[3060]: time reset 2.272984 s
Mar 21 14:29:22 localhost ntpd[3060]: synchronisation lost
Mar 21 15:45:01 localhost ntpd[3060]: synchronisation lost
Mar 21 16:00:53 localhost ntpd[3060]: time reset 4.989967 s
Mar 21 16:00:53 localhost ntpd[3060]: synchronisation lost
Mar 21 12:28:31 localhost smartd[2072]: Device: /dev/hda, starting
scheduled Short Self-Test.

*** And there's the problem. openlog/vslog/closelog have the wrong time!
*** I noticed this because I heard the disk starting a scheduled self-test
*** at the wrong time, which means that time(2) is returning the wrong
*** value within the smartd process (not just for syslog).

Mar 21 19:29:03 localhost su(pam_unix)[13096]: session opened
for user root by ballen(uid=500)
Mar 21 13:41:16 localhost smartd[2072]: Signal USR1 - checking devices now
rather than in 1035 seconds.

*** This time difference is exactly the difference between US Central time
*** and Berlin time: 7 hours.

Mar 21 20:42:28 localhost logger: here is the output of date Sun Mar 21
20:42:27 CET 2004

*** I echoed the output of `date` into "logger" above

Mar 21 20:42:40 localhost logger: here is the output of ntptime
ntp_gettime() returns code 0 (OK) time c4086eb0.6ad0b000 Sun, Mar 21 2004
20:42:40.417, (.417247), maximum error 312657 us, estimated error 6382 us
ntp_adjtime() returns code 0 (OK) modes 0x0 (), offset -17322.000
us, frequency 82.893 ppm, interval 4 s, maximum error 312657 us, estimated
error 6382 us, status 0x1 (PLL), time constant 6, precision 1.000 us,
tolerance 512 ppm, pps frequency 0.000 ppm, stability 512.000 ppm, jitter
200.000 us, intervals 0, jitter exceeded 0, stability exceeded 0, errors
0.

*** I echoed the output of `ntptime` into "logger" above

Mar 21 13:42:44 localhost smartd[2072]: Signal USR1 - checking devices now
rather than in 947 seconds.

*** and finally, I sent SIGUSR1 to smartd.  It's still logging US Central
*** time!

Is this glibc problem, an ntpd problem, a kernel problem, or is there
something wrong with my smartd code?  The following bit of code is
equivalent to what's in smartd:

 int main() {
   time_t now=time(NULL);
   openlog("smartd", LOG_PID, LOG_DAEMON);
   syslog(LOG_INFO, "local time is %s\n", ctime(&now));
   closelog();
   return 0;
 }

and it makes this (correct!) entry:

Mar 21 21:13:25 localhost experiment[13705]: local time is Sun Mar 21
21:13:25 2004

This is making the jet lag even worse (;-)!

Cheers,
	Bruce

