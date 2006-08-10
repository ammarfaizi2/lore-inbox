Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWHJR7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWHJR7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWHJR7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:59:15 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:61669 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1422659AbWHJR7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:59:15 -0400
Subject: [patch 1/2] selinux:  enable configuration of max policy version
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Darrel Goeddel <dgoeddel@trustedcs.com>, Eric Paris <eparis@redhat.com>,
       James Morris <jmorris@namei.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 10 Aug 2006 14:01:24 -0400
Message-Id: <1155232884.1123.332.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable configuration of SELinux maximum supported policy version
to support legacy userland (init) that does not gracefully handle
kernels that support newer policy versions two or more beyond the
installed policy, as in FC3 and FC4.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>
Acked-by:  Eric Paris <eparis@redhat.com>

---

For 2.6.19.

 security/selinux/Kconfig            |   33 +++++++++++++++++++++++++++++++++
 security/selinux/include/security.h |    6 +++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 814ddc4..e718381 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -124,3 +124,36 @@ config SECURITY_SELINUX_ENABLE_SECMARK_D
 
 	  If you are unsure what do do here, select N.
 
+config SECURITY_SELINUX_POLICYDB_VERSION_MAX
+	bool "NSA SELinux maximum supported policy format version"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	  This option enables the maximum policy format version supported
+	  by SELinux to be set to a particular value.  This value is reported
+	  to userspace via /selinux/policyvers and used at policy load time.
+	  It can be adjusted downward to support legacy userland (init) that
+	  does not correctly handle kernels that support newer policy versions.
+
+	  Examples:  For FC3 or FC4, enable this option and set the value via
+	  the next option.  For FC5 and later, do not enable this option.
+
+	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
+	int "NSA SELinux maximum supported policy format version value"
+	depends on SECURITY_SELINUX_POLICYDB_VERSION_MAX
+	range 15 20
+	default 19
+	help
+	  This option sets the value for the maximum policy format version
+	  supported by SELinux.
+
+	  Examples:  For FC3, use 18.  For FC4, use 19.
+
+	  If you are unsure how to answer this question, look for the
+	  policy format version supported by your policy toolchain, by
+	  running 'checkpolicy -V'. Or look at what policy you have
+	  installed under /etc/selinux/$SELINUXTYPE/policy, where
+	  SELINUXTYPE is defined in your /etc/selinux/config.
+
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 063af47..f4b784f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -27,7 +27,11 @@ #define POLICYDB_VERSION_AVTAB		20
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_AVTAB
+#ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
+#define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
+#else
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_AVTAB
+#endif
 
 extern int selinux_enabled;
 extern int selinux_mls_enabled;

-- 
Stephen Smalley
National Security Agency

