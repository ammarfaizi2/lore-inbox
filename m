Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130653AbQL2Xsg>; Fri, 29 Dec 2000 18:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129930AbQL2Xs0>; Fri, 29 Dec 2000 18:48:26 -0500
Received: from m102-mp1-cvx1a.col.ntl.com ([213.104.68.102]:11012 "EHLO
	[213.104.68.102]") by vger.kernel.org with ESMTP id <S130061AbQL2XsS>;
	Fri, 29 Dec 2000 18:48:18 -0500
To: <linux-kernel@vger.kernel.org>
Cc: "Stephen Rothwell" <sfr@linuxcare.com>
Subject: [PATCH] add capability to reject APM suspend events from userspace
From: "John Fremlin" <vii@penguinpowered.com>
Date: 29 Dec 2000 23:01:52 +0000
Message-ID: <m266k2de73.fsf@boreas.yi.org.>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to use the off button to cleanly shutdown
a computer. The feature has been supported by the userspace apmd
daemon for ages, but for some reason the patches to include it in the
kernel were (apparently) ignored by Linus' patch tracking "system".

For the original patch by the person in charge of APM, Stephen
Rothwell, see:
http://boudicca.tux.org/hypermail/linux-kernel/2000week15/0481.html

The following patch is based on the above, but only adds functionality
to reject a suspend event, and does not integrate the other useful
features. On the other hand, it does apply to linux-2.4.0-test13-pre4
so people can use it now.

diff -u linux-2.4.0-test13-pre4/arch/i386/kernel/apm.c linux-hacked/arch/i386/kernel/apm.c
--- linux-2.4.0-test13-pre4/arch/i386/kernel/apm.c	Fri Dec 29 22:47:16 2000
+++ linux-hacked/arch/i386/kernel/apm.c	Fri Dec 29 22:49:32 2000
@@ -38,6 +38,7 @@
  * Jan 2000, Version 1.12
  * Feb 2000, Version 1.13
  * Nov 2000, Version 1.14
+ * Dec 2000, Version 1.15
  *
  * History:
  *    0.6b: first version in official kernel, Linux 1.3.46
@@ -148,6 +149,10 @@
  *   1.14: Make connection version persist across module unload/load.
  *         Enable and engage power management earlier.
  *         Disengage power management on module unload.
+ *   1.15: Add APM_IOC_REJECT ioctl, based on a patch from Stephen
+ *         Rothwell but apparently written by Craig Markwardt
+ *         <craigm@lheamail.gsfc.nasa.gov>.
+ *         John Fremlin <vii@penguinpowered.com>
  *
  * APM 1.1 Reference:
  *
@@ -301,6 +306,7 @@
 	int		suspend_result;
 	int		suspends_pending;
 	int		standbys_pending;
+	int		rejects_pending;
 	int		suspends_read;
 	int		standbys_read;
 	int		event_head;
@@ -325,6 +331,7 @@
 #endif
 static int			suspends_pending;
 static int			standbys_pending;
+static int			rejects_pending;
 static int			waiting_for_resume;
 static int			ignore_normal_resume;
 static int			bounce_interval = DEFAULT_BOUNCE_INTERVAL;
@@ -350,7 +357,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *	user_list;
 
-static char			driver_version[] = "1.14";	/* no spaces */
+static char			driver_version[] = "1.15";	/* no spaces */
 
 static char *	apm_event_name[] = {
 	"system standby",
@@ -832,6 +839,15 @@
 			as->standbys_pending++;
 			standbys_pending++;
 			break;
+
+		case APM_SUSPEND_REJECT:
+			as->suspend_wait = 0;
+			as->suspend_result = -EAGAIN;
+			/* Fall through to */
+		case APM_STANDBY_REJECT:
+			as->rejects_pending++;
+			rejects_pending++;
+			break;
 		}
 	}
 	wake_up_interruptible(&apm_waitqueue);
@@ -1211,6 +1227,41 @@
 	return 0;
 }
 
+static int send_reject(struct apm_user *as, apm_event_t state)
+{
+	if (as->rejects_pending > 0) {
+		as->rejects_pending--;
+		rejects_pending--;
+	} else {
+		switch (state) {
+		case APM_SYS_SUSPEND:
+		case APM_USER_SUSPEND:
+			queue_event(APM_SUSPEND_REJECT, as);
+			break;
+		case APM_SYS_STANDBY:
+		case APM_USER_STANDBY:
+			queue_event(APM_STANDBY_REJECT, as);
+			break;
+		}
+	}
+	if ((rejects_pending <= 0) &&
+	    (suspends_pending <= 0) &&
+	    (standbys_pending <= 0)) {
+		switch (state) {
+		case APM_SYS_SUSPEND:
+		case APM_USER_SUSPEND:
+			send_event(APM_NORMAL_RESUME);
+			break;
+		case APM_SYS_STANDBY:
+		case APM_USER_STANDBY:
+			send_event(APM_STANDBY_RESUME);
+			break;
+		}
+		return apm_set_power_state(APM_STATE_REJECT);
+	}
+	return APM_SUCCESS;
+}
+
 static int do_ioctl(struct inode * inode, struct file *filp,
 		    u_int cmd, u_long arg)
 {
@@ -1262,12 +1313,30 @@
 			return as->suspend_result;
 		}
 		break;
+	case APM_IOC_REJECT:
+		if (as->suspends_read > 0) {
+			as->suspends_read--;
+			as->suspends_pending--;
+			suspends_pending--;
+			if(send_reject(as, APM_SYS_SUSPEND)!=APM_SUCCESS)
+				return -EREMOTEIO;
+		} else if (as->standbys_read > 0) {
+			as->standbys_read--;
+			as->standbys_pending--;
+			standbys_pending--;
+			if(send_reject(as, APM_SYS_STANDBY)!=APM_SUCCESS)
+				return -EREMOTEIO;
+		} else
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
 	return 0;
 }
 
+
+
 static int do_release(struct inode * inode, struct file * filp)
 {
 	struct apm_user *	as;
@@ -1277,14 +1346,16 @@
 		return 0;
 	filp->private_data = NULL;
 	lock_kernel();
+	rejects_pending -= as->rejects_pending;
+	as->rejects_pending = 0;
 	if (as->standbys_pending > 0) {
 		standbys_pending -= as->standbys_pending;
-		if (standbys_pending <= 0)
+		if (standbys_pending <= 0 && rejects_pending <= 0)
 			standby();
 	}
 	if (as->suspends_pending > 0) {
 		suspends_pending -= as->suspends_pending;
-		if (suspends_pending <= 0)
+		if (suspends_pending <= 0 && rejects_pending <= 0)
 			(void) suspend();
 	}
 	if (user_list == as)
@@ -1318,7 +1389,7 @@
 	}
 	as->magic = APM_BIOS_MAGIC;
 	as->event_tail = as->event_head = 0;
-	as->suspends_pending = as->standbys_pending = 0;
+	as->suspends_pending = as->standbys_pending = as->rejects_pending = 0;
 	as->suspends_read = as->standbys_read = 0;
 	/*
 	 * XXX - this is a tiny bit broken, when we consider BSD
diff --recursive -u linux-2.4.0-test13-pre4/include/linux/apm_bios.h linux-hacked/include/linux/apm_bios.h
--- linux-2.4.0-test13-pre4/include/linux/apm_bios.h	Fri Dec 29 22:46:31 2000
+++ linux-hacked/include/linux/apm_bios.h	Fri Dec 29 06:57:09 2000
@@ -139,6 +139,8 @@
 #define APM_USER_SUSPEND	0x000a
 #define APM_STANDBY_RESUME	0x000b
 #define APM_CAPABILITY_CHANGE	0x000c
+#define APM_STANDBY_REJECT	0x000d
+#define APM_SUSPEND_REJECT	0x000e
 
 /*
  * Error codes
@@ -210,5 +212,6 @@
 
 #define APM_IOC_STANDBY		_IO('A', 1)
 #define APM_IOC_SUSPEND		_IO('A', 2)
+#define APM_IOC_REJECT		_IO('A', 3)
 
 #endif	/* LINUX_APM_H */

-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
