Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVBAAP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVBAAP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVBAAOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:14:08 -0500
Received: from lists.us.dell.com ([143.166.224.162]:32697 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261498AbVBAAJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:09:43 -0500
Date: Mon, 31 Jan 2005 18:09:39 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.6.11-rc2] vmlinux: put built-in module parameter info in vmlinux
Message-ID: <20050201000939.GF24164@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Module parameter descriptions are added to loadable modules, but is
omitted from objects built into the kernel itself.  It would be nice
if you could get the list of parameters usable on the kernel command
line by looking at vmlinux.

$ modinfo vmlinux | grep parm:
parm:           thermal.tzp:Thermal zone polling frequency, in 1/10 seconds.
parm:           drm.drm_debug:Enable debug output
parm:           drm.drm_cards_limit:Maximum number of graphics cards
parm:           i8042.debug:Turn i8042 debugging mode on and off
parm:           i8042.noacpi:Do not use ACPI to detect controller settings
parm:           i8042.dumbkbd:Disable the AUX Loopback command while probing for the AUX port
parm:           i8042.dumbkbd:Pretend that controller can only read data from keyboard
parm:           i8042.direct:Put keyboard port into non-translated mode.
parm:           i8042.reset:Reset controller during init and cleanup.
parm:           i8042.unlock:Ignore keyboard lock.
parm:           i8042.nomux:Do not check whether an active multiplexing conrtoller is present.
parm:           i8042.noaux:Do not probe or use AUX (mouse) port.
parm:           8250.probe_rsa:Probe I/O ports for RSA
parm:           8250.share_irqs:Share IRQs with other non-8250/16x50 devices (unsafe)
parm:           rd.rd_blocksize:Blocksize of each RAM disk in bytes.
parm:           rd.rd_size:Size of each RAM disk in kbytes.
parm:           usbcore.use_both_schemes:try the other device initialization scheme if the first one fails
parm:           usbcore.old_scheme_first:start with the old device initialization scheme
parm:           usbcore.blinkenlights:true to cycle leds on hubs
parm:           usbcore.usbfs_snoop:true to log all usbfs traffic
parm:           mousedev.tap_time:Tap time for touchpads in absolute mode (msecs)
parm:           mousedev.yres:Vertical screen resolution
parm:           mousedev.xres:Horizontal screen resolution
parm:           atkbd.extra:Enable extra LEDs and keys on IBM RapidAcces, EzKey and similar keyboards
parm:           atkbd.scroll:Enable scroll-wheel on MS Office and similar keyboards
parm:           atkbd.softraw:Use software generated rawmode
parm:           atkbd.softrepeat:Use software keyboard repeat
parm:           atkbd.reset:Reset keyboard during initialization
parm:           atkbd.set:Select keyboard code set (2 = default, 3 = PS/2 native)
parm:           psmouse.resetafter:Reset device after so many bad packets (0 = never).
parm:           psmouse.smartscroll:Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.
parm:           psmouse.rate:Report rate, in reports per second.
parm:           psmouse.resolution:Resolution, in dpi.
parm:           psmouse.proto:Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.

Patch below implements such.  It also emits modulename.version fields
should they exist, but omits license, author, and description fields,
as I'm not sure how interesting those fields are when built-in.

Feedback requested prior to submission for inclusion.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== include/linux/module.h 1.92 vs edited =====
--- 1.92/include/linux/module.h	2005-01-10 13:28:15 -06:00
+++ edited/include/linux/module.h	2005-01-31 17:59:23 -06:00
@@ -76,14 +79,27 @@
 
 extern struct subsystem module_subsys;
 
+/* You can override this manually, but generally this should match the
+   module name. */
 #ifdef MODULE
+#define MODULE_PARAM_PREFIX /* empty */
+#else
+#define MODULE_PARAM_PREFIX __stringify(KBUILD_MODNAME) "."
+#endif
+
 #define ___module_cat(a,b) __mod_ ## a ## b
 #define __module_cat(a,b) ___module_cat(a,b)
 #define __MODULE_INFO(tag, name, info)					  \
 static const char __module_cat(name,__LINE__)[]				  \
   __attribute_used__							  \
-  __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
+  __attribute__((section(".modinfo"),unused)) = MODULE_PARAM_PREFIX __stringify(tag) "=" info
+
+#define ___MODULE_INFO(tag, name, info)					  \
+static const char __module_cat(name,__LINE__)[]				  \
+  __attribute_used__							  \
+  __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" MODULE_PARAM_PREFIX info
 
+#ifdef MODULE
 #define MODULE_GENERIC_TABLE(gtype,name)			\
 extern const struct gtype##_id __mod_##gtype##_table		\
   __attribute__ ((unused, alias(__stringify(name))))
@@ -94,7 +110,6 @@
 #else  /* !MODULE */
 
 #define MODULE_GENERIC_TABLE(gtype,name)
-#define __MODULE_INFO(tag, name, info)
 #define THIS_MODULE ((struct module *)0)
 #endif
 
@@ -130,6 +145,7 @@
  * 2.	So the community can ignore bug reports including proprietary modules
  * 3.	So vendors can do likewise based on their own policies
  */
+#ifdef MODULE
 #define MODULE_LICENSE(_license) MODULE_INFO(license, _license)
 
 /* Author, ideally of form NAME <EMAIL>[, NAME <EMAIL>]*[ and NAME <EMAIL>] */
@@ -137,11 +153,17 @@
   
 /* What your module does. */
 #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
+#else
+#define MODULE_LICENSE(_license)
+#define MODULE_AUTHOR(_author)
+#define MODULE_DESCRIPTION(_description)
+#endif
+
 
 /* One for each parameter, describing how to use it.  Some files do
    multiple of these per line, so can't just use MODULE_INFO. */
 #define MODULE_PARM_DESC(_parm, desc) \
-	__MODULE_INFO(parm, _parm, #_parm ":" desc)
+	___MODULE_INFO(parm, _parm, #_parm ":" desc)
 
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
