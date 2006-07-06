Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbWGFJbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWGFJbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWGFJbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:31:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965178AbWGFJbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:31:40 -0400
Date: Thu, 6 Jul 2006 02:31:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>,
       Rich Townsend <rhdt@bartol.udel.edu>
Subject: Re: linux-2.6.17-mm6: can not boot: bad spinlock magic
Message-Id: <20060706023131.04de8092.akpm@osdl.org>
In-Reply-To: <20060706130849.f227ae98.pauldrynoff@gmail.com>
References: <20060706130849.f227ae98.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 13:08:49 +0400
Paul Drynoff <pauldrynoff@gmail.com> wrote:

> I tried 2.6.17-mm6, and got durring boot:
> fb0: VGA16 VGA frame buffer device
> BUG: spinlock bad magic on CPU#0, swapper/1
> _raw_spin_lock
> _spin_lock_irqsave
> __down
> __down_faied
> .text.lock.cm_sbs
> acpi_ac_init
> init
> kernel_thread_helper

Thanks.  This'll probably help.


From: Andrew Morton <akpm@osdl.org>

cm_sbs_sem is being downed (via acpi_ac_init->acpi_lock_ac_dir) before it is
initialised, with grave results.

- Make it a mutex

- Initialise it

- Make it static

- Clean other stuff up.

Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/cm_sbs.c |   46 ++++++++++++----------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff -puN drivers/acpi/cm_sbs.c~acpi-initialise-cm_sbs_sem drivers/acpi/cm_sbs.c
--- a/drivers/acpi/cm_sbs.c~acpi-initialise-cm_sbs_sem
+++ a/drivers/acpi/cm_sbs.c
@@ -39,50 +39,43 @@ ACPI_MODULE_NAME("cm_sbs")
 static struct proc_dir_entry *acpi_ac_dir;
 static struct proc_dir_entry *acpi_battery_dir;
 
-static struct semaphore cm_sbs_sem;
+static DEFINE_MUTEX(cm_sbs_mutex);
 
-static int lock_ac_dir_cnt = 0;
-static int lock_battery_dir_cnt = 0;
+static int lock_ac_dir_cnt;
+static int lock_battery_dir_cnt;
 
 struct proc_dir_entry *acpi_lock_ac_dir(void)
 {
-
-	down(&cm_sbs_sem);
-	if (!acpi_ac_dir) {
+	mutex_lock(&cm_sbs_mutex);
+	if (!acpi_ac_dir)
 		acpi_ac_dir = proc_mkdir(ACPI_AC_CLASS, acpi_root_dir);
-	}
 	if (acpi_ac_dir) {
 		lock_ac_dir_cnt++;
 	} else {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Cannot create %s\n", ACPI_AC_CLASS));
 	}
-	up(&cm_sbs_sem);
+	mutex_unlock(&cm_sbs_mutex);
 	return acpi_ac_dir;
 }
-
 EXPORT_SYMBOL(acpi_lock_ac_dir);
 
 void acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir_param)
 {
-
-	down(&cm_sbs_sem);
-	if (acpi_ac_dir_param) {
+	mutex_lock(&cm_sbs_mutex);
+	if (acpi_ac_dir_param)
 		lock_ac_dir_cnt--;
-	}
 	if (lock_ac_dir_cnt == 0 && acpi_ac_dir_param && acpi_ac_dir) {
 		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
 		acpi_ac_dir = 0;
 	}
-	up(&cm_sbs_sem);
+	mutex_unlock(&cm_sbs_mutex);
 }
-
 EXPORT_SYMBOL(acpi_unlock_ac_dir);
 
 struct proc_dir_entry *acpi_lock_battery_dir(void)
 {
-
-	down(&cm_sbs_sem);
+	mutex_lock(&cm_sbs_mutex);
 	if (!acpi_battery_dir) {
 		acpi_battery_dir =
 		    proc_mkdir(ACPI_BATTERY_CLASS, acpi_root_dir);
@@ -93,39 +86,28 @@ struct proc_dir_entry *acpi_lock_battery
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Cannot create %s\n", ACPI_BATTERY_CLASS));
 	}
-	up(&cm_sbs_sem);
+	mutex_unlock(&cm_sbs_mutex);
 	return acpi_battery_dir;
 }
-
 EXPORT_SYMBOL(acpi_lock_battery_dir);
 
 void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir_param)
 {
-
-	down(&cm_sbs_sem);
-	if (acpi_battery_dir_param) {
+	mutex_lock(&cm_sbs_mutex);
+	if (acpi_battery_dir_param)
 		lock_battery_dir_cnt--;
-	}
 	if (lock_battery_dir_cnt == 0 && acpi_battery_dir_param
 	    && acpi_battery_dir) {
 		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
 		acpi_battery_dir = 0;
 	}
-	up(&cm_sbs_sem);
+	mutex_unlock(&cm_sbs_mutex);
 	return;
 }
-
 EXPORT_SYMBOL(acpi_unlock_battery_dir);
 
 static int __init acpi_cm_sbs_init(void)
 {
-
-	if (acpi_disabled)
-		return 0;
-
-	init_MUTEX(&cm_sbs_sem);
-
 	return 0;
 }
-
 subsys_initcall(acpi_cm_sbs_init);
_

