Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293697AbSCFRRW>; Wed, 6 Mar 2002 12:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293712AbSCFRRQ>; Wed, 6 Mar 2002 12:17:16 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:9737 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S293697AbSCFRRF>; Wed, 6 Mar 2002 12:17:05 -0500
Message-ID: <3C864F07.8050806@linkvest.com>
Date: Wed, 06 Mar 2002 18:16:55 +0100
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Rework of /proc/stat
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2002 17:16:55.0362 (UTC) FILETIME=[B7135A20:01C1C532]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I've made a new version of IO statistics in kstat that remove the
previous limitations of MAX_MAJOR
I've made tests on my machine.
Could someone test it, please?
Feedback welcome.
Bye
-jec

--- /tmp/linux-2.4.18-vanilla/include/linux/kernel_stat.h	Thu Nov 22 20:46:19 2001
+++ /toc/linux-2.4.18-reempt/include/linux/kernel_stat.h	Wed Mar  6 18:02:57 2002
@@ -12,18 +12,37 @@
   * used by rstatd/perfmeter
   */

-#define DK_MAX_MAJOR 16
-#define DK_MAX_DISK 16
+#define DK_MAX_DEVICES 64
+#define DK_BUCKETS 256
+
+
+struct _kstat_block_io
+{
+    struct _kstat_block_io* next;
+
+ 
unsigned int major;
+    unsigned int minor;
+
+ 
unsigned int io;
+    unsigned int rio;
+    unsigned int wio;
+    unsigned int rblk;
+    unsigned int wblk;
+};
+typedef struct _kstat_block_io kstat_block_io;
+
+
+/* static array of IO stats */
+extern unsigned int kstat_devices_current_index;
+extern kstat_block_io kstat_devices_array[DK_MAX_DEVICES];
+
+

  struct kernel_stat {
  	unsigned int per_cpu_user[NR_CPUS],
  	             per_cpu_nice[NR_CPUS],
  	             per_cpu_system[NR_CPUS];
- 
unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
- 
unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
- 
unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
- 
unsigned int dk_drive_rblk[DK_MAX_MAJOR][DK_MAX_DISK];
- 
unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
+    kstat_block_io* io_stat_tbl[DK_BUCKETS];
  	unsigned int pgpgin, pgpgout;
  	unsigned int pswpin, pswpout;
  #if !defined(CONFIG_ARCH_S390)
@@ -37,6 +56,103 @@

  extern struct kernel_stat kstat;

+
+
+/* Size of the table */
+extern const unsigned int kstat_block_io_tbl_size;
+
+/* hash function */
+static inline unsigned kstat_block_io_hash(unsigned int major, unsigned 
int minor)
+{
+       return major * 1999 ^ minor;
+}
+
+
+/* add an IO stat */
+static inline kstat_block_io* kstat_block_io_add(unsigned int major, 
unsigned int minor)
+{
+    unsigned int i;
+ 
kstat_block_io* p;
+    kstat_block_io* pstat;
+
+ 
if (kstat_devices_current_index >= DK_MAX_DEVICES)
+ 
{
+ 
     printk("ERROR: kstat: No more slot for device IO stats. Try 
extending DK_MAX_DEVICES\n");
+ 
     return 0;
+ 
}
+
+    pstat = &kstat_devices_array[kstat_devices_current_index];
+ 
kstat_devices_current_index++;
+    pstat->next = 0;
+    pstat->major = major;
+    pstat->minor = minor;
+    pstat->io = 0;
+    pstat->rio = 0;
+    pstat->wio = 0;
+    pstat->rblk = 0;
+    pstat->wblk = 0;
+
+    i = kstat_block_io_hash(major, minor) % kstat_block_io_tbl_size;
+    p = kstat.io_stat_tbl[i];
+ 
if (p == 0)
+ 
{
+ 
     kstat.io_stat_tbl[i] = pstat;
+ 
}
+ 
else
+ 
{
+ 
     printk("WARNING: kstat: Collision found in IO stat accounting table 
(add). Try extending DK_BUCKETS\n");
+        while (p->next != 0)
+ 
	{
+            p = p->next;
+ 
	}
+ 
     p->next = pstat;
+ 
}
+ 
return pstat;
+}
+
+/* lookup an IO stat */
+static inline kstat_block_io* kstat_block_io_lookup(unsigned major, 
unsigned minor)
+{
+ 
unsigned int i = kstat_block_io_hash(major, minor) % 
kstat_block_io_tbl_size;
+ 
kstat_block_io* p = kstat.io_stat_tbl[i];
+ 
while (p && p->major != major && p->minor != minor)
+ 
{
+ 
     printk("WARNING: kstat: Collision found in IO stat accounting table 
(lookup). Try extending DK_BUCKETS\n");
+ 
	p = p->next;
+ 
}
+ 
if (p == 0)
+ 
{
+ 
     p = kstat_block_io_add(major, minor);
+ 
	if (p == 0)
+ 
	{
+ 
	    return 0;
+ 
	}
+ 
}
+ 
return p;
+}
+
+/* This is used by MD to see if IDLE */
+static inline unsigned long kstat_get_rwblk(unsigned int major, 
unsigned int minor)
+{
+    kstat_block_io* stat = kstat_block_io_lookup(major, minor);
+    if (stat == 0)
+ 
{
+ 
     printk("ERROR: kstat: No IO stat found for (%d/%d)\n", major, minor);
+        return 0;
+ 
}
+    return stat->rblk + stat->wblk;
+}
+
+
+
+
+
+
+
+
+
+
+
  #if !defined(CONFIG_ARCH_S390)
  /*
   * Number of interrupts per specific IRQ source, since bootup
--- /tmp/linux-2.4.18-vanilla/drivers/md/md.c	Mon Feb 25 20:37:58 2002
+++ /toc/linux-2.4.18-reempt/drivers/md/md.c	Wed Mar  6 16:46:56 2002
@@ -3284,6 +3284,9 @@
  	return NULL;
  }

+/* MD devices are major=9 and minor=1-31 */
+#define DK_MAX_MAJOR 16
+#define DK_MAX_DISK 32
  static unsigned int sync_io[DK_MAX_MAJOR][DK_MAX_DISK];
  void md_sync_acct(kdev_t dev, unsigned long nr_sectors)
  {
@@ -3305,15 +3308,12 @@
  	unsigned long curr_events;

  	idle = 1;
- 
ITERATE_RDEV(mddev,rdev,tmp) {
+ 
ITERATE_RDEV(mddev,rdev,tmp)
+ 
{
  		int major = MAJOR(rdev->dev);
  		int idx = disk_index(rdev->dev);

- 
	if ((idx >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
- 
		continue;
-
- 
	curr_events = kstat.dk_drive_rblk[major][idx] +
- 
					kstat.dk_drive_wblk[major][idx] ;
+        curr_events = kstat_get_rwblk(major, idx);
  		curr_events -= sync_io[major][idx];
  		if ((curr_events - rdev->last_events) > 32) {
  	 
	rdev->last_events = curr_events;
--- /tmp/linux-2.4.18-vanilla/drivers/block/ll_rw_blk.c	Mon Feb 25 20:37:57 2002
+++ /toc/linux-2.4.18-reempt/drivers/block/ll_rw_blk.c	Wed Mar  6 18:12:03 2002
@@ -501,19 +501,22 @@
  	 
		unsigned long nr_sectors, int new_io)
  {
  	unsigned int major = MAJOR(dev);
- 
unsigned int index;
+ 
unsigned int minor = MINOR(dev);
+    kstat_block_io* stat = kstat_block_io_lookup(major, minor);

- 
index = disk_index(dev);
- 
if ((index >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
- 
	return;
+    if (stat == 0)
+    {
+ 
     printk("ERROR: kstat: Haven't found an IO stat struct for major=%d 
/ minor=%d\n", major, minor);
+        return;
+ 
}

- 
kstat.dk_drive[major][index] += new_io;
+ 
stat->io += new_io;
  	if (rw == READ) {
- 
	kstat.dk_drive_rio[major][index] += new_io;
- 
	kstat.dk_drive_rblk[major][index] += nr_sectors;
+ 
	stat->rio += new_io;
+ 
	stat->rblk += nr_sectors;
  	} else if (rw == WRITE) {
- 
	kstat.dk_drive_wio[major][index] += new_io;
- 
	kstat.dk_drive_wblk[major][index] += nr_sectors;
+ 
	stat->wio += new_io;
+ 
	stat->wblk += nr_sectors;
  	} else
  		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
  }
--- /tmp/linux-2.4.18-vanilla/fs/proc/proc_misc.c	Wed Nov 21 06:29:09 2001
+++ /toc/linux-2.4.18-reempt/fs/proc/proc_misc.c	Wed Mar  6 17:41:28 2002
@@ -282,25 +282,19 @@
  		len += sprintf(page + len, " %u", kstat_irqs(i));
  #endif

- 
len += sprintf(page + len, "\ndisk_io: ");
+    len += sprintf(page + len, "\ndisk_io: ");

- 
for (major = 0; major < DK_MAX_MAJOR; major++) {
- 
	for (disk = 0; disk < DK_MAX_DISK; disk++) {
- 
		int active = kstat.dk_drive[major][disk] +
- 
			kstat.dk_drive_rblk[major][disk] +
- 
			kstat.dk_drive_wblk[major][disk];
- 
		if (active)
- 
			len += sprintf(page + len,
- 
				"(%u,%u):(%u,%u,%u,%u,%u) ",
- 
				major, disk,
- 
				kstat.dk_drive[major][disk],
- 
				kstat.dk_drive_rio[major][disk],
- 
				kstat.dk_drive_rblk[major][disk],
- 
				kstat.dk_drive_wio[major][disk],
- 
				kstat.dk_drive_wblk[major][disk]
- 
		);
- 
	}
- 
}
+    for (i = 0; i < kstat_devices_current_index; i++)
+    {
+        kstat_block_io* stat = &kstat_devices_array[i];
+        len += sprintf( page + len, "(%u,%u):(%u,%u,%u,%u,%u) ",
+                        stat->major, stat->minor,
+                        stat->io,
+                        stat->rio,
+                        stat->wio,
+                        stat->rblk,
+                        stat->wblk );
+    }

  	len += sprintf(page + len,

  		"\nctxt %u\n"



