Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUBZBxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbUBZBxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:53:19 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63887 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262322AbUBZBxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:53:13 -0500
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <403D0F63.3050101@mvista.com>
References: <403C014F.2040504@blue-labs.org>
	 <1077674048.10393.369.camel@cube>  <403C2E56.2060503@blue-labs.org>
	 <1077679677.10393.431.camel@cube>  <403CCD3A.7080200@mvista.com>
	 <1077725042.8084.482.camel@cube>  <403D0F63.3050101@mvista.com>
Content-Type: text/plain
Message-Id: <1077760348.2857.129.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 25 Feb 2004 17:52:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-25 at 13:10, George Anzinger wrote:
> Albert Cahalan wrote:
> > This is NOT sane. Remeber that procps doesn't get to see HZ.
> > Only USER_HZ is available, as the AT_CLKTCK ELF note.
> > 
> > I think the way to fix this is to skip or add a tick
> > every now and then, so that the long-term HZ is exact.
> > 
> > Another way is to simply choose between pure old-style
> > tick-based timekeeping and pure new-style cycle-based
> > (TSC or ACPI) timekeeping. Systems with uncooperative
> > hardware have to use the old-style time keeping. This
> > should simply the code greatly.
> 
> On checking the code and thinking about this, I would suggest that we change 
> start_time in the task struct to be the wall time (or monotonic time if that 
> seems better).  I only find two places this is used, in proc and in the 
> accounting code.  Both of these could easily be changed.  Of course, even 
> leaving it as it is, they could be changed to report more correct values by 
> using the correct conversions to translate the system HZ to USER_HZ.

Is this close to what your thinking of? 
I can't reproduce the issue on my systems, so I'll need someone else to
test this. 

thanks
-john

--- 1.5/include/linux/times.h	Sun Nov  9 19:26:08 2003
+++ edited/include/linux/times.h	Wed Feb 25 17:39:11 2004
@@ -7,7 +7,7 @@
 #include <asm/param.h>
 
 #if (HZ % USER_HZ)==0
-# define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
+# define jiffies_to_clock_t(x) (((x*TICK_NSEC*HZ)/NSEC_PER_SEC) / (HZ / USER_HZ))
 #else
 # define jiffies_to_clock_t(x) ((clock_t) jiffies_64_to_clock_t((u64) x))
 #endif




