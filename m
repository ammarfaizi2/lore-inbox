Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbULCCEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbULCCEC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 21:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbULCCEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 21:04:02 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:14222 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261877AbULCCD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 21:03:58 -0500
Date: Fri, 3 Dec 2004 03:03:58 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: do_posix_clock_monotonic_gettime() returns negative nsec
Message-ID: <20041203020357.GA28468@mail.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

recent kernels (tested 2.6.10-rc2 and 2.6.10-rc2-bk15)
produce funny output in /proc/uptime like this:

	# cat /proc/uptime
	  12.4294967218 9.05
	# cat /proc/uptime
	  13.4294967251 10.33
	# cat /proc/uptime
	  14.4294967295 11.73

a short investigation of the issue, ended at
do_posix_clock_monotonic_gettime() which can (and 
often does) return negative nsec values (within
one second), so while the actual 'time' returned
is correct, some parts of the kernel assume that
those part is within the range (0 - NSEC_PER_SEC)

        len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
                        (unsigned long) uptime.tv_sec,
                        (uptime.tv_nsec / (NSEC_PER_SEC / 100)),

as the function itself corrects overflows, it would
make sense to me to correct underflows too, for 
example with the following patch:

--- ./kernel/posix-timers.c.orig	2004-11-19 21:11:05.000000000 +0100
+++ ./kernel/posix-timers.c	2004-12-03 02:23:56.000000000 +0100
@@ -1208,7 +1208,10 @@ int do_posix_clock_monotonic_gettime(str
 	tp->tv_sec += wall_to_mono.tv_sec;
 	tp->tv_nsec += wall_to_mono.tv_nsec;
 
-	if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
+	if (tp->tv_nsec < 0) {
+		tp->tv_nsec += NSEC_PER_SEC;
+		tp->tv_sec--;
+	} else if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
 		tp->tv_nsec -= NSEC_PER_SEC;
 		tp->tv_sec++;
 	}

best,
Herbert

