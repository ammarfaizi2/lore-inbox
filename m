Return-Path: <linux-kernel-owner+w=401wt.eu-S1751571AbXAPQpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbXAPQpx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbXAPQpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:45:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37962 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbXAPQop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:45 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       <netdev@vger.kernel.org>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       minyard@acm.org, openipmi-developer@lists.sourceforge.net,
       <tony.luck@intel.com>, linux-mips@linux-mips.org, ralf@linux-mips.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com,
       linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
       lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
       <ak@suse.de>, vojtech@suse.cz, clemens@ladisch.de, a.zummo@towertech.it,
       rtc-linux@googlegroups.com, linux-parport@lists.infradead.org,
       andrea@suse.de, tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
       coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 59/59] sysctl: Remove the proc_dir_entry member for the sysctl tables.
Date: Tue, 16 Jan 2007 09:40:04 -0700
Message-Id: <11689657081820-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

It isn't needed anymore, all of the users are gone, and all of the
ctl_table initializers have been converted to use explicit names
of the fields they are initializing.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sysctl.h |    1 -
 net/decnet/dn_dev.c    |    5 -----
 net/ipv4/devinet.c     |    5 -----
 net/ipv6/addrconf.c    |    5 -----
 4 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 20c23b5..8c2fab5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -1025,7 +1025,6 @@ struct ctl_table
 	ctl_table *child;
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	ctl_handler *strategy;		/* Callback function for all r/w */
-	struct proc_dir_entry *de;	/* /proc control block */
 	void *extra1;
 	void *extra2;
 };
diff --git a/net/decnet/dn_dev.c b/net/decnet/dn_dev.c
index baaa02e..324eb47 100644
--- a/net/decnet/dn_dev.c
+++ b/net/decnet/dn_dev.c
@@ -261,7 +261,6 @@ static void dn_dev_sysctl_register(struct net_device *dev, struct dn_dev_parms *
 	for(i = 0; i < ARRAY_SIZE(t->dn_dev_vars) - 1; i++) {
 		long offset = (long)t->dn_dev_vars[i].data;
 		t->dn_dev_vars[i].data = ((char *)parms) + offset;
-		t->dn_dev_vars[i].de = NULL;
 	}
 
 	if (dev) {
@@ -273,13 +272,9 @@ static void dn_dev_sysctl_register(struct net_device *dev, struct dn_dev_parms *
 	}
 
 	t->dn_dev_dev[0].child = t->dn_dev_vars;
-	t->dn_dev_dev[0].de = NULL;
 	t->dn_dev_conf_dir[0].child = t->dn_dev_dev;
-	t->dn_dev_conf_dir[0].de = NULL;
 	t->dn_dev_proto_dir[0].child = t->dn_dev_conf_dir;
-	t->dn_dev_proto_dir[0].de = NULL;
 	t->dn_dev_root_dir[0].child = t->dn_dev_proto_dir;
-	t->dn_dev_root_dir[0].de = NULL;
 	t->dn_dev_vars[0].extra1 = (void *)dev;
 
 	t->sysctl_header = register_sysctl_table(t->dn_dev_root_dir);
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index b731a0c..8cfcc78 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1573,7 +1573,6 @@ static void devinet_sysctl_register(struct in_device *in_dev,
 		return;
 	for (i = 0; i < ARRAY_SIZE(t->devinet_vars) - 1; i++) {
 		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
-		t->devinet_vars[i].de = NULL;
 	}
 
 	if (dev) {
@@ -1595,13 +1594,9 @@ static void devinet_sysctl_register(struct in_device *in_dev,
 
 	t->devinet_dev[0].procname    = dev_name;
 	t->devinet_dev[0].child	      = t->devinet_vars;
-	t->devinet_dev[0].de	      = NULL;
 	t->devinet_conf_dir[0].child  = t->devinet_dev;
-	t->devinet_conf_dir[0].de     = NULL;
 	t->devinet_proto_dir[0].child = t->devinet_conf_dir;
-	t->devinet_proto_dir[0].de    = NULL;
 	t->devinet_root_dir[0].child  = t->devinet_proto_dir;
-	t->devinet_root_dir[0].de     = NULL;
 
 	t->sysctl_header = register_sysctl_table(t->devinet_root_dir);
 	if (!t->sysctl_header)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 791aaba..6aded83 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3973,7 +3973,6 @@ static void addrconf_sysctl_register(struct inet6_dev *idev, struct ipv6_devconf
 		return;
 	for (i=0; t->addrconf_vars[i].data; i++) {
 		t->addrconf_vars[i].data += (char*)p - (char*)&ipv6_devconf;
-		t->addrconf_vars[i].de = NULL;
 		t->addrconf_vars[i].extra1 = idev; /* embedded; no ref */
 	}
 	if (dev) {
@@ -3996,13 +3995,9 @@ static void addrconf_sysctl_register(struct inet6_dev *idev, struct ipv6_devconf
 	t->addrconf_dev[0].procname = dev_name;
 
 	t->addrconf_dev[0].child = t->addrconf_vars;
-	t->addrconf_dev[0].de = NULL;
 	t->addrconf_conf_dir[0].child = t->addrconf_dev;
-	t->addrconf_conf_dir[0].de = NULL;
 	t->addrconf_proto_dir[0].child = t->addrconf_conf_dir;
-	t->addrconf_proto_dir[0].de = NULL;
 	t->addrconf_root_dir[0].child = t->addrconf_proto_dir;
-	t->addrconf_root_dir[0].de = NULL;
 
 	t->sysctl_header = register_sysctl_table(t->addrconf_root_dir);
 	if (t->sysctl_header == NULL)
-- 
1.4.4.1.g278f

