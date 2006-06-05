Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750848AbWFEJLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWFEJLj (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWFEJLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:11:38 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:3315 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750832AbWFEJLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:11:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=VPY+gAhmvAMkyMOerirR4s43lhDFfTMyOUwmRJyZstka3BNjQmX50wN/ncPUNzPCboEFTlthuo0YxFQxw0+gej/zf8Sm7Z02u4vUW4MIDnUz7gy1msRIdoetSc6dhEdo8K9wTU390v1S1cpMbWffvdnkaaIHYH2gupUGRQ9Wa2M=
Date: Mon, 5 Jun 2006 18:11:31 +0900
From: Tejun Heo <htejun@gmail.com>
To: pavel@suse.cz, Jeff Garzik <jgarzik@pobox.com>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH] swsusp: allow drivers to determine between write-resume and actual wakeup
Message-ID: <20060605091131.GE8106@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no way to tell whether a device is resuming to
write swsusp image or waking up from actual software suspend.  FREEZE
and SUSPEND are different operations for some devices (e.g. disks
don't spin down for FREEZE) and the resume operation for each is also
different.

This patch makes swsusp change device power state from PMSG_FREEZE to
PMSG_SUSPEND on resume from software suspend.  A driver can determine
whether it's getting thawed or resuming by looking at device power
state - if FREEZE, it's getting thawed to write image; if SUSPEND,
resuming from software suspend.  This patch doesn't affect drivers
which don't update device power state.  Only drivers which set power
state to FREEZE after freezing are affected.

Note that the behavior introduced by this patch is more correct in
that, on resume, the last power operation done on those devices are
PMSG_SUSPEND, not PMSG_FREEZE.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Hello, Pavel.

I'm currently working on libata suspend/resume support.  libata needs
to take different actions for getting thawed and resuming, so this
patch.  If you have any better idea, please let me know.

Also, another piece of information libata can use is whether the
current power operation is due to runtime (per-device) PM request or
system PM event.  In ATA, many EH operations are bus-wide and it would
be better/simpler to perform PM bus-wide if possible.  I think this
can be done by adding a function to query global PM state.

Thanks.

 drivers/base/power/resume.c |   25 +++++++++++++++++++++++++
 include/linux/pm.h          |    1 +
 kernel/power/swsusp.c       |    4 ++++
 3 files changed, 30 insertions(+), 0 deletions(-)

4f2edc42e5b0d628ba164e4f438a7255672a82a2
diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 317edbf..3e08c58 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -122,3 +122,28 @@ void device_power_up(void)
 EXPORT_SYMBOL_GPL(device_power_up);
 
 
+/**
+ *	device_prep_swsusp_resume - Prep for resume from swsusp
+ *
+ *	Change power state of devices from PMSG_FREEZE to PMSG_SUSPEND
+ *	in preparation for resume from swsusp.  This allows drivers to
+ *	tell whether they are resuming from frozen state to write
+ *	image or from actual swsusp.
+ */
+
+void device_prep_swsusp_resume(void)
+{
+	struct device *dev;
+
+	list_for_each_entry(dev, &dpm_off_irq, power.entry)
+		if (dev->power.power_state.event == PM_EVENT_FREEZE)
+			dev->power.power_state = PMSG_SUSPEND;
+
+	down(&dpm_sem);
+	down(&dpm_list_sem);
+	list_for_each_entry(dev, &dpm_off, power.entry)
+		if (dev->power.power_state.event == PM_EVENT_FREEZE)
+			dev->power.power_state = PMSG_SUSPEND;
+	up(&dpm_list_sem);
+	up(&dpm_sem);
+}
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 66be589..3e1d79c 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -184,6 +184,7 @@ #endif
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
 extern int device_power_down(pm_message_t state);
+extern void device_prep_swsusp_resume(void);
 extern void device_power_up(void);
 extern void device_resume(void);
 
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index c4016cb..a534f84 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -238,6 +238,10 @@ int swsusp_suspend(void)
 		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
+
+	if (!in_suspend)
+		device_prep_swsusp_resume();
+
 Restore_highmem:
 	restore_highmem();
 	device_power_up();
-- 
1.3.2

