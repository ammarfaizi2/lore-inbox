Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVIUBBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVIUBBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVIUBBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:01:34 -0400
Received: from fmr17.intel.com ([134.134.136.16]:28550 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750858AbVIUBBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:01:33 -0400
Subject: [PATCH]introduce .valid callback in pm_ops
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, akpm <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 09:08:06 +0800
Message-Id: <1127264887.3927.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch adds .valid callback in pm_ops, so only available pm states
show in /sys/power/state. And this also makes an earlier states error
report at enter_state before we do actual suspend/resume.

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
Acked-by: Pavel Machek<pavel@suse.cz> 

---

 linux-2.6.14-rc1-root/drivers/acpi/sleep/main.c |    8 ++++++++
 linux-2.6.14-rc1-root/include/linux/pm.h        |    1 +
 linux-2.6.14-rc1-root/kernel/power/main.c       |    5 ++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff -puN kernel/power/main.c~pm_states_cleanup kernel/power/main.c
--- linux-2.6.14-rc1/kernel/power/main.c~pm_states_cleanup	2005-09-19 16:32:53.000000000 +0800
+++ linux-2.6.14-rc1-root/kernel/power/main.c	2005-09-19 16:51:12.000000000 +0800
@@ -167,6 +167,8 @@ static int enter_state(suspend_state_t s
 {
 	int error;
 
+	if (pm_ops->valid && !pm_ops->valid(state))
+		return -ENODEV;
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
 
@@ -236,7 +238,8 @@ static ssize_t state_show(struct subsyst
 	char * s = buf;
 
 	for (i = 0; i < PM_SUSPEND_MAX; i++) {
-		if (pm_states[i])
+		if (pm_states[i] && pm_ops && (!pm_ops->valid
+			||(pm_ops->valid && pm_ops->valid(i))))
 			s += sprintf(s,"%s ",pm_states[i]);
 	}
 	s += sprintf(s,"\n");
diff -puN include/linux/pm.h~pm_states_cleanup include/linux/pm.h
--- linux-2.6.14-rc1/include/linux/pm.h~pm_states_cleanup	2005-09-19 16:33:35.000000000 +0800
+++ linux-2.6.14-rc1-root/include/linux/pm.h	2005-09-19 16:50:38.000000000 +0800
@@ -170,6 +170,7 @@ typedef int __bitwise suspend_disk_metho
 
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
+	int (*valid)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
diff -puN drivers/acpi/sleep/main.c~pm_states_cleanup drivers/acpi/sleep/main.c
--- linux-2.6.14-rc1/drivers/acpi/sleep/main.c~pm_states_cleanup	2005-09-19 16:42:26.000000000 +0800
+++ linux-2.6.14-rc1-root/drivers/acpi/sleep/main.c	2005-09-19 16:51:33.000000000 +0800
@@ -158,7 +158,15 @@ int acpi_suspend(u32 acpi_state)
 	return -EINVAL;
 }
 
+static int acpi_pm_state_valid(suspend_state_t pm_state)
+{
+	u32 acpi_state = acpi_suspend_states[pm_state];
+
+	return sleep_states[acpi_state];
+}
+
 static struct pm_ops acpi_pm_ops = {
+	.valid = acpi_pm_state_valid,
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_pm_enter,
 	.finish = acpi_pm_finish,
_


