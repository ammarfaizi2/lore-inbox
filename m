Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTKYQpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTKYQpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:45:53 -0500
Received: from users.ccur.com ([208.248.32.211]:61560 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S262805AbTKYQpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:45:51 -0500
Date: Tue, 25 Nov 2003 11:42:38 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: root@chaos.analogic.com, George Anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Gabriel Paubert <paubert@iram.es>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC] possible erronous use of tick_usec in do_gettimeofday
Message-ID: <20031125164237.GA15498@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <1067300966.1118.378.camel@cog.beaverton.ibm.com> <20031027171738.1f962565.shemminger@osdl.org> <20031028115558.GA20482@iram.es> <20031028102120.01987aa4.shemminger@osdl.org> <20031029100745.GA6674@iram.es> <20031029113850.047282c4.shemminger@osdl.org> <16288.17470.778408.883304@wombat.chubb.wattle.id.au> <3FA1838C.3060909@mvista.com> <Pine.LNX.4.53.0310301645170.16005@chaos> <16289.39801.239846.9369@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16289.39801.239846.9369@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

test10's version of do_gettimeofday is using tick_usec which is
defined in terms of USER_HZ not HZ.

Against 2.6.0-test10-bk1.  Compiled, not tested, for comment only.

Joe

--- base/arch/i386/kernel/time.c	2003-11-23 20:31:55.000000000 -0500
+++ new/arch/i386/kernel/time.c	2003-11-25 11:22:38.000000000 -0500
@@ -94,7 +94,7 @@
 {
 	unsigned long seq;
 	unsigned long usec, sec;
-	unsigned long max_ntp_tick = tick_usec - tickadj;
+	unsigned long max_ntp_tick;
 
 	do {
 		unsigned long lost;
@@ -110,13 +110,14 @@
 		 * Better to lose some accuracy than have time go backwards..
 		 */
 		if (unlikely(time_adjust < 0)) {
+			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
 			usec = min(usec, max_ntp_tick);
 
 			if (lost)
 				usec += lost * max_ntp_tick;
 		}
 		else if (unlikely(lost))
-			usec += lost * tick_usec;
+			usec += lost * (USEC_PER_SEC / HZ);
 
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
