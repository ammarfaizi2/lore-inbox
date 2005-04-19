Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVDSPa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVDSPa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 11:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDSPa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 11:30:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54216 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261614AbVDSP33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 11:29:29 -0400
Date: Tue, 19 Apr 2005 11:29:22 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Steve Grubb <sgrubb@redhat.com>
Subject: [PATCH] SELinux: add finer grained permissions to Netlink audit
 processing
Message-ID: <Xine.LNX.4.44.0504191109180.16593-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides finer grained permissions for the audit family of 
Netlink sockets under SELinux.

1. We need a way to differentiate between privileged and unprivileged
reads of kernel data maintained by the audit subsystem.  The AUDIT_GET
operation is unprivileged: it returns the current status of the audit
subsystem (e.g. whether it's enabled etc.).  The AUDIT_LIST operation
however returns a list of the current audit ruleset, which is considered
privileged by the audit folk.  To deal with this, a new SELinux permission
has been implemented and applied to the operation:  nlmsg_readpriv, which
can be allocated to appropriately privileged domains.  Unprivileged
domains would only be allocated nlmsg_read.

2. There is a requirement for certain domains to generate audit events
from userspace.  These events need to be collected by the kernel, collated
and transmitted sequentially back to the audit daemon.  An example is user
level login, an auditable event under CAPP, where login-related domains
generate AUDIT_USER messages via PAM which are relayed back to auditd via
the kernel.  To prevent handing out nlmsg_write permissions to such
domains, a new permission has been added, nlmsg_relay, which is intended
for this type of purpose: data is passed via the kernel back to userspace
but no privileged information is written to the kernel.

Also, AUDIT_LOGIN messages are now valid only for kernel->user messaging,
so this value has been removed from the SELinux nlmsgtab (which is only
used to check user->kernel messages).

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/include/av_perm_to_string.h |    2 ++
 security/selinux/include/av_permissions.h    |    2 ++
 security/selinux/nlmsgtab.c                  |   13 ++++++-------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff -purN -X dontdiff linux-2.6.12-rc2-mm3.o/security/selinux/include/av_permissions.h linux-2.6.12-rc2-mm3.w1/security/selinux/include/av_permissions.h
--- linux-2.6.12-rc2-mm3.o/security/selinux/include/av_permissions.h	2005-04-14 21:02:39.000000000 -0400
+++ linux-2.6.12-rc2-mm3.w1/security/selinux/include/av_permissions.h	2005-04-15 15:32:36.000000000 -0400
@@ -840,6 +840,8 @@
 
 #define NETLINK_AUDIT_SOCKET__NLMSG_READ          0x00400000UL
 #define NETLINK_AUDIT_SOCKET__NLMSG_WRITE         0x00800000UL
+#define NETLINK_AUDIT_SOCKET__NLMSG_RELAY         0x01000000UL
+#define NETLINK_AUDIT_SOCKET__NLMSG_READPRIV      0x02000000UL
 
 #define NETLINK_IP6FW_SOCKET__IOCTL               0x00000001UL
 #define NETLINK_IP6FW_SOCKET__READ                0x00000002UL
diff -purN -X dontdiff linux-2.6.12-rc2-mm3.o/security/selinux/include/av_perm_to_string.h linux-2.6.12-rc2-mm3.w1/security/selinux/include/av_perm_to_string.h
--- linux-2.6.12-rc2-mm3.o/security/selinux/include/av_perm_to_string.h	2005-04-14 21:02:39.000000000 -0400
+++ linux-2.6.12-rc2-mm3.w1/security/selinux/include/av_perm_to_string.h	2005-04-15 15:32:00.000000000 -0400
@@ -220,6 +220,8 @@
    S_(SECCLASS_NETLINK_XFRM_SOCKET, NETLINK_XFRM_SOCKET__NLMSG_WRITE, "nlmsg_write")
    S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_READ, "nlmsg_read")
    S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_WRITE, "nlmsg_write")
+   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_RELAY, "nlmsg_relay")
+   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_READPRIV, "nlmsg_readpriv")
    S_(SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_READ, "nlmsg_read")
    S_(SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_WRITE, "nlmsg_write")
    S_(SECCLASS_DBUS, DBUS__ACQUIRE_SVC, "acquire_svc")
diff -purN -X dontdiff linux-2.6.12-rc2-mm3.o/security/selinux/nlmsgtab.c linux-2.6.12-rc2-mm3.w1/security/selinux/nlmsgtab.c
--- linux-2.6.12-rc2-mm3.o/security/selinux/nlmsgtab.c	2005-04-14 21:02:39.000000000 -0400
+++ linux-2.6.12-rc2-mm3.w1/security/selinux/nlmsgtab.c	2005-04-15 16:42:33.000000000 -0400
@@ -91,13 +91,12 @@ static struct nlmsg_perm nlmsg_xfrm_perm
 
 static struct nlmsg_perm nlmsg_audit_perms[] =
 {
-	{ AUDIT_GET,		NETLINK_AUDIT_SOCKET__NLMSG_READ  },
-	{ AUDIT_SET,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE },
-	{ AUDIT_LIST,		NETLINK_AUDIT_SOCKET__NLMSG_READ  },
-	{ AUDIT_ADD,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE },
-	{ AUDIT_DEL,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE },
-	{ AUDIT_USER,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE },
-	{ AUDIT_LOGIN,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE },
+	{ AUDIT_GET,		NETLINK_AUDIT_SOCKET__NLMSG_READ     },
+	{ AUDIT_SET,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
+	{ AUDIT_LIST,		NETLINK_AUDIT_SOCKET__NLMSG_READPRIV },
+	{ AUDIT_ADD,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
+	{ AUDIT_DEL,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
+	{ AUDIT_USER,		NETLINK_AUDIT_SOCKET__NLMSG_RELAY    },
 };
 
 


