Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVCLQjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVCLQjW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVCLQhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:37:50 -0500
Received: from fmr24.intel.com ([143.183.121.16]:64186 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261954AbVCLQhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 11:37:17 -0500
Date: Sat, 12 Mar 2005 08:36:00 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: George Anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
Message-ID: <20050312083559.A23564@unix-os.sc.intel.com>
References: <20050312131143.GA31038@fieldses.org> <4233111A.5070807@mvista.com> <Pine.LNX.4.61.0503120918130.2166@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0503120918130.2166@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Sat, Mar 12, 2005 at 09:25:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 09:25:13AM -0700, Zwane Mwaikambo wrote:
> On Sat, 12 Mar 2005, George Anzinger wrote:
> 
> > And more... That this occures implies we are attempting to update the cmos
> > clock on resume seems wrong.  One would presume that the time is wrong at this
> > time and we are about to save that wrong time.  Possibly the APM code should
> > change time_status to STA_UNSYNC on the way into the sleep (or what ever it is
> > called).  Who should we ping with this?
> 
> timer_resume, which appears to be the problem, wants to calculate amount 
> of time was spent suspended, also your unconditional irq enable in 
> get_cmos_time breaks the atomicity of device_power_up and would deadlock 
> in sections of code which call get_time_diff() with xtime_lock held. I 
> sent a patch subject "APM: fix interrupts enabled in device_power_up" 
> which should address this.
> 

How about this patch? Also fixes one other use of rtc_lock in acpi/sleep/proc.c

Thanks,
Venki


rtc_lock is held during timer interrupts. So, we should block interrupts
while holding it.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

--- linux-2.6.10/arch/i386/kernel/time.c.org	2005-03-12 10:38:23.000000000 -0800
+++ linux-2.6.10/arch/i386/kernel/time.c	2005-03-12 10:40:26.000000000 -0800
@@ -305,15 +305,16 @@ irqreturn_t timer_interrupt(int irq, voi
 unsigned long get_cmos_time(void)
 {
 	unsigned long retval;
+	unsigned long flags;
 
-	spin_lock(&rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 
 	if (efi_enabled)
 		retval = efi_get_time();
 	else
 		retval = mach_get_cmos_time();
 
-	spin_unlock(&rtc_lock);
+	spin_unlock_restore(&rtc_lock, flags);
 
 	return retval;
 }
--- linux-2.6.10/drivers/acpi/sleep/proc.c.org	2005-03-12 10:50:40.000000000 -0800
+++ linux-2.6.10/drivers/acpi/sleep/proc.c	2005-03-12 10:53:08.000000000 -0800
@@ -84,10 +84,11 @@ static int acpi_system_alarm_seq_show(st
 	u32			sec, min, hr;
 	u32			day, mo, yr;
 	unsigned char		rtc_control = 0;
+	unsigned long 		flags;
 
 	ACPI_FUNCTION_TRACE("acpi_system_alarm_seq_show");
 
-	spin_lock(&rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 
 	sec = CMOS_READ(RTC_SECONDS_ALARM);
 	min = CMOS_READ(RTC_MINUTES_ALARM);
@@ -109,7 +110,7 @@ static int acpi_system_alarm_seq_show(st
 	else
 		yr = CMOS_READ(RTC_YEAR);
 
-	spin_unlock(&rtc_lock);
+	spin_unlock_restore(&rtc_lock, flags);
 
 	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
 		BCD_TO_BIN(sec);
