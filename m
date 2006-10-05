Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWJEMuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWJEMuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 08:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWJEMuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 08:50:37 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:4231 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751446AbWJEMug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 08:50:36 -0400
Date: Thu, 5 Oct 2006 14:48:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ashok Raj <ashok.raj@intel.com>, Nathan Lynch <nathanl@austin.ibm.com>
Subject: Re: [PATCH] drivers/base: error handling fixes
Message-ID: <20061005124848.GB6920@osiris.boeblingen.de.ibm.com>
References: <20061004130554.GA25974@havoc.gtf.org> <20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com> <20061005081705.GA6920@osiris.boeblingen.de.ibm.com> <4524E983.6010208@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4524E983.6010208@garzik.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>> static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
> >>>@@ -112,17 +110,18 @@ static int __cpuinit topology_cpu_callba
> >>> {
> >>> 	unsigned int cpu = (unsigned long)hcpu;
> >>> 	struct sys_device *sys_dev;
> >>>+	int rc = 0;
> >>>  	sys_dev = get_cpu_sysdev(cpu);
> >>> 	switch (action) {
> >>> 	case CPU_ONLINE:
> >>>-		topology_add_dev(sys_dev);
> >>>+		rc = topology_add_dev(sys_dev);
> >>> 		break;
> >>> 	case CPU_DEAD:
> >>> 		topology_remove_dev(sys_dev);
> >>> 		break;
> >>> 	}
> >>>-	return NOTIFY_OK;
> >>>+	return rc ? NOTIFY_BAD : NOTIFY_OK;
> >>> }
> >>Wouldn't that also require that _cpu_up checked the return code when
> >>doing CPU_ONLINE notification (and clean up on error)?
> >After all code that gets a CPU_ONLINE notification is not supposed to fail.
> >For allocating resources while bringing up a cpu CPU_UP_PREPARE is supposed
> >to be used. That one is allowed to fail.
> 
> It's a bug no matter how you look at it... I just lessen the impact.  :)
> 
> If someone wants to provide a better fix, let's see the patch...

If sysfs_remove_group() would also work for non-created (-existent) groups
then the patch below would work. Unfortunately that is not the case. So one
would have to remember if sysfs_create_group() was done and succeeded before
calling sysfs_remove_group()...
There must be an easier way.

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 3ef9d51..d0056c3 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -97,8 +97,7 @@ static struct attribute_group topology_a
 /* Add/Remove cpu_topology interface for CPU device */
 static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
 {
-	sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
-	return 0;
+	return sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
 }
 
 static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
@@ -112,12 +111,16 @@ static int __cpuinit topology_cpu_callba
 {
 	unsigned int cpu = (unsigned long)hcpu;
 	struct sys_device *sys_dev;
+	int rc;
 
 	sys_dev = get_cpu_sysdev(cpu);
 	switch (action) {
-	case CPU_ONLINE:
-		topology_add_dev(sys_dev);
+	case CPU_UP_PREPARE:
+		rc = topology_add_dev(sys_dev);
+		if (rc)
+			return NOTIFY_BAD;
 		break;
+	case CPU_UP_CANCELED:
 	case CPU_DEAD:
 		topology_remove_dev(sys_dev);
 		break;
@@ -132,11 +135,15 @@ static struct notifier_block __cpuinitda
 
 static int __cpuinit topology_sysfs_init(void)
 {
-	int i;
-
-	for_each_online_cpu(i) {
-		topology_cpu_callback(&topology_cpu_notifier, CPU_ONLINE,
-				(void *)(long)i);
+	struct sys_device *sys_dev;
+	int cpu;
+	int rc;
+
+	for_each_online_cpu(cpu) {
+		sys_dev = get_cpu_sysdev(cpu);
+		rc = topology_add_dev(sys_dev);
+		if (rc)
+			return rc;
 	}
 
 	register_hotcpu_notifier(&topology_cpu_notifier);
