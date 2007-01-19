Return-Path: <linux-kernel-owner+w=401wt.eu-S964933AbXASOts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbXASOts (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 09:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbXASOts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 09:49:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:56153 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964933AbXASOtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 09:49:46 -0500
X-Authenticated: #14842415
From: Alessandro Di Marco <dmr@gmx.it>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] System Inactivity Monitor v1.0
References: <877ivkrv5s.fsf@gmx.it>
	<1169192306.3055.379.camel@laptopd505.fenrus.org>
Date: Fri, 19 Jan 2007 15:49:43 +0100
In-Reply-To: <1169192306.3055.379.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Fri\, 19 Jan 2007 08\:38\:26 +0100")
Message-ID: <87zm8fkr5k.fsf@gmx.it>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Arjan van de Ven <arjan@infradead.org> writes:

   On Thu, 2007-01-18 at 20:29 +0100, Alessandro Di Marco wrote:
   > Hi all,
   >=20
   > this is a new 2.6.20 module implementing a user inactivity trigger. Ba=
sically
   > it acts as an event sniffer, issuing an ACPI event when no user activi=
ty is
   > detected for more than a certain amount of time. This event can be suc=
cessively
   > grabbed and managed by an user-level daemon such as acpid, blanking th=
e screen,
   > dimming the lcd-panel light =E0 la mac, etc...


   Hi,

   why did you chose an ACPI event? I'd expect a uevent (which dbus
   captures etc) to be a more logical choice..

Laziness... :) Just an idea realized in a hurry to dim my laptop panel when=
 it
is in idle (I don't use X11, so no xscreensaver et simila.)=20=20

Anyway I can accommodate it, if someone of you thinks that it is interesting
enough to be carried on the business.

The patch in attachment fixes some silly bugs of the previous version.

Regards,


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=sin-1.2.patch

diff -uN old/procfs.c new/procfs.c
--- old/procfs.c	2007-01-19 15:24:12.000000000 +0100
+++ new/procfs.c	2007-01-19 15:20:26.000000000 +0100
@@ -89,9 +89,19 @@
 	return err;
 }
 
+static int fake_write_proc(struct file *file, const __user char *ubuf,
+			   unsigned long count, void *data)
+{
+	void (*func)(void) = data;
+
+	func();
+	return count;
+}
+
 int start_procfs(void)
 {
-	struct proc_dir_entry *inputd, *acpid, *table, *ilink, *alink;
+	struct proc_dir_entry *inputd, *acpid,
+		*table, *interact, *ilink, *alink;
 
 	int err = -ENOMEM;
 
@@ -159,24 +169,35 @@
 	table->write_proc = write_proc;
 	table->owner = THIS_MODULE;
 
+	interact = create_proc_entry("interact", 0200, rootdir);
+	if (!interact) {
+		goto cleanout9;
+	}
+
+	interact->data = (void *) simulate_interaction;
+	interact->write_proc = fake_write_proc;
+	interact->owner = THIS_MODULE;
+
 	ilink = proc_symlink("sources", rootdir, "input");
 	if (!ilink) {
-		goto cleanout9;
+		goto cleanout10;
 	}
 
 	ilink->owner = THIS_MODULE;
 
 	alink = proc_symlink("destinations", rootdir, "acpi");
 	if (!alink) {
-		goto cleanout10;
+		goto cleanout11;
 	}
 
 	alink->owner = THIS_MODULE;
 
 	return 0;
 
-cleanout10:
+cleanout11:
 	remove_proc_entry("sources", rootdir);
+cleanout10:
+	remove_proc_entry("interact", rootdir);
 cleanout9:
 	remove_proc_entry("table", rootdir);
 cleanout8:
@@ -203,6 +224,7 @@
 {
 	remove_proc_entry("destinations", rootdir);
 	remove_proc_entry("sources", rootdir);
+	remove_proc_entry("interact", rootdir);
 	remove_proc_entry("table", rootdir);
 	remove_proc_entry("acpi", rootdir);
 	remove_proc_entry("input", rootdir);
diff -uN old/sin.c new/sin.c
--- old/sin.c	2007-01-19 15:24:12.000000000 +0100
+++ new/sin.c	2007-01-19 15:20:26.000000000 +0100
@@ -34,7 +34,7 @@
 
 MODULE_ALIAS("blanker");
 
-MODULE_VERSION("1.0");
+MODULE_VERSION("1.2");
 
 static struct acpi_device *acpi_device;
 
@@ -49,13 +49,18 @@
 static DEFINE_MUTEX(runlock);
 static int running;
 
-static void event(struct input_handle *handle,
-		  unsigned int type, unsigned int code, int value)
+inline void signal_interaction(void)
 {
 	if (unlikely(test_and_clear_bit(0, &notify))) {
 		clear_bit(1, &notify);
 		occasionally_generate_event(acpi_device);
 	}
+}
+
+static void event(struct input_handle *handle,
+		  unsigned int type, unsigned int code, int value)
+{
+	signal_interaction();
 
 	atomic_inc(&interactions);
 }
@@ -166,8 +171,13 @@
 	if (running) {
 		shutdown = 1;
 		del_timer_sync(&timer);
+
 		input_unregister_handler(&ih);
 		kfree(ih.id_table);
+
+		signal_interaction();
+		cleanup_table();
+
 		running = 0;
 	}
 
@@ -176,14 +186,14 @@
 
 static int __init sih_init(void)
 {
-	printk("System Inactivity Notifier 1.0 - (c) Alessandro Di Marco <dmr@c0nc3pt.com>\n");
+	printk("System Inactivity Notifier 1.2 - (c) Alessandro Di Marco <dmr@c0nc3pt.com>\n");
 	return start_procfs();
 }
 
 static void __exit sih_exit(void)
 {
 	stop_procfs();
-	stop_monitor();
+	(void) stop_monitor();
 }
 
 module_init(sih_init);
diff -uN old/sin.h new/sin.h
--- old/sin.h	2007-01-19 15:24:12.000000000 +0100
+++ new/sin.h	2007-01-19 15:20:26.000000000 +0100
@@ -26,6 +26,8 @@
 
 #define MODULE_NAME "sin"
 
+extern void signal_interaction(void);
+
 extern int start_monitor(char *ids, struct input_device_id *idi, unsigned long pace);
 extern void stop_monitor(void);
 
diff -uN old/table.c new/table.c
--- old/table.c	2007-01-19 15:24:12.000000000 +0100
+++ new/table.c	2007-01-19 15:20:26.000000000 +0100
@@ -32,7 +32,7 @@
 #include "acpi_enumerator.h"
 
 static struct table rt;
-static int debug;
+static int counter, action;
 
 /*
  * WARNING: sonypi, buttons and others issue a spurious event when removed from
@@ -42,7 +42,7 @@
 
 void occasionally_generate_event(struct acpi_device *acpi_device)
 {
-	if (unlikely(debug)) {
+	if (unlikely(rt.debug)) {
 		printk("generating special event [%d, %d]\n",
 		       rt.rules[rt.rnum].type, rt.rules[rt.rnum].data);
 	}
@@ -54,17 +54,15 @@
 void timely_generate_event(struct acpi_device *acpi_device,
 			   int interactions, unsigned long *notify)
 {
-	static int counter, action;
-
 	if (interactions && counter) {
-		if (unlikely(debug)) {
+		if (unlikely(rt.debug)) {
 			printk("user activity detected, counter reset!\n");
 		}
 
 		counter = action = 0;
 	}
 
-	if (unlikely(debug)) {
+	if (unlikely(rt.debug)) {
 		printk("global counter %d, next rule is [%d %d %d]\n",
 		       counter,
 		       rt.rules[action].counter,
@@ -73,7 +71,7 @@
 	}
 
 	while (action < rt.rnum && rt.rules[action].counter == counter) {
-		if (unlikely(debug)) {
+		if (unlikely(rt.debug)) {
 			printk("generating event [%d, %d]\n",
 			       rt.rules[action].type,
 			       rt.rules[action].data);
@@ -87,7 +85,7 @@
 	}
 
 	if (rt.raction >= 0 && action == rt.rnum) {
-		if (unlikely(debug)) {
+		if (unlikely(rt.debug)) {
 			printk("last rule reached, restarting from %d\n",
 			       rt.rcounter);
 		}
@@ -101,6 +99,12 @@
 	}
 }
 
+void simulate_interaction(void)
+{
+	signal_interaction();
+	counter = action = 0;
+}
+
 #define parse_num(endp) ({				\
 			char *cp = endp;		\
 							\
@@ -129,6 +133,7 @@
 
 int push_table(char *buf, unsigned long count)
 {
+	struct table nrt;
 	struct input_device_id *idi;
 	struct uniq uniq;
 	int devices;
@@ -137,25 +142,25 @@
 
 	devices = get_devices();
 
-	debug = parse_num(buf);
+	nrt.debug = parse_num(buf);
 
-	rt.pace = (parse_num(buf) * HZ) / 10;
-	rt.dnum = parse_num(buf);
-	rt.rnum = parse_num(buf);
+	nrt.pace = (parse_num(buf) * HZ) / 10;
+	nrt.dnum = parse_num(buf);
+	nrt.rnum = parse_num(buf);
 
-	if (out_of_range(1, rt.pace, 1000000) ||
-	    out_of_range(0, rt.dnum, devices)) {
+	if (out_of_range(1, nrt.pace, 1000000) ||
+	    out_of_range(0, nrt.dnum, devices)) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	rt.devices = kmalloc(rt.dnum * sizeof (int), GFP_KERNEL);
-	if (!rt.devices) {
+	nrt.devices = kmalloc(nrt.dnum * sizeof (int), GFP_KERNEL);
+	if (!nrt.devices) {
 		goto out;
 	}
 
-	rt.rules = kmalloc((rt.rnum + 1) * sizeof (struct rule), GFP_KERNEL);
-	if (!rt.rules) {
+	nrt.rules = kmalloc((nrt.rnum + 1) * sizeof (struct rule), GFP_KERNEL);
+	if (!nrt.rules) {
 		goto cleanout1;
 	}
 
@@ -163,69 +168,76 @@
 		goto cleanout2;
 	}
 
-	for (i = 0; i < rt.dnum; i++) {
-		rt.devices[i] = parse_num(buf);
-		if (uniq_check(&uniq, rt.devices[i])) {
+	for (i = 0; i < nrt.dnum; i++) {
+		nrt.devices[i] = parse_num(buf);
+		if (uniq_check(&uniq, nrt.devices[i])) {
 			break;
 		}
 	}
 
 	uniq_free(&uniq);
 
-	if (i < rt.dnum) {
+	if (i < nrt.dnum) {
 		err = -EINVAL;
 		goto cleanout2;
 	}
 
-	rt.handle = parse_num(buf);
-	if (out_of_range(0, rt.handle, get_handlers())) {
+	nrt.handle = parse_num(buf);
+	if (out_of_range(0, nrt.handle, get_handlers())) {
 		err = -EINVAL;
 		goto cleanout2;
 	}
 
-	rt.rcounter = parse_num(buf);
+	nrt.rcounter = parse_num(buf);
 
-	rt.rules[rt.rnum].counter = -1;
-	rt.rules[rt.rnum].type = parse_num(buf);
-	rt.rules[rt.rnum].data = parse_num(buf);
-
-	for (i = 0; i < rt.rnum; i++) {
-		rt.rules[i].counter = parse_num(buf);
-		if (rt.rules[i].counter < 0) {
+	nrt.rules[nrt.rnum].counter = -1;
+	nrt.rules[nrt.rnum].type = parse_num(buf);
+	nrt.rules[nrt.rnum].data = parse_num(buf);
+
+	for (i = 0; i < nrt.rnum; i++) {
+		nrt.rules[i].counter = parse_num(buf);
+		if (nrt.rules[i].counter < 0) {
 			err = -EINVAL;
 			goto cleanout2;
 		}
 
-		rt.rules[i].type = parse_num(buf);
-		rt.rules[i].data = parse_num(buf);
+		nrt.rules[i].type = parse_num(buf);
+		nrt.rules[i].data = parse_num(buf);
 	}
 
-	sort(rt.rules, rt.rnum, sizeof (struct rule), cmp, swap);
+	sort(nrt.rules, nrt.rnum, sizeof (struct rule), cmp, swap);
 
-	rt.raction = -1;
+	nrt.raction = -1;
 
-	if (rt.rcounter >= 0) {
-		for (i = 0; i < rt.rnum; i++) {
-			if (rt.rules[i].counter >= rt.rcounter) {
-				rt.raction = i;
+	if (nrt.rcounter >= 0) {
+		for (i = 0; i < nrt.rnum; i++) {
+			if (nrt.rules[i].counter >= nrt.rcounter) {
+				nrt.raction = i;
 				break;
 			}
 		}
 	}
 
+	if (!tablecmp(&rt, &nrt)) {
+		err = count;
+		goto cleanout2;
+	}
+
 	stop_monitor();
 
-	idi = kzalloc((rt.dnum + 1) *
+	idi = kzalloc((nrt.dnum + 1) *
 		      sizeof (struct input_device_id), GFP_KERNEL);
 	if (!idi) {
 		goto cleanout2;
 	}
 
-	for (i = 0; i < rt.dnum; i++) {
-		fill_input_device(&idi[i], rt.devices[i]);
+	for (i = 0; i < nrt.dnum; i++) {
+		fill_input_device(&idi[i], nrt.devices[i]);
 	}
 
-	err = start_monitor(get_hardware_id(rt.handle), idi, rt.pace);
+	memcpy(&rt, &nrt, sizeof (struct table));
+
+	err = start_monitor(get_hardware_id(rt.handle), idi, nrt.pace);
 	if (err < 0) {
 		goto cleanout3;
 	}
@@ -235,9 +247,9 @@
 cleanout3:
 	kfree(idi);
 cleanout2:
-	kfree(rt.rules);
+	kfree(nrt.rules);
 cleanout1:
-	kfree(rt.devices);
+	kfree(nrt.devices);
 out:
 	return err;
 }
@@ -252,7 +264,7 @@
 		return -EFAULT;
 	}
 
-	b += sprintf(b, "%d\n%lu\n%d %d\n", debug,
+	b += sprintf(b, "%d\n%lu\n%d %d\n", rt.debug,
 		     (rt.pace * 10) / HZ, rt.dnum, rt.rnum);
 
 	for (i = 0; i < rt.dnum; i++) {
@@ -272,3 +284,12 @@
 
 	return b - *buf;
 }
+
+void cleanup_table(void)
+{
+	kfree(rt.devices);
+	kfree(rt.rules);
+	memset(&rt, 0, sizeof (struct table));
+
+	counter = action = 0;
+}
diff -uN old/table.h new/table.h
--- old/table.h	2007-01-19 15:24:12.000000000 +0100
+++ new/table.h	2007-01-19 15:20:26.000000000 +0100
@@ -31,6 +31,7 @@
 };
 
 struct table {
+	int debug;
 	unsigned long pace;
 	int dnum, rnum;
 	int *devices;
@@ -39,6 +40,28 @@
 	struct rule *rules;
 };
 
+static inline int tablecmp(struct table *l, struct table *r)
+{
+	if (l->debug != r->debug ||
+	    l->pace != r->pace ||
+	    l->dnum != r->dnum ||
+	    l->handle != r->handle ||
+	    l->rcounter != r->rcounter ||
+	    l->raction != r->raction) {
+		return 1;
+	}
+
+	if (memcmp(l->devices, r->devices, l->dnum * sizeof (int))) {
+		return 1;
+	}
+
+	if (memcmp(l->rules, r->rules, l->rnum * sizeof (struct rule))) {
+		return 1;
+	}
+
+	return 0;
+}
+
 #define TABLE_SIZE (sizeof (struct table) - 2 * sizeof (void *)	  \
 		    + rt.dnum * sizeof (int)			  \
 		    + rt.rnum * sizeof (struct rule))
@@ -48,7 +71,10 @@
 extern void occasionally_generate_event(struct acpi_device *acpi_device);
 extern void timely_generate_event(struct acpi_device *acpi_device, int interactions, unsigned long *notify);
 
+void simulate_interaction(void);
+
 extern int push_table(char *buf, unsigned long count);
 extern int pull_table(char **buf);
+extern void cleanup_table(void);
 
 #endif /* TABLE_H */

--=-=-=


-- 
Ethics is not definable, is not implementable, because it is not conscious; it
involves not only our thinking, but also our feeling. - Valdemar W. Setzer

--=-=-=--
