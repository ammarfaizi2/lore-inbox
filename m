Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVCLRr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVCLRr1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 12:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVCLRr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 12:47:27 -0500
Received: from fmr21.intel.com ([143.183.121.13]:18314 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261191AbVCLRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 12:47:14 -0500
Date: Sat, 12 Mar 2005 09:45:50 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       George Anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
Message-ID: <20050312094550.A23946@unix-os.sc.intel.com>
References: <20050312131143.GA31038@fieldses.org> <4233111A.5070807@mvista.com> <Pine.LNX.4.61.0503120918130.2166@montezuma.fsmlabs.com> <20050312083559.A23564@unix-os.sc.intel.com> <Pine.LNX.4.61.0503120942570.2166@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0503120942570.2166@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Sat, Mar 12, 2005 at 09:46:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 09:46:54AM -0700, Zwane Mwaikambo wrote:
> On Sat, 12 Mar 2005, Venkatesh Pallipadi wrote:
> 
> > On Sat, Mar 12, 2005 at 09:25:13AM -0700, Zwane Mwaikambo wrote:
> > 
> > How about this patch? Also fixes one other use of rtc_lock in acpi/sleep/proc.c
> >
> > rtc_lock is held during timer interrupts. So, we should block interrupts
> > while holding it.
> 
> It's certainly a lot safer with saving/restoring eflags and the 
> drivers/acpi/sleep/proc.c change is a good catch, but i think the 
> get_cmos_time() callers should take care of the interrupt disabling. btw, 
> s/spin_unlock_restore/spin_unlock_irqrestore/. Please submit the proc.c 
> change.
> 

So, I will assume get_cmos_time issue will be fixed in some other way.
Sending the proper proc.c change this time. 
Andrew: Please apply.

Thanks,
Venki

rtc_lock is held during timer interrupts. So, we should block interrupts
while holding it.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

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
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
 		BCD_TO_BIN(sec);
