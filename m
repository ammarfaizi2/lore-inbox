Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136090AbRAHXC5>; Mon, 8 Jan 2001 18:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136005AbRAHXCs>; Mon, 8 Jan 2001 18:02:48 -0500
Received: from m311-mp1-cvx1a.col.ntl.com ([213.104.69.55]:34308 "EHLO
	[213.104.69.55]") by vger.kernel.org with ESMTP id <S136077AbRAHXCg>;
	Mon, 8 Jan 2001 18:02:36 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "Andy Henroid" <andy_henroid@yahoo.com>, <apm@linuxcare.com.au>,
        <linux-laptop@vger.kernel.org>
Subject: Unified power management userspace policy
From: "John Fremlin" <vii@penguinpowered.com>
Date: 08 Jan 2001 23:05:03 +0000
Message-ID: <m2lmsld4rk.fsf@boreas.yi.org.>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Hi all!

At the moment there are two power management drivers in the linux
kernel (AFAIK). They each have different userspace interfaces --
/proc/apm and /dev/apmctl and /proc/sys/acpi/events or something. This
is not altogether bad, but as they do the same thing, it might be nice
to unify (part) of the interface. In fact this is already done for the
in kernel interface with pm_send_all.

The kernel patch below extends the pm_send_all idea to ask userspace
if the event causing it should be allowed to go ahead or not. This
functionality is useful to me, because my power button sends an APM
user suspend to the kernel, which I wish to convert into a clean
shutdown -p now. The functionality is only hooked up to the APM driver
at the moment (because that was the only caller of pm_send_all that I
could find and ACPI doesn't seem to do anything useful on my box).

The kernel will run /sbin/powermanager (proc configurable) when it
receives a rejectable PM event. This is to my mind preferable to
having a power daemon because a PM event might occur even when the
daemon isn't started yet, you waste a process entry the whole time,
I'd have to implement a bunch of special file ops and binary
interfaces, and to parallel the hotplug system.

There is an APM specific patch floating around that would permit apmd
to reject suspend events. I played around with it for a bit updating
it to the late 2.4.0-test12 but I didn't like it because it did
suspend() directly after receiving the event from the BIOS, so my box
would suspend briefly before rejecting the event.

An example /sbin/powermanager should be being uploaded to my homepage
as I write:

	http://www.penguinpowered.com/~vii/programs/linux/offbutton

or
	http://john.snoop.dk/programs/linux/offbutton

The patch has been working fine for me in various forms since
2.4.0-prerelease came out, though I'm hardly a power user (pun).

It is against linux 2.4.0.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.4.0-pmpolicy-3.patch

diff -u --recursive linux-clean/arch/i386/kernel/apm.c linux-hacked-pmpolicy/arch/i386/kernel/apm.c
--- linux-clean/arch/i386/kernel/apm.c	Sat Dec 30 00:21:33 2000
+++ linux-hacked-pmpolicy/arch/i386/kernel/apm.c	Mon Jan  8 21:15:23 2001
@@ -148,6 +148,8 @@
  *   1.14: Make connection version persist across module unload/load.
  *         Enable and engage power management earlier.
  *         Disengage power management on module unload.
+ *   ---   Modified to support new pm_event API (John Fremlin
+ *         <vii@penguinpowered.com>)
  *
  * APM 1.1 Reference:
  *
@@ -884,30 +886,65 @@
 #endif
 }
 
+static int soft_suspend()
+{
+	struct pm_event pe;
+	memset(&pe,0,sizeof pe);
+
+	pe.pe_state = PM_STATE_SLEEP;
+	pe.pe_source = PME_SRC_SOFT;
+	pe.pe_flags = PME_FLAGS_REJECTABLE;
+
+	return pm_request_event(&pe);
+}
+
 static int send_event(apm_event_t event)
 {
+	struct pm_event pe;
+	memset(&pe,0,sizeof pe);
+
 	switch (event) {
 	case APM_SYS_SUSPEND:
+		pe.pe_state = PM_STATE_SLEEP;
+		pe.pe_source = PME_SRC_SYS;
+		pe.pe_flags = PME_FLAGS_REJECTABLE;
+		break;
+		
 	case APM_CRITICAL_SUSPEND:
+		pe.pe_state = PM_STATE_SLEEP;
+		pe.pe_source = PME_SRC_SYS;
+		break;
+			
 	case APM_USER_SUSPEND:
-		/* map all suspends to ACPI D3 */
-		if (pm_send_all(PM_SUSPEND, (void *)3)) {
-			if (event == APM_CRITICAL_SUSPEND) {
-				printk(KERN_CRIT "apm: Critical suspend was vetoed, expect armageddon\n" );
-				return 0;
-			}
-			if (apm_info.connection_version > 0x100)
-				apm_set_power_state(APM_STATE_REJECT);
-			return 0;
-		}
+		pe.pe_state = PM_STATE_SLEEP;
+		pe.pe_source = PME_SRC_HWUSER;
+		pe.pe_flags = PME_FLAGS_REJECTABLE;
 		break;
-	case APM_NORMAL_RESUME:
+
 	case APM_CRITICAL_RESUME:
-		/* map all resumes to ACPI D0 */
-		(void) pm_send_all(PM_RESUME, (void *)0);
+		pe.pe_state = PM_STATE_WAKEFUL;
+		pe.pe_source = PME_SRC_SYS;
+		break;
+		
+	case APM_NORMAL_RESUME:
+		pe.pe_state = PM_STATE_WAKEFUL;
+		pe.pe_source = PME_SRC_HWUSER;
 		break;
+		
+	default:
+		return 1;
 	}
 
+	if(pm_prepare_for_event(&pe))
+	{
+		if (event == APM_CRITICAL_SUSPEND) {
+			printk(KERN_CRIT "apm: critical suspend was vetoed, expect armageddon\n" );
+			return 0;
+		}
+		if (apm_info.connection_version > 0x100)
+			apm_set_power_state(APM_STATE_REJECT);
+		return 0;
+	}
 	return 1;
 }
 
@@ -925,8 +962,10 @@
 		err = APM_SUCCESS;
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
-	send_event(APM_NORMAL_RESUME);
 	sti();
+	/* We mustn't pm_event_lock because whoever is waiting for the
+	 * end of this suspend is holding the lock */
+	send_event(APM_NORMAL_RESUME);
 	queue_event(APM_NORMAL_RESUME, NULL);
 	for (as = user_list; as != NULL; as = as->next) {
 		as->suspend_wait = 0;
@@ -947,6 +986,21 @@
 		apm_error("standby", err);
 }
 
+static int apm_enter_state(pm_state_t*ps)
+{
+	switch(*ps){
+	case PM_STATE_SLEEP:
+		return suspend();
+	case PM_STATE_WAKEFUL:
+		return 0;
+	case PM_STATE_POWEROFF:
+		apm_power_off();
+		return 2; /* it didn't work, did it? */
+	default:
+		return 1;
+	}
+}
+
 static apm_event_t get_event(void)
 {
 	int		error;
@@ -1019,12 +1073,17 @@
 			 */
 			if (waiting_for_resume)
 				return;
+			
+			pm_event_lock();
+			
 			if (send_event(event)) {
 				queue_event(event, NULL);
 				waiting_for_resume = 1;
 				if (suspends_pending <= 0)
 					(void) suspend();
 			}
+			pm_event_unlock();
+
 			break;
 
 		case APM_NORMAL_RESUME:
@@ -1036,7 +1095,10 @@
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
 				set_time();
+				pm_event_lock();
 				send_event(event);
+				pm_event_unlock();
+				
 				queue_event(event, NULL);
 			}
 			break;
@@ -1053,12 +1115,16 @@
 			break;
 
 		case APM_CRITICAL_SUSPEND:
+			pm_event_lock();
 			send_event(event);
 			/*
 			 * We can only hope it worked - we are not allowed
 			 * to reject a critical suspend.
 			 */
 			(void) suspend();
+			
+			pm_event_unlock();
+			
 			break;
 		}
 	}
@@ -1240,14 +1306,16 @@
 			as->suspends_read--;
 			as->suspends_pending--;
 			suspends_pending--;
-		} else if (!send_event(APM_USER_SUSPEND))
-			return -EAGAIN;
-		else
-			queue_event(APM_USER_SUSPEND, as);
+		}
+		
 		if (suspends_pending <= 0) {
-			if (suspend() != APM_SUCCESS)
+			if (soft_suspend() != 0)
 				return -EIO;
+
+			queue_event(APM_USER_SUSPEND, as);
 		} else {
+			queue_event(APM_USER_SUSPEND, as);
+			
 			as->suspend_wait = 1;
 			add_wait_queue(&apm_suspend_waitqueue, &wait);
 			while (1) {
@@ -1285,7 +1353,7 @@
 	if (as->suspends_pending > 0) {
 		suspends_pending -= as->suspends_pending;
 		if (suspends_pending <= 0)
-			(void) suspend();
+			(void) soft_suspend();
 	}
 	if (user_list == as)
 		user_list = as->next;
@@ -1526,6 +1594,9 @@
 #ifdef CONFIG_MAGIC_SYSRQ
 	sysrq_power_off = apm_power_off;
 #endif
+
+	pm_enter_state = apm_enter_state;
+
 	if (smp_num_cpus == 1) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = apm_console_blank;
diff -u --recursive linux-clean/include/linux/pm.h linux-hacked-pmpolicy/include/linux/pm.h
--- linux-clean/include/linux/pm.h	Fri Jan  5 21:30:21 2001
+++ linux-hacked-pmpolicy/include/linux/pm.h	Sat Jan  6 16:38:41 2001
@@ -27,6 +27,50 @@
 #include <linux/list.h>
 
 /*
+ * Power management events
+ */
+
+typedef int pm_state_t;
+typedef int pm_source_t;
+
+struct pm_event
+{
+	pm_state_t pe_state;
+	pm_source_t pe_source;
+	unsigned pe_flags;
+}
+;
+
+/* The states: */
+enum{
+	PM_STATE_SLEEP,
+	PM_STATE_WAKEFUL,
+	PM_STATE_POWEROFF
+};
+
+/* The sources: */
+
+enum {
+	PME_SRC_SOFT,
+		/* The user clicked suspend in the GUI, or a program decided
+		    by itself */
+		   
+	PME_SRC_HWUSER,
+		/* The user pressed the offbutton, or closed the laptop lid or something */
+
+	PME_SRC_SYS
+		/* The power management system got bored and decided to assert itself */
+}
+;
+
+/* The flags: */
+
+#define PME_FLAGS_REJECTABLE	0x1
+	//	1 == yes, it can be vetoed
+	//	0 == no, it's going to happen anyway
+
+
+/*
  * Power management requests
  */
 enum
@@ -109,10 +153,12 @@
 
 #ifdef CONFIG_PM
 
+extern int (*pm_enter_state)(pm_state_t*ps);
 extern int pm_active;
 
 #define PM_IS_ACTIVE() (pm_active != 0)
 
+
 /*
  * Register a device with power management
  */
@@ -140,6 +186,38 @@
  */
 int pm_send_all(pm_request_t rqst, void *data);
 
+
+/*
+ * Ask pm system to enter a particular state
+ */
+int pm_request_event(struct pm_event*pe);
+	// returns non-zero on failure.
+
+/*
+ * Low level function only for PM drivers that are going to put the
+ * system in particular state and want to handle the actual system state
+ * change themselves, but want all drivers etc. notified.
+ *
+ * You should use pm_event_lock and pm_event_unlock around this
+ * procedure!
+ *
+ */
+int pm_prepare_for_event(struct pm_event*pe);
+	// prepares system for event but does not call pm_enter_state
+	// returns non-zero if the event was rejected
+
+/*
+ * Access control: power management events should be serialized.
+ *
+ * Example of how to lock:
+ * If you're going to pm_prepare_for_event and then call
+ * custom_do_system_suspend you should pm_event_lock before you start,
+ * and pm_event_unlock after you've called custom_do_system_suspend.
+ */
+void pm_event_lock();
+void pm_event_unlock();
+
+
 /*
  * Find a device
  */
@@ -171,6 +249,24 @@
 extern inline int pm_send_all(pm_request_t rqst, void *data)
 {
 	return 0;
+}
+
+extern inline int pm_request_event(struct pm_event*pe)
+{
+	return 1;
+}
+
+extern inline int pm_prepare_for_event(struct pm_event*pe)
+{
+	return 0;
+}
+
+extern inline void pm_event_lock() 
+{
+}
+
+extrn inline void pm_event_unlock()
+{
 }
 
 extern inline struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from)
diff -u --recursive linux-clean/include/linux/sysctl.h linux-hacked-pmpolicy/include/linux/sysctl.h
--- linux-clean/include/linux/sysctl.h	Fri Jan  5 21:29:45 2001
+++ linux-hacked-pmpolicy/include/linux/sysctl.h	Tue Jan  2 14:43:17 2001
@@ -117,6 +117,7 @@
 	KERN_OVERFLOWGID=47,	/* int: overflow GID */
 	KERN_SHMPATH=48,	/* string: path to shm fs */
 	KERN_HOTPLUG=49,	/* string: path to hotplug policy agent */
+	KERN_POWERMANAGER=50,   /* string: path to PM policy agent */
 };
 
 
diff -u --recursive linux-clean/kernel/pm.c linux-hacked-pmpolicy/kernel/pm.c
--- linux-clean/kernel/pm.c	Fri May 12 19:21:20 2000
+++ linux-hacked-pmpolicy/kernel/pm.c	Sat Jan  6 17:00:48 2001
@@ -16,14 +16,29 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Changes:
+ *
+ * 2001-01-02	Added support for userspace rejection of PM events
+ *		John Fremlin <vii@penguinpowered.com>
  */
 
+#define __KERNEL_SYSCALLS__
+
+#include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+#include <linux/kmod.h> // for usermodehelper
+#include <linux/unistd.h>
+
 #include <linux/pm.h>
 
 int pm_active;
+int (*pm_enter_state)(pm_state_t*ps); /* = 0 */
+static DECLARE_MUTEX(pm_event_sem);
 
 static spinlock_t pm_devs_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(pm_devs);
@@ -186,8 +201,9 @@
  *	Zero is returned on success. If a suspend fails then the status
  *	from the device that vetoes the suspend is returned.
  *
- *	BUGS: what stops two power management requests occuring in parallel
- *	and conflicting.
+ *	Use pm_request_event or a pm_event_lock, pm_prepare_for_event,
+ *	custom_do_event, pm_event_unlock instead of this function to avoid
+ *	racing.
  */
  
 int pm_send_all(pm_request_t rqst, void *data)
@@ -211,6 +227,227 @@
 	return 0;
 }
 
+static inline char* state2a(pm_state_t* s)
+{
+	switch(*s){
+	case PM_STATE_SLEEP:
+		return "sleep";
+	case PM_STATE_WAKEFUL:
+		return "wake";
+	case PM_STATE_POWEROFF:
+		return "poweroff";
+	default:
+		BUG();
+		return "unknown";
+	}
+}
+
+static inline char* source2a(pm_source_t* s)
+{
+	switch(*s){
+	case PME_SRC_SOFT:
+		return "soft";
+	case PME_SRC_HWUSER:
+		return "user";
+	case PME_SRC_SYS:
+		return "sys";
+	default:
+		BUG();
+		return "unknown";
+	}
+}
+
+/* 
+ *  For more examples of doing this kind of thing, see kernel/kmod.c
+ *  but especially drivers/net/hamradio/baycom_epp.c.
+ */
+
+/* If you change the size of this variable, also change
+ * kernel/sysctl.c as it is exported to procfs
+ */
+char pm_policyhelper_path[256] = "/sbin/powermanager";
+
+static int exec_policyhelper(void*p)
+{
+	static char * envp[] = {
+		"HOME=/",
+		"TERM=linux",
+		"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
+		0 };
+
+	struct pm_event*pe=(struct pm_event*)p;
+	char* source = source2a(&pe->pe_source);
+	char* state = state2a(&pe->pe_state);
+	
+	char*argv[] = 
+		{
+			pm_policyhelper_path,
+			source,
+			state,
+			0
+		}
+	;
+
+	int ret;
+
+	ret = exec_usermodehelper(pm_policyhelper_path,argv,envp);
+	
+	printk(KERN_ERR "pm: unable to exec \"%s\" (ret == %d, errno == %d)\n",
+		       pm_policyhelper_path,
+		       ret,
+		       errno);
+	do_exit(ret);
+}
+
+/*
+ *  Return 0 -> reject event, non-zero accept
+ */	 
+static int event_policy(struct pm_event*pe)
+{
+	pid_t pid;
+	int ret;
+	int err;
+
+	if (!current->fs->root) {
+		printk(KERN_ERR "pm: unable to query userspace as root fs not mounted\n");
+		return -1;
+	}
+	
+	pid = kernel_thread(exec_policyhelper, pe, CLONE_VFORK);
+	if (pid < 0) {
+		printk(KERN_ERR "pm: fork failed (errno == %d)\n", -pid);
+		return -1;
+	}
+
+	{
+		/* Allow ret to be in kernel space. */
+		mm_segment_t fs = get_fs();
+		set_fs(KERNEL_DS); 
+		err = waitpid(pid, &ret, __WCLONE);
+		set_fs(fs);
+	}
+
+	if (err != pid) {
+		printk(KERN_ERR "pm: waitpid (pid==%d) failed (errno = %d, ret = %d)\n", pid, err, ret);
+		return -1;
+	}
+
+	if(ret > 0) {
+		printk(KERN_DEBUG "pm: userspace policy vetoed event (returning %d)\n",
+		       ret);
+		return 0;
+	}
+	if(ret == 0) {
+//		printk(KERN_DEBUG "pm: userspace policy accepted event\n");
+		return 1;
+	}
+
+	printk(KERN_DEBUG "pm: userspace policy command returned failure: %d\n", ret );
+	return -1;
+}
+
+
+/**
+ *	pm_event_lock - block until any currently processing PM event is finished.
+ *
+ *	It is needed because of the following race: you decide to wake
+ *	the machine up from suspend, and notify everybody you're doing
+ *	this. While your pm_prepare_for_event is sleeping, some other
+ *	thread decides to suspend the machine to a deep sleep or
+ *	something and calls pm_prepare_for_event. The two
+ *	pm_prepare_for_event threads now race: if the second wins, the
+ *	machine is suspended then immediately woken up by the
+ *	first. The result is that all PM capable devices are in
+ *	suspended animation but the computer is awake and won't try to
+ *	wake them up.
+ *
+ *	You should therefore use pm_event_lock and pm_event_unlock
+ *	around pm_prepare_for_event. In fact you should almost
+ *	certainly use pm_request_event, which does this for you.
+ *
+ */
+
+void pm_event_lock()
+{
+	down(&pm_event_sem);
+}
+void pm_event_unlock()
+{
+	up(&pm_event_sem);
+}
+
+
+int pm_prepare_for_event(struct pm_event*pe) 
+{
+	pm_request_t req;
+	void*data;
+
+	if(pe->pe_flags & PME_FLAGS_REJECTABLE)
+	{
+		if(!event_policy(pe))
+			return 1;
+	}
+	
+	switch(pe->pe_state){
+	case PM_STATE_SLEEP:
+		req = PM_SUSPEND;
+		data = (void*)3; /* Map suspend to ACPI D3 */
+		break;
+	case PM_STATE_WAKEFUL:
+		req = PM_RESUME;
+		data = 0;
+		break;
+	case PM_STATE_POWEROFF:
+		return 0;
+	default:
+		BUG();
+		return 2;
+	}
+
+	if(pm_send_all(req,data))
+		return 1;
+	
+	return 0;
+}
+
+/**
+ *	pm_request_event - ask the PM system to enter a state
+ *	@pe: state and request orginator
+ *
+ *	pm_request_event reserves the right to sleep and definitely
+ *	will do if the pe_flags of @pe have the REJECTABLE bit set.
+ *
+ *	pm_request_event will notify all PM aware drivers, and
+ *	possibly ask userspace if the event should go ahead, depending
+ *	on the pe_flags of @pe.
+ *
+ *	A return of 0 indicates that the event was successfully
+ *	initiated, otherwise non-zero is returned.
+ */
+
+int pm_request_event(struct pm_event*pe)
+{
+	int v;
+
+	pm_event_lock();
+	
+	v=pm_prepare_for_event(pe);
+	if(v)
+		goto out;
+
+	if(!pm_enter_state)
+	{
+		v=2;
+		goto out;
+	}
+
+	v = pm_enter_state(&pe->pe_state);
+	
+ out:
+	pm_event_unlock();
+	return v;
+}
+
 /**
  *	pm_find  - find a device
  *	@type: type of device
@@ -241,5 +478,11 @@
 EXPORT_SYMBOL(pm_unregister_all);
 EXPORT_SYMBOL(pm_send);
 EXPORT_SYMBOL(pm_send_all);
+EXPORT_SYMBOL(pm_event_lock);
+EXPORT_SYMBOL(pm_event_unlock);
+EXPORT_SYMBOL(pm_prepare_for_event);
+EXPORT_SYMBOL(pm_request_event);
 EXPORT_SYMBOL(pm_find);
 EXPORT_SYMBOL(pm_active);
+EXPORT_SYMBOL(pm_enter_state);
+EXPORT_SYMBOL(pm_policyhelper_path);
diff -u --recursive linux-clean/kernel/sysctl.c linux-hacked-pmpolicy/kernel/sysctl.c
--- linux-clean/kernel/sysctl.c	Tue Jan  2 09:26:17 2001
+++ linux-hacked-pmpolicy/kernel/sysctl.c	Tue Jan  2 14:43:44 2001
@@ -58,6 +58,9 @@
 #ifdef CONFIG_HOTPLUG
 extern char hotplug_path[];
 #endif
+#ifdef CONFIG_PM
+extern char pm_policyhelper_path[];
+#endif
 #ifdef CONFIG_CHR_DEV_SG
 extern int sg_big_buff;
 #endif
@@ -195,6 +198,10 @@
 	{KERN_HOTPLUG, "hotplug", &hotplug_path, 256,
 	 0644, NULL, &proc_dostring, &sysctl_string },
 #endif
+#ifdef CONFIG_PM
+	{KERN_POWERMANAGER, "powermanager",&pm_policyhelper_path, 256,
+	 0644, NULL, &proc_dostring, &sysctl_string },
+#endif	
 #ifdef CONFIG_CHR_DEV_SG
 	{KERN_SG_BIG_BUFF, "sg-big-buff", &sg_big_buff, sizeof (int),
 	 0444, NULL, &proc_dointvec},

--=-=-=


-- 

	http://www.penguinpowered.com/~vii

--=-=-=--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
