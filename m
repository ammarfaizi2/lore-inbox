Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWF0IR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWF0IR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030754AbWF0IR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:17:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:31346 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030753AbWF0IR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:17:27 -0400
X-IronPort-AV: i="4.06,178,1149490800"; 
   d="scan'208"; a="57205353:sNHT96119366"
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
Date: Tue, 27 Jun 2006 16:15:07 +0800
Message-Id: <1151396107.21189.76.camel@sli10-desk.sh.intel.com>
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
[PATCH 2/3] using request_firmware to load microcode

using request_firmware to pull ucode from userspace, so we don't need
the application 'microcode_ctl' to assist. We name each ucode file
according to CPU's info as intel-ucode/family-model-stepping. In this
way we could split ucode file as small one. This has a lot of advantages
such as selectively update and validate microcode for specific models,
better manage microcode file, easily write tools for administerators and
so on.
with the changes, we should put all intel-ucode/xx-xx-xx microcode files
into the firmware dir (I had a tool to split previous big data file into
small one and later we will release new style data file). The init
script should be changed to just loading the driver without unloading

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Acked-by: Tigran Aivazian <tigran@veritas.com>
---
 arch/i386/kernel/microcode.c  |  116 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/firmware_class.c |    2 
 2 files changed, 117 insertions(+), 1 deletion(-)

Index: linux-2.6.17/arch/i386/kernel/microcode.c
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/microcode.c	2006-06-26 14:08:32.000000000 +0800
+++ linux-2.6.17/arch/i386/kernel/microcode.c	2006-06-26 14:09:24.000000000 +0800
@@ -83,6 +83,9 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/cpu.h>
+#include <linux/firmware.h>
+#include <linux/platform_device.h>
 
 #include <asm/msr.h>
 #include <asm/uaccess.h>
@@ -495,6 +498,112 @@ MODULE_ALIAS_MISCDEV(MICROCODE_MINOR);
 #define microcode_dev_exit() do { } while(0)
 #endif
 
+static long get_next_ucode_from_buffer(void **mc, void *buf,
+	unsigned long size, long offset)
+{
+	microcode_header_t *mc_header;
+	unsigned long total_size;
+
+	/* No more data */
+	if (offset >= size)
+		return 0;
+	mc_header = (microcode_header_t *)(buf + offset);
+	total_size = get_totalsize(mc_header);
+
+	if ((offset + total_size > size)
+		|| (total_size < DEFAULT_UCODE_TOTALSIZE)) {
+		printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
+		return -EINVAL;
+	}
+
+	*mc = vmalloc(total_size);
+	if (!*mc) {
+		printk(KERN_ERR "microcode: error! Can not allocate memory\n");
+		return -ENOMEM;
+	}
+	memcpy(*mc, buf + offset, total_size);
+	return offset + total_size;
+}
+
+/* fake device for request_firmware */
+static struct platform_device *microcode_pdev;
+
+static int cpu_request_microcode(int cpu)
+{
+	char name[30];
+	struct cpuinfo_x86 *c = cpu_data + cpu;
+	const struct firmware *firmware;
+	void * buf;
+	unsigned long size;
+	long offset = 0;
+	int error;
+	void *mc;
+
+	/* We should bind the task to the CPU */
+	BUG_ON(cpu != raw_smp_processor_id());
+	sprintf(name,"intel-ucode/%02x-%02x-%02x",
+		c->x86, c->x86_model, c->x86_mask);
+	error = request_firmware(&firmware, name, &microcode_pdev->dev);
+	if (error) {
+		pr_debug("ucode data file %s load failed\n", name);
+		return error;
+	}
+	buf = (void *)firmware->data;
+	size = firmware->size;
+	while ((offset = get_next_ucode_from_buffer(&mc, buf, size, offset))
+			> 0) {
+		error = microcode_sanity_check(mc);
+		if (error)
+			break;
+		error = get_maching_microcode(mc, cpu);
+		if (error < 0)
+			break;
+		/*
+		 * It's possible the data file has multiple matching ucode,
+		 * lets keep searching till the latest version
+		 */
+		if (error == 1) {
+			apply_microcode(cpu);
+			error = 0;
+		}
+		vfree(mc);
+	}
+	if (offset > 0)
+		vfree(mc);
+	if (offset < 0)
+		error = offset;
+	release_firmware(firmware);
+
+	return error;
+}
+
+static void microcode_init_cpu(int cpu)
+{
+	cpumask_t old;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
+	old = current->cpus_allowed;
+
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	mutex_lock(&microcode_mutex);
+	collect_cpu_info(cpu);
+	if (uci->valid)
+		cpu_request_microcode(cpu);
+	mutex_unlock(&microcode_mutex);
+	set_cpus_allowed(current, old);
+}
+
+static void microcode_fini_cpu(int cpu)
+{
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
+	mutex_lock(&microcode_mutex);
+	uci->valid = 0;
+	vfree(uci->mc);
+	uci->mc = NULL;
+	mutex_unlock(&microcode_mutex);
+}
+
 static int __init microcode_init (void)
 {
 	int error;
@@ -502,6 +611,12 @@ static int __init microcode_init (void)
 	error = microcode_dev_init();
 	if (error)
 		return error;
+	microcode_pdev = platform_device_register_simple("microcode", -1,
+							 NULL, 0);
+	if (IS_ERR(microcode_pdev)) {
+		microcode_dev_exit();
+		return PTR_ERR(microcode_pdev);
+	}
 
 	printk(KERN_INFO 
 		"IA-32 Microcode Update Driver: v" MICROCODE_VERSION " <tigran@veritas.com>\n");
@@ -511,6 +626,7 @@ static int __init microcode_init (void)
 static void __exit microcode_exit (void)
 {
 	microcode_dev_exit();
+	platform_device_unregister(microcode_pdev);
 }
 
 module_init(microcode_init)
Index: linux-2.6.17/drivers/base/firmware_class.c
===================================================================
--- linux-2.6.17.orig/drivers/base/firmware_class.c	2006-06-26 14:08:32.000000000 +0800
+++ linux-2.6.17/drivers/base/firmware_class.c	2006-06-26 14:09:24.000000000 +0800
@@ -602,7 +602,7 @@ firmware_class_exit(void)
 	class_unregister(&firmware_class);
 }
 
-module_init(firmware_class_init);
+fs_initcall(firmware_class_init);
 module_exit(firmware_class_exit);
 
 EXPORT_SYMBOL(release_firmware);

