Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWGHQdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWGHQdo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWGHQdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:33:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45502 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964893AbWGHQdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:33:43 -0400
Date: Sat, 8 Jul 2006 09:33:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com,
       kristen.c.accardi@intel.com
Subject: Re: 2.6.18-rc1: breaks boot on thinkpad x32 -- acpiphp problems?
Message-Id: <20060708093339.79453063.akpm@osdl.org>
In-Reply-To: <20060708120635.GA1585@elf.ucw.cz>
References: <20060707105041.GA1656@elf.ucw.cz>
	<20060707040156.e385670e.akpm@osdl.org>
	<20060708120635.GA1585@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006 14:06:35 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> > > I tried to update to 2.6.18-rc1-git, but got hang after
> > > 
> > > acpiphp: Slot [1] registered
> > > 
> > > ...but acpi=off failed to workaround the problem, it merely hung at
> > > another place. I went back to 2.6.18-rc1, and it hung at same
> > > place.
> > 
> > There have been no post-2.6.18-rc1 commits yet.
> >
> > >  2.6.17 works. Any ideas?
> > 
> > Nope.  Is the hang during initial bootup or during modprobing?
> 
> > If during initial bootup, try adding initcall_debug to the boot
> > command line.
> 
> Initial bootup, I basically do not use modules.
> 
> It hangs at the same place... but with with acpi=off, I can see it
> hanging at acpi_ac_init. What is going on?

The patch I sent should fix it, honest.  Here it is again.



From: Andrew Morton <akpm@osdl.org>

cm_sbs_sem is being downed (via acpi_ac_init->acpi_lock_ac_dir) before it is
initialised, with grave results.

- Make it a mutex

- Initialise it

- Make it static

- Clean other stuff up.

Thanks to Paul Drynoff <pauldrynoff@gmail.com> for reporting and testing.

Cc: "Brown, Len" <len.brown@intel.com>
Cc: Rich Townsend <rhdt@bartol.udel.edu>
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

