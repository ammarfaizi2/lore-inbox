Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267724AbUHJUo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267724AbUHJUo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267726AbUHJUoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:44:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:46782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267724AbUHJUnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:43:23 -0400
Date: Tue, 10 Aug 2004 13:43:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040810134319.S1924@build.pdx.osdl.net>
References: <20040810132311.R1924@build.pdx.osdl.net> <Xine.LNX.4.44.0408101625490.9412-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0408101625490.9412-100000@dhcp83-76.boston.redhat.com>; from jmorris@redhat.com on Tue, Aug 10, 2004 at 04:27:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> On Tue, 10 Aug 2004, Chris Wright wrote:
> 
> > * James Morris (jmorris@redhat.com) wrote:
> > > On Tue, 10 Aug 2004, Kurt Garloff wrote:
> > > > The first patch patch does just change the selinux default; so you
> > > > need to enable with selinux=1.
> > > 
> > > This issue has been through a couple of iterations and the current scheme
> > > where if you have SELinux enabled, it is on by default, is aimed at being
> > > more secure by default.  On some platforms, boot parameters are not
> > > feasible.  To allow SELinux to be disable for these, the /selinux/disable
> > > node was implemented, which allows SELinux to be unregistered during boot.  
> > > I suggest you investigate using this; look at what Fedora does.
> > 
> > Could make selinux_enabled value configurable.  I don't really like the
> > extra configuration, but if it's more vendor neutral to have config
> > not only control if you can have bootparam, but also default value,
> > then perhaps it'd be useful.
> 
> Config option sounds fine to me.

I'll push this up, unless there's an objection.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== security/selinux/Kconfig 1.6 vs edited =====
--- 1.6/security/selinux/Kconfig	2004-06-01 02:27:56 -07:00
+++ edited/security/selinux/Kconfig	2004-08-10 13:39:43 -07:00
@@ -24,6 +24,21 @@
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_SELINUX_BOOTPARAM_VALUE
+	int "NSA SELinux boot parameter default value"
+	depends on SECURITY_SELINUX_BOOTPARAM
+	range 0 1
+	default 1
+	help
+	  This option sets the default value for the kernel parameter
+	  'selinux', which allows SELinux to be disabled at boot.  If this
+	  option is set to 0 (zero), the SELinux kernel parameter will
+	  default to 0, disabling SELinux at bootup.  If this option is
+	  set to 1 (one), the SELinux kernel paramater will default to 1,
+	  enabling SELinux at bootup.
+
+	  If you are unsure how to answer this question, answer 1.
+
 config SECURITY_SELINUX_DISABLE
 	bool "NSA SELinux runtime disable"
 	depends on SECURITY_SELINUX
===== security/selinux/hooks.c 1.53 vs edited =====
--- 1.53/security/selinux/hooks.c	2004-07-28 21:58:32 -07:00
+++ edited/security/selinux/hooks.c	2004-08-10 13:44:00 -07:00
@@ -87,7 +87,7 @@
 #endif
 
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
-int selinux_enabled = 1;
+int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
 
 static int __init selinux_enabled_setup(char *str)
 {
