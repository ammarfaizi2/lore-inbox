Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTKDXXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 18:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTKDXXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 18:23:23 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:57516 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261722AbTKDXXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 18:23:21 -0500
Date: Tue, 4 Nov 2003 15:22:53 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       john stultz <johnstul@us.ibm.com>
Subject: get_cycles() on i386
Message-ID: <20031104232252.GG5792@ca-server1.us.oracle.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	john stultz <johnstul@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
	Certain distributions are building all of their SMP kernels
NUMA-aware.  This is great, as the kernels support boxes like the x440
with no trouble.  However, this implicitly disables CONFIG_X86_TSC.
While that is good for NUMA systems, and fine from a kernel timing
standpoint, it also eliminates any generic access to the TSC via
get_cycles().  With CONFIG_X86_TSC not defined, get_cycles() always
returns 0.
	Given that >95% of machines will not be x440s, this means that a
user of that kernel cannot access a high resolution timer via
get_cycles().  I don't want to have to litter my code with rdtscll()
when I managed to remove it!
	The proposed patch is trivial.  If the system has a TSC, it is
available get_cycles().  This makes no change to the other parts of the
kernel protected by CONFIG_X86_TSC.

Joel

diff -uNr ../kernel-2.4.21-4.0.1.EL/linux-2.4.21/include/asm-i386/timex.h linux-2.4.21/include/asm-i386/timex.h
--- ../kernel-2.4.21-4.0.1.EL/linux-2.4.21/include/asm-i386/timex.h	2002-11-28 15:53:15.000000000 -0800
+++ linux-2.4.21/include/asm-i386/timex.h	2003-11-04 11:33:08.000000000 -0800
@@ -40,7 +40,7 @@
 
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
+#ifndef CONFIG_X86_HAS_TSC
 	return 0;
 #else
 	unsigned long long ret;


-- 

"Hey mister if you're gonna walk on water,
 Could you drop a line my way?"

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
