Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWBHRtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWBHRtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 12:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWBHRtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 12:49:41 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:232 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030397AbWBHRtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 12:49:40 -0500
Date: Wed, 8 Feb 2006 17:49:33 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060208174933.GA30719@srcf.ucam.org>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org> <20060208171649.GA21373@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208171649.GA21373@kroah.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 09:16:49AM -0800, Greg KH wrote:

> kerneldoc will not work with this.  It needs to be a one line, short,
> description.  Put the full description below the function paramaters, it
> can be as many lines as you want there.

Ok, how's this one?

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
index 46110d5..31745fb 100644
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
@@ -39,6 +40,41 @@ void pm_set_ops(struct pm_ops * ops)
 	up(&pm_sem);
 }
 
+/**
+ *	pm_set_ac_status - Set the ac status callback.
+ *	@ops:	Pointer to function
+ *
+ *      Provide a callback that returns true if the system is currently on
+ *      AC power. This should be called by power management subsystems.
+ */
+
+void pm_set_ac_status(int (*ac_status_function)(void))
+{
+	down(&pm_sem);
+	get_ac_status = ac_status_function;
+	up(&pm_sem);
+}
+EXPORT_SYMBOL_GPL(pm_set_ac_status);
+
+/**
+ *	pm_get_ac_status - return true if the system is on AC
+ *
+ *      Returns true if the system has a registered callback for determining 
+ *      AC state and is currently on AC power, false otherwise.
+ */
+
+int pm_get_ac_status(void)
+{
+	int status=0;
+
+	down (&pm_sem);
+	if (get_ac_status)
+		status = get_ac_status();
+	up (&pm_sem);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(pm_get_ac_status);
 
 /**
  *	suspend_prepare - Do prep work before entering low-power state.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
