Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTKDX3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 18:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTKDX3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 18:29:35 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:62704 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261351AbTKDX3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 18:29:34 -0500
Subject: Re: get_cycles() on i386
From: john stultz <johnstul@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20031104232252.GG5792@ca-server1.us.oracle.com>
References: <20031104232252.GG5792@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: 
Message-Id: <1067988463.11437.115.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Nov 2003 15:27:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-04 at 15:22, Joel Becker wrote:
> Folks,
> 	Certain distributions are building all of their SMP kernels
> NUMA-aware.  This is great, as the kernels support boxes like the x440
> with no trouble.  However, this implicitly disables CONFIG_X86_TSC.
> While that is good for NUMA systems, and fine from a kernel timing
> standpoint, it also eliminates any generic access to the TSC via
> get_cycles().  With CONFIG_X86_TSC not defined, get_cycles() always
> returns 0.
> 	Given that >95% of machines will not be x440s, this means that a
> user of that kernel cannot access a high resolution timer via
> get_cycles().  I don't want to have to litter my code with rdtscll()
> when I managed to remove it!
> 	The proposed patch is trivial.  If the system has a TSC, it is
> available get_cycles().  This makes no change to the other parts of the
> kernel protected by CONFIG_X86_TSC.

CONFIG_X86_TSC be the devil. Personally, I'd much prefer dropping the
compile time option and using dynamic detection. Something like (not
recently tested and i believe against 2.5.something, but you get the
idea):


diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Mon Feb 24 21:09:32 2003
+++ b/include/asm-i386/timex.h	Mon Feb 24 21:09:32 2003
@@ -40,14 +40,10 @@
 
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
-	return 0;
-#else
-	unsigned long long ret;
-
-	rdtscll(ret);
+	unsigned long long ret = 0;
+	if(cpu_has_tsc)
+		rdtscll(ret);
 	return ret;
-#endif
 }
 
 extern unsigned long cpu_khz;


thanks
-john


