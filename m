Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263692AbUFBRZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbUFBRZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUFBRZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:25:10 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:58814 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263692AbUFBRYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:24:44 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aeb@cwi.nl>
Subject: [PATCH] serio.c: dynamically control serio ports bindings via procfs (Was: [RFC/RFT] Raw access to serio ports)
References: <xb7d64i5lxb.fsf@savona.informatik.uni-freiburg.de>
	<200406020733.22737.dtor_core@ameritech.net>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 02 Jun 2004 19:24:36 +0200
In-Reply-To: <200406020733.22737.dtor_core@ameritech.net>
Message-ID: <xb74qpt6ffv.fsf_-_@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:

    Dmitry> On Wednesday 02 June 2004 04:49 am, Sau Dan Lee wrote:

    >>  So, only AUX ports can be directly accessed?  No direct access
    >> to keyboard port?  Why?

    Dmitry> Keyboards are to be handled in-kernel, at least for
    Dmitry> now. If there really a need we can enable grabbing
    Dmitry> keyboard as well, no big deal.

My new patch should  be able to connect the PC AT  or PS/2 keyboard to
your serio_raw thing.  See below.


    >> 2) I hate this black magic, in which the input "devices"
    >> (i.e. drivers) kidnap the serio ports they like according to
    >> the port type SERIO_8042_RAW, etc.  That's a kind of hardcoding
    >> the binding between ports and drivers.

    Dmitry> We do have some hardcoding so atkbd does not try to grab a
    Dmitry> serio linked to a serial port and sermouse does not try
    Dmitry> grabbing keyboard port, etc..  There is nothing new.

Of course, it is completely OK  for the serio device code to check the
serio port type, and refuse to work with incompatible ports.  However,
that  doesn't mean  it  should rob  all  the ports  it likes.   That's
selfish.  There could be other  serio devices that are also interested
in the  same kinds of ports  as yours!  Loving  chocolate doesn't mean
you should  steal all the  chocolates in the  world and eat  them all.
Learn to share!  :)

======================================================================

I've  added procfs  support to  serio.c, so  that we  can  now control
dynamically which serio ports connect  to which serio devices.  I call
it "serio_switch", because it conceptually works like a patch panel or
a switch with which you can rewire the connections.

If  you  ignore  this feature,  that  it  work  as in  vanilla  2.6.*.
However,  you can  now  go to  /proc/bus/input/serio_switch/ and  look
around.   There   are  2   directories  there:  "ports/"   with  files
representing  all registered  serio port.   Each file  is a  r/w file.
Upon reading,  it shows  the "name"  of the serio  device which  it is
connected to, or  "(unconnected)".  Write to it the  "name" of a serio
device, and that port will be connected to the device.  The write will
fail with a  kernel log message if the device name  is invalid, or the
device REFUSES  to connected to  the port (e.g. connecting  'atkbd' to
the  AUX port  attached to  a  mouse), leaving  the port  unconnected.
Write "(unconnected)" or  simply "" to the file, and  the port will be
disconnected.   (Feature: "cat  port_file  > port_file"  will cause  a
disconnection followed immediately by a connection!)

The other directory is "devices/",  with one file per registered serio
device.  "cat"  the file and  you see the  names of serio ports  it is
handling.  The file is read-only.


Problem: the  modules providing serio  devices do not  appropriate set
the name  field in the  struct serio_dev.  So,  my patch cannot  get a
meaningful serio  device name.   Right now, the  code checks  for this
problem,  and would  manufacture  a (hopefully  unique)  name for  the
device.   Once the  modules are  fixed  w.r.t. this  issue, the  serio
device names will be more user-friendly.



I think the same thing would be useful for input.c.  I choose to do it
for serio.c because it is  simpler (serio_port -> serio_device is 1->n
mapping), and because  it is a module.  (I can't  compile input.c as a
module unless I give up virtual terminals.)  It is useful for input.c,
because when debugging  input modules, it'd be better  to have 'evbug'
to monitor *only* the device being debugged.
 


    >> Isn't it better to leave the AUX ports as SERIO_8042, and let
    >> the user dynamically change this port<-->driver binding?  Then,
    >> we don't even need that ugly "i8042.raw" boot parameter or
    >> i8042_aux_raw option.  The user can decide which ports are
    >> connected to your serio_raw driver, and which ports are
    >> connected to psmouse.ko.  That would also allow multiple
    >> drivers driving the ports of the same type.
    >> 

    Dmitry> Yes, that's the perfect solution, but I believe we need
    Dmitry> sysfs for that and at least I started working on it, but
    Dmitry> it takes time. 

I've been studying and experimenting  with sysfs and kobject for a few
hours.  But  I'm still  so confused  that I decided  to go  the procfs
route.  At least, I can code it with procfs in a few hours.


    Dmitry> In the meantime i8042.raw should alleviate most of the
    Dmitry> user's troubles with their input devices no longer
    Dmitry> working.

Use my patch!   :D With my patch, it should be  possible to rewire any
serio port to your raw-device.  Instead of your i8042.raw option, It'd
be better to  have a "manual_connect" option that  tells the module to
refrain from  connecting to any devices upon  module loading.  Without
this option, it works like before: hunt for all its favourite preys.



Finally, here is  the patch.  It is based on  2.6.7-rc1.  (But I don't
think anything has changed in serio.c since 2.6.0.)

I actually developed this  patch upon a SERIO_USERDEV-patched version.
So, Tuukka, if  you want it, I  can give a patch on  patch.  Thanks to
the tool  'patch' with the  -F option and  rcsdiff, it took me  only 5
minutes to backport the changes to the serio.c in stock 2.6.7-rc1.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=serio_switch.patch
Content-Description: patch against 2.6.7-rc1

--- linux-2.6.7-rc1/drivers/input/serio/serio.c	2004/06/02 16:47:33	1.1.1.1
+++ linux-2.6.7-rc1.serio_switch/drivers/input/serio/serio.c	2004/06/02 16:55:34	1.1.1.2
@@ -35,20 +35,22 @@
 #include <linux/stddef.h>
 #include <linux/module.h>
 #include <linux/serio.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/completion.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/suspend.h>
 #include <linux/slab.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Serio abstraction core");
 MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(serio_interrupt);
 EXPORT_SYMBOL(serio_register_port);
 EXPORT_SYMBOL(serio_register_port_delayed);
 EXPORT_SYMBOL(__serio_register_port);
 EXPORT_SYMBOL(serio_unregister_port);
@@ -66,20 +68,26 @@
 	struct serio *serio;
 	struct list_head node;
 };
 
 static DECLARE_MUTEX(serio_sem);
 static LIST_HEAD(serio_list);
 static LIST_HEAD(serio_dev_list);
 static LIST_HEAD(serio_event_list);
 static int serio_pid;
 
+#ifdef CONFIG_PROC_FS
+static struct proc_dir_entry *proc_bus_input_ss_dir;
+static struct proc_dir_entry *proc_bus_input_ss_ports_dir;
+static struct proc_dir_entry *proc_bus_input_ss_devices_dir;
+#endif
+
 static void serio_find_dev(struct serio *serio)
 {
 	struct serio_dev *dev;
 
 	list_for_each_entry(dev, &serio_dev_list, node) {
 		if (serio->dev)
 			break;
 		if (dev->connect)
 			dev->connect(serio, dev);
 	}
@@ -215,28 +223,50 @@
 /*
  * Submits register request to kseriod for subsequent execution.
  * Can be used when it is not obvious whether the serio_sem is
  * taken or not and when delayed execution is feasible.
  */
 void serio_register_port_delayed(struct serio *serio)
 {
 	serio_queue_event(serio, SERIO_REGISTER_PORT);
 }
 
+#ifdef CONFIG_PROC_FS
+static 
+int serio_switch_port_proc_file_read(char *page, char **start, off_t off,
+				     int count, int *eof, void *data);
+static
+int serio_switch_port_proc_file_write(struct file *file,
+				      const char __user *buffer,
+				      unsigned long count, void *data);
+#endif
+
 /*
  * Should only be called directly if serio_sem has already been taken,
  * for example when unregistering a serio from other input device's
  * connect() function.
  */
 void __serio_register_port(struct serio *serio)
 {
 	list_add_tail(&serio->node, &serio_list);
+
+#ifdef CONFIG_PROC_FS
+	if (proc_bus_input_ss_ports_dir) {
+		struct proc_dir_entry *proc_entry;
+
+		proc_entry = create_proc_read_entry(serio->name, S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH, proc_bus_input_ss_ports_dir,
+						    serio_switch_port_proc_file_read, serio);
+		proc_entry->owner = THIS_MODULE;
+		proc_entry->write_proc = serio_switch_port_proc_file_write;
+	}
+#endif
+
 	serio_find_dev(serio);
 }
 
 void serio_unregister_port(struct serio *serio)
 {
 	down(&serio_sem);
 	__serio_unregister_port(serio);
 	up(&serio_sem);
 }
 
@@ -251,40 +281,85 @@
 }
 
 /*
  * Should only be called directly if serio_sem has already been taken,
  * for example when unregistering a serio from other input device's
  * disconnect() function.
  */
 void __serio_unregister_port(struct serio *serio)
 {
 	serio_invalidate_pending_events(serio);
+#ifdef CONFIG_PROC_FS
+	if (proc_bus_input_ss_ports_dir) {
+		remove_proc_entry(serio->name, proc_bus_input_ss_ports_dir);
+	}
+#endif
 	list_del_init(&serio->node);
 	if (serio->dev && serio->dev->disconnect)
 		serio->dev->disconnect(serio);
 }
 
+#ifdef CONFIG_PROC_FS
+static 
+int serio_switch_device_proc_file_read(char *page, char **start, off_t off,
+				       int count, int *eof, void *data);
+#endif
+
 void serio_register_device(struct serio_dev *dev)
 {
 	struct serio *serio;
 	down(&serio_sem);
 	list_add_tail(&dev->node, &serio_dev_list);
 	list_for_each_entry(serio, &serio_list, node)
 		if (!serio->dev && dev->connect)
 			dev->connect(serio, dev);
 	up(&serio_sem);
+
+#ifdef CONFIG_PROC_FS
+	if (!dev->name) {
+	  /* some modules do not set the dev->name!  :( */
+	  dev->name = kmalloc(16, GFP_KERNEL);
+	  if (!dev->name)
+	  	dev->name = "out of memory";
+	  else
+	  	snprintf(dev->name, 16, "xx%p", dev);
+	}
+
+	if (proc_bus_input_ss_devices_dir) {
+		struct proc_dir_entry *proc_entry;
+
+		proc_entry = create_proc_read_entry(dev->name, 0, proc_bus_input_ss_devices_dir,
+						    serio_switch_device_proc_file_read, dev);
+		proc_entry->owner = THIS_MODULE;
+	}
+#endif
 }
 
 void serio_unregister_device(struct serio_dev *dev)
 {
 	struct serio *serio;
 
+#ifdef CONFIG_PROC_FS
+	if (proc_bus_input_ss_devices_dir) {
+		remove_proc_entry(dev->name, proc_bus_input_ss_devices_dir);
+	}
+
+	if (dev->name[0] == 'x' && dev->name[1] == 'x') {
+		/* assume this name was generated by us */
+		kfree(dev->name);
+		dev->name = NULL;
+	} else if (strcpy(dev->name, "out of memory")==0) {
+		/* couldn't kmalloc */
+		dev->name = NULL;
+	}
+#endif
+
 	down(&serio_sem);
 	list_del_init(&dev->node);
 
 	list_for_each_entry(serio, &serio_list, node) {
 		if (serio->dev == dev && dev->disconnect)
 			dev->disconnect(serio);
 		serio_find_dev(serio);
 	}
 	up(&serio_sem);
 }
@@ -300,34 +375,218 @@
 	return 0;
 }
 
 /* called from serio_dev->connect/disconnect methods under serio_sem */
 void serio_close(struct serio *serio)
 {
 	serio->close(serio);
 	serio->dev = NULL;
 }
 
+
+#ifdef CONFIG_PROC_FS
+static
+struct proc_dir_entry *get_proc_bus_input(void)
+{
+	struct proc_dir_entry *entry;
+	for (entry = proc_bus->subdir; entry; entry = entry->next)
+		if (strcmp(entry->name, "input")==0) {
+			return entry;
+		}
+	return NULL;
+}
+#endif
+
+#ifdef CONFIG_PROC_FS
+static 
+int serio_switch_port_proc_file_read(char *page, char **start, off_t off,
+				     int count, int *eof, void *data)
+{
+	struct serio *serio = data;
+	struct serio_dev *dev = serio->dev;
+	int len, c;
+
+	if (!dev)
+		strcpy(page, "(unconnected)\n");
+	else
+	  	strcat(strcpy(page, dev->name), "\n");
+
+	len = strlen(page);
+	c = len - off;
+	if (c<0) c = 0;
+	*start = page + off;
+	*eof = 1;
+	return count<c? count : c;
+}
+
+static
+int serio_switch_port_proc_file_write(struct file *file,
+				      const char __user *ubuffer,
+				      unsigned long count, void *data)
+{
+	struct serio *serio = data;
+	unsigned char *kbuffer;
+	int r;
+  
+	kbuffer = kmalloc(count+1, GFP_KERNEL);
+	if (!kbuffer) return -ENOMEM;
+	r=copy_from_user(kbuffer, ubuffer, count);
+	if (r) goto out;
+	kbuffer[count] = '\0';
+	if (kbuffer[count-1] == '\n') /* tolerate an EOL */
+		kbuffer[count-1] = '\0';
+
+	if (strlen(kbuffer)==0 ||
+	    strcmp(kbuffer, "(unconnected)")==0) { /* disconnect */
+		if (serio->dev && serio->dev->disconnect)
+			serio->dev->disconnect(serio);
+		goto success;
+	} else {
+		/* find the device to connect to */
+		struct serio_dev *dev;
+
+		down(&serio_sem);
+		list_for_each_entry(dev, &serio_dev_list, node) {
+			if (strcmp(kbuffer, dev->name) != 0)
+				continue; /* not match */
+
+			/* found */
+
+			/* disconnect old connect first */
+			if (serio->dev && serio->dev->disconnect)
+				serio->dev->disconnect(serio);
+
+			/* now, connect to the found device */
+			if (dev->connect)
+				dev->connect(serio, dev);
+
+			up(&serio_sem);
+			if (serio->dev == dev)
+				goto success; /* done */
+			else {
+				printk(KERN_ERR "Inappropriate serio device '%s'\n", kbuffer);
+				r = -EINVAL;
+				goto out;
+			}
+		}
+		up(&serio_sem);
+
+		/* not found */
+		printk(KERN_ERR "Bad serio device '%s'\n", kbuffer);
+		r = -EINVAL;
+		goto out;
+	}
+success:
+	r = count;
+out:
+	kfree(kbuffer);
+	return r;
+}
+
+
+static 
+int serio_switch_device_proc_file_read(char *page, char **start, off_t off,
+				       int count, int *eof, void *data)
+{
+	struct serio_dev *dev = data;
+	struct serio *serio;
+	int len, cnt = 0;
+	off_t at = 0;
+
+	down(&serio_sem);
+	list_for_each_entry(serio, &serio_list, node) {
+		if (serio->dev != dev)
+			continue;
+		len = sprintf(page, "%s\n", serio->name);
+		at += len;
+
+		if (at >= off) {
+			if (!*start) {
+				*start = page + (off - (at - len));
+				cnt = at - off;
+			} else  cnt += len;
+			page += len;
+			if (cnt >= count)
+				break;
+		}
+	}
+
+	if (&serio->node == &serio_list)
+		*eof = 1;
+	up(&serio_sem);
+
+	return (count > cnt) ? cnt : count;
+}
+#endif
+
+
 static int __init serio_init(void)
 {
 	int pid;
 
 	pid = kernel_thread(serio_thread, NULL, CLONE_KERNEL);
 
 	if (!pid) {
 		printk(KERN_WARNING "serio: Failed to start kseriod\n");
 		return -1;
 	}
 
 	serio_pid = pid;
 
+#ifdef CONFIG_PROC_FS
+	{
+		struct proc_dir_entry *proc_bus_input_dir = get_proc_bus_input();
+		if (proc_bus_input_dir) {
+			proc_bus_input_ss_dir = proc_mkdir("serio_switch", proc_bus_input_dir);
+			if (proc_bus_input_ss_dir) {
+				proc_bus_input_ss_dir->owner = THIS_MODULE;
+
+				proc_bus_input_ss_ports_dir = proc_mkdir("ports", proc_bus_input_ss_dir);
+				if (proc_bus_input_ss_ports_dir)
+					proc_bus_input_ss_ports_dir->owner = THIS_MODULE;
+				else
+					printk(KERN_WARNING "/proc/bus/input/serio/ports/ cannot be created\n");
+
+				proc_bus_input_ss_devices_dir = proc_mkdir("devices", proc_bus_input_ss_dir);
+				if (proc_bus_input_ss_devices_dir)
+					proc_bus_input_ss_devices_dir->owner = THIS_MODULE;
+				else
+					printk(KERN_WARNING "/proc/bus/input/serio/devices/ cannot be created\n");
+			} else {
+				printk(KERN_WARNING "/proc/bus/input/serio/ cannot be created\n");
+			}
+		} else {
+			printk(KERN_WARNING "/proc/bus/input/ not found\n");
+		}
+	}
+#endif
+
 	return 0;
 }
 
 static void __exit serio_exit(void)
 {
+#ifdef CONFIG_PROC_FS
+	{
+		if (proc_bus_input_ss_devices_dir) {
+			proc_bus_input_ss_devices_dir->owner = NULL;
+			remove_proc_entry(proc_bus_input_ss_devices_dir->name,
+					  proc_bus_input_ss_devices_dir->parent);
+		}
+		if (proc_bus_input_ss_ports_dir) {
+			proc_bus_input_ss_ports_dir->owner = NULL;
+			remove_proc_entry(proc_bus_input_ss_ports_dir->name,
+					  proc_bus_input_ss_ports_dir->parent);
+		}
+		if (proc_bus_input_ss_dir) {
+			proc_bus_input_ss_dir->owner = NULL;
+			remove_proc_entry(proc_bus_input_ss_dir->name,
+					  proc_bus_input_ss_dir->parent);
+		}
+	}
+#endif
 	kill_proc(serio_pid, SIGTERM, 1);
 	wait_for_completion(&serio_exited);
 }
 
 module_init(serio_init);
 module_exit(serio_exit);

--=-=-=
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable




--=20
Sau Dan LEE                     =A7=F5=A6u=B4=B0(Big5)                    ~=
{@nJX6X~}(HZ)=20

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

--=-=-=--

