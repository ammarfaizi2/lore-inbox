Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUFWVhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUFWVhz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266696AbUFWVfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:35:46 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:21513 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266715AbUFWVai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:30:38 -0400
Message-ID: <40D9F74A.9090508@hp.com>
Date: Wed, 23 Jun 2004 17:34:02 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HPET driver
References: <200406181616.i5IGGECd003812@hera.kernel.org>	<40D35740.8070206@pobox.com> <20040618145531.015fbc12.akpm@osdl.org> <40D37090.20909@pobox.com>
In-Reply-To: <40D37090.20909@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew:

I eliminated the request_irq brain damage, eliminated procfs support, 
made the check for FMODE_WRITE  in hpet_open and responded to a few 
other suggestions.


I misinterpreted your desire to change HPET from using a major device 
number and moving to miscdevice.  I thought one objective was to avoid 
LANANA registration.  It obviously isn't and I have done LANANA 
registration but need a reply.  So it's possible the values for hpet in 
miscdevice.h and devices.txt will change.

thanks,

Bob

diff -ruN -X /home/picco/losl/dontdiff 
linux-2.6.7-mm1-orig/arch/i386/kernel/time_hpet.c 
linux-2.6.7-mm1-hpet/arch/i386/kernel/time_hpet.c
--- linux-2.6.7-mm1-orig/arch/i386/kernel/time_hpet.c    2004-06-21 
07:42:51.000000000 -0400
+++ linux-2.6.7-mm1-hpet/arch/i386/kernel/time_hpet.c    2004-06-21 
07:51:12.000000000 -0400
@@ -155,10 +155,9 @@
        hd.hd_address = hpet_virt_address;
        hd.hd_nirqs = ntimer;
        hd.hd_flags = HPET_DATA_PLATFORM;
-#ifndef    CONFIG_HPET_EMULATE_RTC
-        hd.hd_state = 0x1;
-#else
-        hd.hd_state = 0x3;
+        HD_STATE(&hd, 0);
+#ifdef    CONFIG_HPET_EMULATE_RTC
+        HD_STATE(&hd, 1);
#endif
        hd.hd_irq[0] = HPET_LEGACY_8254;
        hd.hd_irq[1] = HPET_LEGACY_RTC;
diff -ruN -X /home/picco/losl/dontdiff 
linux-2.6.7-mm1-orig/Documentation/devices.txt 
linux-2.6.7-mm1-hpet/Documentation/devices.txt
--- linux-2.6.7-mm1-orig/Documentation/devices.txt    2004-06-16 
01:19:13.000000000 -0400
+++ linux-2.6.7-mm1-hpet/Documentation/devices.txt    2004-06-21 
10:03:42.000000000 -0400
@@ -434,6 +434,7 @@
        225 = /dev/pps        Pulse Per Second driver
        226 = /dev/systrace    Systrace device
        227 = /dev/mcelog    X86_64 Machine Check Exception driver
+        228 = /dev/hpet        HPET driver
        240-254            Reserved for local use
        255            Reserved for MISC_DYNAMIC_MINOR

diff -ruN -X /home/picco/losl/dontdiff 
linux-2.6.7-mm1-orig/Documentation/filesystems/proc.txt 
linux-2.6.7-mm1-hpet/Documentation/filesystems/proc.txt
--- linux-2.6.7-mm1-orig/Documentation/filesystems/proc.txt    
2004-06-21 07:42:55.000000000 -0400
+++ linux-2.6.7-mm1-hpet/Documentation/filesystems/proc.txt    
2004-06-21 15:26:00.000000000 -0400
@@ -201,7 +201,7 @@
 devices     Available devices (block and character)           
 dma         Used DMS channels                                 
 filesystems Supported filesystems                             - 
driver         Various drivers grouped here, currently rtc (2.4) and 
hpet (2.6)
+ driver         Various drivers grouped here, currently rtc (2.4)
 execdomains Execdomains, related to security            (2.4)
 fb         Frame Buffer devices                (2.4)
 fs         File system parameters, currently nfs/exports    (2.4)
diff -ruN -X /home/picco/losl/dontdiff 
linux-2.6.7-mm1-orig/Documentation/hpet.txt 
linux-2.6.7-mm1-hpet/Documentation/hpet.txt
--- linux-2.6.7-mm1-orig/Documentation/hpet.txt    2004-06-21 
07:42:55.000000000 -0400
+++ linux-2.6.7-mm1-hpet/Documentation/hpet.txt    2004-06-21 
10:02:04.000000000 -0400
@@ -103,7 +103,7 @@
        return;
    }

-    fd = open(argv[0], O_RDWR);
+    fd = open(argv[0], O_RDONLY);
    if (fd < 0)
        fprintf(stderr, "hpet_open_close: open failed\n");
    else
@@ -136,7 +136,7 @@
    freq = atoi(argv[1]);
    iterations = atoi(argv[2]);

-    fd = open(argv[0], O_RDWR);
+    fd = open(argv[0], O_RDONLY);

    if (fd < 0) {
        fprintf(stderr, "hpet_poll: open of %s failed\n", argv[0]);
@@ -230,7 +230,7 @@
        goto out;
    }

-    fd = open(argv[0], O_RDWR);
+    fd = open(argv[0], O_RDONLY);

    if (fd < 0) {
        fprintf(stderr, "hpet_fasync: failed to open %s\n", argv[0]);
diff -ruN -X /home/picco/losl/dontdiff 
linux-2.6.7-mm1-orig/drivers/char/hpet.c 
linux-2.6.7-mm1-hpet/drivers/char/hpet.c
--- linux-2.6.7-mm1-orig/drivers/char/hpet.c    2004-06-21 
07:42:55.000000000 -0400
+++ linux-2.6.7-mm1-hpet/drivers/char/hpet.c    2004-06-22 
12:21:36.000000000 -0400
@@ -50,6 +50,8 @@
/* A lock for concurrent intermodule access to hpet and isr hpet 
activity. */
static spinlock_t hpet_task_lock = SPIN_LOCK_UNLOCKED;

+#define    HPET_DEV_NAME    (7)
+
struct hpet_dev {
    struct hpets *hd_hpets;
    struct hpet *hd_hpet;
@@ -62,6 +64,7 @@
    unsigned int hd_flags;
    unsigned int hd_irq;
    unsigned int hd_hdwirq;
+    char hd_name[HPET_DEV_NAME];
};

struct hpets {
@@ -148,6 +151,9 @@
    struct hpets *hpetp;
    int i;

+    if (file->f_mode & FMODE_WRITE)
+        return -EINVAL;
+
    spin_lock_irq(&hpet_lock);

    for (devp = NULL, hpetp = hpets; hpetp && !devp; hpetp = 
hpetp->hp_next)
@@ -191,8 +197,6 @@
    add_wait_queue(&devp->hd_waitqueue, &wait);

    do {
-        __set_current_state(TASK_INTERRUPTIBLE);
-
        spin_lock_irq(&hpet_lock);
        data = devp->hd_irqdata;
        devp->hd_irqdata = 0;
@@ -208,6 +212,7 @@
            goto out;
        }

+        set_current_state(TASK_INTERRUPTIBLE);
        schedule();

    } while (1);
@@ -255,9 +260,6 @@
    if (((vma->vm_end - vma->vm_start) != PAGE_SIZE) || vma->vm_pgoff)
        return -EINVAL;

-    if (vma->vm_flags & VM_WRITE)
-        return -EPERM;
-
    devp = file->private_data;
    addr = (unsigned long)devp->hd_hpet;

@@ -371,12 +373,10 @@
    irq = devp->hd_hdwirq;

    if (irq) {
-        char name[7];
-
-        sprintf(name, "hpet%d", (int)(devp - hpetp->hp_dev));
+        sprintf(devp->hd_name, "hpet%d", (int)(devp - hpetp->hp_dev));

        if (request_irq
-            (irq, hpet_interrupt, SA_INTERRUPT, name, (void *)devp)) {
+            (irq, hpet_interrupt, SA_INTERRUPT, devp->hd_name, (void 
*)devp)) {
            printk(KERN_ERR "hpet: IRQ %d is not free\n", irq);
            irq = 0;
        }
@@ -731,73 +731,6 @@

static struct ctl_table_header *sysctl_header;

-static void *hpet_start(struct seq_file *s, loff_t * pos)
-{
-    struct hpets *hpetp;
-    loff_t n;
-
-    for (n = *pos, hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-        if (!n--)
-            return hpetp;
-
-    return 0;
-}
-
-static void *hpet_next(struct seq_file *s, void *v, loff_t * pos)
-{
-    struct hpets *hpetp;
-
-    hpetp = v;
-    ++*pos;
-    return hpetp->hp_next;
-}
-
-static void hpet_stop(struct seq_file *s, void *v)
-{
-    return;
-}
-
-static int hpet_show(struct seq_file *s, void *v)
-{
-    struct hpets *hpetp;
-    struct hpet *hpet;
-    u64 cap, vendor, period;
-
-    hpetp = v;
-    hpet = hpetp->hp_hpet;
-
-    cap = readq(&hpet->hpet_cap);
-    period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
-        HPET_COUNTER_CLK_PERIOD_SHIFT;
-    vendor = (cap & HPET_VENDOR_ID_MASK) >> HPET_VENDOR_ID_SHIFT;
-
-    seq_printf(s,
-           "HPET%d period = %d 10**-15  vendor = 0x%x number timer = 
%d\n",
-           hpetp->hp_which, (u32) period, (u32) vendor,
-           hpetp->hp_ntimer);
-
-    return 0;
-}
-
-static struct seq_operations hpet_seq_ops = {
-    .start = hpet_start,
-    .next = hpet_next,
-    .stop = hpet_stop,
-    .show = hpet_show
-};
-
-static int hpet_proc_open(struct inode *inode, struct file *file)
-{
-    return seq_open(file, &hpet_seq_ops);
-}
-
-static struct file_operations hpet_proc_fops = {
-    .open = hpet_proc_open,
-    .read = seq_read,
-    .llseek = seq_lseek,
-    .release = seq_release
-};
-
/*
 * Adjustment for when arming the timer with
 * initial conditions.  That is, main counter
@@ -1025,19 +958,12 @@

static int __init hpet_init(void)
{
-    struct proc_dir_entry *entry;
-
    (void)acpi_bus_register_driver(&hpet_acpi_driver);

    if (hpets) {
        if (misc_register(&hpet_misc))
            return -ENODEV;

-        entry = create_proc_entry("driver/hpet", 0, 0);
-
-        if (entry)
-            entry->proc_fops = &hpet_proc_fops;
-
        sysctl_header = register_sysctl_table(dev_root, 0);

#ifdef    CONFIG_TIME_INTERPOLATION
@@ -1062,10 +988,8 @@
{
    acpi_bus_unregister_driver(&hpet_acpi_driver);

-    if (hpets) {
+    if (hpets)         unregister_sysctl_table(sysctl_header);
-        remove_proc_entry("driver/hpet", NULL);
-    }

    return;
}
diff -ruN -X /home/picco/losl/dontdiff 
linux-2.6.7-mm1-orig/include/linux/hpet.h 
linux-2.6.7-mm1-hpet/include/linux/hpet.h
--- linux-2.6.7-mm1-orig/include/linux/hpet.h    2004-06-21 
07:43:05.000000000 -0400
+++ linux-2.6.7-mm1-hpet/include/linux/hpet.h    2004-06-21 
07:48:31.000000000 -0400
@@ -115,6 +115,8 @@
    void *ht_opaque;
};

+#define    HD_STATE(HD, TIMER)    (HD)->hd_state |= (1 << TIMER)
+
struct hpet_data {
    unsigned long hd_address;
    unsigned short hd_nirqs;
diff -ruN -X /home/picco/losl/dontdiff 
linux-2.6.7-mm1-orig/include/linux/miscdevice.h 
linux-2.6.7-mm1-hpet/include/linux/miscdevice.h
--- linux-2.6.7-mm1-orig/include/linux/miscdevice.h    2004-06-21 
07:43:05.000000000 -0400
+++ linux-2.6.7-mm1-hpet/include/linux/miscdevice.h    2004-06-21 
10:20:47.000000000 -0400
@@ -33,9 +33,9 @@
#define SGI_STREAMS_KEYBOARD 150
/* drivers/sgi/char/usema.c */
#define SGI_USEMACLONE         151
-#define    HPET_MINOR         152

#define TUN_MINOR         200
+#define    HPET_MINOR         228

struct device;






