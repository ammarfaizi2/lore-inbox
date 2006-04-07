Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWDGSgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWDGSgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWDGSgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:36:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:29573 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964851AbWDGSgL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:36:11 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
References: <20060407095132.455784000@sergelap>
To: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       devel@openvz.org, James Morris <jmorris@namei.org>
Subject: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: ~/Mail/SENT
Message-Id: <20060407183600.E40C119B902@sergelap.hallyn.com>
Date: Fri,  7 Apr 2006 13:36:00 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sysctl uts patch.  This clearly will need to be done another way, but
since sysctl itself needs to be container aware, 'the right thing' is
a separate patchset.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 kernel/sysctl.c |   38 ++++++++++++++++++++++++++++----------
 1 files changed, 28 insertions(+), 10 deletions(-)

40f7e1320c82efb6e875fc3bf44408cdfd093f21
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e82726f..c2b18ef 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -233,8 +233,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_OSTYPE,
 		.procname	= "ostype",
-		.data		= system_utsname.sysname,
-		.maxlen		= sizeof(system_utsname.sysname),
+		.data		= init_uts_ns.name.sysname,
+		.maxlen		= sizeof(init_uts_ns.name.sysname),
 		.mode		= 0444,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -242,8 +242,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_OSRELEASE,
 		.procname	= "osrelease",
-		.data		= system_utsname.release,
-		.maxlen		= sizeof(system_utsname.release),
+		.data		= init_uts_ns.name.release,
+		.maxlen		= sizeof(init_uts_ns.name.release),
 		.mode		= 0444,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -251,8 +251,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_VERSION,
 		.procname	= "version",
-		.data		= system_utsname.version,
-		.maxlen		= sizeof(system_utsname.version),
+		.data		= init_uts_ns.name.version,
+		.maxlen		= sizeof(init_uts_ns.name.version),
 		.mode		= 0444,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -260,8 +260,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_NODENAME,
 		.procname	= "hostname",
-		.data		= system_utsname.nodename,
-		.maxlen		= sizeof(system_utsname.nodename),
+		.data		= init_uts_ns.name.nodename,
+		.maxlen		= sizeof(init_uts_ns.name.nodename),
 		.mode		= 0644,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -269,8 +269,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_DOMAINNAME,
 		.procname	= "domainname",
-		.data		= system_utsname.domainname,
-		.maxlen		= sizeof(system_utsname.domainname),
+		.data		= init_uts_ns.name.domainname,
+		.maxlen		= sizeof(init_uts_ns.name.domainname),
 		.mode		= 0644,
 		.proc_handler	= &proc_doutsstring,
 		.strategy	= &sysctl_string,
@@ -1619,6 +1619,24 @@ static int proc_doutsstring(ctl_table *t
 {
 	int r;
 
+	switch (table->ctl_name) {
+		case KERN_OSTYPE:
+			table->data = utsname()->sysname;
+			break;
+		case KERN_OSRELEASE:
+			table->data = utsname()->release;
+			break;
+		case KERN_VERSION:
+			table->data = utsname()->version;
+			break;
+		case KERN_NODENAME:
+			table->data = utsname()->nodename;
+			break;
+		case KERN_DOMAINNAME:
+			table->data = utsname()->domainname;
+			break;
+	}
+
 	if (!write) {
 		down_read(&uts_sem);
 		r=proc_dostring(table,0,filp,buffer,lenp, ppos);
-- 
1.2.4


