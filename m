Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVHZFwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVHZFwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 01:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVHZFwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 01:52:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5323 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932495AbVHZFwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 01:52:50 -0400
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Masoud Sharbiani <masouds@masoud.ir>, Len Brown <len.brown@intel.com>
Subject: Re: 2.6.13-rc6: halt instead of reboot
References: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee>
	<m14q9iva4q.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0508221152350.17731@math.ut.ee>
	<m1mznativw.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0508242252120.20856@math.ut.ee>
	<m11x4iofmw.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0508260802230.22690@math.ut.ee>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 25 Aug 2005 23:52:19 -0600
In-Reply-To: <Pine.SOC.4.61.0508260802230.22690@math.ut.ee> (Meelis Roos's
 message of "Fri, 26 Aug 2005 08:05:29 +0300 (EEST)")
Message-ID: <m1ek8htfcc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> writes:

>> When skimming through the code I thought that reboot_thru_bios was the
>> default.
>
> My bad. I retested it and it's reboot=w was the one that works.
>
>> If you can't track this down we can at least dig up your board DMI ID
>> and put it in the list of systems that need to go through the BIOS to reboot.
>
> I have good news - it the ACPI merge commit
> 5028770a42e7bc4d15791a44c28f0ad539323807 that seems to break reboot. Also
> acpi=off works around it.
>
> So the "poweroff instead reboot" seems to be an ACPI regression :(

Does this small patch fix the problem for you?

In another bug fix we started calling acpi_sleep_prepare on the shutdown
path called by reboot/halt/poweroff, so the code would always be called with
interrupts enabled.  This just modifies it so we only call this code
if we know we are going to power off the system.

That change was added in the patch you indicate as where the
regression started.  

---

 drivers/acpi/sleep/poweroff.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

7194b86c5e67aaf9ce8c25482441e87d700f057d
diff --git a/drivers/acpi/sleep/poweroff.c b/drivers/acpi/sleep/poweroff.c
--- a/drivers/acpi/sleep/poweroff.c
+++ b/drivers/acpi/sleep/poweroff.c
@@ -55,7 +55,11 @@ void acpi_power_off(void)
 
 static int acpi_shutdown(struct sys_device *x)
 {
-	return acpi_sleep_prepare(ACPI_STATE_S5);
+	if (system_state == SYSTEM_POWER_OFF) {
+		/* Prepare if we are going to power off the system */
+		return acpi_sleep_prepare(ACPI_STATE_S5);
+	}
+	return 0;
 }
 
 static struct sysdev_class acpi_sysclass = {
