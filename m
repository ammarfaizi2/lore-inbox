Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSIIR1W>; Mon, 9 Sep 2002 13:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSIIR1W>; Mon, 9 Sep 2002 13:27:22 -0400
Received: from mailhub.cs.sjsu.edu ([130.65.86.58]:5513 "EHLO
	mailhub.cs.sjsu.edu") by vger.kernel.org with ESMTP
	id <S317589AbSIIR1P>; Mon, 9 Sep 2002 13:27:15 -0400
Date: Mon, 9 Sep 2002 10:31:42 -0700 (PDT)
From: Juan Gomez <gomez@cs.sjsu.edu>
To: hch@infradead.org
cc: linux-kernel@vger.kernel.org
Subject: NFS lockd patch proposal for user-level control of the grace period
 (Unified format)
Message-ID: <Pine.GSO.4.05.10209091028300.17492-100000@eniac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As Requested here is the patch created using unified format:

diff -rNu linux-2.4.19/fs/lockd/Makefile linux-2.4.19-lockd-sysctl/fs/lockd/Makefile
--- linux-2.4.19/fs/lockd/Makefile	Fri Dec 29 14:07:23 2000
+++ linux-2.4.19-lockd-sysctl/fs/lockd/Makefile	Mon Sep  9 17:03:32 2002
@@ -12,7 +12,7 @@
 export-objs := lockd_syms.o
 
 obj-y    := clntlock.o clntproc.o host.o svc.o svclock.o svcshare.o \
-	    svcproc.o svcsubs.o mon.o xdr.o lockd_syms.o
+	    svcproc.o svcsubs.o mon.o xdr.o lockd_syms.o sysctl.o
 
 obj-$(CONFIG_LOCKD_V4) += xdr4.o svc4proc.o
 
diff -rNu linux-2.4.19/fs/lockd/svc.c linux-2.4.19-lockd-sysctl/fs/lockd/svc.c
--- linux-2.4.19/fs/lockd/svc.c	Sun Oct 21 10:32:33 2001
+++ linux-2.4.19-lockd-sysctl/fs/lockd/svc.c	Mon Sep  9 17:03:32 2002
@@ -58,6 +58,12 @@
 unsigned long			nlm_timeout = LOCKD_DFLT_TIMEO;
 unsigned long			nlm_udpport, nlm_tcpport;
 
+/* Imports needed to support sysctl */
+extern void             lockd_register_sysctl(void);
+extern void             lockd_deregister_sysctl(void);
+
+static unsigned long            grace_period_expire;
+
 static unsigned long set_grace_period(void)
 {
 	unsigned long grace_period;
@@ -72,11 +78,20 @@
 	return grace_period + jiffies;
 }
 
-static inline void clear_grace_period(void)
+/* Public version of set_grace_period used from sysctl.c */
+inline void start_grace_period(void)
+{
+
+	grace_period_expire = set_grace_period();
+
+}
+
+inline void clear_grace_period(void)
 {
 	nlmsvc_grace_period = 0;
 }
 
+
 /*
  * This is the lockd kernel thread
  */
@@ -85,7 +100,6 @@
 {
 	struct svc_serv	*serv = rqstp->rq_server;
 	int		err = 0;
-	unsigned long grace_period_expire;
 
 	/* Lock module and set up kernel thread */
 	MOD_INC_USE_COUNT;
@@ -228,6 +242,8 @@
 	if (nlmsvc_pid)
 		goto out;
 
+	lockd_register_sysctl();
+
 	/*
 	 * Sanity check: if there's no pid,
 	 * we should be the first user ...
@@ -291,6 +307,8 @@
 			goto out;
 	} else
 		printk(KERN_WARNING "lockd_down: no users! pid=%d\n", nlmsvc_pid);
+
+	lockd_deregister_sysctl();
 
 	if (!nlmsvc_pid) {
 		if (warned++ == 0)
diff -rNu linux-2.4.19/fs/lockd/sysctl.c linux-2.4.19-lockd-sysctl/fs/lockd/sysctl.c
--- linux-2.4.19/fs/lockd/sysctl.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.19-lockd-sysctl/fs/lockd/sysctl.c	Mon Sep  9 17:03:32 2002
@@ -0,0 +1,157 @@
+
+#include <linux/types.h>
+#include <linux/ctype.h>
+#include <linux/sysctl.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/file.h>
+
+static struct ctl_table_header  *lockd_table_header;
+static ctl_table		lockd_table[];
+
+/* Stuff imported from svc.c */
+
+extern inline void start_grace_period(void);
+extern inline void clear_grace_period(void);
+extern int nlmsvc_grace_period;
+
+
+/* Register with sysctl so we can export control of lockd to user-land
+ * via /proc/sys
+ */
+
+void lockd_register_sysctl()
+{
+
+  if (!lockd_table_header) {
+
+    printk("lockd_register_sysctl:=>register_sysctl_table()\n");
+    lockd_table_header = register_sysctl_table(lockd_table, 1);
+
+  }
+	
+
+}/* void lockd_register_sysctl() */
+
+
+
+
+/* De-register with sysctl so we do not have stale entries in 
+ * /proc/sys
+ */
+
+void lockd_deregister_sysctl()
+{
+
+	if (lockd_table_header) {
+	        printk("lockd_deregister_sysctl:=>register_sysctl_table()\n");
+		unregister_sysctl_table(lockd_table_header);
+		lockd_table_header = NULL;
+	}
+
+}/* void lockd_deregister_sysctl() */
+
+static int
+proc_do_lockd_grace_period(ctl_table *table, 
+                           int write, 
+                           struct file *file,
+                           void *buffer, 
+                           size_t *lenp)
+{
+	char		tmpbuf[20], *p, c;
+	unsigned int	value;
+	size_t		left, len;
+
+	printk("proc_do_lockd_grace_period: write=%d, lenp=%p, buffer=%p\n",
+	       write, lenp, buffer);
+	printk("proc_do_lockd_grace_period: len=%d\n", lenp ? *lenp : 0);
+
+	if ((file->f_pos && !write) || !*lenp) {
+		*lenp = 0;
+		return 0;
+	}
+
+	left = *lenp;
+
+	if (write) {
+
+          if (!access_ok(VERIFY_WRITE, buffer, left))
+            return -EFAULT;
+          p = (char *) buffer;
+          while (left && __get_user(c, p) >= 0 && isspace(c))
+            left--, p++;
+          if (!left)
+            goto done;
+          
+          if (left > sizeof(tmpbuf) - 1)
+            return -EINVAL;
+          copy_from_user(tmpbuf, p, left);
+          tmpbuf[left] = '\0';
+
+
+	  for (p = tmpbuf, value = 0; '0' <= *p && *p <= '9'; p++, left--)
+	    value = 10 * value + (*p - '0');
+	  if (*p && !isspace(*p))
+	    return -EINVAL;
+	  while (left && isspace(*p))
+	    left--, p++;
+
+          if (value == 0) {
+
+            clear_grace_period();
+
+          } else if(value == 1) {
+
+            start_grace_period();
+
+          } else {
+
+            return -EINVAL;
+
+          }
+          
+
+	} else {
+          /* Read Access */
+
+	  printk("proc_do_lockd_grace_period: reading...\n");
+
+          if (!access_ok(VERIFY_READ, buffer, left))
+            return -EFAULT;
+
+          len = sprintf(tmpbuf, "%d", nlmsvc_grace_period);
+          if (len > left)
+            len = left;
+          copy_to_user(buffer, tmpbuf, len);
+          if ((left -= len) > 0) {
+            put_user('\n', (char *)buffer + len);
+            left--;
+          }
+	}
+
+done:
+	*lenp -= left;
+	file->f_pos += *lenp;
+	return 0;
+
+}/*static int proc_do_lockd_sysctl() */
+
+/* Define dir structure we want to export through /proc/fs */
+
+#define DIRENTRY(nam1, nam2, child)	\
+	{CTL_##nam1, #nam2, NULL, 0, 0555, child }
+#define LOCKD_FILE_ENTRY(nam1, nam2)	\
+	{LOCKD_CTL_##nam1##, "lockd_" #nam2, NULL, 0,\
+	 0644, NULL, &proc_do_lockd_grace_period}
+
+static ctl_table		lockd_file_table[] = {
+	LOCKD_FILE_ENTRY(GRACE_PERIOD,  grace_period),
+	{0}
+};
+
+static ctl_table		lockd_table[] = {
+	DIRENTRY(LOCKD, lockd, lockd_file_table),
+	{0}
+};
+
diff -rNu linux-2.4.19/include/linux/sysctl.h linux-2.4.19-lockd-sysctl/include/linux/sysctl.h
--- linux-2.4.19/include/linux/sysctl.h	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19-lockd-sysctl/include/linux/sysctl.h	Mon Sep  9 17:03:32 2002
@@ -63,7 +63,8 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+        CTL_LOCKD=11,           /* Lockd info and control */
 };
 
 /* CTL_BUS names: */
@@ -627,6 +628,14 @@
 	ABI_TRACE=5,		/* tracing flags */
 	ABI_FAKE_UTSNAME=6,	/* fake target utsname information */
 };
+
+
+/* /proc/sys/lockd */
+enum
+{
+        LOCKD_CTL_GRACE_PERIOD=1,/* Enable user-level grace period control */
+};
+
 
 #ifdef __KERNEL__
 

