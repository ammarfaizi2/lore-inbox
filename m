Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136755AbREAXIe>; Tue, 1 May 2001 19:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136754AbREAXIP>; Tue, 1 May 2001 19:08:15 -0400
Received: from m117-mp1-cvx1b.col.ntl.com ([213.104.72.117]:896 "EHLO
	[213.104.72.117]") by vger.kernel.org with ESMTP id <S131742AbREAXIB>;
	Tue, 1 May 2001 19:08:01 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Actual patch for next gen PM interface
In-Reply-To: <E14qJkH-0007pb-00@the-village.bc.nu>
From: John Fremlin <chief@bandits.org>
Date: 02 May 2001 00:07:17 +0100
In-Reply-To: <E14qJkH-0007pb-00@the-village.bc.nu>
Message-ID: <m2y9sgekii.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


This is an attempt at a generic PM event interface for the kernel.
The design is more or less obvious and was laid out in a previous
message. Comments appreciated.

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > The entire PM layer for the embedded board I worked on was
> > > 3Kbytes. How small will yours be 8)
> > 
> > The generic event interface will be under 3kB, I hope. Would you
> > accept it if so? ;-)
> 
> We shall see. I've played with several ideas and never really been
> happy with them so maybe you can solve it

The fruits of today's labour are here. Unfortunately it *is* just over
3kB (but if I understand correctly under 4kB) mostly due to the
generous buffer sizes.

Note that this is prelim work. (Particularly the changes to the APM
stuff need to be looked at, and are not strictly relevant to the patch
at hand.) At the moment, APM events are printed to /dev/pmevent and
kmsg. Suspend requests are no longer acted on by the kernel. This
breaks backward compatibility.

The /dev/pmevent stuff is hopefully pretty feature complete. The
device numbers for it are 10 137. Multiple listeners are allowed etc.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.4.4-pmevent-2.patch

diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/arch/i386/kernel/apm.c linux-2.4.4-pmevent/arch/i386/kernel/apm.c
--- linux-2.4.4-orig/arch/i386/kernel/apm.c	Tue May  1 14:33:34 2001
+++ linux-2.4.4-pmevent/arch/i386/kernel/apm.c	Tue May  1 23:47:18 2001
@@ -186,6 +186,7 @@
 #include <linux/pm.h>
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/pmevent.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -327,7 +328,6 @@
 #endif
 static int			suspends_pending;
 static int			standbys_pending;
-static int			waiting_for_resume;
 static int			ignore_normal_resume;
 static int			bounce_interval = DEFAULT_BOUNCE_INTERVAL;
 
@@ -886,33 +886,6 @@
 #endif
 }
 
-static int send_event(apm_event_t event)
-{
-	switch (event) {
-	case APM_SYS_SUSPEND:
-	case APM_CRITICAL_SUSPEND:
-	case APM_USER_SUSPEND:
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
-		break;
-	case APM_NORMAL_RESUME:
-	case APM_CRITICAL_RESUME:
-		/* map all resumes to ACPI D0 */
-		(void) pm_send_all(PM_RESUME, (void *)0);
-		break;
-	}
-
-	return 1;
-}
-
 static int suspend(void)
 {
 	int		err;
@@ -927,7 +900,6 @@
 		err = APM_SUCCESS;
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
-	send_event(APM_NORMAL_RESUME);
 	sti();
 	queue_event(APM_NORMAL_RESUME, NULL);
 	for (as = user_list; as != NULL; as = as->next) {
@@ -968,6 +940,43 @@
 	return 0;
 }
 
+static void announce_event(apm_event_t event)
+{
+	char*type = PME_NOTIFY;
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
+		type = PME_SLEEP;
+		break;
+	case APM_NORMAL_RESUME:
+	case APM_CRITICAL_RESUME:
+	case APM_STANDBY_RESUME:
+		type = PME_WAKE;
+		break;
+	case APM_CAPABILITY_CHANGE:
+		type = PME_NOTIFY;
+		break;
+	case APM_LOW_BATTERY:
+		type = PME_EMERGENCY;
+		break;
+	case APM_POWER_STATUS_CHANGE:
+		type = PME_POWERCHANGE;
+		break;
+	default:
+		type = PME_NOTIFY;
+	}
+	pme_announce(type,"APM",name);
+}
+
 static void check_events(void)
 {
 	apm_event_t		event;
@@ -989,56 +998,35 @@
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
+			queue_event(event, NULL);
+			if (standbys_pending <= 0)
+				standby();
 			break;
 
 		case APM_USER_SUSPEND:
-#ifdef CONFIG_APM_IGNORE_USER_SUSPEND
-			if (apm_info.connection_version > 0x100)
-				apm_set_power_state(APM_STATE_REJECT);
-			break;
-#endif
 		case APM_SYS_SUSPEND:
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
+			/* Reject all suspend requests and let
+			 * userspace call suspend if they want to
 			 */
-			if (waiting_for_resume)
-				return;
-			if (send_event(event)) {
-				queue_event(event, NULL);
-				waiting_for_resume = 1;
-				if (suspends_pending <= 0)
-					(void) suspend();
-			}
+			if (apm_info.connection_version > 0x100)
+				apm_set_power_state(APM_STATE_REJECT);
+
+			queue_event(event, NULL);
 			break;
 
 		case APM_NORMAL_RESUME:
 		case APM_CRITICAL_RESUME:
 		case APM_STANDBY_RESUME:
-			waiting_for_resume = 0;
 			last_resume = jiffies;
 			ignore_bounce = 1;
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
 				set_time();
-				send_event(event);
 				queue_event(event, NULL);
 			}
 			break;
@@ -1046,7 +1034,6 @@
 		case APM_CAPABILITY_CHANGE:
 		case APM_LOW_BATTERY:
 		case APM_POWER_STATUS_CHANGE:
-			send_event(event);
 			queue_event(event, NULL);
 			break;
 
@@ -1055,7 +1042,6 @@
 			break;
 
 		case APM_CRITICAL_SUSPEND:
-			send_event(event);
 			/*
 			 * We can only hope it worked - we are not allowed
 			 * to reject a critical suspend.
@@ -1153,6 +1139,9 @@
 	apm_event_t		event;
 	DECLARE_WAITQUEUE(wait, current);
 
+	if (ppos != &fp->f_pos)
+		return -ESPIPE;
+
 	as = fp->private_data;
 	if (check_apm_user(as, "read"))
 		return -EIO;
@@ -1230,9 +1219,7 @@
 			as->standbys_read--;
 			as->standbys_pending--;
 			standbys_pending--;
-		} else if (!send_event(APM_USER_STANDBY))
-			return -EAGAIN;
-		else
+		} else
 			queue_event(APM_USER_STANDBY, as);
 		if (standbys_pending <= 0)
 			standby();
@@ -1242,9 +1229,7 @@
 			as->suspends_read--;
 			as->suspends_pending--;
 			suspends_pending--;
-		} else if (!send_event(APM_USER_SUSPEND))
-			return -EAGAIN;
-		else
+		} else
 			queue_event(APM_USER_SUSPEND, as);
 		if (suspends_pending <= 0) {
 			if (suspend() != APM_SUCCESS)
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/include/linux/pmevent.h linux-2.4.4-pmevent/include/linux/pmevent.h
--- linux-2.4.4-orig/include/linux/pmevent.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.4-pmevent/include/linux/pmevent.h	Tue May  1 23:46:35 2001
@@ -0,0 +1,32 @@
+#ifndef _LINUX_PMEVENT_H_
+#define _LINUX_PMEVENT_H_
+
+#define PME_NOTIFY		"NOTIFY"
+#define PME_SLEEP		"SLEEP"
+#define PME_OFF			"OFF"
+#define PME_WAKE		"WAKE"
+#define PME_EMERGENCY		"EMERGENCY"
+#define PME_POWERCHANGE	PME_NOTIFY
+
+#define PME_FLOOD		"MSGFLOOD"
+					/* only generated if a buffer
+					 * internal to the pm event
+					 * system overflows
+					 */
+#ifdef __KERNEL__
+#include <linux/config.h>
+
+#ifdef CONFIG_PM
+void pme_announce(const char* event_type,
+		  const char* subsystem,
+		  const char* desc);
+#else
+static inline void  pme_announce(const char* event_type,
+				 const char* subsystem,
+				 const char* desc) 
+{
+}
+#endif
+#endif
+
+#endif
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/kernel/Makefile linux-2.4.4-pmevent/kernel/Makefile
--- linux-2.4.4-orig/kernel/Makefile	Tue Feb 20 16:45:51 2001
+++ linux-2.4.4-pmevent/kernel/Makefile	Tue May  1 18:01:49 2001
@@ -18,7 +18,7 @@
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
-obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_PM) += pm.o pmevent.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff --new-file -u --recursive --exclude *~ linux-2.4.4-orig/kernel/pmevent.c linux-2.4.4-pmevent/kernel/pmevent.c
--- linux-2.4.4-orig/kernel/pmevent.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.4-pmevent/kernel/pmevent.c	Tue May  1 23:57:13 2001
@@ -0,0 +1,262 @@
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
+#include <asm/uaccess.h>
+
+#include <linux/pmevent.h>
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
+ *	pme_announce - inform userspace listeners of a power management event
+ *	@event_type: one of the PME_* defines in linux/pmevent.h, general event class
+ *	@subsystem: kernel subsystem generating the event (e.g. "APM")
+ *	@desc: longer description of event (e.g. "lid closed")
+ *
+ *	This function must not be called from interrupt context.
+ */
+
+void pme_announce(const char* event_type,
+		  const char* subsystem,
+		  const char* desc)
+{
+	unsigned ring_cur;
+	
+	/* No snprintf in kernel */
+	if(strlen(event_type)+strlen(subsystem)+strlen(desc) + 5 >=
+		MSG_MAXLEN) {
+		panic("pme_announce arguments too long\n");
+	}
+
+	printk(KERN_DEBUG "pm event: %s %s %s\n",event_type,subsystem,desc);
+	
+	spin_lock(&listeners_lock);
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
+	spin_unlock(&listeners_lock);
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
+	struct fop_priv *priv = (struct fop_priv *)file->private_data;
+
+	if (ppos != &file->f_pos) {
+		ret = -ESPIPE;
+		goto out;
+	}
+	
+ retry:	
+	spin_lock(&listeners_lock);
+
+	ret = do_read(priv,buf,count);
+
+	spin_unlock(&listeners_lock);
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
+	priv = kmalloc(sizeof *priv,GFP_KERNEL);
+	if(!priv)
+		return -ENOMEM;
+
+	memset(priv,0,sizeof *priv);
+	
+	file->private_data = priv;
+
+	spin_lock(&listeners_lock);
+	priv->fp_ringpos = ring_next;
+	list_add(&priv->fp_entry, &listeners);
+	spin_unlock(&listeners_lock);
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
+
+	spin_lock(&listeners_lock);
+
+	do_remove_priv(priv);
+	
+	spin_unlock(&listeners_lock);
+
+	return 0;
+}
+
+static unsigned int fop_poll(struct file *file, poll_table * wait)
+{
+	struct fop_priv *priv = (struct fop_priv *)file->private_data;
+	unsigned ret = 0;
+	
+	poll_wait(file, &waiters, wait);
+
+	spin_lock(&listeners_lock);
+	if(priv->fp_overflow || priv->fp_ringpos != ring_next)
+		ret = POLLIN | POLLRDNORM;
+	spin_unlock(&listeners_lock);
+
+	return ret;
+}
+
+
+static struct file_operations pme_fops = {
+	read:		fop_read,
+	poll:		fop_poll,
+	open:		fop_open,
+	release:        fop_release,
+};
+
+static struct miscdevice pme_dev=
+{
+	PMEVENT_MINOR,
+	"pmevent",
+	&pme_fops
+};
+
+static int __init pme_init(void)
+{
+	misc_register(&pme_dev);
+	printk(KERN_INFO "pm event: subsystem ready\n");
+	return 0;
+}
+
+static void __exit pme_exit(void)
+{
+	struct list_head *i,*j;
+
+	misc_deregister(&pme_dev);
+	printk(KERN_INFO "pm event: subsystem closing\n");
+
+	spin_lock(&listeners_lock);
+
+	for(i=listeners.next;i!=&listeners;i=j){
+		struct fop_priv *priv
+			= list_entry(i, struct fop_priv, fp_entry);
+		j = i->next;
+		do_remove_priv(priv);
+	}
+}
+
+module_init(pme_init);
+module_exit(pme_exit);

--=-=-=


-- 

	http://www.penguinpowered.com/~vii

--=-=-=--
