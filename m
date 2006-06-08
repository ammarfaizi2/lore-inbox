Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWFIAAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWFIAAW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 20:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWFIAAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 20:00:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:20968 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964782AbWFIAAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 20:00:22 -0400
Subject: Re: 2.6.17-rc6-rt1
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Murray <mmurray@vmware.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060607211455.GA6132@elte.hu>
References: <20060607211455.GA6132@elte.hu>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 16:57:46 -0700
Message-Id: <1149811066.4266.127.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 23:14 +0200, Ingo Molnar wrote:
> if we accidentally dropped some fix in the process then please complain. 
> x86 and x86_64 build and boot, but some initial rough edges are to be 
> expected. Deepak, your ARM-GTOD patches are included but not tested yet.

Ingo,
	This fix will be needed in 2.6.17-rc6-rt1, as it includes the x86-64
TOD conversion (not yet in -mm).

I accidentally used the kernel-mapped vsyscall_gtod_data value, 
rather then the user-mapped __vsyscall_gtod_data value in do_get_tz.

This would cause gettimeofday to segfault when using a non-null 
timezone pointer.

Many thanks to Martin Murray, who pointed out this issue and its fix.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
index 98692a4..0bda23b 100644
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -125,7 +125,7 @@ static __always_inline void do_vgettimeo
 /* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
 static __always_inline void do_get_tz(struct timezone * tz)
 {
-	*tz = vsyscall_gtod_data.sys_tz;
+	*tz = __vsyscall_gtod_data.sys_tz;
 }
 
 static __always_inline int gettimeofday(struct timeval *tv, struct timezone *tz)


