Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136627AbREGTPl>; Mon, 7 May 2001 15:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136624AbREGTPe>; Mon, 7 May 2001 15:15:34 -0400
Received: from m42-mp1-cvx1b.col.ntl.com ([213.104.72.42]:12416 "EHLO
	[213.104.72.42]") by vger.kernel.org with ESMTP id <S136618AbREGTPZ>;
	Mon, 7 May 2001 15:15:25 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Ralf Baechle <ralf@gnu.ai.mit.edu>, <linux-mips@fnet.fr>,
        David S <Miller@boreas.yi.org>, Russell King <linux@arm.linux.org.uk>,
        <linux-arm-kernel@lists.arm.linux.org.uk>,
        <sparclinux@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
        <linux-laptop@vger.kernel.org>, <andrew.grover@intel.com>,
        <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: simple userspace pm interface
From: John Fremlin <chief@bandits.org>
Date: 07 May 2001 20:14:37 +0100
Message-ID: <m24rux9dk2.fsf@boreas.yi.org.>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Here is a patch to deal with PM events (e.g. button presses) in a
system independent way. Could people with the applicable hardware test
out or comment on the changes?

The files affected are

	 arch/i386/kernel/apm.c
	 arch/mips/sgi/kernel/reset.c
	 arch/mips64/sgi-ip22/ip22-reset.c
	 arch/sparc64/kernel/power.c
	 drivers/acpi/driver.c
	 drivers/char/nwbutton.c
	 drivers/char/nwbutton.h

There are many power management and button press drivers in the
kernel. They all tend to have their own interface to distribute events
to userspace. This is bad, because it means duplicated code, and
requires arch specific userspace whatnots, which should not be
necessary. 

Specifically, at the moment, the following approaches are taken by
various subsystems:
       - launch /sbin/shutdown
       - signal init
       - do nothing

And there 3 or so different special devices that userspace can read to
see events. After this patch there are only 2 that I know of (ACPI and
/dev/boxevent, perhaps the ACPI stuff could also be removed, I didn't
look).

The patch converts the PM drivers I found to use a single
interface. (Only APM is tested because nobody has given me e.g. a
SPARC box: i.e. the patch is just a suggestion.)

The kernel interface is very simple. Each driver just does

#include <linux/boxevent.h>

void button_interrupt() {
        boxevent(BUTTONEVENT_OFF,"TurboSnail","button pressed");
}

and the event is exported to any number of userspace listeners on
/dev/boxevent. Thereby writing a new power button driver does not
involve having to deal with all the baggage of device nodes, etc.

You can create /dev/boxevent with mknod boxevent c 10 137

You can see what events occur simply by "cat"ing it to the console.
The format is very simple.

<event> <WS> <subsystem> <WS> <description> <LF>

Where <event> is one of the strings OFF,SLEEP,WAKE,EMERGENCY,NOTIFY
(if a reader does not read events quickly enough, it will get a
MSGFLOOD event), <WS> is a space character, <subsystem> is a word
denoting the kernel pm interface responsible for generating the event,
<description> is an arbitrary string. <LF> is a newline character \n.

This is flexible. It means a reasonable default behaviour can be
suggested by the kernel (OFF,SLEEP,etc.) for events that userspace
doesn't know about, but userspace can choose fine grained policy and
provide helpful error messages based on the exact event name by
checking the description.

In fact, here is the "daemon" I use

#! /bin/perl

use Sys::Syslog qw(:DEFAULT setlogsock);

sub do_off {
	system("/sbin/shutdown -p now");
	exit(0);
}
sub do_overflow {
	setlogsock("unix");
	openlog("boxd","cons","daemon");
	syslog('err',"messages arriving too fast");
	closelog();
}

while(<>){
	if(/MSGFLOOD/) { 
		do_overflow();
		next 
	}
	if(/^SLEEP APM user suspend/){ 
		do_off();
		next
	}
	if(/^OFF/){ 
		do_off();
		next
	}
}


The patch against 2.4.4 is attached.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.4.4-boxevent-1.patch

diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/arch/i386/kernel/apm.c linux-2.4.4-boxevent/arch/i386/kernel/apm.c
--- linux-2.4.4-orig/arch/i386/kernel/apm.c	Tue May  1 14:33:34 2001
+++ linux-2.4.4-boxevent/arch/i386/kernel/apm.c	Mon May  7 15:36:53 2001
@@ -148,6 +148,9 @@
  *   1.14: Make connection version persist across module unload/load.
  *         Enable and engage power management earlier.
  *         Disengage power management on module unload.
+ *   1.15: Move most of the /dev/apm_bios stuff to drivers/char/boxevent.c
+ *         Reject all events by default
+ *         (John Fremlin <vii@altern.org>)
  *
  * APM 1.1 Reference:
  *
@@ -186,6 +189,7 @@
 #include <linux/pm.h>
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/boxevent.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -301,10 +305,6 @@
 	int		suser: 1;
 	int		suspend_wait: 1;
 	int		suspend_result;
-	int		suspends_pending;
-	int		standbys_pending;
-	int		suspends_read;
-	int		standbys_read;
 	int		event_head;
 	int		event_tail;
 	apm_event_t	events[APM_MAX_EVENTS];
@@ -325,8 +325,7 @@
 #ifdef CONFIG_APM_CPU_IDLE
 static int			clock_slowed;
 #endif
-static int			suspends_pending;
-static int			standbys_pending;
+static int			suspend_launched;
 static int			waiting_for_resume;
 static int			ignore_normal_resume;
 static int			bounce_interval = DEFAULT_BOUNCE_INTERVAL;
@@ -352,7 +351,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *	user_list;
 
-static char			driver_version[] = "1.14";	/* no spaces */
+static char			driver_version[] = "1.15";	/* no spaces */
 
 static char *	apm_event_name[] = {
 	"system standby",
@@ -579,56 +578,6 @@
 		clock_slowed = 0;
 	}
 }
-
-#if 0
-extern int hlt_counter;
-
-/*
- * If no process has been interested in this
- * CPU for some time, we want to wake up the
- * power management thread - we probably want
- * to conserve power.
- */
-#define HARD_IDLE_TIMEOUT (HZ/3)
-
-/* This should wake up kapmd and ask it to slow the CPU */
-#define powermanagement_idle()  do { } while (0)
-
-/*
- * This is the idle thing.
- */
-static void apm_cpu_idle(void)
-{
-	unsigned int start_idle;
-
-	start_idle = jiffies;
-	while (1) {
-		if (!current->need_resched) {
-			if (jiffies - start_idle < HARD_IDLE_TIMEOUT) {
-				if (!current_cpu_data.hlt_works_ok)
-					continue;
-				if (hlt_counter)
-					continue;
-				__cli();
-				if (!current->need_resched)
-					safe_halt();
-				else
-					__sti();
-				continue;
-			}
-
-			/*
-			 * Ok, do some power management - we've been idle for too long
-			 */
-			powermanagement_idle();
-		}
-
-		schedule();
-		check_pgt_cache();
-		start_idle = jiffies;
-	}
-}
-#endif
 #endif
 
 #ifdef CONFIG_SMP
@@ -791,54 +740,6 @@
 }
 #endif
 
-static int queue_empty(struct apm_user *as)
-{
-	return as->event_head == as->event_tail;
-}
-
-static apm_event_t get_queued_event(struct apm_user *as)
-{
-	as->event_tail = (as->event_tail + 1) % APM_MAX_EVENTS;
-	return as->events[as->event_tail];
-}
-
-static void queue_event(apm_event_t event, struct apm_user *sender)
-{
-	struct apm_user *	as;
-
-	if (user_list == NULL)
-		return;
-	for (as = user_list; as != NULL; as = as->next) {
-		if (as == sender)
-			continue;
-		as->event_head = (as->event_head + 1) % APM_MAX_EVENTS;
-		if (as->event_head == as->event_tail) {
-			static int notified;
-
-			if (notified++ == 0)
-			    printk(KERN_ERR "apm: an event queue overflowed\n");
-			as->event_tail = (as->event_tail + 1) % APM_MAX_EVENTS;
-		}
-		as->events[as->event_head] = event;
-		if (!as->suser)
-			continue;
-		switch (event) {
-		case APM_SYS_SUSPEND:
-		case APM_USER_SUSPEND:
-			as->suspends_pending++;
-			suspends_pending++;
-			break;
-
-		case APM_SYS_STANDBY:
-		case APM_USER_STANDBY:
-			as->standbys_pending++;
-			standbys_pending++;
-			break;
-		}
-	}
-	wake_up_interruptible(&apm_waitqueue);
-}
-
 static void set_time(void)
 {
 	unsigned long	flags;
@@ -898,8 +799,6 @@
 				printk(KERN_CRIT "apm: Critical suspend was vetoed, expect armageddon\n" );
 				return 0;
 			}
-			if (apm_info.connection_version > 0x100)
-				apm_set_power_state(APM_STATE_REJECT);
 			return 0;
 		}
 		break;
@@ -913,6 +812,44 @@
 	return 1;
 }
 
+static void announce_event(apm_event_t event)
+{
+	char*type = BOXEVENT_NOTIFY;
+	char*name;
+
+	if (event <= NR_APM_EVENT_NAME)
+		name = apm_event_name[event - 1];
+	else	name = "unknown event";
+	
+	switch(event){
+	case APM_SYS_STANDBY:
+	case APM_USER_STANDBY:
+	case APM_SYS_SUSPEND:
+	case APM_USER_SUSPEND:
+	case APM_CRITICAL_SUSPEND:
+		type = BOXEVENT_SLEEP;
+		break;
+	case APM_NORMAL_RESUME:
+	case APM_CRITICAL_RESUME:
+	case APM_STANDBY_RESUME:
+		type = BOXEVENT_WAKE;
+		break;
+	case APM_CAPABILITY_CHANGE:
+		type = BOXEVENT_WAKE;
+		break;
+	case APM_LOW_BATTERY:
+		type = BOXEVENT_EMERGENCY;
+		break;
+	case APM_POWER_STATUS_CHANGE:
+		type = BOXEVENT_POWERCHANGE;
+		break;
+	default:
+		type = BOXEVENT_NOTIFY;
+	}
+	boxevent(type,"APM",name);
+}
+
+
 static int suspend(void)
 {
 	int		err;
@@ -929,12 +866,13 @@
 		apm_error("suspend", err);
 	send_event(APM_NORMAL_RESUME);
 	sti();
-	queue_event(APM_NORMAL_RESUME, NULL);
+	announce_event(APM_NORMAL_RESUME);
 	for (as = user_list; as != NULL; as = as->next) {
 		as->suspend_wait = 0;
 		as->suspend_result = ((err == APM_SUCCESS) ? 0 : -EIO);
 	}
 	ignore_normal_resume = 1;
+	suspend_launched = 0;
 	wake_up_interruptible(&apm_suspend_waitqueue);
 	return err;
 }
@@ -989,46 +927,16 @@
 		if (ignore_normal_resume && (event != APM_NORMAL_RESUME))
 			ignore_normal_resume = 0;
 
+		announce_event(event);
+		
 		switch (event) {
 		case APM_SYS_STANDBY:
 		case APM_USER_STANDBY:
-			if (send_event(event)) {
-				queue_event(event, NULL);
-				if (standbys_pending <= 0)
-					standby();
-			}
-			break;
-
 		case APM_USER_SUSPEND:
-#ifdef CONFIG_APM_IGNORE_USER_SUSPEND
+		case APM_SYS_SUSPEND:
 			if (apm_info.connection_version > 0x100)
 				apm_set_power_state(APM_STATE_REJECT);
 			break;
-#endif
-		case APM_SYS_SUSPEND:
-			if (ignore_bounce) {
-				if (apm_info.connection_version > 0x100)
-					apm_set_power_state(APM_STATE_REJECT);
-				break;
-			}
-			/*
-			 * If we are already processing a SUSPEND,
-			 * then further SUSPEND events from the BIOS
-			 * will be ignored.  We also return here to
-			 * cope with the fact that the Thinkpads keep
-			 * sending a SUSPEND event until something else
-			 * happens!
-			 */
-			if (waiting_for_resume)
-				return;
-			if (send_event(event)) {
-				queue_event(event, NULL);
-				waiting_for_resume = 1;
-				if (suspends_pending <= 0)
-					(void) suspend();
-			}
-			break;
-
 		case APM_NORMAL_RESUME:
 		case APM_CRITICAL_RESUME:
 		case APM_STANDBY_RESUME:
@@ -1039,7 +947,6 @@
 			    || (ignore_normal_resume == 0)) {
 				set_time();
 				send_event(event);
-				queue_event(event, NULL);
 			}
 			break;
 
@@ -1047,7 +954,6 @@
 		case APM_LOW_BATTERY:
 		case APM_POWER_STATUS_CHANGE:
 			send_event(event);
-			queue_event(event, NULL);
 			break;
 
 		case APM_UPDATE_TIME:
@@ -1055,7 +961,9 @@
 			break;
 
 		case APM_CRITICAL_SUSPEND:
+			suspend_launched = 1;
 			send_event(event);
+			
 			/*
 			 * We can only hope it worked - we are not allowed
 			 * to reject a critical suspend.
@@ -1068,20 +976,6 @@
 
 static void apm_event_handler(void)
 {
-	static int	pending_count = 4;
-	int		err;
-
-	if ((standbys_pending > 0) || (suspends_pending > 0)) {
-		if ((apm_info.connection_version > 0x100) && (pending_count-- <= 0)) {
-			pending_count = 4;
-			if (debug)
-				printk(KERN_DEBUG "apm: setting state busy\n");
-			err = apm_set_power_state(APM_STATE_BUSY);
-			if (err)
-				apm_error("busy", err);
-		}
-	} else
-		pending_count = 4;
 	check_events();
 }
 
@@ -1146,78 +1040,10 @@
 	return 0;
 }
 
-static ssize_t do_read(struct file *fp, char *buf, size_t count, loff_t *ppos)
-{
-	struct apm_user *	as;
-	int			i;
-	apm_event_t		event;
-	DECLARE_WAITQUEUE(wait, current);
-
-	as = fp->private_data;
-	if (check_apm_user(as, "read"))
-		return -EIO;
-	if (count < sizeof(apm_event_t))
-		return -EINVAL;
-	if (queue_empty(as)) {
-		if (fp->f_flags & O_NONBLOCK)
-			return -EAGAIN;
-		add_wait_queue(&apm_waitqueue, &wait);
-repeat:
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (queue_empty(as) && !signal_pending(current)) {
-			schedule();
-			goto repeat;
-		}
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&apm_waitqueue, &wait);
-	}
-	i = count;
-	while ((i >= sizeof(event)) && !queue_empty(as)) {
-		event = get_queued_event(as);
-		if (copy_to_user(buf, &event, sizeof(event))) {
-			if (i < count)
-				break;
-			return -EFAULT;
-		}
-		switch (event) {
-		case APM_SYS_SUSPEND:
-		case APM_USER_SUSPEND:
-			as->suspends_read++;
-			break;
-
-		case APM_SYS_STANDBY:
-		case APM_USER_STANDBY:
-			as->standbys_read++;
-			break;
-		}
-		buf += sizeof(event);
-		i -= sizeof(event);
-	}
-	if (i < count)
-		return count - i;
-	if (signal_pending(current))
-		return -ERESTARTSYS;
-	return 0;
-}
-
-static unsigned int do_poll(struct file *fp, poll_table * wait)
-{
-	struct apm_user * as;
-
-	as = fp->private_data;
-	if (check_apm_user(as, "poll"))
-		return 0;
-	poll_wait(fp, &apm_waitqueue, wait);
-	if (!queue_empty(as))
-		return POLLIN | POLLRDNORM;
-	return 0;
-}
-
 static int do_ioctl(struct inode * inode, struct file *filp,
 		    u_int cmd, u_long arg)
 {
 	struct apm_user *	as;
-	DECLARE_WAITQUEUE(wait, current);
 
 	as = filp->private_data;
 	if (check_apm_user(as, "ioctl"))
@@ -1226,43 +1052,27 @@
 		return -EPERM;
 	switch (cmd) {
 	case APM_IOC_STANDBY:
-		if (as->standbys_read > 0) {
-			as->standbys_read--;
-			as->standbys_pending--;
-			standbys_pending--;
-		} else if (!send_event(APM_USER_STANDBY))
+		if (!send_event(APM_USER_STANDBY))
 			return -EAGAIN;
-		else
-			queue_event(APM_USER_STANDBY, as);
-		if (standbys_pending <= 0)
-			standby();
+		standby();
 		break;
 	case APM_IOC_SUSPEND:
-		if (as->suspends_read > 0) {
-			as->suspends_read--;
-			as->suspends_pending--;
-			suspends_pending--;
-		} else if (!send_event(APM_USER_SUSPEND))
-			return -EAGAIN;
-		else
-			queue_event(APM_USER_SUSPEND, as);
-		if (suspends_pending <= 0) {
-			if (suspend() != APM_SUCCESS)
-				return -EIO;
-		} else {
+		if(suspend_launched) {
 			as->suspend_wait = 1;
-			add_wait_queue(&apm_suspend_waitqueue, &wait);
-			while (1) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				if ((as->suspend_wait == 0)
-				    || signal_pending(current))
-					break;
-				schedule();
+			if(wait_event_interruptible(apm_suspend_waitqueue,
+						    as->suspend_wait == 0)) {
+				as->suspend_wait = 0;
+				return -ERESTARTSYS;
 			}
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&apm_suspend_waitqueue, &wait);
+			
 			return as->suspend_result;
 		}
+
+		suspend_launched = 1;
+		if (!send_event(APM_USER_SUSPEND))
+			return -EAGAIN;
+		if (suspend() != APM_SUCCESS)
+			return -EIO;
 		break;
 	default:
 		return -EINVAL;
@@ -1279,16 +1089,7 @@
 		return 0;
 	filp->private_data = NULL;
 	lock_kernel();
-	if (as->standbys_pending > 0) {
-		standbys_pending -= as->standbys_pending;
-		if (standbys_pending <= 0)
-			standby();
-	}
-	if (as->suspends_pending > 0) {
-		suspends_pending -= as->suspends_pending;
-		if (suspends_pending <= 0)
-			(void) suspend();
-	}
+
 	if (user_list == as)
 		user_list = as->next;
 	else {
@@ -1320,11 +1121,10 @@
 	}
 	as->magic = APM_BIOS_MAGIC;
 	as->event_tail = as->event_head = 0;
-	as->suspends_pending = as->standbys_pending = 0;
-	as->suspends_read = as->standbys_read = 0;
+
 	/*
 	 * XXX - this is a tiny bit broken, when we consider BSD
-         * process accounting. If the device is opened by root, we
+	 * process accounting. If the device is opened by root, we
 	 * instantly flag that we used superuser privs. Who knows,
 	 * we might close the device immediately without doing a
 	 * privileged operation -- cevans
@@ -1578,8 +1378,6 @@
 
 static struct file_operations apm_bios_fops = {
 	owner:		THIS_MODULE,
-	read:		do_read,
-	poll:		do_poll,
 	ioctl:		do_ioctl,
 	open:		do_open,
 	release:	do_release,
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/arch/mips/sgi/kernel/reset.c linux-2.4.4-boxevent/arch/mips/sgi/kernel/reset.c
--- linux-2.4.4-orig/arch/mips/sgi/kernel/reset.c	Sat May 13 16:29:14 2000
+++ linux-2.4.4-boxevent/arch/mips/sgi/kernel/reset.c	Mon May  7 15:55:46 2001
@@ -7,11 +7,14 @@
  * for more details.
  *
  * Copyright (C) 1997, 1998 by Ralf Baechle
+ *
+ * 2001 May 7 Mangled to use new boxevent interface by John Fremlin
  */
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/notifier.h>
 #include <linux/timer.h>
+#include <linux/boxevent.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/system.h>
@@ -21,22 +24,14 @@
 #include <asm/sgi/sgint23.h>
 
 /*
- * Just powerdown if init hasn't done after POWERDOWN_TIMEOUT seconds.
- * I'm not shure if this feature is a good idea, for now it's here just to
- * make the power button make behave just like under IRIX.
- */
-#define POWERDOWN_TIMEOUT	120
-
-/*
  * Blink frequency during reboot grace period and when paniced.
  */
-#define POWERDOWN_FREQ		(HZ / 4)
 #define PANIC_FREQ		(HZ / 8)
 
 static unsigned char sgi_volume;
 
-static struct timer_list power_timer, blink_timer, debounce_timer, volume_timer;
-static int shuting_down, has_paniced;
+static struct timer_list blink_timer, debounce_timer, volume_timer;
+static int has_paniced;
 
 static void sgi_machine_restart(char *command) __attribute__((noreturn));
 static void sgi_machine_halt(void) __attribute__((noreturn));
@@ -45,15 +40,11 @@
 /* XXX How to pass the reboot command to the firmware??? */
 static void sgi_machine_restart(char *command)
 {
-	if (shuting_down)
-		sgi_machine_power_off();
 	prom_reboot();
 }
 
 static void sgi_machine_halt(void)
 {
-	if (shuting_down)
-		sgi_machine_power_off();
 	prom_imode();
 }
 
@@ -113,20 +104,7 @@
 {
 	if (has_paniced)
 		return;
-
-	if (shuting_down || kill_proc(1, SIGINT, 1)) {
-		/* No init process or button pressed twice.  */
-		sgi_machine_power_off();
-	}
-
-	shuting_down = 1;
-	blink_timer.data = POWERDOWN_FREQ;
-	blink_timeout(POWERDOWN_FREQ);
-
-	init_timer(&power_timer);
-	power_timer.function = power_timeout;
-	power_timer.expires = jiffies + POWERDOWN_TIMEOUT * HZ;
-	add_timer(&power_timer);
+	boxevent(BOXEVENT_OFF,"MIPS","button pressed");
 }
 
 void inline sgi_volume_set(unsigned char volume)
@@ -146,9 +124,11 @@
 {
 	del_timer(&volume_timer);
 
+	boxevent(BOXEVENT_NOTIFY,"MIPS","volume up button pressed");
+	
 	if (sgi_volume < 0xff)
 		sgi_volume++;
-
+	
 	hpc3c0->pbus_extregs[2][0] = sgi_volume;
 	hpc3c0->pbus_extregs[2][1] = sgi_volume;
 
@@ -163,6 +143,8 @@
 {
 	del_timer(&volume_timer);
 
+	boxevent(BOXEVENT_NOTIFY,"MIPS","volume down button pressed");
+	
 	if (sgi_volume > 0)
 		sgi_volume--;
 
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/arch/mips64/sgi-ip22/ip22-reset.c linux-2.4.4-boxevent/arch/mips64/sgi-ip22/ip22-reset.c
--- linux-2.4.4-orig/arch/mips64/sgi-ip22/ip22-reset.c	Sat May 13 16:30:17 2000
+++ linux-2.4.4-boxevent/arch/mips64/sgi-ip22/ip22-reset.c	Mon May  7 15:58:56 2001
@@ -7,11 +7,14 @@
  * Reset an IP22.
  *
  * Copyright (C) 1997, 1998, 1999 by Ralf Baechle
+ *
+ * 2001 May 7 Mangled to use new boxevent interface by John Fremlin
  */
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/notifier.h>
 #include <linux/timer.h>
+#include <linux/boxevent.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/system.h>
@@ -20,23 +23,14 @@
 #include <asm/sgi/sgint23.h>
 
 /*
- * Just powerdown if init hasn't done after POWERDOWN_TIMEOUT seconds.
- * I'm not shure if this feature is a good idea, for now it's here just to
- * make the power button make behave just like under IRIX.
- */
-#define POWERDOWN_TIMEOUT	120
-
-/*
  * Blink frequency during reboot grace period and when paniced.
  */
-#define POWERDOWN_FREQ		(HZ / 4)
 #define PANIC_FREQ		(HZ / 8)
 
 static unsigned char sgi_volume;
 
-static struct timer_list power_timer, blink_timer, debounce_timer, volume_timer;
-static int shuting_down, has_paniced;
-
+static struct timer_list blink_timer, debounce_timer, volume_timer;
+static int has_paniced;
 void machine_restart(char *command) __attribute__((noreturn));
 void machine_halt(void) __attribute__((noreturn));
 void machine_power_off(void) __attribute__((noreturn));
@@ -44,15 +38,11 @@
 /* XXX How to pass the reboot command to the firmware??? */
 void machine_restart(char *command)
 {
-	if (shuting_down)
-		machine_power_off();
 	ArcReboot();
 }
 
 void machine_halt(void)
 {
-	if (shuting_down)
-		machine_power_off();
 	ArcEnterInteractiveMode();
 }
 
@@ -76,11 +66,6 @@
 	}
 }
 
-static void power_timeout(unsigned long data)
-{
-	machine_power_off();
-}
-
 static void blink_timeout(unsigned long data)
 {
 	/* XXX Fix this for Fullhouse  */
@@ -113,19 +98,7 @@
 	if (has_paniced)
 		return;
 
-	if (shuting_down || kill_proc(1, SIGINT, 1)) {
-		/* No init process or button pressed twice.  */
-		machine_power_off();
-	}
-
-	shuting_down = 1;
-	blink_timer.data = POWERDOWN_FREQ;
-	blink_timeout(POWERDOWN_FREQ);
-
-	init_timer(&power_timer);
-	power_timer.function = power_timeout;
-	power_timer.expires = jiffies + POWERDOWN_TIMEOUT * HZ;
-	add_timer(&power_timer);
+	boxevent(BOXEVENT_OFF,"MIPS64-IP22","button pressed");
 }
 
 void inline ip22_volume_set(unsigned char volume)
@@ -145,6 +118,8 @@
 {
 	del_timer(&volume_timer);
 
+	boxevent(BOXEVENT_NOTIFY,"MIPS64-IP22","volume up button pressed");
+
 	if (sgi_volume < 0xff)
 		sgi_volume++;
 
@@ -162,6 +137,8 @@
 {
 	del_timer(&volume_timer);
 
+	boxevent(BOXEVENT_NOTIFY,"MIPS64-IP22","volume down button pressed");
+	
 	if (sgi_volume > 0)
 		sgi_volume--;
 
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/arch/sparc64/kernel/power.c linux-2.4.4-boxevent/arch/sparc64/kernel/power.c
--- linux-2.4.4-orig/arch/sparc64/kernel/power.c	Tue Jul 11 23:46:08 2000
+++ linux-2.4.4-boxevent/arch/sparc64/kernel/power.c	Mon May  7 15:31:17 2001
@@ -10,10 +10,9 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/delay.h>
+#include <linux/boxevent.h>
 
 #include <asm/ebus.h>
-
-#define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
 
 #ifdef CONFIG_PCI
@@ -26,10 +25,7 @@
 
 static void power_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
-	if (button_pressed == 0) {
-		wake_up(&powerd_wait);
-		button_pressed = 1;
-	}
+	boxevent_intr(BOXEVENT_OFF,"SPARC-PCI","button pressed");
 }
 #endif /* CONFIG_PCI */
 
@@ -52,30 +48,6 @@
 }
 
 #ifdef CONFIG_PCI
-static int powerd(void *__unused)
-{
-	static char *envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
-	char *argv[] = { "/sbin/shutdown", "-h", "now", NULL };
-
-	daemonize();
-	sprintf(current->comm, "powerd");
-
-again:
-	while(button_pressed == 0) {
-		spin_lock_irq(&current->sigmask_lock);
-		flush_signals(current);
-		spin_unlock_irq(&current->sigmask_lock);
-		interruptible_sleep_on(&powerd_wait);
-	}
-
-	/* Ok, down we go... */
-	if (execve("/sbin/shutdown", argv, envp) < 0) {
-		printk("powerd: shutdown execution failed\n");
-		button_pressed = 0;
-		goto again;
-	}
-	return 0;
-}
 
 void __init power_init(void)
 {
@@ -93,11 +65,7 @@
 found:
 	power_reg = (unsigned long)ioremap(edev->resource[0].start, 0x4);
 	printk("power: Control reg at %016lx ... ", power_reg);
-	if (kernel_thread(powerd, 0, CLONE_FS) < 0) {
-		printk("Failed to start power daemon.\n");
-		return;
-	}
-	printk("powerd running.\n");
+
 	if (edev->irqs[0] != 0) {
 		if (request_irq(edev->irqs[0],
 				power_handler, SA_SHIRQ, "power",
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/drivers/acpi/driver.c linux-2.4.4-boxevent/drivers/acpi/driver.c
--- linux-2.4.4-orig/drivers/acpi/driver.c	Thu Feb 22 18:28:26 2001
+++ linux-2.4.4-boxevent/drivers/acpi/driver.c	Mon May  7 15:57:08 2001
@@ -21,6 +21,8 @@
  * Changes
  * David Woodhouse <dwmw2@redhat.com> 2000-12-6
  * - Fix interruptible_sleep_on() races
+ * John Fremlin 2001-05-07
+ * - Mangled to use new boxevent interface 
  */
 
 #include <linux/config.h>
@@ -33,6 +35,7 @@
 #include <linux/sysctl.h>
 #include <linux/pm.h>
 #include <linux/acpi.h>
+#include <linux/boxevent.h>
 #include <asm/uaccess.h>
 #include "acpi.h"
 #include "driver.h"
@@ -163,9 +166,11 @@
 
 	switch (event) {
 	case ACPI_EVENT_POWER_BUTTON:
+		boxevent(BOXEVENT_OFF,"ACPI","power button pressed");
 		mask = ACPI_PWRBTN;
 		break;
 	case ACPI_EVENT_SLEEP_BUTTON:
+		boxevent(BOXEVENT_SLEEP,"ACPI","sleep button pressed");
 		mask = ACPI_SLPBTN;
 		break;
 	default:
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/drivers/char/Config.in linux-2.4.4-boxevent/drivers/char/Config.in
--- linux-2.4.4-orig/drivers/char/Config.in	Tue May  1 14:32:05 2001
+++ linux-2.4.4-boxevent/drivers/char/Config.in	Mon May  7 15:55:47 2001
@@ -150,9 +150,6 @@
 if [ "$CONFIG_ARCH_NETWINDER" = "y" ]; then
    tristate 'NetWinder thermometer support' CONFIG_DS1620
    tristate 'NetWinder Button' CONFIG_NWBUTTON
-   if [ "$CONFIG_NWBUTTON" != "n" ]; then
-      bool '  Reboot Using Button' CONFIG_NWBUTTON_REBOOT
-   fi
    tristate 'NetWinder flash support' CONFIG_NWFLASH
 fi
 
@@ -187,6 +184,8 @@
    bool '  Generic SiS support' CONFIG_AGP_SIS
    bool '  ALI chipset support' CONFIG_AGP_ALI
 fi
+
+tristate '/dev/boxevent (userspace async event interface)' CONFIG_BOXEVENT
 
 source drivers/char/drm/Config.in
 
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/drivers/char/Makefile linux-2.4.4-boxevent/drivers/char/Makefile
--- linux-2.4.4-orig/drivers/char/Makefile	Tue May  1 14:33:51 2001
+++ linux-2.4.4-boxevent/drivers/char/Makefile	Mon May  7 14:32:49 2001
@@ -179,6 +179,8 @@
 
 obj-$(CONFIG_QIC02_TAPE) += tpqic02.o
 
+obj-$(CONFIG_BOXEVENT) += boxevent.o
+
 subdir-$(CONFIG_FTAPE) += ftape
 subdir-$(CONFIG_DRM) += drm
 subdir-$(CONFIG_PCMCIA) += pcmcia
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/drivers/char/boxevent.c linux-2.4.4-boxevent/drivers/char/boxevent.c
--- linux-2.4.4-orig/drivers/char/boxevent.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.4-boxevent/drivers/char/boxevent.c	Mon May  7 16:22:45 2001
@@ -0,0 +1,291 @@
+/* (C) 2001 John Fremlin */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+#include <linux/boxevent.h>
+
+static const char msg_overflow[] = "MSGFLOOD KERNEL messages lost\n";
+
+#define	N_MSGS		16
+#define	MSG_MAXLEN	100
+
+static const char ring[N_MSGS][MSG_MAXLEN];
+static unsigned ring_next; /*=0*/
+
+struct fop_priv
+{
+	int fp_overflow;
+	unsigned fp_ringpos;
+	unsigned fp_msgpos;
+	
+	struct list_head fp_entry;
+}
+;
+
+static DECLARE_WAIT_QUEUE_HEAD(waiters);
+static LIST_HEAD(listeners);
+static spinlock_t listeners_lock = SPIN_LOCK_UNLOCKED;
+	/* protects listeners, ring, ring_next and all the ring_pos in the fop_priv */
+
+/**
+ *	boxevent - inform userspace listeners of a power management event
+ *
+ *	@event_type: one of the BOXEVENT_* defines in linux/boxevent.h,
+ *	general event class
+ *	@subsystem: kernel subsystem generating the event (e.g. "APM")
+ *	@desc: longer description of event (e.g. "lid closed")
+ *
+ *	The arguments are copied, so the caller is responsible for
+ *	freeing them.  This function may be called from interrupt
+ *	context.
+ */
+
+void boxevent(const char* event_type,
+	      const char* subsystem,
+	      const char* desc)
+{
+	unsigned ring_cur;
+	unsigned long flags;
+	
+	/* No snprintf in kernel */
+	if(strlen(event_type)+strlen(subsystem)+strlen(desc) + 5 >=
+		MSG_MAXLEN) {
+		panic("boxevent() arguments too long\n");
+	}
+
+	printk(KERN_DEBUG "box event: %s %s %s\n",event_type,subsystem,desc);
+	
+	spin_lock_irqsave(&listeners_lock,flags);
+
+	ring_cur = ring_next;
+	
+	if(++ring_next >= N_MSGS)
+		ring_next = 0;
+	
+	{
+		struct list_head *i;
+		
+		list_for_each(i,&listeners) {
+			struct fop_priv *priv = list_entry(i, struct fop_priv, fp_entry);
+			if(ring_next == priv->fp_ringpos) {
+				/* we will actually overflow next item,
+				 * but it is easier to complain now
+				 */
+				priv->fp_msgpos = 0;
+				priv->fp_overflow = 1;
+			}
+		}
+
+		
+	}
+
+	sprintf((char*)ring[ring_cur],"%s %s %s\n",event_type,subsystem,desc);
+	
+	spin_unlock_irqrestore(&listeners_lock,flags);
+	
+	wake_up_all(&waiters); /* Recipe for contention */
+}
+
+static ssize_t do_read(struct fop_priv*priv,char*buf,size_t count)
+{
+	ssize_t ret = 0;
+	char* msg; 
+
+	if(!priv->fp_overflow) {
+		if(priv->fp_ringpos == ring_next) {
+			ret = ret ? ret : -EAGAIN;
+			goto out;
+		}
+		msg = (char*)ring[priv->fp_ringpos];
+	}
+	else
+		msg = (char*)msg_overflow;
+			
+	msg += priv->fp_msgpos;
+	ret = strlen(msg);
+	if(ret <= count){
+		if(priv->fp_overflow){
+			priv->fp_overflow = 0;
+			priv->fp_ringpos = ring_next;
+			/* This means the minimum number of
+			 * messages is lost, which might not
+			 * be an altogether good idea, because
+			 * the reader is not given much chance
+			 * to catch up with the flood
+			 */
+		}
+
+		if (++priv->fp_ringpos >= N_MSGS)
+			priv->fp_ringpos = 0;
+			
+		priv->fp_msgpos = 0;
+	} else {
+		ret = count;
+		priv->fp_msgpos += count;
+	}
+		
+	if (copy_to_user(buf, msg, ret))
+		ret = -EFAULT;
+
+ out:
+	return ret;
+}
+	
+
+static ssize_t fop_read(struct file * file, char * buf,
+			size_t count, loff_t *ppos)
+{
+	ssize_t ret;
+	unsigned long flags;
+	struct fop_priv *priv = (struct fop_priv *)file->private_data;
+
+	if (ppos != &file->f_pos) {
+		ret = -ESPIPE;
+		goto out;
+	}
+	
+ retry:	
+	spin_lock_irqsave(&listeners_lock,flags);
+
+	ret = do_read(priv,buf,count);
+
+	spin_unlock_irqrestore(&listeners_lock,flags);
+
+	if((ret == -EAGAIN) && !(file->f_flags&O_NONBLOCK)) {
+		if (wait_event_interruptible(waiters,
+		    priv->fp_overflow || priv->fp_ringpos != ring_next)
+		    == -ERESTARTSYS) {
+			ret = ret ? ret : -ERESTARTSYS;
+			goto out;
+		}
+		goto retry;
+	}
+ out:
+	return ret;
+}
+
+static int fop_open(struct inode * inode, struct file * file)
+{
+	struct fop_priv*priv;
+	unsigned long flags;
+	
+	priv = kmalloc(sizeof *priv,GFP_KERNEL);
+	if(!priv)
+		return -ENOMEM;
+
+	memset(priv,0,sizeof *priv);
+	
+	file->private_data = priv;
+
+	spin_lock_irqsave(&listeners_lock,flags);
+	priv->fp_ringpos = ring_next;
+	list_add(&priv->fp_entry, &listeners);
+	spin_unlock_irqrestore(&listeners_lock,flags);
+
+	return 0;
+}
+
+static void do_remove_priv(struct fop_priv *priv)
+{
+	list_del(&priv->fp_entry);
+	kfree(priv);
+}
+
+static int fop_release(struct inode * inode, struct file * file)
+{
+	struct fop_priv *priv = (struct fop_priv *)file->private_data;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&listeners_lock,flags);
+
+	do_remove_priv(priv);
+	
+	spin_unlock_irqrestore(&listeners_lock,flags);
+
+	return 0;
+}
+
+static unsigned int fop_poll(struct file *file, poll_table * wait)
+{
+	struct fop_priv *priv = (struct fop_priv *)file->private_data;
+	unsigned ret = 0;
+	unsigned long flags;
+	
+	poll_wait(file, &waiters, wait);
+
+	spin_lock_irqsave(&listeners_lock,flags);
+	if(priv->fp_overflow || priv->fp_ringpos != ring_next)
+		ret = POLLIN | POLLRDNORM;
+	spin_unlock_irqrestore(&listeners_lock,flags);
+
+	return ret;
+}
+
+
+static struct file_operations box_fops = {
+	owner:		THIS_MODULE,
+	read:		fop_read,
+	poll:		fop_poll,
+	open:		fop_open,
+	release:		fop_release,
+};
+
+static struct miscdevice box_dev=
+{
+	BOXEVENT_MINOR,
+	"boxevent",
+	&box_fops
+};
+
+static int __init box_init(void)
+{
+	if(misc_register(&box_dev)){
+		printk(KERN_DEBUG "boxevent: could not register device node\n");
+		return -EBUSY;
+	}
+	
+	/* FIXME: remove if this gets into main tree */
+	printk(KERN_INFO "boxevent: subsystem ready\n");
+	return 0;
+}
+
+static void __exit box_exit(void)
+{
+	struct list_head *i,*j;
+	unsigned long flags;
+
+	if(misc_deregister(&box_dev))
+		printk(KERN_DEBUG "boxevent: could not deregister device node\n");
+
+	/* FIXME: remove if this gets into main tree */
+	printk(KERN_INFO "boxevent: shut down\n");
+
+	spin_lock_irqsave(&listeners_lock,flags);
+
+	for(i=listeners.next;i!=&listeners;i=j){
+		struct fop_priv *priv
+			= list_entry(i, struct fop_priv, fp_entry);
+		j = i->next;
+		do_remove_priv(priv);
+	}
+	
+	spin_unlock_irqrestore(&listeners_lock,flags);
+}
+
+module_init(box_init);
+module_exit(box_exit);
+
+MODULE_DESCRIPTION("Simple asynchronous event interface");
+MODULE_AUTHOR("John Fremlin");
+EXPORT_SYMBOL(boxevent);
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/drivers/char/nwbutton.c linux-2.4.4-boxevent/drivers/char/nwbutton.c
--- linux-2.4.4-orig/drivers/char/nwbutton.c	Sun Aug 13 17:54:15 2000
+++ linux-2.4.4-boxevent/drivers/char/nwbutton.c	Mon May  7 15:26:02 2001
@@ -2,6 +2,7 @@
  * 	NetWinder Button Driver-
  *	Copyright (C) Alex Holden <alex@linuxhacker.org> 1998, 1999.
  *
+ *	2001 May 7: Mangled for the the boxevent interface by John Fremlin
  */
 
 #include <linux/config.h>
@@ -12,7 +13,7 @@
 #include <linux/time.h>
 #include <linux/timer.h>
 #include <linux/fs.h>
-#include <linux/miscdevice.h>
+#include <linux/boxevent.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -28,11 +29,9 @@
 static struct timer_list button_timer;	/* Times for the end of a sequence */ 
 static DECLARE_WAIT_QUEUE_HEAD(button_wait_queue); /* Used for blocking read */
 static char button_output_buffer[32];	/* Stores data to write out of device */
-static int bcount;			/* The number of bytes in the buffer */
 static int bdelay = BUTTON_DELAY;	/* The delay, in jiffies */
 static struct button_callback button_callback_list[32]; /* The callback list */
 static int callback_count;		/* The number of callbacks registered */
-static int reboot_count = NUM_PRESSES_REBOOT; /* Number of presses to reboot */
 
 /*
  * This function is called by other drivers to register a callback function
@@ -119,19 +118,15 @@
  * This function is called when the button_timer times out.
  * ie. When you don't press the button for bdelay jiffies, this is taken to
  * mean you have ended the sequence of key presses, and this function is
- * called to wind things up (write the press_count out to /dev/button, call
+ * called to wind things up (write the press_count out to /dev/boxevent, call
  * any matching registered function callbacks, initiate reboot, etc.).
  */
 
 static void button_sequence_finished (unsigned long parameters)
 {
-#ifdef CONFIG_NWBUTTON_REBOOT		/* Reboot using button is enabled */
-	if (button_press_count == reboot_count) {
-		kill_proc (1, SIGINT, 1);	/* Ask init to reboot us */
-	}
-#endif /* CONFIG_NWBUTTON_REBOOT */
 	button_consume_callbacks (button_press_count);
-	bcount = sprintf (button_output_buffer, "%d\n", button_press_count);
+	sprintf (button_output_buffer, "%d presses", button_press_count);
+	boxevent(BOXEVENT_NOTIFY,"nwbutton",button_output_buffer);
 	button_press_count = 0;		/* Reset the button press counter */
 	wake_up_interruptible (&button_wait_queue);
 }
@@ -157,53 +152,11 @@
 }
 
 /*
- * This function is called when a user space program attempts to read
- * /dev/nwbutton. It puts the device to sleep on the wait queue until
- * button_sequence_finished writes some data to the buffer and flushes
- * the queue, at which point it writes the data out to the device and
- * returns the number of characters it has written. This function is
- * reentrant, so that many processes can be attempting to read from the
- * device at any one time.
- */
-
-static int button_read (struct file *filp, char *buffer,
-			size_t count, loff_t *ppos)
-{
-	interruptible_sleep_on (&button_wait_queue);
-	return (copy_to_user (buffer, &button_output_buffer, bcount))
-		 ? -EFAULT : bcount;
-}
-
-/* 
- * This structure is the file operations structure, which specifies what
- * callbacks functions the kernel should call when a user mode process
- * attempts to perform these operations on the device.
- */
-
-static struct file_operations button_fops = {
-	owner:		THIS_MODULE,
-	read:		button_read,
-};
-
-/* 
- * This structure is the misc device structure, which specifies the minor
- * device number (158 in this case), the name of the device (for /proc/misc),
- * and the address of the above file operations structure.
- */
-
-static struct miscdevice button_misc_device = {
-	BUTTON_MINOR,
-	"nwbutton",
-	&button_fops,
-};
-
-/*
- * This function is called to initialise the driver, either from misc.c at
- * bootup if the driver is compiled into the kernel, or from init_module
- * below at module insert time. It attempts to register the device node
- * and the IRQ and fails with a warning message if either fails, though
- * neither ever should because the device number and IRQ are unique to
- * this driver.
+ * This function is called to initialise the driver, either from
+ * misc.c at bootup if the driver is compiled into the kernel, or from
+ * init_module below at module insert time. It attempts to register
+ * the IRQ and fails with a warning message if this fails, though it
+ * never ever should because the IRQ is unique to this driver.
  */
 
 static int __init nwbutton_init(void)
@@ -214,17 +167,10 @@
 	printk (KERN_INFO "NetWinder Button Driver Version %s (C) Alex Holden "
 			"<alex@linuxhacker.org> 1998.\n", VERSION);
 
-	if (misc_register (&button_misc_device)) {
-		printk (KERN_WARNING "nwbutton: Couldn't register device 10, "
-				"%d.\n", BUTTON_MINOR);
-		return -EBUSY;
-	}
-
 	if (request_irq (IRQ_NETWINDER_BUTTON, button_handler, SA_INTERRUPT,
 			"nwbutton", NULL)) {
 		printk (KERN_WARNING "nwbutton: IRQ %d is not free.\n",
 				IRQ_NETWINDER_BUTTON);
-		misc_deregister (&button_misc_device);
 		return -EIO;
 	}
 	return 0;
@@ -233,7 +179,6 @@
 static void __exit nwbutton_exit (void) 
 {
 	free_irq (IRQ_NETWINDER_BUTTON, NULL);
-	misc_deregister (&button_misc_device);
 }
 
 EXPORT_NO_SYMBOLS;
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/drivers/char/nwbutton.h linux-2.4.4-boxevent/drivers/char/nwbutton.h
--- linux-2.4.4-orig/drivers/char/nwbutton.h	Wed Jul  5 21:22:07 2000
+++ linux-2.4.4-boxevent/drivers/char/nwbutton.h	Mon May  7 15:20:28 2001
@@ -10,10 +10,8 @@
 
 /* Various defines: */
 
-#define NUM_PRESSES_REBOOT 2	/* How many presses to activate shutdown */
 #define BUTTON_DELAY 30 	/* How many jiffies for sequence to end */
 #define VERSION "0.3"		/* Driver version number */
-#define BUTTON_MINOR 158	/* Major 10, Minor 158, /dev/nwbutton */
 
 /* Structure definitions: */
 
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/include/linux/boxevent.h linux-2.4.4-boxevent/include/linux/boxevent.h
--- linux-2.4.4-orig/include/linux/boxevent.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.4-boxevent/include/linux/boxevent.h	Mon May  7 16:04:11 2001
@@ -0,0 +1,34 @@
+/* (C) 2001 John Fremlin */
+
+#ifndef _LINUX_BOXEVENT_H_
+#define _LINUX_BOXEVENT_H_
+
+#define BOXEVENT_NOTIFY		       "NOTIFY"
+#define BOXEVENT_SLEEP		       "SLEEP"
+#define BOXEVENT_OFF		       "OFF"
+#define BOXEVENT_WAKE		       "WAKE"
+#define BOXEVENT_EMERGENCY	       "EMERGENCY"
+#define BOXEVENT_POWERCHANGE	        BOXEVENT_NOTIFY
+
+#define BOXEVENT_FLOOD		       "MSGFLOOD"
+					/* only generated if a buffer
+					 * internal to the pm event
+					 * system overflows
+					 */
+#ifdef __KERNEL__
+#include <linux/config.h>
+
+#ifdef CONFIG_BOXEVENT
+void boxevent(const char* event_type,
+	      const char* subsystem,
+	      const char* desc);
+#else
+static inline void  boxevent(const char* event_type,
+			     const char* subsystem,
+			     const char* desc) 
+{
+}
+#endif
+#endif
+
+#endif
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/include/linux/miscdevice.h linux-2.4.4-boxevent/include/linux/miscdevice.h
--- linux-2.4.4-orig/include/linux/miscdevice.h	Tue May  1 20:47:45 2001
+++ linux-2.4.4-boxevent/include/linux/miscdevice.h	Mon May  7 16:21:26 2001
@@ -17,6 +17,7 @@
 #define TEMP_MINOR		131	/* Temperature Sensor */
 #define RTC_MINOR 135
 #define EFI_RTC_MINOR		136	/* EFI Time services */
+#define BOXEVENT_MINOR		137
 #define SUN_OPENPROM_MINOR 139
 #define NVRAM_MINOR 144
 #define I2O_MINOR 166

--=-=-=


-- 

	http://ape.n3.net

--=-=-=--
