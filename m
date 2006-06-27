Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWF0ISM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWF0ISM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWF0IRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:17:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:31346 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030753AbWF0IRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:17:30 -0400
X-IronPort-AV: i="4.06,178,1149490800"; 
   d="scan'208"; a="57205371:sNHT82337094"
Subject: Re: [PATCH]microcode update driver rewrite - takes 2
From: Shaohua Li <shaohua.li@intel.com>
To: Greg KH <greg@kroah.com>
Cc: arjan <arjan@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Rajesh Shah <rajesh.shah@intel.com>,
       Tigran Aivazian <tigran@veritas.com>
In-Reply-To: <20060627060214.GA27469@kroah.com>
References: <1151376693.21189.52.camel@sli10-desk.sh.intel.com>
	 <20060627060214.GA27469@kroah.com>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 16:15:09 +0800
Message-Id: <1151396109.21189.77.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 23:02 -0700, Greg KH wrote:
> On Tue, Jun 27, 2006 at 10:51:33AM +0800, Shaohua Li wrote:
> > This is the rewrite of microcode update driver. Changes:
> > 1. trim the code
> > 2. using request_firmware to pull ucode from userspace, so we don't need
> > the application 'microcode_ctl' to assist. We name each ucode file
> > according to CPU's info as intel-ucode/family-model-stepping. In this
> > way we could split ucode file as small one. This has a lot of advantages
> > such as selectively update and validate microcode for specific models,
> > better manage microcode file, easily write tools for administerators and
> > so on.
> > 3. add sysfs support. Currently each CPU has two microcode related
> > attributes. One is 'version' which shows current ucode version of CPU.
> > Tools can use the attribute do validation or show CPU ucode status. The
> > other is 'reload' which allows manually reloading ucode. 
> > 4. add suspend/resume and CPU hotplug support. 
> 
> Why not break this up into 4 patches so we can better review them?
> 
> Remember, one patch per change please :)
> 
> > With the changes, we should put all intel-ucode/xx-xx-xx microcode files
> > into the firmware dir (I had a tool to split previous big data file into
> > small one and later we will release new style data file). The init
> > script should be changed to just loading the driver without unloading
> > for hotplug and suspend/resume (for back compatibility I keep old
> > interface, so old init script also works).
> > 
> > Previous post is at
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=114852925121064&w=2
> > Changes against previous patch:
> > 1. use sys_create_group to add attributes
> > 2. add a fake platform_device for reqeust_firmware as Greg disliked the
> > request_firmware_kobj interface previous patch introduced
> > 3. add a new attribute 'pf' to help tools check if CPU has latest ucode
> 
> What does "pf" stand for?
[PATCH 3/3] suspend/resume & hotplug support for microcode driver

add sysfs support. Currently each CPU has three microcode related
attributes. One is 'version' which shows current ucode version of CPU.
Tools can use the attribute do validation or show CPU ucode status. one
is 'reload' which allows manually reloading ucode. Another is
'processor_flags', which exports processor flags, so we can write tools
to check if CPU has latest ucode. Also add suspend/resume and CPU
hotplug support. 

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Acked-by: Tigran Aivazian <tigran@veritas.com>
---
 arch/i386/kernel/microcode.c |  146 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 146 insertions(+)

Index: linux-2.6.17/arch/i386/kernel/microcode.c
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/microcode.c	2006-06-26 14:09:24.000000000 +0800
+++ linux-2.6.17/arch/i386/kernel/microcode.c	2006-06-26 14:09:29.000000000 +0800
@@ -604,6 +604,134 @@ static void microcode_fini_cpu(int cpu)
 	mutex_unlock(&microcode_mutex);
 }
 
+static ssize_t reload_store(struct sys_device *dev, const char *buf, size_t sz)
+{
+	struct ucode_cpu_info *uci = ucode_cpu_info + dev->id;
+	char *end;
+	unsigned long val = simple_strtoul(buf, &end, 0);
+	int err = 0;
+	int cpu = dev->id;
+
+	if (end == buf)
+		return -EINVAL;
+	if (val == 1) {
+		cpumask_t old;
+
+		old = current->cpus_allowed;
+
+		lock_cpu_hotplug();
+		set_cpus_allowed(current, cpumask_of_cpu(cpu));
+
+		mutex_lock(&microcode_mutex);
+		if (uci->valid)
+			err = cpu_request_microcode(cpu);
+		mutex_unlock(&microcode_mutex);
+		unlock_cpu_hotplug();
+		set_cpus_allowed(current, old);
+	}
+	if (err)
+		return err;
+	return sz;
+}
+
+static ssize_t version_show(struct sys_device *dev, char *buf)
+{
+	struct ucode_cpu_info *uci = ucode_cpu_info + dev->id;
+
+	return sprintf(buf, "0x%x\n", uci->rev);
+}
+
+static ssize_t pf_show(struct sys_device *dev, char *buf)
+{
+	struct ucode_cpu_info *uci = ucode_cpu_info + dev->id;
+
+	return sprintf(buf, "0x%x\n", uci->pf);
+}
+
+static SYSDEV_ATTR(reload, 0200, NULL, reload_store);
+static SYSDEV_ATTR(version, 0400, version_show, NULL);
+static SYSDEV_ATTR(processor_flags, 0400, pf_show, NULL);
+
+static struct attribute * mc_default_attrs[] = {
+	&attr_reload.attr,
+	&attr_version.attr,
+	&attr_processor_flags.attr,
+	NULL
+};
+
+static struct attribute_group mc_attr_group = {
+	.attrs = mc_default_attrs,
+	.name = "microcode",
+};
+
+static int mc_sysdev_add(struct sys_device *sys_dev)
+{
+	int cpu = sys_dev->id;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
+	if (!cpu_online(cpu))
+		return 0;
+	pr_debug("Microcode:CPU %d added\n", cpu);
+	memset(uci, 0, sizeof(*uci));
+	sysfs_create_group(&sys_dev->kobj, &mc_attr_group);
+
+	microcode_init_cpu(cpu);
+	return 0;
+}
+
+static int mc_sysdev_remove(struct sys_device *sys_dev)
+{
+	int cpu = sys_dev->id;
+
+	if (!cpu_online(cpu))
+		return 0;
+	pr_debug("Microcode:CPU %d removed\n", cpu);
+	microcode_fini_cpu(cpu);
+	sysfs_remove_group(&sys_dev->kobj, &mc_attr_group);
+	return 0;
+}
+
+static int mc_sysdev_resume(struct sys_device *dev)
+{
+	int cpu = dev->id;
+
+	if (!cpu_online(cpu))
+		return 0;
+	pr_debug("Microcode:CPU %d resumed\n", cpu);
+	/* only CPU 0 will apply ucode here */
+	apply_microcode(0);
+	return 0;
+}
+
+static struct sysdev_driver mc_sysdev_driver = {
+	.add = mc_sysdev_add,
+	.remove = mc_sysdev_remove,
+	.resume = mc_sysdev_resume,
+};
+
+static __cpuinit int
+mc_cpu_callback(struct notifier_block *nb, unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	struct sys_device *sys_dev;
+
+	sys_dev = get_cpu_sysdev(cpu);
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_DOWN_FAILED:
+		mc_sysdev_add(sys_dev);
+		break;
+	case CPU_DOWN_PREPARE:
+		mc_sysdev_remove(sys_dev);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mc_cpu_notifier = {
+	.notifier_call = mc_cpu_callback,
+};
+
 static int __init microcode_init (void)
 {
 	int error;
@@ -618,6 +746,17 @@ static int __init microcode_init (void)
 		return PTR_ERR(microcode_pdev);
 	}
 
+	lock_cpu_hotplug();
+	error = sysdev_driver_register(&cpu_sysdev_class, &mc_sysdev_driver);
+	unlock_cpu_hotplug();
+	if (error) {
+		microcode_dev_exit();
+		platform_device_unregister(microcode_pdev);
+		return error;
+	}
+
+	register_cpu_notifier(&mc_cpu_notifier);
+
 	printk(KERN_INFO 
 		"IA-32 Microcode Update Driver: v" MICROCODE_VERSION " <tigran@veritas.com>\n");
 	return 0;
@@ -626,6 +765,13 @@ static int __init microcode_init (void)
 static void __exit microcode_exit (void)
 {
 	microcode_dev_exit();
+
+	unregister_cpu_notifier(&mc_cpu_notifier);
+
+	lock_cpu_hotplug();
+	sysdev_driver_unregister(&cpu_sysdev_class, &mc_sysdev_driver);
+	unlock_cpu_hotplug();
+
 	platform_device_unregister(microcode_pdev);
 }
 
