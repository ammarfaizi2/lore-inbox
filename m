Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261761AbSIXTAV>; Tue, 24 Sep 2002 15:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSIXTAV>; Tue, 24 Sep 2002 15:00:21 -0400
Received: from p5084EB48.dip.t-dialin.net ([80.132.235.72]:11845 "EHLO
	goat.bogus.local") by vger.kernel.org with ESMTP id <S261761AbSIXTAT>;
	Tue, 24 Sep 2002 15:00:19 -0400
X-From-Line: nobody Tue Sep 24 17:39:44 2002
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [PATCH] accessfs v0.5 ported to LSM - 1/2
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Tue, 24 Sep 2002 17:39:43 +0200
Message-ID: <878z1rpfb4.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Accessfs is a new file system to control access to system resources.
For further information see the help text.

Changes:
- ported to LSM
- support capabilities
- merged ipv4/ipv6 into ip

This part (1/2) adds a hook to LSM to enable control based on the port
number.

The patch is attached below. It is also available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs-2.5.34-0.5-1_2.patch.gz>

It applies to 2.5.3[5-8] as well.

I did minimal testing using uml 0.58-2.5.34.

Regards, Olaf.

diff -urN v2.5.34/include/linux/security.h v2.5.34-accessfs/include/linux/security.h
--- v2.5.34/include/linux/security.h	Sun Sep  1 00:04:51 2002
+++ v2.5.34-accessfs/include/linux/security.h	Tue Sep 24 13:25:50 2002
@@ -642,6 +642,13 @@
  *	@args contains the call arguments (user space pointer).
  *	The module should return -ENOSYS if it does not implement any new
  *	system calls.
+ * @ip_prot_sock:
+ *	Check, whether this is a protected port.
+ *	Security modules may use this hook to implement fine grained control
+ *	based on the port number.
+ *	@port contains the requested port
+ *	The module should return true if port is a protected port (e.g. < 1024),
+ *	false otherwise.
  *
  * @register_security:
  * 	allow module stacking.
@@ -785,6 +792,7 @@
 			   unsigned long arg5);
 	void (*task_kmod_set_label) (void);
 	void (*task_reparent_to_init) (struct task_struct * p);
+	int (*ip_prot_sock) (int port);
 
 	/* allow module stacking */
 	int (*register_security) (const char *name,
diff -urN v2.5.34/net/ipv4/af_inet.c v2.5.34-accessfs/net/ipv4/af_inet.c
--- v2.5.34/net/ipv4/af_inet.c	Tue Sep 24 11:52:15 2002
+++ v2.5.34-accessfs/net/ipv4/af_inet.c	Tue Sep 24 13:21:29 2002
@@ -531,7 +531,7 @@
 
 	snum = ntohs(addr->sin_port);
 	err = -EACCES;
-	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+	if (security_ops->ip_prot_sock(snum) && !capable(CAP_NET_BIND_SERVICE))
 		goto out;
 
 	/*      We keep a pair of addresses. rcv_saddr is the one
diff -urN v2.5.34/net/ipv6/af_inet6.c v2.5.34-accessfs/net/ipv6/af_inet6.c
--- v2.5.34/net/ipv6/af_inet6.c	Tue Sep 24 11:52:15 2002
+++ v2.5.34-accessfs/net/ipv6/af_inet6.c	Tue Sep 24 13:21:56 2002
@@ -313,7 +313,7 @@
 	}
 
 	snum = ntohs(addr->sin6_port);
-	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+	if (security_ops->ip_prot_sock(snum) && !capable(CAP_NET_BIND_SERVICE))
 		return -EACCES;
 
 	lock_sock(sk);
diff -urN v2.5.34/security/capability.c v2.5.34-accessfs/security/capability.c
--- v2.5.34/security/capability.c	Sun Sep  1 00:04:55 2002
+++ v2.5.34-accessfs/security/capability.c	Tue Sep 24 13:20:08 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <net/sock.h>
 
 /* flag to keep track of how we were registered */
 static int secondary;
@@ -679,6 +680,11 @@
 	return;
 }
 
+static int cap_ip_prot_sock (int port)
+{
+	return port && port < PROT_SOCK;
+}
+
 static int cap_register (const char *name, struct security_operations *ops)
 {
 	return -EINVAL;
@@ -781,6 +787,8 @@
 	.task_prctl =			cap_task_prctl,
 	.task_kmod_set_label =		cap_task_kmod_set_label,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
+
+	.ip_prot_sock =	cap_ip_prot_sock,
 
 	.register_security =		cap_register,
 	.unregister_security =		cap_unregister,
diff -urN v2.5.34/security/dummy.c v2.5.34-accessfs/security/dummy.c
--- v2.5.34/security/dummy.c	Sun Sep  1 00:04:52 2002
+++ v2.5.34-accessfs/security/dummy.c	Tue Sep 24 13:19:21 2002
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <net/sock.h>
 
 static int dummy_ptrace (struct task_struct *parent, struct task_struct *child)
 {
@@ -493,6 +494,11 @@
 	return;
 }
 
+static int dummy_ip_prot_sock (int port)
+{
+	return port && port < PROT_SOCK;
+}
+
 static int dummy_register (const char *name, struct security_operations *ops)
 {
 	return -EINVAL;
@@ -595,6 +601,8 @@
 	.task_prctl =			dummy_task_prctl,
 	.task_kmod_set_label =		dummy_task_kmod_set_label,
 	.task_reparent_to_init =	dummy_task_reparent_to_init,
+
+	.ip_prot_sock =	dummy_ip_prot_sock,
 
 	.register_security =		dummy_register,
 	.unregister_security =		dummy_unregister,
