Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUDAT0m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbUDAT0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:26:42 -0500
Received: from holomorphy.com ([207.189.100.168]:13231 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262731AbUDAT0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:26:31 -0500
Date: Thu, 1 Apr 2004 11:26:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com,
       Chris Wright <chrisw@osdl.org>
Subject: Re: disable-cap-mlock
Message-ID: <20040401192612.GL791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	kenneth.w.chen@intel.com, Chris Wright <chrisw@osdl.org>
References: <20040401135920.GF18585@dualathlon.random> <1080841071.25431.155.camel@moss-spartans.epoch.ncsc.mil> <20040401174405.GG791@holomorphy.com> <200404011952.29724@WOLK> <20040401175436.GI791@holomorphy.com> <1080845238.25431.196.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080845238.25431.196.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 01:47:18PM -0500, Stephen Smalley wrote:
> Some form of control over changing the sysctl settings (beyond just the
> mode) should be provided; otherwise, the module is too unsafe by itself
> for real use, and you can't assume that people will only use it stacked
> with SELinux (which could control such changes).  Allowing the settings
> to be locked as mcp suggested sounds simple and sufficient for the
> proposed use; they can disable their desired capability and then lock in
> /sbin/init.  For greater generality, I'd suggest adding a new capability
> to control the ability to set the capability sysctls, but then we are in
> a vicious cycle...

Okay, done.

Misc fix thrown in: the policies beyond enabled/disabled were wrongly
set up in minmax' args, so this throws the real max in the table.


-- wli


Index: mm4-2.6.5-rc3/security/sysctl_capable.c
===================================================================
--- mm4-2.6.5-rc3.orig/security/sysctl_capable.c	2004-04-01 10:11:53.000000000 -0800
+++ mm4-2.6.5-rc3/security/sysctl_capable.c	2004-04-01 11:24:44.000000000 -0800
@@ -43,6 +43,7 @@
 #define CAP_SYSCTL_MKNOD		(1 + CAP_MKNOD)
 #define CAP_SYSCTL_LEASE		(1 + CAP_LEASE)
 #define MAX_CAPABILITY			CAP_SYSCTL_LEASE
+#define CAP_SYSCTL_LOCKDOWN		(1 + MAX_CAPABILITY)
 
 #define CAPABILITY_SYSCTL_ENABLED	0
 #define CAPABILITY_SYSCTL_DISABLED	1
@@ -56,19 +57,22 @@
 		.ctl_name	= CAP_SYSCTL_##x,			\
 		.procname	= #y ,					\
 		.extra1		= (void *)&capability_sysctl_zero,	\
-		.extra2		= (void *)&capability_sysctl_one,	\
+		.extra2		= (void *)&capability_sysctl_three,	\
 		.data		= &capability_sysctl_state[CAP_##x],	\
 		.mode		= 0644,					\
 		.strategy	= sysctl_intvec,			\
-		.proc_handler	= proc_dointvec_minmax,			\
+		.proc_handler	= capability_sysctl_handler,		\
 		.maxlen		= sizeof(int),				\
 	},
 
 static int capability_sysctl_state[MAX_CAPABILITY];
 static const int capability_sysctl_zero = 0;
 static const int capability_sysctl_one = 1;
-static int secondary;
+static const int capability_sysctl_three = 3;
+static int secondary, lockdown;
 static struct ctl_table_header *capability_sysctl_table_header;
+static int capability_sysctl_handler(struct ctl_table *, int,
+				struct file *, void __user *, size_t *);
 
 static struct ctl_table capability_sysctl_table[] = {
 	MKCTL(CHOWN, chown)
@@ -101,6 +105,17 @@
 	MKCTL(MKNOD, mknod)
 	MKCTL(LEASE, lease)
 	{
+		.ctl_name	= CAP_SYSCTL_LOCKDOWN,
+		.procname	= "lockdown",
+		.extra1		= (void *)&capability_sysctl_zero,
+		.extra2		= (void *)&capability_sysctl_one,
+		.data		= &lockdown,
+		.mode		= 0644,
+		.strategy	= sysctl_intvec,
+		.proc_handler	= capability_sysctl_handler,
+		.maxlen		= sizeof(int),
+	},
+	{
 		.ctl_name	= 0,
 	},
 };
@@ -138,6 +153,14 @@
 	.vm_enough_memory	=             cap_vm_enough_memory,
 };
 
+static int capability_sysctl_handler(struct ctl_table *table,
+		int write, struct file *file, void __user *buf, size_t *length)
+{
+	if (lockdown && write)
+		return -EINVAL;
+	else
+		return proc_dointvec_minmax(table, write, file, buf, length);
+}
 
 static int capability_sysctl_capable(task_t *task, int cap)
 {
