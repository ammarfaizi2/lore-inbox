Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271808AbTG2PSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271814AbTG2PSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:18:14 -0400
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:17932 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP id S271808AbTG2PRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:17:04 -0400
Date: Tue, 29 Jul 2003 16:17:03 +0100
From: Philip Graham Willoughby <pgw99@doc.ic.ac.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030729151701.GA6795@bodmin.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch adds an abstraction layer for programmable LED devices,
hardware drivers for the Status LEDs found on some Intel PIIX4E based
server hardware (notably the ISP1100 1U rackmount server) and LEDs wired
to the parallel port data lines.

It also includes a kernel-space heartbeat module and a module to monitor
a user-space program, both of which will flash an LED while the system
is happy.

I'm sorry for not involving all of you earlier, but I had to obtain the
permission of my boss to GPL this, and he was out of the country.

This patch is against the 2.4 series (specifically 2.4.21, but it should
apply against any 2.4) -- the code part of the patch is fine on 2.[56] but
the config stuff obviously needs changing.

The user-level software for this can be downloaded from
http://csgsoft.doc.ic.ac.uk/leds/

Please cc me on replies as I'm only on the digest list...

Regards,

Philip Willoughby
Systems Programmer, Department of Computing, Imperial College, London, UK


diff -uNr linux-2.4.21.vanilla/arch/i386/config.in linux-2.4.21.patched/arch/i386/config.in
--- linux-2.4.21.vanilla/arch/i386/config.in	2003-07-17 17:06:01.000000000 +0100
+++ linux-2.4.21.patched/arch/i386/config.in	2003-07-29 15:28:17.000000000 +0100
@@ -485,3 +485,4 @@
 endmenu
 
 source lib/Config.in
+source drivers/leds/Config.in
diff -uNr linux-2.4.21.vanilla/Documentation/Configure.help linux-2.4.21.patched/Documentation/Configure.help
--- linux-2.4.21.vanilla/Documentation/Configure.help	2003-07-17 17:07:00.000000000 +0100
+++ linux-2.4.21.patched/Documentation/Configure.help	2003-07-29 15:28:17.000000000 +0100
@@ -26649,6 +26649,53 @@
 CONFIG_IPMI_WATCHDOG
   This enables the IPMI watchdog timer.
 
+LED Subsystem Support
+CONFIG_LEDS
+  Enables support for LED devices.
+
+Intel PIIX4E LED Support
+CONFIG_PIIX4E_LEDS
+  Enables support for the programmable LEDs on some Intel PIIX4E-based
+  mainboards.  One such board is contained in the Intel ISP1100
+  server.  If you don't have an Intel PIIX4E this driver will do
+  nothing.  On boards with the LEDs unconnected, this driver _should_
+  do no harm, but I have not been able to test it on all such boards.
+  It should be safe to load this driver (Y or M) on all machines, if
+  you find a problem, please contact me:
+
+  Philip Willoughby <pgw@alumni.doc.ic.ac.uk>
+
+  Put "PIIX4E LED BUG" in the subject line please.
+
+Parallel Port LED Support
+CONFIG_PARPORT_LEDS
+  Enables support for a bank of 8 LEDs connected to the parallel port.
+  These devices are extremely simple and cannot be autodetected.  I
+  recommend you do not load this driver unless you are sure you have
+  such a device attached.  Say N here unless you really know what
+  you're doing.
+
+Kernel Heartbeat LED
+CONFIG_KBEAT_LED
+  Enables a kernel-resident piece of code which will toggle the status
+  of a LED twice per second.  Useful as a liveness indicator.  This
+  will do nothing if you do not have any LED hardware drivers loaded.
+
+  If you build this code as a module, you can tune the flash interval
+  with module parameters.
+
+User Heartbeat
+CONFIG_UBEAT
+  Enables a kernel-resident piece of code which monitors a user daemon
+  (ubeatd).  While the user-level code is working fine, a LED will
+  flash.  In the event of a failure, a message will be logged through
+  the normal kernel logging facilities.
+
+  If you have no LED hardware, this code will still work -- no LEDs
+  will flash, but the failure message will still work.
+
+  ubeatd can be downloaded from http://csgsoft.doc.ic.ac.uk/leds/
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,
diff -uNr linux-2.4.21.vanilla/drivers/leds/Config.in linux-2.4.21.patched/drivers/leds/Config.in
--- linux-2.4.21.vanilla/drivers/leds/Config.in	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.21.patched/drivers/leds/Config.in	2003-07-29 15:28:17.000000000 +0100
@@ -0,0 +1,21 @@
+#
+# LED device configuration
+#
+mainmenu_option next_comment
+comment 'LED Subsystem'
+
+tristate 'LED Subsystem Support' CONFIG_LEDS
+if [ "$CONFIG_LEDS" != "n" ]; then
+comment 'LED hardware drivers'
+  if [ "$CONFIG_X86" = "y" -a "$CONFIG_X86_64" != "y" ]; then
+    dep_tristate 'Intel PIIX4E LED Support' CONFIG_PIIX4E_LEDS $CONFIG_LEDS
+  fi
+  if [ "$CONFIG_PARPORT" != "n" ]; then
+    dep_tristate 'Parallel Port LED Support (Read Help)' CONFIG_PARPORT_LEDS $CONFIG_LEDS $CONFIG_PARPORT
+  fi
+comment 'LED-using software'
+  dep_tristate 'Kernel Heartbeat LED' CONFIG_KBEAT_LED $CONFIG_LEDS
+  dep_tristate 'User Heartbeat' CONFIG_UBEAT $CONFIG_LEDS
+fi
+
+endmenu
diff -uNr linux-2.4.21.vanilla/drivers/leds/kbeat_led.c linux-2.4.21.patched/drivers/leds/kbeat_led.c
--- linux-2.4.21.vanilla/drivers/leds/kbeat_led.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.21.patched/drivers/leds/kbeat_led.c	2003-07-22 14:05:54.000000000 +0100
@@ -0,0 +1,58 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+
+static unsigned int kbeat_led;
+static unsigned char kbeat_state = 0;
+
+static struct timer_list kbeat_timer;
+static unsigned int kbeat_stps __initdata = 2;
+static unsigned int kbeat_interval = HZ/2;
+
+static void
+kbeat_beat (unsigned long GoOnGccWarnMeThen)
+{
+  kbeat_state = ~kbeat_state;
+  led_set (kbeat_led, kbeat_state, THIS_MODULE);
+  /* init_timer(&kbeat_timer); */
+  kbeat_timer.expires=jiffies + kbeat_interval;
+  kbeat_timer.function=kbeat_beat;
+  add_timer(&kbeat_timer);
+}
+
+void __exit
+kbeat_exit(void)
+{
+  del_timer_sync (&kbeat_timer);
+  led_release(kbeat_led, THIS_MODULE);
+}
+
+int __init
+kbeat_init(void)
+{
+  if (led_reserve(&kbeat_led, THIS_MODULE) == 0)
+  {
+    printk(KERN_INFO "kbeat_led: got LED %.8x\n", kbeat_led);
+    if ((kbeat_stps <= 0) || ((kbeat_interval = HZ/kbeat_stps) == 0))
+      kbeat_interval = HZ/2;
+    init_timer(&kbeat_timer);
+    kbeat_timer.expires=jiffies + kbeat_interval;
+    kbeat_timer.function=kbeat_beat;
+    add_timer(&kbeat_timer);
+    return 0;
+  }
+  return -ENODEV;
+}
+
+module_init (kbeat_init);
+module_exit (kbeat_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Philip Graham Willoughby <pgw@alumni.doc.ic.ac.uk>");
+MODULE_DESCRIPTION("Blinks a LED to indicate the kernel is alive and well");
+MODULE_PARM(kbeat_stps, "i");
+MODULE_PARM_DESC(kbeat_stps, "State changes per second for the kernel controlled LED.");
+EXPORT_NO_SYMBOLS;
diff -uNr linux-2.4.21.vanilla/drivers/leds/leds.c linux-2.4.21.patched/drivers/leds/leds.c
--- linux-2.4.21.vanilla/drivers/leds/leds.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.21.patched/drivers/leds/leds.c	2003-07-29 15:22:49.000000000 +0100
@@ -0,0 +1,595 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/ioctl.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+
+static struct list_head led_list;
+static rwlock_t led_list_lock = RW_LOCK_UNLOCKED;
+static unsigned int leds_major_num;
+static devfs_handle_t ledsdir;
+static devfs_handle_t ledsctl;
+static int have_devfs = 0;
+
+static void
+del_all_owned_by_pid (pid_t who, struct linux_leds_info *leds)
+{
+  int i;
+  if (leds->owners == NULL)
+    return;
+  for (i = 0 ; i < leds->count ; ++i)
+    if ((leds->owners[i].ownertype == leds_user) && (leds->owners[i].ownerdata.processdata.pid == who))
+    {
+      leds->owners[i].ownertype = leds_noone;
+      leds->release(leds->data);
+    }
+}
+
+static void
+release_all_owned_by_pid (pid_t pid)
+{
+  struct list_head *hd;
+  write_lock(&led_list_lock);
+  hd = &led_list;
+  while (hd->next != &led_list)
+  {
+    hd = hd->next;
+    del_all_owned_by_pid (pid, (struct linux_leds_info *)hd);
+  }
+  write_unlock(&led_list_lock);
+}
+
+static void
+del_all_owned_by(struct led_owner *who, struct linux_leds_info *leds)
+{
+  int i;
+  if (leds->owners == NULL)
+    return;
+  for (i = 0 ; i < leds->count ; ++i)
+  {
+    switch (who->ownertype)
+    {
+      case leds_noone:
+	break;
+      case leds_kernel:
+	if (leds->owners[i].ownerdata.module == who->ownerdata.module)
+	{
+	  leds->owners[i].ownertype = leds_noone;
+	  leds->release(leds->data);
+	}
+	break;
+      case leds_user:
+	if ((leds->owners[i].ownerdata.processdata.pid == who->ownerdata.processdata.pid) && (leds->owners[i].ownerdata.processdata.uid == who->ownerdata.processdata.uid))
+	{
+	  leds->owners[i].ownertype = leds_noone;
+	  leds->release(leds->data);
+	}
+    }
+  }
+}
+
+static void
+release_all_owned_by(struct led_owner *pid)
+{
+  struct list_head *hd;
+  write_lock(&led_list_lock);
+  hd = &led_list;
+  while (hd->next != &led_list)
+  {
+    hd = hd->next;
+    del_all_owned_by (pid, (struct linux_leds_info *)hd);
+  }
+  write_unlock(&led_list_lock);
+}
+
+int leds_read_proc (char *buf, char **start, off_t offset, int count, int *eof, void *data)
+{
+  int len = 0;
+  int i;
+  int id;
+  struct list_head *hd;
+  *start=buf;
+  if (offset == 0)
+  {
+    len += sprintf (buf+len, "LED ID:           PID/Module Name:  UID:              \n");
+  }
+  else
+  {
+    offset /= 55;
+    --offset; /* The header -- almost forgot ;-) */
+  }
+  read_lock(&led_list_lock);
+  hd = &led_list;
+  while ((hd->next != &led_list) && ( len + 55 <= count))
+  {
+    hd = hd->next;
+    if (((struct linux_leds_info *)hd)->count < offset)
+    {
+      offset -=((struct linux_leds_info *)hd)->count;
+      continue;
+    }
+    for (i=0 ; i < ((struct linux_leds_info *)hd)->count ; ++i)
+    {
+      if (i >= offset)
+      {
+	if ( len + 55 > count)
+	{
+	  read_unlock(&led_list_lock);
+	  return len;
+	}
+	id = ((struct linux_leds_info *)hd)->id;
+	id <<= 24;
+	id |= i;
+	len += sprintf (buf+len, "%.16X  ", id);
+	if (((struct linux_leds_info *)hd)->owners == NULL)
+	{
+	  len += sprintf (buf+len, "Not allocated                       \n");
+	}
+	else if (((struct linux_leds_info *)hd)->owners[i].ownertype == leds_noone)
+	{
+	  len += sprintf (buf+len, "Not allocated                       \n");
+	}
+	else if (((struct linux_leds_info *)hd)->owners[i].ownertype == leds_kernel)
+	{
+	  int c;
+	  c = sprintf (buf+len, "%.36s", ((struct linux_leds_info *)hd)->owners[i].ownerdata.module->name);
+	  len += c;
+	  while (c < 36)
+	  {
+	    len += sprintf (buf+len, " ");
+	    ++c;
+	  }
+	  len += sprintf (buf+len, "\n");
+	}
+	else if (((struct linux_leds_info *)hd)->owners[i].ownertype == leds_user)
+	{
+	  int c;
+	  c = sprintf (buf+len, "%-16u", ((struct linux_leds_info *)hd)->owners[i].ownerdata.processdata.pid);
+	  len += c;
+	  while (c < 18)
+	  {
+	    len += sprintf (buf+len, " ");
+	    ++c;
+	  }
+	  c = sprintf (buf+len, "%-16u", ((struct linux_leds_info *)hd)->owners[i].ownerdata.processdata.uid);
+	  len += c;
+	  while (c < 18)
+	  {
+	    len += sprintf (buf+len, " ");
+	    ++c;
+	  }
+	  len += sprintf (buf+len, "\n");
+	}
+	else
+	{
+	  len += sprintf (buf+len,"Corrupted structure encountered     \n");
+	}
+      }
+    }
+    offset = 0;
+  }
+  read_unlock(&led_list_lock);
+  *eof = 1;
+  return len;
+}
+
+int
+leds_add (struct linux_leds_info *leds)
+{
+  struct list_head *hd;
+  MOD_INC_USE_COUNT;
+  INIT_LIST_HEAD(&leds->list);
+  leds->owners=NULL;
+  leds->id=0;
+  write_lock(&led_list_lock);
+  hd = &led_list;
+  while (hd->next != &led_list)
+  {
+    hd = hd->next;
+    if (leds->id < ((struct linux_leds_info *)hd)->id)
+    {
+      list_add_tail(&leds->list, hd);
+      write_unlock(&led_list_lock);
+      return 0;
+    }
+    ++leds->id;
+  }
+  list_add_tail(&leds->list, &led_list);
+  write_unlock(&led_list_lock);
+  return 0;
+}
+
+int
+leds_del (struct linux_leds_info *leds)
+{
+  MOD_DEC_USE_COUNT;
+  write_lock(&led_list_lock);
+  list_del (&leds->list);
+  write_unlock(&led_list_lock);
+  return 0;
+}
+
+unsigned int
+leds_count(void)
+{
+  unsigned int cnt = 0;
+  struct list_head *hd;
+  read_lock(&led_list_lock);
+  hd = &led_list;
+  while (hd->next != &led_list)
+  {
+    hd = hd->next;
+    cnt += ((struct linux_leds_info *)hd)->count;
+  }
+  read_unlock(&led_list_lock);
+  return cnt;
+}
+
+static int
+del_led_owner(struct led_owner *who, unsigned int idx, struct linux_leds_info *leds)
+{
+  if (leds->owners == NULL)
+    return -EBUSY;
+  if (leds->owners[idx].ownertype == leds_noone)
+    return -EBUSY;
+  if (leds->owners[idx].ownertype != who->ownertype)
+    return -EPERM;
+  switch (who->ownertype)
+  {
+    case leds_noone:
+      return -EBADFD;
+    case leds_user:
+      if (leds->owners[idx].ownerdata.processdata.pid != who->ownerdata.processdata.pid)
+	return -EPERM;
+      leds->owners[idx].ownertype = leds_noone;
+      return 0;
+    case leds_kernel:
+      if (leds->owners[idx].ownerdata.module != who->ownerdata.module)
+	return -EPERM;
+      leds->owners[idx].ownertype = leds_noone;
+      return 0;
+  }
+  return -EBUSY;
+}
+
+static int
+add_led_owner(struct led_owner *who, unsigned int idx, struct linux_leds_info *leds)
+{
+  if (leds->owners == NULL)
+  {
+    int i;
+    leds->owners = kmalloc (leds->count * sizeof(struct led_owner), GFP_KERNEL);
+    if (leds->owners == NULL)
+      return -ENOMEM;
+    for (i = 0 ; i < leds->count ; ++i)
+    {
+      leds->owners[i].ownertype = leds_noone;
+    }
+  }
+  if (leds->owners[idx].ownertype == leds_noone)
+  {
+    leds->owners[idx].ownertype = who->ownertype;
+    switch (who->ownertype)
+    {
+      case leds_noone:
+	return -EBADFD;
+	break;
+      case leds_user:
+	leds->owners[idx].ownerdata.processdata.pid = who->ownerdata.processdata.pid;
+	leds->owners[idx].ownerdata.processdata.uid = who->ownerdata.processdata.uid;
+	return 0;
+	break;
+      case leds_kernel:
+	leds->owners[idx].ownerdata.module = who->ownerdata.module;
+	return 0;
+    }
+  }
+  return -EBUSY;
+}
+
+static int
+is_allowed(struct led_owner *who, unsigned int idx, struct linux_leds_info *leds)
+{
+  int ret = -EBUSY;
+  read_lock(&led_list_lock);
+  if (leds->owners == NULL)
+    ret = 0;
+  if (leds->owners[idx].ownertype == who->ownertype)
+  {
+    switch (who->ownertype)
+    {
+      case leds_noone:
+	break;
+      case leds_user:
+	if (leds->owners[idx].ownerdata.processdata.pid != who->ownerdata.processdata.pid)
+	  break;
+	ret = 0;
+	break;
+      case leds_kernel:
+	if (leds->owners[idx].ownerdata.module != who->ownerdata.module)
+	  break;
+	ret = 0;
+    }
+  }
+  read_unlock(&led_list_lock);
+  return ret;
+}
+
+static int
+led_release_real(struct led_owner *who, unsigned int which)
+{
+  struct list_head *hd;
+  int tmp;
+  write_lock(&led_list_lock);
+  hd = &led_list;
+  while (hd->next != &led_list)
+  {
+    hd = hd->next;
+    if (((which >> 24) & 0xff) == ((struct linux_leds_info *)hd)->id)
+    {
+      if ((tmp = del_led_owner(who, which & 0xffffff, (struct linux_leds_info *)hd)) == 0)
+      {
+	((struct linux_leds_info *)hd)->release(((struct linux_leds_info *)hd)->data);
+      }
+      write_unlock(&led_list_lock);
+      return tmp;
+    }
+  }
+  write_unlock(&led_list_lock);
+  return -ENODEV;
+}
+
+static int
+led_reserve_real(struct led_owner *who, unsigned int *which)
+{
+  struct list_head *hd;
+  int tmp;
+  write_lock(&led_list_lock);
+  hd = &led_list;
+  while (hd->next != &led_list)
+  {
+    int i;
+    hd = hd->next;
+    for (i=0 ; i < ((struct linux_leds_info *)hd)->count ; ++i)
+    {
+      if ((tmp = add_led_owner(who, i, (struct linux_leds_info *)hd)) == 0)
+      {
+	*which = ((struct linux_leds_info *)hd)->id;
+	*which <<= 24;
+	*which |= i;
+	((struct linux_leds_info *)hd)->reserve(((struct linux_leds_info *)hd)->data);
+	write_unlock(&led_list_lock);
+	return tmp;
+      }
+    }
+  }
+  write_unlock(&led_list_lock);
+  return -ENODEV;
+}
+
+static int
+led_set_real (struct led_owner *who, unsigned int which, unsigned char state)
+{
+  struct list_head *hd;
+  int ret;
+  read_lock(&led_list_lock);
+  hd = &led_list;
+  if (state) state=~0;
+  while (hd->next != &led_list)
+  {
+    hd = hd->next;
+    if (((which >> 24) & 0xff) == ((struct linux_leds_info *)hd)->id)
+    {
+      if ((which & 0xffffff) > ((struct linux_leds_info *)hd)->count)
+      {
+	read_unlock(&led_list_lock);
+	return -ENODEV;
+      }
+      if ((ret = is_allowed(who, which & 0xffffff, (struct linux_leds_info *)hd)) == 0)
+	((struct linux_leds_info *)hd)->set_state(which & 0xffffff, state, ((struct linux_leds_info *)hd)->data);
+      read_unlock(&led_list_lock);
+      return ret;
+    }
+  }
+  read_unlock(&led_list_lock);
+  return -ENODEV;
+}
+
+int led_release (unsigned int idx, struct module *mod)
+{
+  struct led_owner a;
+  a.ownertype = leds_kernel;
+  a.ownerdata.module = mod;
+  return led_release_real(&a, idx);
+}
+
+int led_reserve (unsigned int *which, struct module *mod)
+{
+  struct led_owner a;
+  a.ownertype = leds_kernel;
+  a.ownerdata.module = mod;
+  return led_reserve_real(&a, which);
+}
+
+int
+led_set(unsigned int idx, unsigned char state, struct module *mod)
+{
+  struct led_owner a;
+  a.ownertype = leds_kernel;
+  a.ownerdata.module = mod;
+  return led_set_real(&a, idx, state);
+}
+
+int
+led_get(unsigned int which)
+{
+  struct list_head *hd;
+  unsigned char state;
+  read_lock(&led_list_lock);
+  hd = &led_list;
+  while (hd->next != &led_list)
+  {
+    hd = hd->next;
+    if (((which >> 24) & 0xff) == ((struct linux_leds_info *)hd)->id)
+    {
+      if ((which & 0xffffff) > ((struct linux_leds_info *)hd)->count)
+      {
+	read_unlock(&led_list_lock);
+	return -ENODEV;
+      }
+      state = ((struct linux_leds_info *)hd)->get_state(which & 0xffffff, ((struct linux_leds_info *)hd)->data);
+      read_unlock(&led_list_lock);
+      if (state) state=~0;
+      return state;
+    }
+  }
+  read_unlock(&led_list_lock);
+  return -ENODEV;
+}
+
+static int
+leds_ioctl (struct inode *inode, struct file *filp, unsigned int cmd, unsigned long arg)
+{
+  unsigned int idx;
+  unsigned char state;
+  signed int tmp;
+  struct led_owner a;
+  pid_t pid;
+  if (MINOR(inode->i_rdev) != 0xff) {
+    return -ENOTTY;
+  }
+  if (_IOC_TYPE(cmd) != LINUX_LEDS_IOC_MAGIC) {
+    return -ENOTTY;
+  }
+  if (_IOC_NR(cmd) > LINUX_LEDS_IOC_MAX_NR) {
+    return -ENOTTY;
+  }
+  if ((_IOC_DIR(cmd) & _IOC_READ) && (!access_ok(VERIFY_WRITE, (void *)arg, _IOC_SIZE(cmd))))
+    return -EFAULT;
+  else if ((_IOC_DIR(cmd) & _IOC_WRITE) && (!access_ok(VERIFY_READ, (void *)arg, _IOC_SIZE(cmd))))
+    return -EFAULT;
+  a.ownertype = leds_user;
+  a.ownerdata.processdata.pid = current->tgid;
+  a.ownerdata.processdata.uid = current->uid;
+  switch (cmd)
+  {
+    case LINUX_LEDS_IOC_COUNT_LEDS:
+      idx = leds_count();
+      __put_user(idx, (unsigned int *)arg);
+      return 0;
+    case LINUX_LEDS_IOC_SET_LED:
+      __get_user (idx, &(((struct linux_leds *)arg)->idx));
+      __get_user (state, &(((struct linux_leds *)arg)->state));
+      return led_set_real (&a, idx, state);
+    case LINUX_LEDS_IOC_GET_LED:
+      __get_user (idx, &(((struct linux_leds *)arg)->idx));
+      tmp = led_get(idx);
+      if (tmp < 0)
+	return tmp;
+      state = ((unsigned int)tmp) &0xff;
+      __put_user (state, &(((struct linux_leds *)arg)->state));
+      return 0;
+    case LINUX_LEDS_IOC_RESERVE_LED:
+      tmp = led_reserve_real (&a, &idx);
+      __put_user (idx, (unsigned int *)arg);
+      return tmp;
+    case LINUX_LEDS_IOC_RELEASE_LED:
+      __get_user (idx, (unsigned int *)arg);
+      return led_release_real (&a, idx);
+    case LINUX_LEDS_IOC_BREAK_LOCK:
+      __get_user (pid, (pid_t *)arg);
+      if (!capable(CAP_DAC_OVERRIDE))
+      {
+	a.ownerdata.processdata.pid = pid;
+	release_all_owned_by (&a);
+      }
+      else
+	release_all_owned_by_pid(pid);
+      return 0;
+  }
+  /* Unreachable code */
+  return -ENOTTY;
+}
+
+static int
+leds_open (struct inode *inode, struct file *filp)
+{
+  if (MINOR(inode->i_rdev) != 0xff) return -ENODEV;
+  MOD_INC_USE_COUNT;
+  return 0;
+}
+
+static int
+leds_release (struct inode *inode, struct file *filp)
+{
+  release_all_owned_by_pid (current->tgid);
+  MOD_DEC_USE_COUNT;
+  return 0;
+}
+
+struct file_operations leds_fops = {
+open: leds_open,
+release: leds_release,
+ioctl: leds_ioctl,
+owner: THIS_MODULE,
+};
+
+void __exit
+leds_exit (void)
+{
+  remove_proc_entry("leds", NULL);
+  if (have_devfs)
+  {
+    devfs_unregister (ledsctl);
+    devfs_unregister (ledsdir);
+  }
+  unregister_chrdev(leds_major_num, "leds");
+}
+
+int __init
+leds_init (void)
+{
+  int maj;
+  maj = register_chrdev(0, "leds", &leds_fops);
+  if (maj < 0) return maj;
+  leds_major_num = maj;
+  printk(KERN_NOTICE "leds: assigned major number %u\n", leds_major_num);
+  write_lock(&led_list_lock);
+  INIT_LIST_HEAD(&led_list);
+  write_unlock(&led_list_lock);
+  ledsdir = devfs_mk_dir (NULL, "leds", NULL);
+  if (ledsdir != NULL)
+  {
+    have_devfs = 1;
+    ledsctl = devfs_register (ledsdir, "ctl", DEVFS_FL_DEFAULT, leds_major_num, 0xff, S_IFCHR | 0666 , &leds_fops, NULL);
+    if (ledsctl == NULL)
+    {
+      devfs_unregister (ledsdir);
+      unregister_chrdev(leds_major_num, "leds");
+      return -EBUSY;
+    }
+  }
+  create_proc_read_entry("leds", 0, NULL, leds_read_proc, NULL);
+  return 0;
+}
+
+module_init(leds_init);
+module_exit(leds_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Philip Graham Willoughby <pgw@alumni.doc.ic.ac.uk>");
+MODULE_DESCRIPTION("Provides a generic kernel interface for LED control");
+EXPORT_SYMBOL(led_get);
+EXPORT_SYMBOL(led_set);
+EXPORT_SYMBOL(led_reserve);
+EXPORT_SYMBOL(led_release);
+EXPORT_SYMBOL(leds_count);
+EXPORT_SYMBOL(leds_add);
+EXPORT_SYMBOL(leds_del);
diff -uNr linux-2.4.21.vanilla/drivers/leds/Makefile linux-2.4.21.patched/drivers/leds/Makefile
--- linux-2.4.21.vanilla/drivers/leds/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.21.patched/drivers/leds/Makefile	2003-07-29 15:29:31.000000000 +0100
@@ -0,0 +1,20 @@
+#
+# Makefile for the kernel LED device drivers.
+#
+
+obj-y:=
+
+obj-m:=
+
+# All of the (potential) objects that export symbols.
+# This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
+
+export-objs:=leds.o
+
+obj-$(CONFIG_LEDS) += leds.o
+obj-$(CONFIG_PIIX4E_LEDS) += piix4e_leds.o
+obj-$(CONFIG_PARPORT_LEDS) += parport_leds.o
+obj-$(CONFIG_KBEAT_LED) += kbeat_led.o
+obj-$(CONFIG_UBEAT) += ubeat.o
+
+include $(TOPDIR)/Rules.make
diff -uNr linux-2.4.21.vanilla/drivers/leds/parport_leds.c linux-2.4.21.patched/drivers/leds/parport_leds.c
--- linux-2.4.21.vanilla/drivers/leds/parport_leds.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.21.patched/drivers/leds/parport_leds.c	2003-07-22 13:55:10.000000000 +0100
@@ -0,0 +1,144 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/parport.h>
+#include <linux/errno.h>
+#include <linux/leds.h>
+#include <linux/spinlock.h>
+
+static spinlock_t parled_lock= SPIN_LOCK_UNLOCKED;
+static unsigned char parled_state = 0;
+static int parled_parport = -1;
+static struct pardevice *parleds_dev = NULL;
+
+static void
+release (void *ignore)
+{
+  MOD_DEC_USE_COUNT;
+}
+
+static void
+reserve (void *ignore)
+{
+  MOD_INC_USE_COUNT;
+}
+
+static void
+set_state (unsigned int idx, unsigned char state, void *ignore)
+{
+  spin_lock(&parled_lock);
+  parled_state &= ~(1 << idx);
+  parled_state |= state & (1 << idx);
+  parleds_dev->port->ops->write_data (parleds_dev->port, parled_state);
+  spin_unlock(&parled_lock);
+}
+
+static unsigned char
+get_state (unsigned int idx, void *ignore)
+{
+  unsigned char reg;
+  spin_lock(&parled_lock);
+  reg = parled_state;
+  spin_unlock(&parled_lock);
+  reg &= (1 << idx);
+  return reg;
+}
+
+static void
+attach (struct parport *thing)
+{
+  if (parled_parport >= 0)
+    return;
+  for (parled_parport = 0 ; parled_parport < PARPORT_MAX ; ++parled_parport)
+  {
+    if (thing == NULL)
+    {
+      printk (KERN_DEBUG "parport_leds: Moo %d\n", parled_parport);
+      continue;
+    }
+    if (thing->number == parled_parport)
+    {
+      struct pardevice *dev;
+      dev = parport_register_device (thing, "leds", NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
+      if (dev == NULL)
+      {
+	printk (KERN_DEBUG "parport_leds: Baa %d\n", parled_parport);
+	continue;
+      }
+      if (!parport_claim (dev) == 0)
+      {
+	parled_parport = -1;
+      }
+      else
+      {
+	parleds_dev = thing->devices;
+      }
+      return;
+    }
+  }
+  parled_parport = -1;
+  return;
+}
+
+static void
+detach (struct parport *thing)
+{
+}
+
+static struct linux_leds_info parleds = {
+get_state:get_state,
+set_state:set_state,
+reserve:reserve,
+release:release,
+count:8,
+drivername:THIS_MODULE,
+};
+
+static struct parport_driver parleds_driver = {
+name:"parleds",
+attach:attach,
+detach:detach,
+};
+
+int __init
+init_parallel_leds (void)
+{
+  int c;
+  if (parport_register_driver (&parleds_driver) != 0)
+  {
+    printk (KERN_INFO "parport_leds: parport_register_driver failed\n");
+    return -EIO;
+  }
+  if (parled_parport < 0)
+  {
+    parport_unregister_driver (&parleds_driver);
+    printk (KERN_INFO "parport_leds: couldn't claim a parallel port\n");
+    return -EIO;
+  }
+  c = leds_add (&parleds);
+  if (c != 0)
+  {
+    parport_unregister_driver (&parleds_driver);
+    printk (KERN_INFO "parport_leds: leds_add failed\n");
+    return -ENODEV;
+  }
+  return c;
+}
+
+void __exit
+cleanup_parallel_leds (void)
+{
+  leds_del (&parleds);
+  parport_release (parleds_dev);
+  parport_unregister_device (parleds_dev);
+  parport_unregister_driver (&parleds_driver);
+}
+
+module_init(init_parallel_leds);
+module_exit(cleanup_parallel_leds);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Philip Graham Willoughby <pgw@alumni.doc.ic.ac.uk>");
+MODULE_DESCRIPTION("This module provides kernel control for programmable LEDs wired up to the parallel port");
+MODULE_SUPPORTED_DEVICE("Parallel port LED boxes");
+EXPORT_NO_SYMBOLS;
+
diff -uNr linux-2.4.21.vanilla/drivers/leds/piix4e_leds.c linux-2.4.21.patched/drivers/leds/piix4e_leds.c
--- linux-2.4.21.vanilla/drivers/leds/piix4e_leds.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.21.patched/drivers/leds/piix4e_leds.c	2003-07-22 13:54:46.000000000 +0100
@@ -0,0 +1,116 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/leds.h>
+#include <linux/spinlock.h>
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+static const unsigned char bxled_mask[] = {0x01, 0x10};
+static const unsigned short bxled_port[] = {0x0435, 0x0437};
+static spinlock_t bxled_lock[] = {SPIN_LOCK_UNLOCKED, SPIN_LOCK_UNLOCKED};
+
+static void
+release (void * ignored)
+{
+  MOD_DEC_USE_COUNT;
+}
+
+static void
+reserve (void * ignored)
+{
+  MOD_INC_USE_COUNT;
+}
+
+static void
+set_state (unsigned int idx, unsigned char state, void *ignored)
+{
+  unsigned char reg;
+  spin_lock(&bxled_lock[idx]);
+  reg = inb(bxled_port[idx]);
+  reg &= ~bxled_mask[idx];
+  reg |= state & bxled_mask[idx];
+  outb (reg, bxled_port[idx]);
+  spin_unlock(&bxled_lock[idx]);
+}
+
+static unsigned char
+get_state (unsigned int idx, void * ignored)
+{
+  unsigned char reg;
+  spin_lock(&bxled_lock[idx]);
+  reg = inb(bxled_port[idx]);
+  spin_unlock(&bxled_lock[idx]);
+  reg &= bxled_mask[idx];
+  return reg;
+}
+
+static struct linux_leds_info bxleds = {
+get_state:get_state,
+set_state:set_state,
+reserve:reserve,
+release:release,
+count:2,
+data:NULL,
+drivername:THIS_MODULE,
+};
+
+int __init
+init_isp1100_lights (void)
+{
+  int c;
+  if (!pci_present())
+    return -ENODEV;
+  if (!(pci_find_device(PCI_VENDOR_ID_INTEL,PCI_DEVICE_ID_INTEL_82371AB_3,NULL)))
+    return -ENODEV;
+  if (!request_region (bxled_port[0], 1, "Intel PIIX4E LED U1"))
+    return -EBUSY;
+  c = -EBUSY;
+  if (!request_region (bxled_port[1], 1, "Intel PIIX4E LED U2"))
+    goto cleanup_zero;
+  /* Now check if there are actually LEDs there.  Boards with them unconnected
+   * seem to lose the status of the IO port -- I therefore assume, if the bit
+   * sticks, poke it
+   */
+  c = -ENODEV;
+  set_state (0, 0, NULL);
+  set_state (1, 0, NULL);
+  if (get_state (0, NULL))
+    goto cleanup_both;
+  if (get_state (1, NULL))
+    goto cleanup_both;
+  set_state (0, ~0, NULL);
+  set_state (1, ~0, NULL);
+  if (!get_state (0, NULL))
+    goto cleanup_both;
+  if (!get_state (1, NULL))
+    goto cleanup_both;
+  c = leds_add (&bxleds);
+  if (c != 0)
+    goto cleanup_both;
+  return c;
+cleanup_both:
+  release_region (bxled_port[1], 1);
+cleanup_zero:
+  release_region (bxled_port[0], 1);
+  return c;
+}
+
+void __exit
+cleanup_isp1100_lights (void)
+{
+  leds_del (&bxleds);
+  release_region (bxled_port[1], 1);
+  release_region (bxled_port[0], 1);
+}
+
+module_init(init_isp1100_lights);
+module_exit(cleanup_isp1100_lights);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Philip Graham Willoughby <pgw@alumni.doc.ic.ac.uk>");
+MODULE_DESCRIPTION("This module provides kernel control for the programmable LEDs on Intel PIIX4E Systems");
+MODULE_SUPPORTED_DEVICE("Intel PIIX4E Chipset");
+EXPORT_NO_SYMBOLS;
+
diff -uNr linux-2.4.21.vanilla/drivers/leds/ubeat.c linux-2.4.21.patched/drivers/leds/ubeat.c
--- linux-2.4.21.vanilla/drivers/leds/ubeat.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.21.patched/drivers/leds/ubeat.c	2003-07-22 14:06:38.000000000 +0100
@@ -0,0 +1,187 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ubeat.h>
+#include <linux/leds.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/ioctl.h>
+
+static unsigned int ubeat_major_num;
+static volatile int ubeat_have_led = 0;
+static int have_devfs = 0;
+static unsigned int ubeat_led;
+static volatile unsigned char ubeat_state = 0;
+static struct timer_list ubeat_timer;
+static unsigned int ubeat_interval;
+static signed int ubeat_timeout __initdata = 2;
+static devfs_handle_t ubeatdir;
+static devfs_handle_t ubeatctl;
+static spinlock_t ubeat_use_lock = SPIN_LOCK_UNLOCKED;
+static volatile int inuse = 0;
+static atomic_t ubeat_carp;
+
+static void
+ubeat_timeup (unsigned long ignored)
+{
+  if (atomic_read(&ubeat_carp) == 0)
+    return;
+  atomic_set (&ubeat_carp, 0);
+  printk(KERN_ALERT "ubeat: User heartbeat not detected - FIX ME!!!!\n");
+}
+
+static int
+ubeat_ioctl (struct inode *inode, struct file *filp, unsigned int cmd, unsigned long arg)
+{
+  if (MINOR(inode->i_rdev) != 0)
+  {
+    printk( KERN_DEBUG "ubeat: Minor number was %u\n", MINOR(inode->i_rdev));
+    return -ENODEV;
+  }
+  if (_IOC_TYPE(cmd) != LINUX_UBEAT_IOC_MAGIC)
+  {
+    printk( KERN_DEBUG "ubeat: Magic number was 0x%x\n", _IOC_TYPE(cmd));
+    return -ENOTTY;
+  }
+  if (_IOC_NR(cmd) > LINUX_UBEAT_IOC_MAX_NR)
+  {
+    printk( KERN_DEBUG "ubeat: Command number was %u\n", _IOC_NR(cmd));
+    return -ENOTTY;
+  }
+  switch (cmd)
+  {
+    case LINUX_UBEAT_IOC_POKE:
+      spin_lock(&ubeat_use_lock);
+      del_timer_sync(&ubeat_timer);
+      ubeat_timer.expires = jiffies + ubeat_interval;
+      add_timer(&ubeat_timer);
+      spin_unlock(&ubeat_use_lock);
+      if (ubeat_have_led)
+      {
+	led_set(ubeat_led, ubeat_state, THIS_MODULE);
+	ubeat_state = ~ubeat_state;
+      }
+      return 0;
+    case LINUX_UBEAT_IOC_FIXT:
+      spin_lock(&ubeat_use_lock);
+      del_timer_sync(&ubeat_timer);
+      ubeat_timer.expires = jiffies + ubeat_interval;
+      add_timer(&ubeat_timer);
+      spin_unlock(&ubeat_use_lock);
+      atomic_set (&ubeat_carp, 1);
+      return 0;
+  }
+  return -ENOTTY;
+}
+
+
+static int
+ubeat_open (struct inode *inode, struct file *filp)
+{
+  MOD_INC_USE_COUNT;
+  spin_lock(&ubeat_use_lock);
+  ++inuse;
+  del_timer_sync(&ubeat_timer);
+  ubeat_timer.expires = jiffies + ubeat_interval;
+  add_timer(&ubeat_timer);
+  spin_unlock(&ubeat_use_lock);
+  return 0;
+}
+
+static int
+ubeat_release (struct inode *inode, struct file *filp)
+{
+  MOD_DEC_USE_COUNT;
+  spin_lock(&ubeat_use_lock);
+  --inuse;
+  if (inuse == 0)
+  {
+    del_timer_sync(&ubeat_timer);
+    atomic_set (&ubeat_carp, 1);
+  }
+  spin_unlock(&ubeat_use_lock);
+  return 0;
+}
+
+
+static struct file_operations ubeat_fops = {
+open: ubeat_open,
+release: ubeat_release,
+ioctl: ubeat_ioctl,
+owner: THIS_MODULE,
+};
+
+void __exit
+ubeat_exit(void)
+{
+  del_timer_sync(&ubeat_timer);
+  if (ubeat_have_led)
+    led_release(ubeat_led, THIS_MODULE);
+  if (have_devfs)
+  {
+    devfs_unregister (ubeatctl);
+    devfs_unregister (ubeatdir);
+  }
+  unregister_chrdev(ubeat_major_num, "ubeat");
+}
+
+int __init
+ubeat_init(void)
+{
+  int maj;
+  atomic_set (&ubeat_carp, 1);
+  maj = register_chrdev(0, "ubeat", &ubeat_fops);
+  if (maj < 0) return maj;
+  ubeat_major_num = maj;
+  printk (KERN_NOTICE "ubeat: got major number %u\n", ubeat_major_num);
+  ubeatdir = devfs_mk_dir(NULL, "ubeat", NULL);
+  if (ubeatdir != NULL)
+  {
+    have_devfs = 1;
+    unregister_chrdev(ubeat_major_num, "ubeat");
+    ubeatctl = devfs_register (ubeatdir, "pokeme", DEVFS_FL_DEFAULT, ubeat_major_num, 0, S_IFCHR | 0660 , &ubeat_fops, NULL);
+    if (ubeatctl == NULL)
+    {
+      devfs_unregister (ubeatdir);
+      unregister_chrdev(ubeat_major_num, "ubeat");
+      return -EBUSY;
+    }
+  }
+  if (led_reserve(&ubeat_led, THIS_MODULE) == 0)
+  {
+    printk (KERN_INFO "ubeat_led: got led %.8x\n", ubeat_led);
+    ubeat_have_led = 1;
+  }
+  if (ubeat_timeout == 0)
+  {
+    printk (KERN_INFO "ubeat_led: timeout value '0' is invalid, using 2\n");
+    ubeat_timeout = 2;
+  }
+  if (ubeat_timeout < 0)
+  {
+    ubeat_interval = HZ / (-1 * ubeat_timeout);
+  } else {
+    ubeat_interval = HZ * ubeat_timeout;
+  }
+  if (ubeat_interval == 0)
+  {
+    printk (KERN_INFO "ubeat_led: timeout value out of range, using 2\n");
+    ubeat_interval = 2 * HZ;
+  }
+  init_timer (&ubeat_timer);
+  ubeat_timer.function = ubeat_timeup;
+  return 0;
+}
+
+module_init(ubeat_init);
+module_exit(ubeat_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Philip Graham Willoughby <pgw@alumni.doc.ic.ac.uk>");
+MODULE_DESCRIPTION("Provides kernel interface to keep an eye on user programs");
+EXPORT_NO_SYMBOLS;
+MODULE_PARM(ubeat_timeout, "i");
+MODULE_PARM_DESC(ubeat_timeout, "Seconds before the kernel should alert you, fractions below 1s can be specified with -ve numbers e.g. -2 means wait 1/2 a second.");
diff -uNr linux-2.4.21.vanilla/drivers/Makefile linux-2.4.21.patched/drivers/Makefile
--- linux-2.4.21.vanilla/drivers/Makefile	2003-07-17 17:04:35.000000000 +0100
+++ linux-2.4.21.patched/drivers/Makefile	2003-07-29 15:28:17.000000000 +0100
@@ -48,5 +48,6 @@
 subdir-$(CONFIG_ACPI)		+= acpi
 
 subdir-$(CONFIG_BLUEZ)		+= bluetooth
+subdir-$(CONFIG_LEDS)		+= leds
 
 include $(TOPDIR)/Rules.make
diff -uNr linux-2.4.21.vanilla/include/linux/leds.h linux-2.4.21.patched/include/linux/leds.h
--- linux-2.4.21.vanilla/include/linux/leds.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.21.patched/include/linux/leds.h	2003-07-22 14:07:52.000000000 +0100
@@ -0,0 +1,68 @@
+#ifndef LINUX_LEDS_H__
+#define LINUX_LEDS_H__
+
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+
+enum ownertype
+{
+  leds_noone = 0,
+  leds_kernel,
+  leds_user,
+};
+
+struct led_owner
+{
+  enum ownertype ownertype;
+  union
+  {
+    struct module *module;
+    struct {
+      pid_t pid;
+      uid_t uid;
+    } processdata;
+  } ownerdata;
+};
+
+struct linux_leds_info
+{
+  struct list_head list;
+  unsigned int id:8;
+  unsigned int count:24;
+  unsigned char (*get_state)(unsigned int, void *);
+  void (*set_state)(unsigned int, unsigned char, void *);
+  void (*reserve)(void *);
+  void (*release)(void *);
+  void *data;
+  struct module *drivername;
+  struct led_owner *owners;
+};
+
+extern int led_get(unsigned int idx);
+extern int led_set(unsigned int idx, unsigned char state, struct module *mod);
+extern int led_reserve(unsigned int *idx, struct module *mod);
+extern int led_release(unsigned int idx, struct module *mod);
+extern unsigned int leds_count(void);
+extern int leds_add (struct linux_leds_info *);
+extern int leds_del (struct linux_leds_info *);
+
+#endif /* defined __KERNEL__ */
+
+#include <linux/ioctl.h>
+
+struct linux_leds {
+  unsigned int idx; /* LEDS are indexed from zero */
+  unsigned char state; /* 0 for off, ~0 for on */
+};
+
+#define LINUX_LEDS_IOC_MAGIC 0x81
+#define LINUX_LEDS_IOC_COUNT_LEDS _IOR(LINUX_LEDS_IOC_MAGIC, 0, unsigned int)
+#define LINUX_LEDS_IOC_SET_LED _IOW(LINUX_LEDS_IOC_MAGIC, 1, struct linux_leds)
+#define LINUX_LEDS_IOC_GET_LED _IOR(LINUX_LEDS_IOC_MAGIC, 2, struct linux_leds)
+#define LINUX_LEDS_IOC_RESERVE_LED _IOR(LINUX_LEDS_IOC_MAGIC, 3, unsigned int)
+#define LINUX_LEDS_IOC_RELEASE_LED _IOW(LINUX_LEDS_IOC_MAGIC, 4, unsigned int)
+#define LINUX_LEDS_IOC_BREAK_LOCK _IOW(LINUX_LEDS_IOC_MAGIC, 5, pid_t)
+#define LINUX_LEDS_IOC_MAX_NR 5
+
+#endif /* ! defined LINUX_LEDS_H__ */
diff -uNr linux-2.4.21.vanilla/include/linux/ubeat.h linux-2.4.21.patched/include/linux/ubeat.h
--- linux-2.4.21.vanilla/include/linux/ubeat.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.21.patched/include/linux/ubeat.h	2003-07-10 21:31:31.000000000 +0100
@@ -0,0 +1,11 @@
+#ifndef LINUX_UBEAT_H__
+#define LINUX_UBEAT_H__
+
+#include <linux/ioctl.h>
+
+#define LINUX_UBEAT_IOC_MAGIC 0x75
+#define LINUX_UBEAT_IOC_POKE _IO(LINUX_UBEAT_IOC_MAGIC, 0)
+#define LINUX_UBEAT_IOC_FIXT _IO(LINUX_UBEAT_IOC_MAGIC, 1)
+#define LINUX_UBEAT_IOC_MAX_NR 1
+
+#endif /* ! defined LINUX_UBEAT_H__ */
