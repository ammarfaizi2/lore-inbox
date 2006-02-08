Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbWBHHyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWBHHyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWBHHyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:54:45 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:5312 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1161065AbWBHHyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:54:44 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 08 Feb 2006 08:54:22 +0100
MIME-Version: 1.0
Subject: time.c vs. timer.c: patch snipplet
Message-ID: <43E9B1BF.17438.A81054D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.02.0+V=4.02+U=2.07.127+R=06 February 2006+T=118589@20060208.074956Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

maybe some of you know my PPSkit that implements (among others) a new kernel clock 
with nanoseconds resolution for Linux 2.4 (i386). During that I tried to 
streamline the code a bit, specifically moving most clock stuff from timer.c and 
sched.c into time.c. You can make most of the NTP state variables static by doing 
so. I did restrict access to messing with the NTP variables that way, too.

Similarly timex.h should only contain NTP related stuff. Currently timex seems to 
be a "catch all" for add-ons. This mean that about any module includes timex.h, 
and upon changing a single NTP define, about 98% of the kernel are recompiled.

As I'm currently working on a merge of the updated NTP algorithms into 2.6, I 
thought I could ask for opinions here. (I'm not subscribed, so please CC: to me).

As I've done some work already, I'm going to present a patch snipplet that you may 
consider applying without great thought:

I really didn't understand what "if (unlikely(time_adjust < 0)) {" is trying to 
fix:

diff -u -r1.1.1.10 time.c
--- arch/i386/kernel/time.c	15 Jan 2006 06:16:02 -0000	1.1.1.10
+++ arch/i386/kernel/time.c	7 Feb 2006 20:24:51 -0000
@@ -126,7 +128,6 @@
 {
 	unsigned long seq;
 	unsigned long usec, sec;
-	unsigned long max_ntp_tick;
 
 	do {
 		unsigned long lost;
@@ -141,22 +142,15 @@
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
-			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
-			usec = min(usec, max_ntp_tick);
-
-			if (lost)
-				usec += lost * max_ntp_tick;
-		}
-		else if (unlikely(lost))
-			usec += lost * (USEC_PER_SEC / HZ);
+		if (unlikely(lost))
+			usec += lost * tick_usec;
 
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
 	} while (read_seqretry(&xtime_lock, seq));
 
-	while (usec >= 1000000) {
-		usec -= 1000000;
+	while (usec >= USEC_PER_SEC) {
+		usec -= USEC_PER_SEC;
 		sec++;
 	}
 

Also, I don't quite like the name "ntp_clear()": Is it a query, ot is it a 
command? I'd prefer "set_ntp_unsync()", beacsue it says very much what it's about. 
Likewise "ntp_synced()" might look like the opposite of "ntp_clear()" at first, 
but it's actually a query, thus I'd prefer something like "is_ntp_synced()". 
Actually it's "is_ntp_not_unsync()", but we only have binary logic here ;-)

Regards,
Ulrich

