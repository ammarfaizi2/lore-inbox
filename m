Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268873AbUJEI01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268873AbUJEI01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 04:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268881AbUJEI01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 04:26:27 -0400
Received: from fmr03.intel.com ([143.183.121.5]:38617 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S268873AbUJEI0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 04:26:16 -0400
Date: Tue, 5 Oct 2004 01:25:57 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, akpm@osdl.org
Cc: Andrew Morton <akpm@osdl.org>, jeffpc@optonline.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       trivial@rustcorp.com.au, rusty@rustcorp.com.au,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6][resend] Add DEVPATH env variable to hotplug helper call
Message-ID: <20041005012556.A22721@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20041003100857.GB5804@optonline.net> <20041003162012.79296b37.akpm@osdl.org> <20041004102220.A3304@unix-os.sc.intel.com> <20041004123725.58f1e77c.akpm@osdl.org> <20041004124355.A17894@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041004124355.A17894@unix-os.sc.intel.com>; from anil.s.keshavamurthy@intel.com on Mon, Oct 04, 2004 at 12:43:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 12:43:55PM -0700, Keshavamurthy Anil S wrote:
> On Mon, Oct 04, 2004 at 12:37:25PM -0700, Andrew Morton wrote:
> > Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
> > >
> > 
> > But still, cpu_run_sbin_hotplug() should not exist.  It is duplicating
> > (indeed, emulating) kobject_hotplug() behaviour.  To the extent that it now
> > has a hardwired sysfs path embedded in it:
> > 
> > 	sprintf(devpath_str, "DEVPATH=devices/system/cpu/cpu%d", cpu);
> > 
> > which should have been obtained from kobject_get_path().
> Yes, I agree to your point that cpu_run_sbin_hotplug() is duplication kobject_hotplug()
> behaviour. I will send you a patch to fix this ASAP(hopefully before end of today).

Hi Andrew,
	Here is what I have come up with(please take a look at this patch).
I was successfully able to get rid of cpu_run_sbin_hotplug() function, but
when I call kobject_hotplug() function, it is finding 
top_kobj->kset->hotplug_ops set to NULL and hence returns without calling
call_usermodehelper(). Not sure if this is a bug in kobject_hotplug(), 
I feel kobject_hotplug() function should continue even if 
top_kobj->kset-hotplug_ops is NULL.

CC'ing grek-KH on this mailing list.

Attached is the patch to remove cpu_run_sbin_hotplug.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

---

 linux-2.6.9-rc3-test-askeshav/drivers/base/cpu.c             |    2 
 linux-2.6.9-rc3-test-askeshav/include/linux/kobject_uevent.h |    1 
 linux-2.6.9-rc3-test-askeshav/kernel/cpu.c                   |   34 -----------
 linux-2.6.9-rc3-test-askeshav/lib/kobject_uevent.c           |    1 
 4 files changed, 4 insertions(+), 34 deletions(-)

diff -puN kernel/cpu.c~cpu_run_sbin_hotplug_v2 kernel/cpu.c
--- linux-2.6.9-rc3-test/kernel/cpu.c~cpu_run_sbin_hotplug_v2	2004-10-04 22:51:15.897914273 -0700
+++ linux-2.6.9-rc3-test-askeshav/kernel/cpu.c	2004-10-04 22:51:16.002406459 -0700
@@ -57,33 +57,6 @@ static inline void check_for_tasks(int c
 	write_unlock_irq(&tasklist_lock);
 }
 
-/* Notify userspace when a cpu event occurs, by running '/sbin/hotplug
- * cpu' with certain environment variables set.  */
-static int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
-{
-	char *argv[3], *envp[5], cpu_str[12], action_str[32];
-	int i;
-
-	sprintf(cpu_str, "CPU=%d", cpu);
-	sprintf(action_str, "ACTION=%s", action);
-	/* FIXME: Add DEVPATH. --RR */
-
-	i = 0;
-	argv[i++] = hotplug_path;
-	argv[i++] = "cpu";
-	argv[i] = NULL;
-
-	i = 0;
-	/* minimal command environment */
-	envp[i++] = "HOME=/";
-	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-	envp[i++] = cpu_str;
-	envp[i++] = action_str;
-	envp[i] = NULL;
-
-	return call_usermodehelper(argv[0], argv, envp, 0);
-}
-
 /* Take this CPU down. */
 static int take_cpu_down(void *unused)
 {
@@ -155,8 +128,6 @@ int cpu_down(unsigned int cpu)
 
 	check_for_tasks(cpu);
 
-	cpu_run_sbin_hotplug(cpu, "offline");
-
 out_thread:
 	err = kthread_stop(p);
 out_allowed:
@@ -165,11 +136,6 @@ out:
 	unlock_cpu_hotplug();
 	return err;
 }
-#else
-static inline int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
-{
-	return 0;
-}
 #endif /*CONFIG_HOTPLUG_CPU*/
 
 int __devinit cpu_up(unsigned int cpu)
diff -puN drivers/base/cpu.c~cpu_run_sbin_hotplug_v2 drivers/base/cpu.c
--- linux-2.6.9-rc3-test/drivers/base/cpu.c~cpu_run_sbin_hotplug_v2	2004-10-04 22:51:15.902797086 -0700
+++ linux-2.6.9-rc3-test-askeshav/drivers/base/cpu.c	2004-10-04 22:52:17.902796326 -0700
@@ -32,6 +32,8 @@ static ssize_t store_online(struct sys_d
 	switch (buf[0]) {
 	case '0':
 		ret = cpu_down(cpu->sysdev.id);
+		if (!ret)
+			kobject_hotplug(&dev->kobj, KOBJ_OFFLINE);
 		break;
 	case '1':
 		ret = cpu_up(cpu->sysdev.id);
diff -puN include/linux/kobject_uevent.h~cpu_run_sbin_hotplug_v2 include/linux/kobject_uevent.h
--- linux-2.6.9-rc3-test/include/linux/kobject_uevent.h~cpu_run_sbin_hotplug_v2	2004-10-04 22:51:15.908656461 -0700
+++ linux-2.6.9-rc3-test-askeshav/include/linux/kobject_uevent.h	2004-10-04 22:51:16.004359584 -0700
@@ -22,6 +22,7 @@ enum kobject_action {
 	KOBJ_CHANGE	= 0x02,	/* a sysfs attribute file has changed */
 	KOBJ_MOUNT	= 0x03,	/* mount event for block devices */
 	KOBJ_UMOUNT	= 0x04,	/* umount event for block devices */
+	KOBJ_OFFLINE	= 0x05,	/* offline event for hotplug devices */
 	KOBJ_MAX_ACTION,	/* must be last action listed */
 };
 
diff -puN lib/kobject_uevent.c~cpu_run_sbin_hotplug_v2 lib/kobject_uevent.c
--- linux-2.6.9-rc3-test/lib/kobject_uevent.c~cpu_run_sbin_hotplug_v2	2004-10-04 22:52:35.953577355 -0700
+++ linux-2.6.9-rc3-test-askeshav/lib/kobject_uevent.c	2004-10-04 22:53:39.304162516 -0700
@@ -33,6 +33,7 @@ static char *actions[] = {
 	"change",	/* 0x02 */
 	"mount",	/* 0x03 */
 	"umount",	/* 0x04 */
+	"offline",	/* 0x05 */
 };
 
 static char *action_to_string(enum kobject_action action)
_
