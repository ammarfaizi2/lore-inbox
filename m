Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVDERpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVDERpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVDERob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:44:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61392 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261847AbVDERVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:21:35 -0400
Date: Tue, 5 Apr 2005 13:21:28 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [PATCH] SELinux: add support for NETLINK_KOBJECT_UEVENT
Message-ID: <Xine.LNX.4.44.0504051317280.12266-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SELinux support for the KOBJECT_UEVENT Netlink family,
so that SELinux can apply finer grained controls to it.  For example,
security policy for hald can be locked down to the KOBJECT_UEVENT
Netlink family only.  Currently, this family simply defaults to the
default Netlink socket class.

Note that some new permission definitions are added to sync with
changes in the core userspace policy package, which auto-generates
header files.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c                     |    2 +
 security/selinux/include/av_inherit.h        |    1 
 security/selinux/include/av_perm_to_string.h |    4 +++
 security/selinux/include/av_permissions.h    |   28 +++++++++++++++++++++++++++
 security/selinux/include/class_to_string.h   |    2 +
 security/selinux/include/flask.h             |    2 +
 6 files changed, 39 insertions(+)

diff -purN -X dontdiff linux-2.6.12-rc1-mm4.o/security/selinux/hooks.c linux-2.6.12-rc1-mm4.w/security/selinux/hooks.c
--- linux-2.6.12-rc1-mm4.o/security/selinux/hooks.c	2005-04-04 18:39:37.000000000 -0400
+++ linux-2.6.12-rc1-mm4.w/security/selinux/hooks.c	2005-04-05 12:41:03.000000000 -0400
@@ -672,6 +672,8 @@ static inline u16 socket_type_to_securit
 			return SECCLASS_NETLINK_IP6FW_SOCKET;
 		case NETLINK_DNRTMSG:
 			return SECCLASS_NETLINK_DNRT_SOCKET;
+		case NETLINK_KOBJECT_UEVENT:
+			return SECCLASS_NETLINK_KOBJECT_UEVENT_SOCKET;
 		default:
 			return SECCLASS_NETLINK_SOCKET;
 		}
diff -purN -X dontdiff linux-2.6.12-rc1-mm4.o/security/selinux/include/av_inherit.h linux-2.6.12-rc1-mm4.w/security/selinux/include/av_inherit.h
--- linux-2.6.12-rc1-mm4.o/security/selinux/include/av_inherit.h	2005-03-15 19:17:05.000000000 -0500
+++ linux-2.6.12-rc1-mm4.w/security/selinux/include/av_inherit.h	2005-04-05 06:44:00.000000000 -0400
@@ -28,3 +28,4 @@
    S_(SECCLASS_NETLINK_AUDIT_SOCKET, socket, 0x00400000UL)
    S_(SECCLASS_NETLINK_IP6FW_SOCKET, socket, 0x00400000UL)
    S_(SECCLASS_NETLINK_DNRT_SOCKET, socket, 0x00400000UL)
+   S_(SECCLASS_NETLINK_KOBJECT_UEVENT_SOCKET, socket, 0x00400000UL)
diff -purN -X dontdiff linux-2.6.12-rc1-mm4.o/security/selinux/include/av_permissions.h linux-2.6.12-rc1-mm4.w/security/selinux/include/av_permissions.h
--- linux-2.6.12-rc1-mm4.o/security/selinux/include/av_permissions.h	2005-04-04 18:39:37.000000000 -0400
+++ linux-2.6.12-rc1-mm4.w/security/selinux/include/av_permissions.h	2005-04-05 06:44:00.000000000 -0400
@@ -559,6 +559,8 @@
 #define CAPABILITY__SYS_TTY_CONFIG                0x04000000UL
 #define CAPABILITY__MKNOD                         0x08000000UL
 #define CAPABILITY__LEASE                         0x10000000UL
+#define CAPABILITY__AUDIT_WRITE                   0x20000000UL
+#define CAPABILITY__AUDIT_CONTROL                 0x40000000UL
 
 #define PASSWD__PASSWD                            0x00000001UL
 #define PASSWD__CHFN                              0x00000002UL
@@ -900,3 +902,29 @@
 #define NSCD__SHMEMGRP                            0x00000040UL
 #define NSCD__SHMEMHOST                           0x00000080UL
 
+#define ASSOCIATION__SENDTO                       0x00000001UL
+#define ASSOCIATION__RECVFROM                     0x00000002UL
+
+#define NETLINK_KOBJECT_UEVENT_SOCKET__IOCTL      0x00000001UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__READ       0x00000002UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__WRITE      0x00000004UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__CREATE     0x00000008UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__GETATTR    0x00000010UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__SETATTR    0x00000020UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__LOCK       0x00000040UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__RELABELFROM 0x00000080UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__RELABELTO  0x00000100UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__APPEND     0x00000200UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__BIND       0x00000400UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__CONNECT    0x00000800UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__LISTEN     0x00001000UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__ACCEPT     0x00002000UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__GETOPT     0x00004000UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__SETOPT     0x00008000UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__SHUTDOWN   0x00010000UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__RECVFROM   0x00020000UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__SENDTO     0x00040000UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__RECV_MSG   0x00080000UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__SEND_MSG   0x00100000UL
+#define NETLINK_KOBJECT_UEVENT_SOCKET__NAME_BIND  0x00200000UL
+
diff -purN -X dontdiff linux-2.6.12-rc1-mm4.o/security/selinux/include/av_perm_to_string.h linux-2.6.12-rc1-mm4.w/security/selinux/include/av_perm_to_string.h
--- linux-2.6.12-rc1-mm4.o/security/selinux/include/av_perm_to_string.h	2005-04-04 18:39:37.000000000 -0400
+++ linux-2.6.12-rc1-mm4.w/security/selinux/include/av_perm_to_string.h	2005-04-05 06:44:00.000000000 -0400
@@ -118,6 +118,8 @@
    S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_TTY_CONFIG, "sys_tty_config")
    S_(SECCLASS_CAPABILITY, CAPABILITY__MKNOD, "mknod")
    S_(SECCLASS_CAPABILITY, CAPABILITY__LEASE, "lease")
+   S_(SECCLASS_CAPABILITY, CAPABILITY__AUDIT_WRITE, "audit_write")
+   S_(SECCLASS_CAPABILITY, CAPABILITY__AUDIT_CONTROL, "audit_control")
    S_(SECCLASS_PASSWD, PASSWD__PASSWD, "passwd")
    S_(SECCLASS_PASSWD, PASSWD__CHFN, "chfn")
    S_(SECCLASS_PASSWD, PASSWD__CHSH, "chsh")
@@ -230,3 +232,5 @@
    S_(SECCLASS_NSCD, NSCD__SHMEMPWD, "shmempwd")
    S_(SECCLASS_NSCD, NSCD__SHMEMGRP, "shmemgrp")
    S_(SECCLASS_NSCD, NSCD__SHMEMHOST, "shmemhost")
+   S_(SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, "sendto")
+   S_(SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, "recvfrom")
diff -purN -X dontdiff linux-2.6.12-rc1-mm4.o/security/selinux/include/class_to_string.h linux-2.6.12-rc1-mm4.w/security/selinux/include/class_to_string.h
--- linux-2.6.12-rc1-mm4.o/security/selinux/include/class_to_string.h	2005-03-15 19:17:05.000000000 -0500
+++ linux-2.6.12-rc1-mm4.w/security/selinux/include/class_to_string.h	2005-04-05 06:44:00.000000000 -0400
@@ -56,3 +56,5 @@
     S_("netlink_dnrt_socket")
     S_("dbus")
     S_("nscd")
+    S_("association")
+    S_("netlink_kobject_uevent_socket")
diff -purN -X dontdiff linux-2.6.12-rc1-mm4.o/security/selinux/include/flask.h linux-2.6.12-rc1-mm4.w/security/selinux/include/flask.h
--- linux-2.6.12-rc1-mm4.o/security/selinux/include/flask.h	2005-03-15 19:17:05.000000000 -0500
+++ linux-2.6.12-rc1-mm4.w/security/selinux/include/flask.h	2005-04-05 06:44:00.000000000 -0400
@@ -58,6 +58,8 @@
 #define SECCLASS_NETLINK_DNRT_SOCKET                     51
 #define SECCLASS_DBUS                                    52
 #define SECCLASS_NSCD                                    53
+#define SECCLASS_ASSOCIATION                             54
+#define SECCLASS_NETLINK_KOBJECT_UEVENT_SOCKET           55
 
 /*
  * Security identifier indices for initial entities


