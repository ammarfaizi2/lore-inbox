Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbVH0G4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbVH0G4z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 02:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbVH0G4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 02:56:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6619 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030326AbVH0G4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 02:56:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Masoud Sharbiani <masouds@masoud.ir>, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] [ACPI] acpi_shutdown: Only prepare for power off on
 power_off
References: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee>
	<m14q9iva4q.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0508221152350.17731@math.ut.ee>
	<m1mznativw.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0508242252120.20856@math.ut.ee>
	<m11x4iofmw.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0508260802230.22690@math.ut.ee>
	<m1ek8htfcc.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0508262144490.24024@math.ut.ee>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 27 Aug 2005 00:56:18 -0600
In-Reply-To: <Pine.SOC.4.61.0508262144490.24024@math.ut.ee> (Meelis Roos's
 message of "Fri, 26 Aug 2005 21:45:10 +0300 (EEST)")
Message-ID: <m1r7cfswa5.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When acpi_sleep_prepare was moved into a shutdown method we
started calling it for all shutdowns.  It appears this triggers
some systems to power off on reboot.  Avoid this by only calling
acpi_sleep_prepare if we are going to power off the system.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


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
