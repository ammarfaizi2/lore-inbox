Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVCVH0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVCVH0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVCVHYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:24:44 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:54673 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262210AbVCVHSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:18:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kenan Esau <kenan.esau@conan.de>
Subject: [PATCH 4/4] psmouse: dynamic protocol switching via sysfs
Date: Tue, 22 Mar 2005 02:17:47 -0500
User-Agent: KMail/1.7.2
Cc: harald.hoyer@redhat.de, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <20050217194217.GA2458@ucw.cz> <200503220215.34198.dtor_core@ameritech.net> <200503220216.38756.dtor_core@ameritech.net>
In-Reply-To: <200503220216.38756.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503220217.47624.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

Input: psmouse - export protocol as a sysfs per-device attribute.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/mouse/psmouse-base.c |  291 ++++++++++++++++++++++++++++++-------
 drivers/input/mouse/psmouse.h      |    1 
 drivers/input/serio/serio.c        |   44 +++++
 include/linux/serio.h              |    6 
 4 files changed, 290 insertions(+), 52 deletions(-)

Index: dtor/drivers/input/serio/serio.c
===================================================================
--- dtor.orig/drivers/input/serio/serio.c
+++ dtor/drivers/input/serio/serio.c
@@ -43,6 +43,7 @@ MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(serio_interrupt);
 EXPORT_SYMBOL(__serio_register_port);
 EXPORT_SYMBOL(serio_unregister_port);
+EXPORT_SYMBOL(serio_unregister_child_port);
 EXPORT_SYMBOL(__serio_unregister_port_delayed);
 EXPORT_SYMBOL(__serio_register_driver);
 EXPORT_SYMBOL(serio_unregister_driver);
@@ -90,12 +91,19 @@ static void serio_bind_driver(struct ser
 	down_write(&serio_bus.subsys.rwsem);
 
 	if (serio_match_port(drv->id_table, serio)) {
+		/* make sure parent is not about to change */
+		if (serio->parent)
+			down(&serio->parent->drv_sem);
+
 		serio->dev.driver = &drv->driver;
 		if (drv->connect(serio, drv)) {
 			serio->dev.driver = NULL;
 			goto out;
 		}
 		device_bind_driver(&serio->dev);
+
+		if (serio->parent)
+			up(&serio->parent->drv_sem);
 	}
 out:
 	up_write(&serio_bus.subsys.rwsem);
@@ -150,12 +158,12 @@ static void serio_queue_event(void *obje
 	spin_lock_irqsave(&serio_event_lock, flags);
 
 	/*
- 	 * Scan event list for the other events for the same serio port,
+	 * Scan event list for the other events for the same serio port,
 	 * starting with the most recent one. If event is the same we
 	 * do not need add new one. If event is of different type we
 	 * need to add this event and should not look further because
 	 * we need to preseve sequence of distinct events.
- 	 */
+	 */
 	list_for_each_entry_reverse(event, &serio_event_list, node) {
 		if (event->object == object) {
 			if (event->type == event_type)
@@ -614,6 +622,19 @@ void serio_unregister_port(struct serio 
 }
 
 /*
+ * Safely unregisters child port if one is present.
+ */
+void serio_unregister_child_port(struct serio *serio)
+{
+	down(&serio_sem);
+	if (serio->child) {
+		serio_disconnect_port(serio->child);
+		serio_destroy_port(serio->child);
+	}
+	up(&serio_sem);
+}
+
+/*
  * Submits register request to kseriod for subsequent execution.
  * Can be used when it is not obvious whether the serio_sem is
  * taken or not and when delayed execution is feasible.
@@ -669,8 +690,18 @@ static int serio_driver_probe(struct dev
 {
 	struct serio *serio = to_serio_port(dev);
 	struct serio_driver *drv = to_serio_driver(dev->driver);
+	int result;
+
+	/* make sure parent is not about to change */
+	if (serio->parent)
+		down(&serio->parent->drv_sem);
+
+	result = drv->connect(serio, drv);
+
+	if (serio->parent)
+		up(&serio->parent->drv_sem);
 
-	return drv->connect(serio, drv);
+	return result;
 }
 
 static int serio_driver_remove(struct device *dev)
@@ -678,7 +709,14 @@ static int serio_driver_remove(struct de
 	struct serio *serio = to_serio_port(dev);
 	struct serio_driver *drv = to_serio_driver(dev->driver);
 
+	if (serio->parent)
+		down(&serio->parent->drv_sem);
+
 	drv->disconnect(serio);
+
+	if (serio->parent)
+		up(&serio->parent->drv_sem);
+
 	return 0;
 }
 
Index: dtor/drivers/input/mouse/psmouse.h
===================================================================
--- dtor.orig/drivers/input/mouse/psmouse.h
+++ dtor/drivers/input/mouse/psmouse.h
@@ -78,6 +78,7 @@ enum psmouse_type {
 	PSMOUSE_SYNAPTICS,
 	PSMOUSE_ALPS,
 	PSMOUSE_LIFEBOOK,
+	PSMOUSE_AUTO		/* This one should always be last */
 };
 
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
Index: dtor/include/linux/serio.h
===================================================================
--- dtor.orig/include/linux/serio.h
+++ dtor/include/linux/serio.h
@@ -83,6 +83,7 @@ static inline void serio_register_port(s
 }
 
 void serio_unregister_port(struct serio *serio);
+void serio_unregister_child_port(struct serio *serio);
 void __serio_unregister_port_delayed(struct serio *serio, struct module *owner);
 static inline void serio_unregister_port_delayed(struct serio *serio)
 {
@@ -153,6 +154,11 @@ static inline int serio_pin_driver(struc
 	return down_interruptible(&serio->drv_sem);
 }
 
+static inline void serio_pin_driver_uninterruptible(struct serio *serio)
+{
+	down(&serio->drv_sem);
+}
+
 static inline void serio_unpin_driver(struct serio *serio)
 {
 	up(&serio->drv_sem);
Index: dtor/drivers/input/mouse/psmouse-base.c
===================================================================
--- dtor.orig/drivers/input/mouse/psmouse-base.c
+++ dtor/drivers/input/mouse/psmouse-base.c
@@ -32,15 +32,14 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@s
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-static unsigned int psmouse_max_proto = -1U;
+static unsigned int psmouse_max_proto = PSMOUSE_AUTO;
 static int psmouse_set_maxproto(const char *val, struct kernel_param *kp);
 static int psmouse_get_maxproto(char *buffer, struct kernel_param *kp);
-static char *psmouse_proto_abbrev[] = { NULL, "bare", NULL, NULL, NULL, "imps", "exps", NULL, NULL, "lifebook" };
 #define param_check_proto_abbrev(name, p)	__param_check(name, p, unsigned int)
 #define param_set_proto_abbrev			psmouse_set_maxproto
 #define param_get_proto_abbrev			psmouse_get_maxproto
 module_param_named(proto, psmouse_max_proto, proto_abbrev, 0644);
-MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps, lifebook, any). Useful for KVM switches.");
+MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps, any). Useful for KVM switches.");
 
 static unsigned int psmouse_resolution = 200;
 module_param_named(resolution, psmouse_resolution, uint, 0644);
@@ -58,6 +57,7 @@ static unsigned int psmouse_resetafter;
 module_param_named(resetafter, psmouse_resetafter, uint, 0644);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
+PSMOUSE_DEFINE_ATTR(protocol);
 PSMOUSE_DEFINE_ATTR(rate);
 PSMOUSE_DEFINE_ATTR(resolution);
 PSMOUSE_DEFINE_ATTR(resetafter);
@@ -68,7 +68,14 @@ __obsolete_setup("psmouse_smartscroll=")
 __obsolete_setup("psmouse_resetafter=");
 __obsolete_setup("psmouse_rate=");
 
-static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2", "LBPS/2" };
+struct psmouse_protocol {
+	enum psmouse_type type;
+	char *name;
+	char *alias;
+	int maxproto;
+	int (*detect)(struct psmouse *, int);
+	int (*init)(struct psmouse *);
+};
 
 /*
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
@@ -408,12 +415,15 @@ static int thinking_detect(struct psmous
  */
 static int ps2bare_detect(struct psmouse *psmouse, int set_properties)
 {
-	if (!psmouse->vendor) psmouse->vendor = "Generic";
-	if (!psmouse->name) psmouse->name = "Mouse";
+	if (set_properties) {
+		if (!psmouse->vendor) psmouse->vendor = "Generic";
+		if (!psmouse->name) psmouse->name = "Mouse";
+	}
 
 	return 0;
 }
 
+
 /*
  * psmouse_extensions() probes for any extensions to the basic PS/2 protocol
  * the mouse may have.
@@ -428,9 +438,7 @@ static int psmouse_extensions(struct psm
  * We always check for lifebook because it does not disturb mouse
  * (it only checks DMI information).
  */
-	if (lifebook_detect(psmouse, set_properties) == 0 ||
-	    max_proto == PSMOUSE_LIFEBOOK) {
-
+	if (lifebook_detect(psmouse, set_properties) == 0) {
 		if (max_proto > PSMOUSE_IMEX) {
 			if (!set_properties || lifebook_init(psmouse) == 0)
 				return PSMOUSE_LIFEBOOK;
@@ -520,6 +528,103 @@ static int psmouse_extensions(struct psm
 	return PSMOUSE_PS2;
 }
 
+static struct psmouse_protocol psmouse_protocols[] = {
+	{
+		.type		= PSMOUSE_PS2,
+		.name		= "PS/2",
+		.alias		= "bare",
+		.maxproto	= 1,
+		.detect		= ps2bare_detect,
+	},
+	{
+		.type		= PSMOUSE_PS2PP,
+		.name		= "PS2++",
+		.alias		= "logitech",
+		.detect		= ps2pp_init,
+	},
+	{
+		.type		= PSMOUSE_THINKPS,
+		.name		= "ThinkPS/2",
+		.alias		= "thinkps",
+		.detect		= thinking_detect,
+	},
+	{
+		.type		= PSMOUSE_GENPS,
+		.name		= "GenPS/2",
+		.alias		= "genius",
+		.detect		= genius_detect,
+	},
+	{
+		.type		= PSMOUSE_IMPS,
+		.name		= "ImPS/2",
+		.alias		= "imps",
+		.maxproto	= 1,
+		.detect		= intellimouse_detect,
+	},
+	{
+		.type		= PSMOUSE_IMEX,
+		.name		= "ImExPS/2",
+		.alias		= "exps",
+		.maxproto	= 1,
+		.detect		= im_explorer_detect,
+	},
+	{
+		.type		= PSMOUSE_SYNAPTICS,
+		.name		= "SynPS/2",
+		.alias		= "synaptics",
+		.detect		= synaptics_detect,
+		.init		= synaptics_init,
+	},
+	{
+		.type		= PSMOUSE_ALPS,
+		.name		= "AlpsPS/2",
+		.alias		= "alps",
+		.detect		= alps_detect,
+		.init		= alps_init,
+	},
+	{
+		.type		= PSMOUSE_LIFEBOOK,
+		.name		= "LBPS/2",
+		.alias		= "lifebook",
+		.init		= lifebook_init,
+	},
+	{
+		.type		= PSMOUSE_AUTO,
+		.name		= "auto",
+		.alias		= "any",
+		.maxproto	= 1,
+	},
+};
+
+static struct psmouse_protocol *psmouse_protocol_by_type(enum psmouse_type type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(psmouse_protocols); i++)
+		if (psmouse_protocols[i].type == type)
+			return &psmouse_protocols[i];
+
+	WARN_ON(1);
+	return &psmouse_protocols[0];
+}
+
+static struct psmouse_protocol *psmouse_protocol_by_name(const char *name, size_t len)
+{
+	struct psmouse_protocol *p;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(psmouse_protocols); i++) {
+		p = &psmouse_protocols[i];
+
+		if ((strlen(p->name) == len && !strncmp(p->name, name, len)) ||
+		    (strlen(p->alias) == len && !strncmp(p->alias, name, len)))
+			return &psmouse_protocols[i];
+	}
+
+	return NULL;
+}
+
+
 /*
  * psmouse_probe() probes for a PS/2 mouse.
  */
@@ -669,6 +774,7 @@ static void psmouse_disconnect(struct se
 {
 	struct psmouse *psmouse, *parent;
 
+	device_remove_file(&serio->dev, &psmouse_attr_protocol);
 	device_remove_file(&serio->dev, &psmouse_attr_rate);
 	device_remove_file(&serio->dev, &psmouse_attr_resolution);
 	device_remove_file(&serio->dev, &psmouse_attr_resetafter);
@@ -693,6 +799,49 @@ static void psmouse_disconnect(struct se
 	kfree(psmouse);
 }
 
+static int psmouse_switch_protocol(struct psmouse *psmouse, struct psmouse_protocol *proto)
+{
+	memset(&psmouse->dev, 0, sizeof(struct input_dev));
+
+	init_input_dev(&psmouse->dev);
+
+	psmouse->dev.private = psmouse;
+	psmouse->dev.dev = &psmouse->ps2dev.serio->dev;
+
+	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
+
+	psmouse->set_rate = psmouse_set_rate;
+	psmouse->set_resolution = psmouse_set_resolution;
+	psmouse->protocol_handler = psmouse_process_byte;
+	psmouse->pktsize = 3;
+
+	if (proto && (proto->detect || proto->init)) {
+		if (proto->detect && proto->detect(psmouse, 1) < 0)
+			return -1;
+
+		if (proto->init && proto->init(psmouse) < 0)
+			return -1;
+
+		psmouse->type = proto->type;
+	}
+	else
+		psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
+
+	sprintf(psmouse->devname, "%s %s %s",
+		psmouse_protocol_by_type(psmouse->type)->name, psmouse->vendor, psmouse->name);
+
+	psmouse->dev.name = psmouse->devname;
+	psmouse->dev.phys = psmouse->phys;
+	psmouse->dev.id.bustype = BUS_I8042;
+	psmouse->dev.id.vendor = 0x0002;
+	psmouse->dev.id.product = psmouse->type;
+	psmouse->dev.id.version = psmouse->model;
+
+	return 0;
+}
+
 /*
  * psmouse_connect() is a callback from the serio module when
  * an unhandled serio port is found.
@@ -720,11 +869,7 @@ static int psmouse_connect(struct serio 
 
 	ps2_init(&psmouse->ps2dev, serio);
 	sprintf(psmouse->phys, "%s/input0", serio->phys);
-	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	psmouse->dev.private = psmouse;
-	psmouse->dev.dev = &serio->dev;
+
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
 	serio_set_drvdata(serio, psmouse);
@@ -748,25 +893,10 @@ static int psmouse_connect(struct serio 
 	psmouse->resolution = psmouse_resolution;
 	psmouse->resetafter = psmouse_resetafter;
 	psmouse->smartscroll = psmouse_smartscroll;
-	psmouse->set_rate = psmouse_set_rate;
-	psmouse->set_resolution = psmouse_set_resolution;
-	psmouse->protocol_handler = psmouse_process_byte;
-	psmouse->pktsize = 3;
 
-	psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
-
-	sprintf(psmouse->devname, "%s %s %s",
-		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
-
-	psmouse->dev.name = psmouse->devname;
-	psmouse->dev.phys = psmouse->phys;
-	psmouse->dev.id.bustype = BUS_I8042;
-	psmouse->dev.id.vendor = 0x0002;
-	psmouse->dev.id.product = psmouse->type;
-	psmouse->dev.id.version = psmouse->model;
+	psmouse_switch_protocol(psmouse, NULL);
 
 	input_register_device(&psmouse->dev);
-
 	printk(KERN_INFO "input: %s on %s\n", psmouse->devname, serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
@@ -776,6 +906,7 @@ static int psmouse_connect(struct serio 
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
 
+	device_create_file(&serio->dev, &psmouse_attr_protocol);
 	device_create_file(&serio->dev, &psmouse_attr_rate);
 	device_create_file(&serio->dev, &psmouse_attr_resolution);
 	device_create_file(&serio->dev, &psmouse_attr_resetafter);
@@ -914,11 +1045,14 @@ ssize_t psmouse_attr_set_helper(struct d
 		parent = serio_get_drvdata(serio->parent);
 		psmouse_deactivate(parent);
 	}
+
 	psmouse_deactivate(psmouse);
 
 	retval = handler(psmouse, buf, count);
 
-	psmouse_activate(psmouse);
+	if (retval != -ENODEV)
+		psmouse_activate(psmouse);
+
 	if (parent)
 		psmouse_activate(parent);
 
@@ -927,6 +1061,73 @@ out:
 	return retval;
 }
 
+static ssize_t psmouse_attr_show_protocol(struct psmouse *psmouse, char *buf)
+{
+	return sprintf(buf, "%s\n", psmouse_protocol_by_type(psmouse->type)->name);
+}
+
+static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, const char *buf, size_t count)
+{
+	struct serio *serio = psmouse->ps2dev.serio;
+	struct psmouse *parent = NULL;
+	struct psmouse_protocol *proto;
+	int retry = 0;
+
+	if (!(proto = psmouse_protocol_by_name(buf, count)))
+		return -EINVAL;
+
+	if (psmouse->type == proto->type)
+		return count;
+
+	while (serio->child) {
+		if (++retry > 3) {
+			printk(KERN_WARNING "psmouse: failed to destroy child port, protocol change aborted.\n");
+			return -EIO;
+		}
+
+		serio_unpin_driver(serio);
+		serio_unregister_child_port(serio);
+		serio_pin_driver_uninterruptible(serio);
+
+		if (serio->drv != &psmouse_drv)
+			return -ENODEV;
+
+		if (psmouse->type == proto->type)
+			return count; /* switched by other thread */
+	}
+
+	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
+		parent = serio_get_drvdata(serio->parent);
+		if (parent->pt_deactivate)
+			parent->pt_deactivate(parent);
+	}
+
+	if (psmouse->disconnect)
+		psmouse->disconnect(psmouse);
+
+	psmouse_set_state(psmouse, PSMOUSE_IGNORE);
+	input_unregister_device(&psmouse->dev);
+
+	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
+
+	if (psmouse_switch_protocol(psmouse, proto) < 0) {
+		psmouse_reset(psmouse);
+		/* default to PSMOUSE_PS2 */
+		psmouse_switch_protocol(psmouse, &psmouse_protocols[0]);
+	}
+
+	psmouse_initialize(psmouse);
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+
+	input_register_device(&psmouse->dev);
+	printk(KERN_INFO "input: %s on %s\n", psmouse->devname, serio->phys);
+
+	if (parent && parent->pt_activate)
+		parent->pt_activate(parent);
+
+	return count;
+}
+
 static ssize_t psmouse_attr_show_rate(struct psmouse *psmouse, char *buf)
 {
 	return sprintf(buf, "%d\n", psmouse->rate);
@@ -983,34 +1184,26 @@ static ssize_t psmouse_attr_set_resetaft
 
 static int psmouse_set_maxproto(const char *val, struct kernel_param *kp)
 {
-	int i;
+	struct psmouse_protocol *proto;
 
 	if (!val)
 		return -EINVAL;
 
-	if (!strncmp(val, "any", 3)) {
-		*((unsigned int *)kp->arg) = -1U;
-		return 0;
-	}
+	proto = psmouse_protocol_by_name(val, strlen(val));
 
-	for (i = 0; i < ARRAY_SIZE(psmouse_proto_abbrev); i++) {
-		if (!psmouse_proto_abbrev[i])
-			continue;
-
-		if (!strncmp(val, psmouse_proto_abbrev[i], strlen(psmouse_proto_abbrev[i]))) {
-			*((unsigned int *)kp->arg) = i;
-			return 0;
-		}
-	}
+	if (!proto || !proto->maxproto)
+		return -EINVAL;
 
-	return -EINVAL;					\
+	*((unsigned int *)kp->arg) = proto->type;
+
+	return 0;					\
 }
 
 static int psmouse_get_maxproto(char *buffer, struct kernel_param *kp)
 {
-	return sprintf(buffer, "%s\n",
-			psmouse_max_proto < ARRAY_SIZE(psmouse_proto_abbrev) ?
-				psmouse_proto_abbrev[psmouse_max_proto] : "any");
+	int type = *((unsigned int *)kp->arg);
+
+	return sprintf(buffer, "%s\n", psmouse_protocol_by_type(type)->name);
 }
 
 static int __init psmouse_init(void)
