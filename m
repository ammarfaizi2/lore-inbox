Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUAFQVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUAFQVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:21:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:54488 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264359AbUAFQVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:21:04 -0500
Date: Tue, 6 Jan 2004 08:19:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: johnstultz@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
Message-Id: <20040106081947.3d51a1d5.akpm@osdl.org>
In-Reply-To: <1073405053.2047.28.camel@mulgrave>
References: <1073405053.2047.28.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> This patch
> 
> 
>  ChangeSet@1.1534.5.2, 2003-12-30 15:40:23-08:00, akpm@osdl.org
>    [PATCH] ia32 jiffy wrapping fixes
> 
>  Causes the voyager boot to hang.  The problem is this change:
> 
>  --- a/arch/i386/kernel/timers/timer_tsc.c       Tue Jan  6 09:57:34 2004
>  +++ b/arch/i386/kernel/timers/timer_tsc.c       Tue Jan  6 09:57:34 2004
>  @@ -141,7 +140,7 @@
>   #ifndef CONFIG_NUMA
>          if (!use_tsc)
>   #endif
>  -               return (unsigned long long)jiffies * (1000000000 / HZ);
>  +               return (unsigned long long)get_jiffies_64() *
>  (1000000000 / HZ);

Hm, OK.  I hit the same deadlock when running with the "don't require TSCs
to be synchronised in sched_clock()" patch from -mm.  The fix for that is
below.  I shall accelerate it.

--- 25/arch/i386/kernel/timers/timer_tsc.c~sched_clock-2.6.0-A1-deadlock-fix	2003-12-30 00:45:09.000000000 -0800
+++ 25-akpm/arch/i386/kernel/timers/timer_tsc.c	2003-12-30 00:45:09.000000000 -0800
@@ -140,7 +140,8 @@ unsigned long long sched_clock(void)
 #ifndef CONFIG_NUMA
 	if (!use_tsc)
 #endif
-		return (unsigned long long)get_jiffies_64() * (1000000000 / HZ);
+		/* jiffies might overflow but this is not a big deal here */
+		return (unsigned long long)jiffies * (1000000000 / HZ);
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);

_

