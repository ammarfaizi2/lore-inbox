Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWBHNE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWBHNE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 08:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWBHNE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 08:04:26 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:43927 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030419AbWBHNEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 08:04:25 -0500
Date: Wed, 8 Feb 2006 13:04:22 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060208130422.GB25659@srcf.ucam.org>
References: <20060208125753.GA25562@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208125753.GA25562@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops - missing <linux/module.h>. Here's the fixed version.

Signed-Off-By: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 5be87ba..59ece0f 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -129,6 +129,8 @@ struct pm_ops {
 
 extern void pm_set_ops(struct pm_ops *);
 extern struct pm_ops *pm_ops;
+extern void pm_set_ac_status(int (*ac_status_function)(void));
+extern int pm_get_ac_status(void);
 extern int pm_suspend(suspend_state_t state);
 
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 46110d5..453cd0e 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -15,7 +15,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/pm.h>
-
+#include <linux/module.h>
 
 #include "power.h"
 
@@ -25,6 +25,7 @@
 DECLARE_MUTEX(pm_sem);
 
 struct pm_ops *pm_ops = NULL;
+int (*get_ac_status)(void);
 suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
 
 /**
@@ -39,6 +40,39 @@ void pm_set_ops(struct pm_ops * ops)
 	up(&pm_sem);
 }
 
+/**
+ *	pm_set_ac_status - Set the ac status callback
+ *	@ops:	Pointer to function
+ */
+
+void pm_set_ac_status(int (*ac_status_function)(void))
+{
+	down(&pm_sem);
+	get_ac_status = ac_status_function;
+	up(&pm_sem);
+}
+
+EXPORT_SYMBOL(pm_set_ac_status);
+
+/**
+ *	pm_get_ac_status - return true if the system is on AC
+ */
+
+int pm_get_ac_status(void)
+{
+	int status;
+
+	down (&pm_sem);
+	if (get_ac_status)
+		status = get_ac_status();
+	else
+		status = 0;
+	up (&pm_sem);
+
+	return status;
+}
+
+EXPORT_SYMBOL(pm_get_ac_status);
 
 /**
  *	suspend_prepare - Do prep work before entering low-power state.


-- 
Matthew Garrett | mjg59@srcf.ucam.org
