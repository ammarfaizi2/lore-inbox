Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTFGBGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 21:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTFGBGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 21:06:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44455 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262470AbTFGBDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 21:03:31 -0400
Date: Fri, 6 Jun 2003 18:18:30 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: linux-kernel@vger.kernel.org
Subject: [RFC] New system device API
Message-ID: <Pine.LNX.4.44.0306061749200.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've changed the way that the driver model handles system devices, 
simplifying the internal representation, the external representation, and 
the cumbersome registration method. 

System devices are special, and after two years of listening to Linus
preach this, it finally sunk in enough to do something about. We don't
need to regard them as real devices that reside on a peripheral bus and
can be dynamically bound to drivers. If we discover, e.g. a CPU, we know
by default that we have a driver for it, and we know damn well that we
have a CPU. We still need to keep track of all the devices, and all the
devices of a particular type. The kobject infrastructure allows us to do
this, without the overhead of the regular model.

A new subsystem is defined that registers as a child object of 
devices_subsys, giving us:

	/sys/devices/system/

struct sysdev_class {
        struct list_head        drivers;

        /* Default operations for these types of devices */
        int     (*shutdown)(struct sys_device *);
        int     (*suspend)(struct sys_device *, u32 state);
        int     (*resume)(struct sys_device *);
        struct kset             kset;
};

Defines a type of system device. These are registered on startup, by e.g. 
drivers/base/cpu.c. The methods are default operations for devices of that 
type that may or may not be used. For things like the i8259 controller, 
these will be filled in, since it is registered by the same component that 
the device controls reside in. 

For things like CPUs, generic code will register the class, but other 
architecture-specific or otherwise configurable drivers may register 
auxillary drivers, that look like: 

struct sysdev_driver {
        struct list_head        entry;
        int     (*add)(struct sys_device *);
        int     (*remove)(struct sys_device *);
        int     (*shutdown)(struct sys_device *);
        int     (*suspend)(struct sys_device *, u32 state);
        int     (*resume)(struct sys_device *);
};


Each auxillary driver gets called during each operation on a device of a 
particular class. 

Auxillary drivers may register with a NULL class parameter, in which case 
they will be added to a list of 'global drivers' that get called for each 
device of each class. 


Besides providing a decent of cleanup for system device drivers, this also 
allows:

- Special handling of system devices during power transitions. 

  We no longer have to worry about shutting down the PIC before we shut 
  down any devices. We can shut down the system devices after we've shut 
  down every other device. 

  Ditto for suspend/resume cycles. Almost (if not) all PM actions for 
  system devices happen with interrupts off, and require only one call, 
  which makes that easier. But, we can also make sure we take care of 
  these last during suspend and first during resume.

- Easy expression of configurable device-specific interfaces. 

  Namely cpufreq and mtrr. We don't have to worry about mispresentation in 
  the driver model (like recent MTRR patches) or using a cumbersome 
  interface ({device,class}_interface) that don't receive all the 
  necessary calls. 

- Consolidation of userspace representation.

  No longer do we have /sys/devices/sys, /sys/bus/sys, and /sys/class/cpu,
  etc. We have only /sys/devices/system: 

# tree /sys/devices/system/
/sys/devices/system/
|-- cpu
|   `-- cpu0
|-- i8259
|   `-- i82590
|-- lapic
|   `-- lapic0
|-- rtc
|   `-- rtc0
`-- timer
    `-- timer0

Each directory in 'system' is the class, and each directory under that is 
the instance of each device in that class. 


This is an experimental patch that hasn't been checked in yet. I'm
interested in hearing what people think of it, especially the cpufreq
people[1] and the NUMA people[2], since they are the biggest users of this
code so far. If all is positive, or nothing is negative, I'll push this on 
to Linus early next week. 

Thanks,


	-pat

[1] cpufreq

I know that this patch will completely break the cpufreq code, and I will 
gladly fix it all up. This shouldn't impact the rest of the code, though 
the location in userspace will be different.


[2] NUMA

This will also break NUMA system device handling. I've abolished struct
sys_root. I think each node should register as a system device, which will 
show up as /sys/devices/system/node? You should also register a 
sysdev_driver with a NULL class, so you get add/remove calls for each 
device. Assuming you can tell which node a device is on, you can create 
symlinks from the nodes' directories to the devices' real directories. 
This will give everyone the same interface in /sys/devices/system, plus 
give you the extra topology information. I'll gladly do the legwork on 
this if someone is willing to test..


===== arch/i386/kernel/apic.c 1.38 vs edited =====
--- 1.38/arch/i386/kernel/apic.c	Sun May 25 23:19:09 2003
+++ edited/arch/i386/kernel/apic.c	Fri Jun  6 17:45:42 2003
@@ -484,13 +484,11 @@
 	unsigned int apic_thmr;
 } apic_pm_state;
 
-static int lapic_suspend(struct device *dev, u32 state, u32 level)
+static int lapic_suspend(struct sys_device *dev, u32 state)
 {
 	unsigned int l, h;
 	unsigned long flags;
 
-	if (level != SUSPEND_POWER_DOWN)
-		return 0;
 	if (!apic_pm_state.active)
 		return 0;
 
@@ -517,13 +515,11 @@
 	return 0;
 }
 
-static int lapic_resume(struct device *dev, u32 level)
+static int lapic_resume(struct sys_device *dev)
 {
 	unsigned int l, h;
 	unsigned long flags;
 
-	if (level != RESUME_POWER_ON)
-		return 0;
 	if (!apic_pm_state.active)
 		return 0;
 
@@ -557,38 +553,37 @@
 	return 0;
 }
 
-static struct device_driver lapic_driver = {
-	.name		= "lapic",
-	.bus		= &system_bus_type,
+
+static struct sysdev_class lapic_sysclass = {
+	set_kset_name("lapic"),
 	.resume		= lapic_resume,
 	.suspend	= lapic_suspend,
 };
 
-/* not static, needed by child devices */
-struct sys_device device_lapic = {
-	.name		= "lapic",
-	.id		= 0,
-	.dev		= {
-		.name	= "lapic",
-		.driver	= &lapic_driver,
-	},
+static struct sys_device device_lapic = {
+	.id	= 0,
+	.cls	= &lapic_sysclass,
 };
-EXPORT_SYMBOL(device_lapic);
 
 static void __init apic_pm_activate(void)
 {
 	apic_pm_state.active = 1;
 }
 
-static int __init init_lapic_devicefs(void)
+static int __init init_lapic_sysfs(void)
 {
+	int error;
+
 	if (!cpu_has_apic)
 		return 0;
 	/* XXX: remove suspend/resume procs if !apic_pm_state.active? */
-	driver_register(&lapic_driver);
-	return sys_device_register(&device_lapic);
+
+	error = sysdev_class_register(&lapic_sysclass);
+	if (!error)
+		error = sys_device_register(&device_lapic);
+	return error;
 }
-device_initcall(init_lapic_devicefs);
+device_initcall(init_lapic_sysfs);
 
 #else	/* CONFIG_PM */
 
===== arch/i386/kernel/i8259.c 1.23 vs edited =====
--- 1.23/arch/i386/kernel/i8259.c	Mon Apr 21 17:23:12 2003
+++ edited/arch/i386/kernel/i8259.c	Fri Jun  6 17:46:50 2003
@@ -238,35 +238,31 @@
 	}
 }
 
-static int i8259A_resume(struct device *dev, u32 level)
+static int i8259A_resume(struct sys_device *dev)
 {
-	if (level == RESUME_POWER_ON)
-		init_8259A(0);
+	init_8259A(0);
 	return 0;
 }
 
-static struct device_driver i8259A_driver = {
-	.name		= "pic",
-	.bus		= &system_bus_type,
-	.resume		= i8259A_resume,
+static struct sysdev_class i8259_sysdev_class = {
+	set_kset_name("i8259"),
+	.resume = i8259A_resume,
 };
 
 static struct sys_device device_i8259A = {
-	.name		= "pic",
-	.id		= 0,
-	.dev		= {
-		.name	= "i8259A PIC",
-		.driver	= &i8259A_driver,
-	},
+	.id	= 0,
+	.cls	= &i8259_sysdev_class,
 };
 
-static int __init init_8259A_devicefs(void)
+static int __init i8259A_init_sysfs(void)
 {
-	driver_register(&i8259A_driver);
-	return sys_device_register(&device_i8259A);
+	int error = sysdev_class_register(&i8259_sysdev_class);
+	if (!error)
+		error = sys_device_register(&device_i8259A);
+	return error;
 }
 
-device_initcall(init_8259A_devicefs);
+device_initcall(i8259A_init_sysfs);
 
 void init_8259A(int auto_eoi)
 {
@@ -385,35 +381,31 @@
 	spin_unlock_irqrestore(&i8253_lock, flags);
 }
 
-static int timer_resume(struct device *dev, u32 level)
+static int timer_resume(struct sys_device *dev)
 {
-	if (level == RESUME_POWER_ON)
-		setup_timer();
+	setup_timer();
 	return 0;
 }
 
-static struct device_driver timer_driver = {
-	.name		= "timer",
-	.bus		= &system_bus_type,
-	.resume		= timer_resume,
+static struct sysdev_class timer_sysclass = {
+	set_kset_name("timer"),
+	.resume	= timer_resume,
 };
 
 static struct sys_device device_timer = {
-	.name		= "timer",
-	.id		= 0,
-	.dev		= {
-		.name	= "timer",
-		.driver	= &timer_driver,
-	},
+	.id	= 0,
+	.cls	= &timer_sysclass,
 };
 
-static int __init init_timer_devicefs(void)
+static int __init init_timer_sysfs(void)
 {
-	driver_register(&timer_driver);
-	return sys_device_register(&device_timer);
+	int error = sysdev_class_register(&timer_sysclass);
+	if (!error)
+		error = sys_device_register(&device_timer);
+	return error;
 }
 
-device_initcall(init_timer_devicefs);
+device_initcall(init_timer_sysfs);
 
 void __init init_IRQ(void)
 {
===== arch/i386/kernel/nmi.c 1.18 vs edited =====
--- 1.18/arch/i386/kernel/nmi.c	Sat Apr 12 14:26:35 2003
+++ edited/arch/i386/kernel/nmi.c	Fri Jun  6 17:46:05 2003
@@ -183,50 +183,46 @@
 #include <linux/device.h>
 static int nmi_pm_active; /* nmi_active before suspend */
 
-static int lapic_nmi_suspend(struct device *dev, u32 state, u32 level)
+static int lapic_nmi_suspend(struct sys_device *dev, u32 state)
 {
-	if (level != SUSPEND_POWER_DOWN)
-		return 0;
 	nmi_pm_active = nmi_active;
 	disable_lapic_nmi_watchdog();
 	return 0;
 }
 
-static int lapic_nmi_resume(struct device *dev, u32 level)
+static int lapic_nmi_resume(struct sys_device *dev)
 {
-	if (level != RESUME_POWER_ON)
-		return 0;
 	if (nmi_pm_active > 0)
 		enable_lapic_nmi_watchdog();
 	return 0;
 }
 
-static struct device_driver lapic_nmi_driver = {
-	.name		= "lapic_nmi",
-	.bus		= &system_bus_type,
+
+static struct sysdev_class nmi_sysclass = {
+	set_kset_name("lapic_nmi"),
 	.resume		= lapic_nmi_resume,
 	.suspend	= lapic_nmi_suspend,
 };
 
 static struct sys_device device_lapic_nmi = {
-	.name		= "lapic_nmi",
-	.id		= 0,
-	.dev		= {
-		.name	= "lapic_nmi",
-		.driver	= &lapic_nmi_driver,
-		.parent = &device_lapic.dev,
-	},
+	.id	= 0,
+	.cls	= &nmi_sysclass,
 };
 
-static int __init init_lapic_nmi_devicefs(void)
+static int __init init_lapic_nmi_sysfs(void)
 {
+	int error;
+
 	if (nmi_active == 0)
 		return 0;
-	driver_register(&lapic_nmi_driver);
-	return sys_device_register(&device_lapic_nmi);
+
+	error = sysdev_class_register(&nmi_sysclass);
+	if (!error)
+		error = sys_device_register(&device_lapic_nmi);
+	return error;
 }
 /* must come after the local APIC's device_initcall() */
-late_initcall(init_lapic_nmi_devicefs);
+late_initcall(init_lapic_nmi_sysfs);
 
 #endif	/* CONFIG_PM */
 
===== arch/i386/kernel/time.c 1.32 vs edited =====
--- 1.32/arch/i386/kernel/time.c	Sun Apr 20 14:47:44 2003
+++ edited/arch/i386/kernel/time.c	Fri Jun  6 16:19:00 2003
@@ -278,18 +278,22 @@
 	return retval;
 }
 
+static struct sysdev_class rtc_sysclass = {
+	set_kset_name("rtc"),
+};
+
 /* XXX this driverfs stuff should probably go elsewhere later -john */
 static struct sys_device device_i8253 = {
-	.name		= "rtc",
 	.id		= 0,
-	.dev	= {
-		.name	= "i8253 Real Time Clock",
-	},
+	.cls	= &rtc_sysclass,
 };
 
 static int time_init_device(void)
 {
-	return sys_device_register(&device_i8253);
+	int error = sysdev_class_register(&rtc_sysclass);
+	if (!error)
+		error = sys_device_register(&device_i8253);
+	return error;
 }
 
 device_initcall(time_init_device);
===== drivers/base/cpu.c 1.12 vs edited =====
--- 1.12/drivers/base/cpu.c	Tue Jun  3 14:23:58 2003
+++ edited/drivers/base/cpu.c	Fri Jun  6 16:35:39 2003
@@ -9,15 +9,8 @@
 
 #include <asm/topology.h>
 
-
-struct class cpu_class = {
-	.name		= "cpu",
-};
-
-
-struct device_driver cpu_driver = {
-	.name		= "cpu",
-	.bus		= &system_bus_type,
+static struct sysdev_class cpu_sysdev_class = {
+	set_kset_name("cpu"),
 };
 
 /*
@@ -28,42 +21,15 @@
  */
 int __init register_cpu(struct cpu *cpu, int num, struct node *root)
 {
-	int retval;
-
 	cpu->node_id = cpu_to_node(num);
-	cpu->sysdev.name = "cpu";
 	cpu->sysdev.id = num;
-	if (root)
-		cpu->sysdev.root = &root->sysroot;
-	snprintf(cpu->sysdev.dev.name, DEVICE_NAME_SIZE, "CPU %u", num);
-	cpu->sysdev.dev.driver = &cpu_driver;
-	retval = sys_device_register(&cpu->sysdev);
-	if (retval)
-		return retval;
-	memset(&cpu->sysdev.class_dev, 0x00, sizeof(struct class_device));
-	cpu->sysdev.class_dev.dev = &cpu->sysdev.dev;
-	cpu->sysdev.class_dev.class = &cpu_class;
-	snprintf(cpu->sysdev.class_dev.class_id, BUS_ID_SIZE, "cpu%d", num);
-	retval = class_device_register(&cpu->sysdev.class_dev);
-	if (retval) {
-		sys_device_unregister(&cpu->sysdev);
-		return retval;
-	}
-	return 0;
+	cpu->sysdev.cls = &cpu_sysdev_class;
+	return sys_device_register(&cpu->sysdev);
 }
 
 
+
 int __init cpu_dev_init(void)
 {
-	int error;
-
-	error = class_register(&cpu_class);
-	if (error)
-		goto out;
-	
-	error = driver_register(&cpu_driver);
-	if (error)
-		class_unregister(&cpu_class);
-out:
-	return error;
+	return sysdev_class_register(&cpu_sysdev_class);
 }
===== drivers/base/power.c 1.19 vs edited =====
--- 1.19/drivers/base/power.c	Tue Jun  3 16:19:52 2003
+++ edited/drivers/base/power.c	Fri Jun  6 15:39:56 2003
@@ -22,6 +22,19 @@
 extern struct subsystem devices_subsys;
 
 /**
+ * We handle system devices differently - we suspend and shut them 
+ * down first and resume them first. That way, we do anything stupid like
+ * shutting down the interrupt controller before any devices..
+ *
+ * Note that there are not different stages for power management calls - 
+ * they only get one called once when interrupts are disabled. 
+ */
+
+extern int sys_device_shutdown(void);
+extern int sys_device_suspend(u32 state);
+extern int sys_device_resume(void);
+
+/**
  * device_suspend - suspend/remove all devices on the device ree
  * @state:	state we're entering
  * @level:	what stage of the suspend process we're at
@@ -98,6 +111,8 @@
 			pr_debug("Ignored.\n");
 	}
 	up_write(&devices_subsys.rwsem);
+
+	sys_device_shutdown();
 }
 
 EXPORT_SYMBOL(device_suspend);
===== drivers/base/sys.c 1.17 vs edited =====
--- 1.17/drivers/base/sys.c	Tue Jun  3 16:19:52 2003
+++ edited/drivers/base/sys.c	Fri Jun  6 17:43:02 2003
@@ -12,7 +12,7 @@
  * add themselves as children of the system bus.
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/device.h>
 #include <linux/err.h>
@@ -22,130 +22,198 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
-/* The default system device parent. */
-static struct device system_bus = {
-       .name           = "System Bus",
-       .bus_id         = "sys",
-};
 
+extern struct subsystem devices_subsys;
 
-/**
- *	sys_register_root - add a subordinate system root
- *	@root:	new root
- *	
- *	This is for NUMA-like systems so they can accurately 
- *	represent the topology of the entire system.
- *	As boards are discovered, a new struct sys_root should 
- *	be allocated and registered. 
- *	The discovery mechanism should initialize the id field
- *	of the struture, as well as much of the embedded device
- *	structure as possible, inlcuding the name, the bus_id
- *	and parent fields.
- *
- *	This simply calls device_register on the embedded device.
- *	On success, it will use the struct @root->sysdev 
- *	device to create a pseudo-parent for system devices
- *	on that board.
- *
- *	The platform code can then use @root to specifiy the
- *	controlling board when discovering and registering 
- *	system devices.
+/* 
+ * declare system_subsys 
  */
-int sys_register_root(struct sys_root * root)
+decl_subsys(system,NULL,NULL);
+
+int sysdev_class_register(struct sysdev_class * cls)
 {
-	int error = 0;
+	pr_debug("Registering sysdev class '%s'\n",cls->kset.kobj.name);
+	INIT_LIST_HEAD(&cls->drivers);
+	cls->kset.subsys = &system_subsys;
+	kset_set_kset_s(cls,system_subsys);
+	return kset_register(&cls->kset);
+}
 
-	if (!root)
-		return -EINVAL;
+void sysdev_class_unregister(struct sysdev_class * cls)
+{
+	pr_debug("Unregistering sysdev class '%s'\n",cls->kset.kobj.name);
+	kset_unregister(&cls->kset);
+}
 
-	if (!root->dev.parent)
-		root->dev.parent = &system_bus;
+EXPORT_SYMBOL(sysdev_class_register);
+EXPORT_SYMBOL(sysdev_class_unregister);
 
-	pr_debug("Registering system board %d\n",root->id);
 
-	error = device_register(&root->dev);
-	if (!error) {
-		strlcpy(root->sysdev.bus_id,"sys",BUS_ID_SIZE);
-		strlcpy(root->sysdev.name,"System Bus",DEVICE_NAME_SIZE);
-		root->sysdev.parent = &root->dev;
-		error = device_register(&root->sysdev);
-	};
+static LIST_HEAD(global_drivers);
 
-	return error;
+/**
+ *	sysdev_driver_register - Register auxillary driver
+ * 	@cls:	Device class driver belongs to.
+ *	@drv:	Driver.
+ *
+ *	If @cls is valid, then @drv is inserted into @cls->drivers to be 
+ *	called on each operation on devices of that class. The refcount
+ *	of @cls is incremented. 
+ *	Otherwise, @drv is inserted into global_drivers, and called for 
+ *	each device.
+ */
+
+int sysdev_driver_register(struct sysdev_class * cls, 
+			   struct sysdev_driver * drv)
+{
+	down_write(&system_subsys.rwsem);
+	if (kset_get(&cls->kset))
+		list_add_tail(&drv->entry,&cls->drivers);
+	else
+		list_add_tail(&drv->entry,&global_drivers);
+	up_write(&system_subsys.rwsem);
+	return 0;
 }
 
+
 /**
- *	sys_unregister_root - remove subordinate root from tree
- *	@root:	subordinate root in question.
- *
- *	We only decrement the reference count on @root->sysdev 
- *	and @root->dev.
- *	If both are 0, they will be cleaned up by the core.
+ *	sysdev_driver_unregister - Remove an auxillary driver.
+ *	@cls:	Class driver belongs to.
+ *	@drv:	Driver.
  */
-void sys_unregister_root(struct sys_root *root)
+void sysdev_driver_unregister(struct sysdev_class * cls,
+			      struct sysdev_driver * drv)
 {
-	device_unregister(&root->sysdev);
-	device_unregister(&root->dev);
+	down_write(&system_subsys.rwsem);
+	list_del_init(&drv->entry);
+	if (cls)
+		kset_put(&cls->kset);
+	up_write(&system_subsys.rwsem);
 }
 
+
 /**
  *	sys_device_register - add a system device to the tree
  *	@sysdev:	device in question
  *
- *	The hardest part about this is getting the ancestry right.
- *	If the device has a parent - super! We do nothing.
- *	If the device doesn't, but @dev->root is set, then we're
- *	dealing with a NUMA like architecture where each root
- *	has a system pseudo-bus to foster the device.
- *	If not, then we fallback to system_bus (at the top of 
- *	this file). 
- *
- *	One way or another, we call device_register() on it and 
- *	are done.
- *
- *	The caller is also responsible for initializing the bus_id 
- *	and name fields of @sysdev->dev.
  */
 int sys_device_register(struct sys_device * sysdev)
 {
-	if (!sysdev)
+	int error;
+	struct sysdev_class * cls = sysdev->cls;
+
+	if (!cls)
 		return -EINVAL;
 
-	if (!sysdev->dev.parent) {
-		if (sysdev->root)
-			sysdev->dev.parent = &sysdev->root->sysdev;
-		else
-			sysdev->dev.parent = &system_bus;
-	}
+	/* Make sure the kset is set */
+	sysdev->kobj.kset = &cls->kset;
 
-	/* make sure bus type is set */
-	if (!sysdev->dev.bus)
-		sysdev->dev.bus = &system_bus_type;
+	/* set the kobject name */
+	snprintf(sysdev->kobj.name,KOBJ_NAME_LEN,"%s%d",
+		 cls->kset.kobj.name,sysdev->id);
 
-	/* construct bus_id */
-	snprintf(sysdev->dev.bus_id,BUS_ID_SIZE,"%s%u",sysdev->name,sysdev->id);
+	pr_debug("Registering sys device '%s'\n",sysdev->kobj.name);
 
-	pr_debug("Registering system device %s\n", sysdev->dev.bus_id);
+	/* Register the object */
+	error = kobject_register(&sysdev->kobj);
 
-	return device_register(&sysdev->dev);
+	if (!error) {
+		struct sysdev_driver * drv;
+
+		down_read(&system_subsys.rwsem);
+		/* Generic notification is implicit, because it's that 
+		 * code that should have called us. 
+		 */
+
+		/* Notify global drivers */
+		list_for_each_entry(drv,&global_drivers,entry) {
+			if (drv->add)
+				drv->add(sysdev);
+		}
+
+		/* Notify class auxillary drivers */
+		list_for_each_entry(drv,&cls->drivers,entry) {
+			if (drv->add)
+				drv->add(sysdev);
+		}
+		up_read(&system_subsys.rwsem);
+	}
+	return error;
 }
 
 void sys_device_unregister(struct sys_device * sysdev)
 {
-	if (sysdev)
-		device_unregister(&sysdev->dev);
+	struct sysdev_driver * drv;
+
+	down_read(&system_subsys.rwsem);
+	list_for_each_entry(drv,&global_drivers,entry) {
+		if (drv->remove)
+			drv->remove(sysdev);
+	}
+
+	list_for_each_entry(drv,&sysdev->cls->drivers,entry) {
+		if (drv->remove)
+			drv->remove(sysdev);
+	}
+	up_read(&system_subsys.rwsem);
+
+	kobject_unregister(&sysdev->kobj);
 }
 
-struct bus_type system_bus_type = {
-	.name		= "system",
-};
+
+
+/**
+ *	sys_device_shutdown - Shut down all system devices.
+ *
+ *	We loop over each type of system device, get the driver for 
+ *	that type, and call the ->shutdown() method for each device
+ *	of that type.
+ */
+
+void sys_device_shutdown(void)
+{
+	struct sysdev_class * cls;
+
+	pr_debug("Shutting Down System Devices\n");
+
+	down_write(&system_subsys.rwsem);
+	list_for_each_entry(cls,&system_subsys.kset.list,kset.kobj.entry) {
+		struct sys_device * sysdev;
+
+		printk("Shutting down type '%s':\n",cls->kset.kobj.name);
+
+		if (!cls->shutdown)
+			continue;
+		list_for_each_entry(sysdev,&cls->kset.list,kobj.entry) {
+			struct sysdev_driver * drv;
+			printk(" %d",sysdev->id);
+
+			/* Call global drivers first. */
+			list_for_each_entry(drv,&global_drivers,entry) {
+				if (drv->shutdown)
+					drv->shutdown(sysdev);
+			}
+
+			/* Call auxillary drivers next. */
+			list_for_each_entry(drv,&cls->drivers,entry) {
+				if (drv->shutdown)
+					drv->shutdown(sysdev);
+			}
+
+			/* Now call the generic one */
+			if (cls->shutdown)
+				cls->shutdown(sysdev);
+		}
+		printk("\n");
+	}
+	up_write(&system_subsys.rwsem);
+}
 
 int __init sys_bus_init(void)
 {
-	bus_register(&system_bus_type);
-	return device_register(&system_bus);
+	system_subsys.kset.kobj.parent = &devices_subsys.kset.kobj;
+	return subsystem_register(&system_subsys);
 }
 
-EXPORT_SYMBOL(system_bus_type);
 EXPORT_SYMBOL(sys_device_register);
 EXPORT_SYMBOL(sys_device_unregister);
===== include/linux/device.h 1.98 vs edited =====
--- 1.98/include/linux/device.h	Thu Jun  5 15:16:19 2003
+++ edited/include/linux/device.h	Fri Jun  6 17:43:57 2003
@@ -351,24 +351,69 @@
 extern struct device * get_device(struct device * dev);
 extern void put_device(struct device * dev);
 
+
 /* drivers/base/sys.c */
 
-struct sys_root {
-	u32		id;
-	struct device 	dev;
-	struct device	sysdev;
+/**
+ * System devices follow a slightly different driver model. 
+ * They don't need to do dynammic driver binding, can't be probed, 
+ * and don't reside on any type of peripheral bus. 
+ * So, we represent and treat them a little differently.
+ * 
+ * We still have a notion of a driver for a system device, because we still
+ * want to perform basic operations on these devices. 
+ *
+ * We also support auxillary drivers binding to devices of a certain class.
+ * 
+ * This allows configurable drivers to register themselves for devices of
+ * a certain type. And, it allows class definitions to reside in generic
+ * code while arch-specific code can register specific drivers.
+ *
+ * Auxillary drivers registered with a NULL cls are registered as drivers
+ * for all system devices, and get notification calls for each device. 
+ */
+
+struct sys_device;
+
+struct sysdev_class {
+	struct list_head	drivers;
+
+	/* Default operations for these types of devices */
+	int	(*shutdown)(struct sys_device *);
+	int	(*suspend)(struct sys_device *, u32 state);
+	int	(*resume)(struct sys_device *);
+	struct kset		kset;
+};
+
+
+extern int sysdev_class_register(struct sysdev_class *);
+extern void sysdev_class_unregister(struct sysdev_class *);
+
+
+/**
+ * Auxillary system device drivers.
+ */
+
+struct sysdev_driver {
+	struct list_head	entry;
+	int	(*add)(struct sys_device *);
+	int	(*remove)(struct sys_device *);
+	int	(*shutdown)(struct sys_device *);
+	int	(*suspend)(struct sys_device *, u32 state);
+	int	(*resume)(struct sys_device *);
 };
 
-extern int sys_register_root(struct sys_root *);
-extern void sys_unregister_root(struct sys_root *);
 
 
+/**
+ * sys_devices can be simplified a lot from regular devices, because they're
+ * simply not as versatile. 
+ */
+
 struct sys_device {
-	char		* name;
 	u32		id;
-	struct sys_root	* root;
-	struct device	dev;
-	struct class_device class_dev;
+	struct sysdev_class	* cls;
+	struct kobject		kobj;
 };
 
 extern int sys_device_register(struct sys_device *);
===== include/linux/kobject.h 1.21 vs edited =====
--- 1.21/include/linux/kobject.h	Tue Jun  3 16:15:33 2003
+++ edited/include/linux/kobject.h	Fri Jun  6 16:09:40 2003
@@ -118,6 +118,14 @@
 extern struct kobject * kset_find_obj(struct kset *, const char *);
 
 
+/**
+ * Use this when initializing an embedded kset with no other 
+ * fields to initialize.
+ */
+#define set_kset_name(str)	.kset = { .kobj = { .name = str } }
+
+
+
 struct subsystem {
 	struct kset		kset;
 	struct rw_semaphore	rwsem;
===== include/linux/node.h 1.2 vs edited =====
--- 1.2/include/linux/node.h	Thu Oct 31 14:48:21 2002
+++ edited/include/linux/node.h	Fri Jun  6 16:06:25 2003
@@ -23,7 +23,7 @@
 
 struct node {
 	unsigned long cpumap;	/* Bitmap of CPUs on the Node */
-	struct sys_root sysroot;
+	struct sys_device	sysdev;
 };
 
 extern int register_node(struct node *, int, struct node *);

