Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVK2PKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVK2PKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVK2PKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:10:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8932 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751362AbVK2PKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:10:19 -0500
Date: Tue, 29 Nov 2005 16:08:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: [PATCH] fix swsusp on machines not supporting S4
Message-ID: <20051129150802.GA17273@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix swsusp on machines not supporting S4. With recent changes, it is
not possible to trigger it using /sys filesystem. Swsusp does not
really need any support from low-level code, it is possible to reboot
or halt at the end of suspend.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 72936ce37893098af1e2ec30b95274ca721bbf82
tree 5b6aaf5cd5402bfc19b3faeab179c88803756805
parent 3248196034f5f0a93554b441bd41af2620afa635
author <pavel@amd.(none)> Tue, 29 Nov 2005 16:05:14 +0100
committer <pavel@amd.(none)> Tue, 29 Nov 2005 16:05:14 +0100

 kernel/power/main.c  |   21 ++++++++++++++++-----
 kernel/power/power.h |    3 ---
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -24,7 +24,7 @@
 
 DECLARE_MUTEX(pm_sem);
 
-struct pm_ops * pm_ops = NULL;
+struct pm_ops *pm_ops = NULL;
 suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
 
 /**
@@ -151,6 +151,18 @@ static char *pm_states[PM_SUSPEND_MAX] =
 #endif
 };
 
+static inline int valid_state(suspend_state_t state)
+{
+	/* Suspend-to-disk does not really need low-level support.
+	 * It can work with reboot if needed. */
+	if (state == PM_SUSPEND_DISK)
+		return 1;
+
+	if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
+		return 0;
+	return 1;
+}
+
 
 /**
  *	enter_state - Do common work of entering low-power state.
@@ -167,7 +179,7 @@ static int enter_state(suspend_state_t s
 {
 	int error;
 
-	if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
+	if (!valid_state(state))
 		return -ENODEV;
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
@@ -238,9 +250,8 @@ static ssize_t state_show(struct subsyst
 	char * s = buf;
 
 	for (i = 0; i < PM_SUSPEND_MAX; i++) {
-		if (pm_states[i] && pm_ops && (!pm_ops->valid
-			||(pm_ops->valid && pm_ops->valid(i))))
-			s += sprintf(s,"%s ",pm_states[i]);
+		if (pm_states[i] && valid_state(i))
+			s += sprintf(s,"%s ", pm_states[i]);
 	}
 	s += sprintf(s,"\n");
 	return (s - buf);

-- 
Thanks, Sharp!
