Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbULCRra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbULCRra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbULCRr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:47:29 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1275 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262444AbULCRqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:46:45 -0500
Message-ID: <41B0A67C.6020006@mvista.com>
Date: Fri, 03 Dec 2004 09:46:36 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: [Fwd: Re: do_posix_clock_monotonic_gettime() returns negative nsec]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just adding my sign off.  Using forward to avoid the dreaded ">" marks

-------- Original Message --------
Subject: Re: do_posix_clock_monotonic_gettime() returns negative nsec
Date: Fri, 3 Dec 2004 18:22:03 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: George Anzinger <george@mvista.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041203020357.GA28468@mail.13thfloor.at> 
<20041202190823.4f287617.akpm@osdl.org> 
<20041203032024.GA29553@mail.13thfloor.at> <41B0297D.3050202@mvista.com>

On Fri, Dec 03, 2004 at 12:53:17AM -0800, George Anzinger wrote:
> Herbert Poetzl wrote:
> >On Thu, Dec 02, 2004 at 07:08:23PM -0800, Andrew Morton wrote:
> >>Herbert Poetzl <herbert@13thfloor.at> wrote:
> >>
> >>>
> >>>Hi Folks!
> >>>
> >>>recent kernels (tested 2.6.10-rc2 and 2.6.10-rc2-bk15)
> >>>produce funny output in /proc/uptime like this:
> >>>
> >>>	# cat /proc/uptime
> >>>	  12.4294967218 9.05
> >>>	# cat /proc/uptime
> >>>	  13.4294967251 10.33
> >>>	# cat /proc/uptime
> >>>	  14.4294967295 11.73
> >>>
> >>>a short investigation of the issue, ended at
> >>>do_posix_clock_monotonic_gettime() which can (and 
> >>>often does) return negative nsec values (within
> >>>one second), so while the actual 'time' returned
> >>>is correct, some parts of the kernel assume that
> >>>those part is within the range (0 - NSEC_PER_SEC)
> >>>
> >>>       len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> >>>                       (unsigned long) uptime.tv_sec,
> >>>                       (uptime.tv_nsec / (NSEC_PER_SEC / 100)),
> >>>
> >>>as the function itself corrects overflows, it would
> >>>make sense to me to correct underflows too, for 
> >>>example with the following patch:
> >>>
> >>>--- ./kernel/posix-timers.c.orig	2004-11-19 21:11:05.000000000 +0100
> >>>+++ ./kernel/posix-timers.c	2004-12-03 02:23:56.000000000 +0100
> >>>@@ -1208,7 +1208,10 @@ int do_posix_clock_monotonic_gettime(str
> >>>	tp->tv_sec += wall_to_mono.tv_sec;
> >>>	tp->tv_nsec += wall_to_mono.tv_nsec;
> >>>
> >>>-	if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
> >>>+	if (tp->tv_nsec < 0) {
> >>>+		tp->tv_nsec += NSEC_PER_SEC;
> >>>+		tp->tv_sec--;
> >>>+	} else if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
> >>>		tp->tv_nsec -= NSEC_PER_SEC;
> >>>		tp->tv_sec++;
> >>>	}
> >>
> >>Doesn't this imply that do_posix_clock_monotonic_gettime_parts() is
> >>returning a negative tv_nsec?
> >
> >
> >nope, not necessarily, because after that ...
> >
> >        tp->tv_sec += wall_to_mono.tv_sec;
> >        tp->tv_nsec += wall_to_mono.tv_nsec;
> >
> >might add a negative value, which explains the
> >underflow ...
> >
> >and if you look closer:
> >
> >	xtime.tv_sec = get_cmos_time();
> >        wall_to_monotonic.tv_sec = -xtime.tv_sec;
> >        xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> >        wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
> 
> Yep, that IS the problem.  It should be normalized here,  I.e.
> 	set_normalized_timespec(wall_to_monotonic,
> 		wall_to_monotonic.tv_sec - xtime.tv_sec,
> 		wall_to_monotonic.tv_nsec - xtime.tv_nsec);
> with the obvious delets :)

agreed, especially as almost all archs do it
properly (jsut i386 and m32r miss that)

> Still, this should be corrected by the first settimeofday, which most 
> systems do on the way up, or is that just those who use NTP?

correct, but not all use settimeofday() ...

here is a better patch:

Fix the non-normalized wall_to_monotonic for i386 and m32r
(The other archs seem to get it right)

Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>
Signed-off-by: George Anzinger george@mvista.com

diff -NurpP --minimal linux-2.6.10-rc2-bk15/arch/i386/kernel/time.c 
linux-2.6.10-rc2-bk15.2/arch/i386/kernel/time.c
--- linux-2.6.10-rc2-bk15/arch/i386/kernel/time.c	2004-11-19 21:10:28.000000000 
+0100
+++ linux-2.6.10-rc2-bk15-fix/arch/i386/kernel/time.c	2004-12-03 
18:12:06.000000000 +0100
@@ -381,9 +381,9 @@ extern void (*late_time_init)(void);
  void __init hpet_time_init(void)
  {
  	xtime.tv_sec = get_cmos_time();
-	wall_to_monotonic.tv_sec = -xtime.tv_sec;
  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
+	set_normalized_timespec(&wall_to_monotonic,
+		-xtime.tv_sec, -xtime.tv_nsec);

  	if (hpet_enable() >= 0) {
  		printk("Using HPET for base-timer\n");
@@ -409,9 +409,9 @@ void __init time_init(void)
  	}
  #endif
  	xtime.tv_sec = get_cmos_time();
-	wall_to_monotonic.tv_sec = -xtime.tv_sec;
  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
+	set_normalized_timespec(&wall_to_monotonic,
+		-xtime.tv_sec, -xtime.tv_nsec);

  	cur_timer = select_timer();
  	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
diff -NurpP --minimal linux-2.6.10-rc2-bk15/arch/m32r/kernel/time.c 
linux-2.6.10-rc2-bk15.2/arch/m32r/kernel/time.c
--- linux-2.6.10-rc2-bk15/arch/m32r/kernel/time.c	2004-12-03 00:38:43.000000000 
+0100
+++ linux-2.6.10-rc2-bk15-fix/arch/m32r/kernel/time.c	2004-12-03 
18:00:14.000000000 +0100
@@ -275,8 +275,8 @@ void __init time_init(void)

  	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	wall_to_monotonic.tv_sec = -xtime.tv_sec;
-	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
+	set_normalized_timespec(&wall_to_monotonic,
+		-xtime.tv_sec, -xtime.tv_nsec);

  #if defined(CONFIG_CHIP_M32102) || defined(CONFIG_CHIP_XNUX2) \
  	|| defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_M32700) \


best,
Herbert


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

