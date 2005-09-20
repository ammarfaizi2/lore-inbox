Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbVITRvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbVITRvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVITRvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:51:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32134 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932711AbVITRvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:51:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: <len.brown@intel.com>, Pierre Ossman <drzeus-list@drzeus.cx>,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       Pavel Machek <pavel@ucw.cz>, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] suspend: Cleanup calling of power off methods.
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com>
	<m1d5ngk4xa.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0509111140550.9218@math.ut.ee>
	<m14q8fhc02.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 20 Sep 2005 11:49:24 -0600
In-Reply-To: <m14q8fhc02.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 20 Sep 2005 11:42:21 -0600")
Message-ID: <m1zmq7fx3v.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the lead up to 2.6.13 I fixed a large number of reboot
problems by making the calling conventions consistent.  Despite
checking and double checking my work it appears I missed an
obvious one.

The S4 suspend code for PM_DISK_PLATFORM was also calling
device_shutdown without setting system_state, and was
not calling the appropriate reboot_notifier.

This patch fixes the bug by replacing the call of device_suspend with
kernel_poweroff_prepare.  

Various forms of this failure have been fixed and tracked for a while.

Thanks for tracking this down go to: Alexey Starikovskiy,
Meelis Roos <mroos@linux.ee>, Nigel Cunningham <ncunningham@cyclades.com>,
Pierre Ossman <drzeus-list@drzeus.cx>

History of this bug is at:
http://bugme.osdl.org/show_bug.cgi?id=4320

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/power/disk.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

2c72ba7b1126a7ccf3e8fc032f041a223e39aa97
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -17,12 +17,12 @@
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
+#include <linux/pm.h>
 
 #include "power.h"
 
 
 extern suspend_disk_method_t pm_disk_mode;
-extern struct pm_ops * pm_ops;
 
 extern int swsusp_suspend(void);
 extern int swsusp_write(void);
@@ -49,13 +49,11 @@ dev_t swsusp_resume_device;
 
 static void power_down(suspend_disk_method_t mode)
 {
-	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_shutdown();
+		kernel_power_off_prepare();
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
