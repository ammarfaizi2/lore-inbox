Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRJEVjK>; Fri, 5 Oct 2001 17:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273818AbRJEVjA>; Fri, 5 Oct 2001 17:39:00 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:13003 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S271911AbRJEVi5>; Fri, 5 Oct 2001 17:38:57 -0400
Date: Fri, 05 Oct 2001 14:35:44 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Olaf Zaplinski <o.zaplinski@mediascape.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.11-pre4
Message-ID: <1565164462.1002292544@mbligh.des.sequent.com>
In-Reply-To: <200110052031.QAA23072@e34.esmtp.ibm.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. OK, it fixes the UP UP_IOAPIC compilation problem.
> System (with preempt-patch) up and runnig.

Good. 
 
> 2. Woohu. I have 8 CPUs, now...;-)
> --- /proc is somewhat broken

Bugger. Didn't realise that cpu_online_map didn't get initialised
to anything sensible under UP. Should be just cosmetic (it's only
the output of /proc/cpuinfo, not the sceduler or anything), but 
try this (I haven't tested it yet - if it doesn't work, just change the
8 to 1 for a second whilst I fix it properly).

===========================

--- setup.c.old	Fri Oct  5 14:20:29 2001
+++ setup.c	Fri Oct  5 14:28:51 2001
@@ -2420,7 +2420,7 @@
 	 * WARNING - nasty evil hack ... if we print > 8, it overflows the
 	 * page buffer and corrupts memory - this needs fixing properly
 	 */
-	for (n = 0; n < 8; n++, c++) {
+	for (n = 0; n < (clustered_apic_mode ? 8 : NR_CPUS); n++, c++) {
 	/* for (n = 0; n < NR_CPUS; n++, c++) { */
 		int fpu_exception;
 #ifdef CONFIG_SMP

===========================

The reason for this hackery is that get_cpuinfo writes to a page
without proper bounds on itself. If you have more than about 8
cpus, it tramples merrily all over the next page, corrupting page
tables, etc, etc. 

The real fix for this overflow was published here a few weeks ago
by James Cleverdon (whom I work with). It's in Alan's tree, but not
Linus' as yet.

M.

