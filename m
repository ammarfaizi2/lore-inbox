Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbUKDHEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbUKDHEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUKDHEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:04:32 -0500
Received: from [211.58.254.17] ([211.58.254.17]:52384 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262118AbUKDGy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:54:28 -0500
Date: Thu, 4 Nov 2004 15:54:25 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 14/15] driver-model: devparam documentation
Message-ID: <20041104065425.GN24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_14_devparam_doc.patch

 This is the 14th patch of 15 patches for devparam.

 Devparam document.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/Documentation/driver-model/devparam.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-export/Documentation/driver-model/devparam.txt	2004-11-04 11:04:13.000000000 +0900
@@ -0,0 +1,419 @@
+Per-Device Parameter
+
+Tejun Heo  <tj@home-tj.org>
+
+19 October 2004
+
+
+ INTRO
+ =====
+
+ Per-device parameter wasn't supported by Linux driver model
+previously.  It was usually done using the moduleparam facility.  As
+the name suggests, moduleparam implements per-module parameters and
+drivers used fixed-size array to implement per-device parameters.
+This results in unnecessary duplication of codes, variation in usage
+and random limits on the number of supported devices or devices which
+users can specify parameters for.  Devparam integrates per-device
+parameter support into the driver model to solve these issues.
+
+ Devparam aims to
+
+ 1. Remove duplicated parameter handling codes from drivers
+ 2. Retain user-visible syntax for converted drivers
+ 3. Remove hard-coded random limits on the number of devices
+    parameters can be specified for
+ 4. Support multiple paramsets
+ 5. Support sysfs access to per-device paramters
+
+
+ OVERVIEW
+ ========
+
+ Parameters are organized into parameter sets or paramsets.  Each
+paramset is represented by a user-defined structure (e.g. struct
+my_dev_paramset).  A paramset definition, or paramset_def, describes
+the paramset to the driver model - what it contains, how to parse each
+parameter and so on.
+
+ A device driver passes paramset_defs it wants to use to the driver
+model when registering the driver, and before the driver is attached
+to a device, the driver model parses user supplied parameters and
+fills the paramsets and pass them to the device driver.
+
+ There are two categories of paramsets.
+
+ I. DEV PARAMSETS
+
+ These are device specific parameters used by the driver.  This
+category includes most parameters currently used by drivers.  Examples
+for network drivers would be stuff like the size of tx/rx descriptor
+ring and hardware checksum enable/disable option.
+
+ As the tailing 'S' suggests, drivers can use multiple paramsets.
+Primary usage of multiple paramsets would be for class parameters for
+class devices.  For example, if the input layer wants to accept some
+common set of parameters for each input device, it can define a
+paramset_def and all input device drivers can use it to accept the
+common parameters.  Once modified to use the facility, the content of
+the paramset_def doesn't matter to specific device drivers, so the
+input paramset_def can be modified without changing or even
+recompiling individual device drivers.
+
+ II. BUS PARAMSET
+
+ These are bus specific parameters.  Individual device drivers
+wouldn't care or know about this paramset.  These paramsets are
+defined and used only by bus drivers.  When a bus driver wants to
+accept some common paramters for all devices living on the bus, the
+driver will supply the bus paramset_def and all device drivers for the
+bus will accept bus parameters.  Examples would be PCI command
+register setting, PCIe QoS settings and so on.
+
+
+ USING DEVPARAM
+ ==============
+
+ Paramset definition is defined using DEFINE_DEVICE_PARAMSET[_NS] and
+DEVICE_PARAM_* macros and passed to the driver-model via the
+paramset_def[s] fields of struct device_driver or struct bus_type.
+The usage is very similar to moduleparam; actually, most of devparam
+is built using moduleparam.
+
+- DEFINE_DEVICE_PARAMSET_NS(Name, Type, Namespace, Paramdefs) macro
+
+	Defines a struct device_paramset_def @Name which contains
+	parameters described by @Paramdefs.  Each parameter definition
+	in @Paramdefs describes how to handle a parameter which is
+	contained in a @Type variable.  All parameters defined with
+	this macros has dot-appended @Namespace as their prefixes.
+
+- DEFINE_DEVICE_PARAMSET(Name, Type, Paramdefs) macro
+
+	Identical with the above macro except that there's no prefix
+	to the parameters.
+
+- DEVICE_PARAM_*() macros
+
+	Syntax is almost identical to module_param_*() macros defined
+	in moduleparam.h.  There are three differences.  The first is
+	that instead of referring directly to a variable to be set,
+	the field name inside @Type of enclosing
+	DEFINE_DEVICE_PARAMSET is used.  The second is that there's an
+	extra argument @Dfl which is a string containing the default
+	value to use when the user didn't specify the parameter.
+	The last is the additional argument @Desc which serves the
+	same purpose as MODULE_PARAM_DESC().
+
+
+ When attaching a device, its paramset structures are allocated and
+cleared with zero, and for each defined parameter, set function is
+called with user supplied argument if it's available or the default
+string.  If the default string is also NULL, set function isn't
+called).  (Actually, all parameters are parsed when the device driver
+is initialized and cached inside the device_driver structure, but the
+end result is the same as described above.)
+
+ Device parameters are passed as comma-separated values via
+moduleparam facility (the first value is for the first device which
+gets attached to the driver, the second value for the second device
+and so on).  In parameter strings, '\' escapes the following
+character, so by using "\," strings containing commas or
+comma-separated arrays can be specified.  To ease nested array
+specification, ':' is also accepted as nested array separator.
+
+ It's best explained with examples.  I'll present two examples - one
+simple and the other more complete.  If you're a driver developer just
+wanting to receive per-device parameters for your driver, reading the
+first example should suffice.
+
+
+ A SIMPLE ONE
+ ============
+
+  I'll use an imaginary pci device driver for this example.  Let's
+say it wants to accept the following parameters.
+
+ - One integer parameter named integer_knob which should be in the
+   range [0, 255] and defaults to 16 when none is specified.
+ - One string parameter named string which can be as long as 63
+   characters and defaults to "mung mung".
+ - A boolean parameter named enable_feature0 which, when 1, sets
+   MY_FEATURE0 in flags and defaults to 0.
+
+ First, a paramset structure needs to be defined.
+
+| struct my_drv_paramset {
+|         int integer_knob;
+|         char string[64];
+|         unsigned flags;
+| };
+
+ Then, the corresponding my_drv_paramset_def.
+
+| static DEFINE_DEVICE_PARAMSET(my_drv_paramset_def, struct my_drv_paramset,
+|         DEVICE_PARAM_RANGED(integer_knob, int, 0, 255, "16", 0444,
+|                 "integer_knob does something, [0,255] default 16")
+|         DEVICE_PARAM_STRING(string, "mung mung", 0444,
+|                 "A string is a string")
+|         DEVICE_PARAM_FLAG(enable_feature0, flags, MY_FEATURE0, "0", 0444,
+|                 "Enables feature0. Whatever that is.")
+| );
+
+ We're almost done already.  The only thing left is to register the
+paramset_def.
+
+| static struct device_paramset_def *paramset_defs[] = {
+|         &my_drv_paramset_def,
+|         NULL
+| };
+|
+| static struct pci_driver my_drv = {
+|         .name                    = "my_drv",
+|         .owner                   = THIS_MODULE,
+|         .probe                   = my_probe,
+|         .driver.paramset_defs    = paramset_defs,
+|         ...
+| };
+| 
+| static int __init my_init(void)
+| {
+|         ...
+|         return pci_register_driver(&my_drv);
+| }
+
+ And we can use the paramset however we want to.
+
+| static int __devinit my_probe(struct pci_dev *pdev,
+|                               const struct pci_device_id *ent)
+| {
+|         struct my_drv_paramset *ps = pdev->dev.paramsets[0];
+|         ...
+| }
+
+ Now, let's see how a user can specify those device parameters.  If
+the driver is compiled into the kernel, parameters can be specified in
+the boot options.
+
+> my_drv.integer_knob=32,32,64 my_drv.string="bungga,asdf"
+
+ The results would be...
+
+		integer_knob	string		flags
+ ----------------------------------------------------------
+ 1st dev:	32		"bungga"	0
+ 2st dev:	32		"asdf"		0
+ 3st dev:	64		"mung mung"	0
+ 4th-Nth:	16		"mung mung"	0
+
+ If the module is compiled as a module, parameters can be specified
+like the following.
+
+> modprobe my_drv integer_knob=8,8,32 enable_feature0=1,1
+
+		integer_knob	string		flags
+ ----------------------------------------------------------
+ 1st dev:	 8		"mung mung"	MY_FEATURE0
+ 2st dev:	 8		"mung mung"	MY_FEATURE0
+ 3st dev:	32		"mung mung"	0
+ 4th-Nth:	16		"mung mung"	0
+
+ Note that when a device attaches, the first empty paramset slot is
+used.  For example, let's say there's device A, B, C and D all of
+which are controlled by my_drv, and three paramsets ps0, ps1 and ps2
+of which ps2 is the default paramset.
+
+ Event		Paramset
+ -----------------------
+ A attaches	ps0
+ B attaches	ps1
+ C attaches	ps2
+ B detaches
+ D attaches	ps1
+ B attaches	ps2
+
+ However, as each device gets its own copy of the paramsets, it can
+modify the paramset as needed.  Modifying its paramset won't affect
+other devices attaching later.
+
+
+ A FULL EXAMPLE
+ ==============
+
+ I'll use a pseudo bus, class and driver respectively named dp_bus,
+dp_class and dp_drv for explanation.  A dp_drv lives on dp_bus and a
+dp_drv device implements a class device belonging to dp_class.  All of
+dp_bus, dp_class and dp_drv accept their own sets of parameters.
+
+ Let's look at dp_bus first.
+
+ I. DP_BUS
+
+ dp_bus defines struct dp_driver (just like struct pci_drv) and
+registration unregistration functions (just like
+pci_[un]register_driver() functions).  So, it defines the following
+interface in dp_bus.h.
+
+| struct dp_driver {
+|         int (*probe)(struct device *dev);
+|         void (*remove)(struct device *dev);
+|         struct device_driver driver;
+| };
+| 
+| extern struct bus_type dp_bus_type;
+|
+| int dp_register_driver(struct dp_driver *drv);
+| void dp_unregister_driver(struct dp_driver *drv);
+
+ dp_bus wants to accept the following parameters.
+
+ - Three integer parameters named bus_a, bus_b and bus_c.
+ - An array of intergers which can have 6 elements at maximum.
+
+ So, in dp_bus.c, the following structure is defined.
+
+| struct dp_bus_paramset {
+|         int a, b, c;
+|         int ar[6], ar_cnt;
+| };
+
+ Also corresponding dp_bus_paramset_def.
+
+| static DEFINE_DEVICE_PARAMSET_NS(dp_bus_paramset_def, struct dp_bus_paramset,
+|                                  "dp_bus",
+|         DEVICE_PARAM(a, int, "0", 0444, "mung mung")
+|         DEVICE_PARAM(b, int, "1", 0444, "bungga bungga")
+|         DEVICE_PARAM(c, int, "2", 0444, "OTL OTL OTL OTL OTL OTL")
+|         DEVICE_PARAM_ARRAY(ar, int, ar_cnt, "1,2,3", 0444, "whatever, dude")
+| );
+
+ Note that, we're defining parameters under "dp_bus" namescope.  All
+of above parameters are treated as they have "dp_bus." prefix.  In
+other words, if a user wants to specify the @a parameter, it must be
+specified as "dp_bus.a".
+
+ So, needed data structures are in place now.  All that's left to do
+is to use the appropriate hooks.  First, we need to set paramset_def
+field of bus_type.
+
+| struct bus_type dp_bus_type = {
+|         .name           = "dp",
+|         .match          = dp_bus_match,
+|         .paramset_def   = &dp_dev_paramset_def
+| };
+
+ And, in dp_register_driver(), we hook up probe and remove to dp_probe
+and dp_remove.
+
+| int dp_register_driver(struct dp_driver *drv, struct module *mod)
+| {
+|         drv->driver.bus = &dp_bus_type;
+|         drv->driver.probe = dp_probe;
+|         drv->driver.remove = dp_remove;
+|         printk("dp_bus: registering driver \"%s\"\n", drv->driver.name);
+|         return driver_register(&drv->driver);
+| }
+
+ dp_probe() looks like the folowing.
+
+| static int dp_probe(struct device *dev)
+| {
+|         struct dp_driver *drv;
+|         struct dp_bus_paramset *ps;
+| 
+|         drv = container_of(dev->driver, struct dp_driver, driver);
+|         ps = dev->bus_paramset;
+| 
+|         /* Whatever the bus driver wanna do can come here. */
+| 
+|         return drv->probe(dev);
+| }
+
+ The driver model parses user specified parameter or the default
+parameter supplied with paramset_def and set dev->bus_paramset field
+to the result.  The bus driver is free to read and modify the
+structure as needed.  As dp_bus is a pseudo bus, it doesn't really
+have anything to do, but a real driver could tweak some bus features
+(e.g. PCIe QoS setting) for the device there.
+
+ Above are all the interesting parts of dp_bus implementation.  Now,
+let's look at dp_class.
+
+
+ II. DP_CLASS
+
+ dp_class is a dummy class which doesn't do anything but accepting
+some parameters and getting devices registered to it.  Consequently,
+it has a very simple interface.
+
+| extern struct class dp_class;
+| extern struct device_paramset_def dp_class_paramset_def;
+| struct dp_class_paramset;
+|
+| extern int dp_class_device_register(struct class_device *dev,
+|                                     struct dp_class_paramset *params);
+| void dp_class_device_unregister(struct class_device *dev);
+
+ Note that dp_class_paramset_def is exported.  This wasn't necessary
+for bus parameters but as device-class association is only known by
+the driver of a device, it must be able to access the paramset_defs of
+the classes it's going to register a device to.  Any driver which
+wants to register with dp_class will pass dp_class_paramset_def to the
+driver-model using drv.paramset_defs field and pass the resulting
+paramset to dp_class_device_register().
+
+ The implementation of dp_class isn't very intriguing.
+dp_class_paramset_def is defined just like dp_bus_paramset_def.  The
+only differences are that there's no static qualifier in front of
+DEFINE_DEVICE_PARAMSET() and dp_bus_paramset_def needs to be
+EXPORT_SYMBOL()'d as it's gonna be referenced by drivers living in
+other modules.
+
+
+III. DP_DRV
+
+ Okay, here's dp_drv, where everything comes together.  dp_drv defines
+its own dp_drv_paramset_def just like dp_bus.  dp_drv also defines an
+array of device_paramset_def's which contain pointers to both
+dp_drv_paramset_def and dp_class_paramset_def.
+
+| static struct device_paramset_def *paramset_defs[] = {
+|         &dp_drv_paramset_def,
+|         &dp_class_paramset_def,
+|         NULL
+| };
+
+ And the dp_driver structure looks like the follwing.
+
+| static struct dp_driver my_drv = {
+|         .driver.name            = "babo",
+|	  .driver.owner           = THIS_MODULE,
+|         .probe                  = dp_drv_probe,
+|         .remove                 = dp_drv_remove,
+|         .driver.paramset_defs   = paramset_defs,
+| };
+| 
+| static int __init dp_drv_init(void)
+| {
+|         return dp_register_driver(&my_drv);
+| }
+
+ Paramsets are accessed and passed to dp_class like the following.
+
+| static int dp_drv_probe(struct device *dev)
+| {
+|         struct dp_drv_paramset *ps = dev->paramsets[0];
+|         ...
+|         ret = dp_class_device_register(priv->class, dev->paramsets[1]);
+|         ...
+| }
+
+ Now everyone has its paramset and should be happy and hazy.
+
+ Complete source code for dp_bus, dp_class, dp_drv and dp_dev (dp_dev
+is for creating pseudo devices which attaches to dp_drv) is available
+at the following URL.
+
+ http://home-tj.org/devparam/dptest.tar.gz
+
+ Happy hacking.
