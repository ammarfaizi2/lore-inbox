Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261979AbRFGLAq>; Thu, 7 Jun 2001 07:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbRFGLAh>; Thu, 7 Jun 2001 07:00:37 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:48512 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261979AbRFGLAY>;
	Thu, 7 Jun 2001 07:00:24 -0400
Date: Thu, 7 Jun 2001 13:00:15 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200106071100.NAA11961@harpo.it.uu.se>
To: remi@a2zis.com
Subject: Re: 2.4.5-ac8 hardlocks when going to standby
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001 22:42:53 +0200, Remi Turk wrote:

>On Wed, Jun 06, 2001 at 07:03:09PM +0200, Remi Turk wrote:
>> 
>> By applying the following patch (lookalike)?
>> 
>> arch/i386/kernel/apm.c:send_event():
>> 
>> 	case APM_SYS_SUSPEND:
>> 	case APM_CRITICAL_SUSPEND:
>> 	case APM_USER_SUSPEND:
>> +	case APM_USER_STANDBY:
>> +	case APM_SYS_STANDBY:
>> 		/* map all suspends to ACPI D3 */
>> 		if (pm_send_all(PM_SUSPEND, (void
>> 			*)3)) {
>
>Well, I tried this one (did I understand correctly wat
>you meant???) and it didn't make any difference.

Try the patch below. Reboot. Run 'apm -S' (or --standby) at the
console. Did you see output from both send_event and apic_pm_callback?
If so, repeat by pressing your power-switch-as-standby button. You
should see the same output -- if not, something APM-related is broken.

FYI, the patch below to apm.c:send_event() [w/o the printk] prevents
my ASUS P3B-F from hanging hard if I invoke apm standby in a UP-APIC
enabled kernel. (Actually, standby doesn't do much on my box since
it wakes up after 1 second or so. I don't know why, perhaps a hub->nic
link beat? 'suspend' works ok, however. Oh, and I have to disable
RedHat's worthless 'kudzu' crap, otherwise 'suspend' won't work.)

/Mikael

--- linux-2.4.5-ac9/arch/i386/kernel/apic.c.~1~	Thu Jun  7 11:58:19 2001
+++ linux-2.4.5-ac9/arch/i386/kernel/apic.c	Thu Jun  7 12:12:19 2001
@@ -480,6 +480,8 @@
 
 static int apic_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
 {
+	printk(__FUNCTION__ ": rqst %u data %lu\n", rqst, (long)data);
+	mdelay(1000);
 	switch (rqst) {
 	case PM_SUSPEND:
 		apic_pm_suspend(data);
--- linux-2.4.5-ac9/arch/i386/kernel/apm.c.~1~	Thu Jun  7 11:58:42 2001
+++ linux-2.4.5-ac9/arch/i386/kernel/apm.c	Thu Jun  7 12:12:10 2001
@@ -915,10 +915,13 @@
 
 static int send_event(apm_event_t event)
 {
+	printk(__FUNCTION__ ": event %u\n", event);
 	switch (event) {
 	case APM_SYS_SUSPEND:
 	case APM_CRITICAL_SUSPEND:
 	case APM_USER_SUSPEND:
+	case APM_SYS_STANDBY:
+	case APM_USER_STANDBY:
 		/* map all suspends to ACPI D3 */
 		if (pm_send_all(PM_SUSPEND, (void *)3)) {
 			if (event == APM_CRITICAL_SUSPEND) {
@@ -932,6 +935,7 @@
 		break;
 	case APM_NORMAL_RESUME:
 	case APM_CRITICAL_RESUME:
+	case APM_STANDBY_RESUME:
 		/* map all resumes to ACPI D0 */
 		(void) pm_send_all(PM_RESUME, (void *)0);
 		break;
--- linux-2.4.5-ac9/arch/i386/kernel/nmi.c.~1~	Thu Jun  7 11:58:42 2001
+++ linux-2.4.5-ac9/arch/i386/kernel/nmi.c	Thu Jun  7 12:12:29 2001
@@ -124,6 +124,8 @@
 
 static int nmi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
 {
+	printk(__FUNCTION__ ": rqst %u data %lu\n", rqst, (long)data);
+	mdelay(1000);
 	switch (rqst) {
 	case PM_SUSPEND:
 		disable_apic_nmi_watchdog();
