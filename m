Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281685AbRKQCZp>; Fri, 16 Nov 2001 21:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281687AbRKQCZi>; Fri, 16 Nov 2001 21:25:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46576 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281685AbRKQCZZ>;
	Fri, 16 Nov 2001 21:25:25 -0500
Date: Fri, 16 Nov 2001 21:25:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "David S. Miller" <davem@redhat.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] more procfs fixes.
In-Reply-To: <20011115.045535.99284023.davem@redhat.com>
Message-ID: <Pine.GSO.4.21.0111162023270.9583-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Nov 2001, David S. Miller wrote:

> I like this patch but I would change one thing.
> 
> "start,next,stop" sound like global kernel helper functions, not PCI
> SEQ specific helpers, why not name them pci_seq_start et al. instead?

Umm... IMO start(), next(), stop() for anything non-static sounds like a
reason for very public execution, but anyway, renaming makes sense.
 
> That pci_devices list does need locking, particularly with the PCI hot
> plug stuff in the tree now.  But PCMCIA could already change the list
> after boot too if I'm not mistaken.

It certainly does.  However, that's a problem I'd be happy to leave to
PCI folks ;-)

OK, here's the next bunch of procfs stuff:
	a) drivers/pci/proc.c
	b) trivial cleanup of ia64 show_cpuinfo() (we never pass NULL as
the second argument, it's EOF indicator for seq_read()).
	c) conversion of s390, s390x and sh get_cpuinfo().

Linus, please apply.

diff -urN S15-pre5/arch/alpha/kernel/setup.c S15-pre5-current/arch/alpha/kernel/setup.c
--- S15-pre5/arch/alpha/kernel/setup.c	Thu Nov 15 23:42:54 2001
+++ S15-pre5-current/arch/alpha/kernel/setup.c	Fri Nov 16 20:49:55 2001
@@ -1064,8 +1064,6 @@
 	char *sysvariation_name;
 	int nr_processors;
 
-	if (!cpu)
-		return 1;
 	cpu_index = (unsigned) (cpu->type - 1);
 	cpu_name = "Unknown";
 	if (cpu_index < N(cpu_names))
diff -urN S15-pre5/arch/s390/kernel/setup.c S15-pre5-current/arch/s390/kernel/setup.c
--- S15-pre5/arch/s390/kernel/setup.c	Wed Oct 24 04:09:51 2001
+++ S15-pre5-current/arch/s390/kernel/setup.c	Fri Nov 16 21:07:54 2001
@@ -34,6 +34,7 @@
 #endif
 #include <linux/bootmem.h>
 #include <linux/console.h>
+#include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/smp.h>
@@ -478,49 +479,48 @@
 }
 
 /*
- * get_cpuinfo - Get information on one CPU for use by procfs.
- *
- *	Prints info on the next CPU into buffer.  Beware, doesn't check for
- *	buffer overflow.  Current implementation of procfs assumes that the
- *	resulting data is <= 1K.
- *
- * Args:
- *	buffer	-- you guessed it, the data buffer
- *	cpu_np	-- Input: next cpu to get (start at 0).  Output: Updated.
- *
- *	Returns number of bytes written to buffer.
+ * show_cpuinfo - Get information on one CPU for use by procfs.
  */
 
-int get_cpuinfo(char *buffer, unsigned *cpu_np)
+static int show_cpuinfo(struct seq_file *m, void *v)
 {
         struct cpuinfo_S390 *cpuinfo;
-        char *p = buffer;
-	unsigned n;
+	unsigned n = v;
 
-	n = *cpu_np;
-	while (n < NR_CPUS && (cpu_online_map & (1 << n)) == 0)
-		n++;
-	if (n >= NR_CPUS) {
-		*cpu_np = NR_CPUS;
-		return (0);
-	}
-	*cpu_np = n + 1;
-
-	if (n == 0) {
-		p += sprintf(p,"vendor_id       : IBM/S390\n"
+	if (!n--) {
+		seq_printf(m, "vendor_id       : IBM/S390\n"
 			       "# processors    : %i\n"
 			       "bogomips per cpu: %lu.%02lu\n",
 			       smp_num_cpus, loops_per_jiffy/(500000/HZ),
 			       (loops_per_jiffy/(5000/HZ))%100);
+	} else if (cpu_online_map & (1 << n)) {
+		cpuinfo = &safe_get_cpu_lowcore(n).cpu_data;
+		seq_printf(m, "processor %i: "
+			       "version = %02X,  "
+			       "identification = %06X,  "
+			       "machine = %04X\n",
+			       n, cpuinfo->cpu_id.version,
+			       cpuinfo->cpu_id.ident,
+			       cpuinfo->cpu_id.machine);
 	}
-	cpuinfo = &safe_get_cpu_lowcore(n).cpu_data;
-	p += sprintf(p,"processor %i: "
-		       "version = %02X,  "
-		       "identification = %06X,  "
-		       "machine = %04X\n",
-		       n, cpuinfo->cpu_id.version,
-		       cpuinfo->cpu_id.ident,
-		       cpuinfo->cpu_id.machine);
-        return p - buffer;
+        return 0;
 }
 
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return *pos <= NR_CPUS ? (void)(*pos+1) : NULL;
+}
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return c_start(m, pos);
+}
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+struct seq_operations cpuinfo_op = {
+	start:	c_start,
+	next:	c_next,
+	stop:	c_stop,
+	show:	show_cpuinfo,
+};
diff -urN S15-pre5/arch/s390x/kernel/setup.c S15-pre5-current/arch/s390x/kernel/setup.c
--- S15-pre5/arch/s390x/kernel/setup.c	Wed Oct 24 04:09:53 2001
+++ S15-pre5-current/arch/s390x/kernel/setup.c	Fri Nov 16 21:08:10 2001
@@ -34,6 +34,7 @@
 #endif
 #include <linux/bootmem.h>
 #include <linux/console.h>
+#include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/smp.h>
@@ -467,49 +468,48 @@
 }
 
 /*
- * get_cpuinfo - Get information on one CPU for use by procfs.
- *
- *	Prints info on the next CPU into buffer.  Beware, doesn't check for
- *	buffer overflow.  Current implementation of procfs assumes that the
- *	resulting data is <= 1K.
- *
- * Args:
- *	buffer	-- you guessed it, the data buffer
- *	cpu_np	-- Input: next cpu to get (start at 0).  Output: Updated.
- *
- *	Returns number of bytes written to buffer.
+ * show_cpuinfo - Get information on one CPU for use by procfs.
  */
 
-int get_cpuinfo(char *buffer, unsigned *cpu_np)
+static int show_cpuinfo(struct seq_file *m, void *v)
 {
         struct cpuinfo_S390 *cpuinfo;
-        char *p = buffer;
-	unsigned n;
+	unsigned n = v;
 
-	n = *cpu_np;
-	while (n < NR_CPUS && (cpu_online_map & (1 << n)) == 0)
-		n++;
-	if (n >= NR_CPUS) {
-		*cpu_np = NR_CPUS;
-		return (0);
-	}
-	*cpu_np = n + 1;
-
-	if (n == 0) {
-		p += sprintf(p, "vendor_id       : IBM/S390\n"
+	if (!n--) {
+		seq_printf(m, "vendor_id       : IBM/S390\n"
 				"# processors    : %i\n"
 				"bogomips per cpu: %lu.%02lu\n",
 				smp_num_cpus, loops_per_jiffy/(500000/HZ),
 				(loops_per_jiffy/(5000/HZ))%100);
+	} else if (cpu_online_map & (1 << n)) {
+		cpuinfo = &safe_get_cpu_lowcore(n).cpu_data;
+		seq_printf(m, "processor %i: "
+				"version = %02X,  "
+				"identification = %06X,  "
+				"machine = %04X\n",
+				n, cpuinfo->cpu_id.version,
+				cpuinfo->cpu_id.ident,
+				cpuinfo->cpu_id.machine);
 	}
-	cpuinfo = &safe_get_cpu_lowcore(n).cpu_data;
-	p += sprintf(p, "processor %i: "
-			"version = %02X,  "
-			"identification = %06X,  "
-			"machine = %04X\n",
-			n, cpuinfo->cpu_id.version,
-			cpuinfo->cpu_id.ident,
-			cpuinfo->cpu_id.machine);
-        return p - buffer;
+        return 0;
 }
 
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return *pos <= NR_CPUS ? (void)(*pos+1) : NULL;
+}
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return c_start(m, pos);
+}
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+struct seq_operations cpuinfo_op = {
+	start:	c_start,
+	next:	c_next,
+	stop:	c_stop,
+	show:	show_cpuinfo,
+};
diff -urN S15-pre5/arch/sh/kernel/setup.c S15-pre5-current/arch/sh/kernel/setup.c
--- S15-pre5/arch/sh/kernel/setup.c	Sun Sep 23 16:11:57 2001
+++ S15-pre5-current/arch/sh/kernel/setup.c	Fri Nov 16 21:11:22 2001
@@ -31,6 +31,7 @@
 #include <linux/bootmem.h>
 #include <linux/console.h>
 #include <linux/ctype.h>
+#include <linux/seq_file.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -517,24 +518,22 @@
  *	Get CPU information for use by the procfs.
  */
 #ifdef CONFIG_PROC_FS
-int get_cpuinfo(char *buffer)
+static int show_cpuinfo(struct seq_file *m, void *v)
 {
-	char *p = buffer;
-
 #if defined(__sh3__)
-	p += sprintf(p,"cpu family\t: SH-3\n"
-		       "cache size\t: 8K-byte\n");
+	seq_printf(m, "cpu family\t: SH-3\n"
+		      "cache size\t: 8K-byte\n");
 #elif defined(__SH4__)
-	p += sprintf(p,"cpu family\t: SH-4\n"
-		       "cache size\t: 8K-byte/16K-byte\n");
+	seq_printf(m, "cpu family\t: SH-4\n"
+		      "cache size\t: 8K-byte/16K-byte\n");
 #endif
-	p += sprintf(p, "bogomips\t: %lu.%02lu\n\n",
+	seq_printf(m, "bogomips\t: %lu.%02lu\n\n",
 		     loops_per_jiffy/(500000/HZ),
 		     (loops_per_jiffy/(5000/HZ)) % 100);
-	p += sprintf(p, "Machine: %s\n", sh_mv.mv_name);
+	seq_printf(m, "Machine: %s\n", sh_mv.mv_name);
 
 #define PRINT_CLOCK(name, value) \
-	p += sprintf(p, name " clock: %d.%02dMHz\n", \
+	seq_printf(m, name " clock: %d.%02dMHz\n", \
 		     ((value) / 1000000), ((value) % 1000000)/10000)
 	
 	PRINT_CLOCK("CPU", boot_cpu_data.cpu_clock);
@@ -544,6 +543,24 @@
 #endif
 	PRINT_CLOCK("Peripheral module", boot_cpu_data.module_clock);
 
-	return p - buffer;
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return (void*)(*pos == 0);
 }
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return NULL;
+}
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+struct seq_operations cpuinfo_op = {
+	start:	c_start,
+	next:	c_next,
+	stop:	c_stop,
+	show:	show_cpuinfo,
+};
 #endif
diff -urN S15-pre5/drivers/pci/proc.c S15-pre5-current/drivers/pci/proc.c
--- S15-pre5/drivers/pci/proc.c	Thu Nov 15 23:43:02 2001
+++ S15-pre5-current/drivers/pci/proc.c	Fri Nov 16 20:29:59 2001
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -302,53 +303,72 @@
 #define LONG_FORMAT "\t%16lx"
 #endif
 
-static int
-get_pci_dev_info(char *buf, char **start, off_t pos, int count)
+/* iterator */
+static void *pci_seq_start(struct seq_file *m, loff_t *pos)
 {
+	struct list_head *p = &pci_devices;
+	loff_t n = *pos;
+
+	/* XXX: surely we need some locking for traversing the list? */
+	while (n--) {
+		p = p->next;
+		if (p == &pci_devices)
+			return NULL;
+	}
+	return p;
+}
+static void *pci_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct list_head *p = v;
+	(*pos)++;
+	return p->next != &pci_devices ? p->next : NULL;
+}
+static void pci_seq_stop(struct seq_file *m, void *v)
+{
+	/* release whatever locks we need */
+}
+
+static int show_device(struct seq_file *m, void *v)
+{
+	struct list_head *p = v;
 	const struct pci_dev *dev;
-	off_t at = 0;
-	int len, i, cnt;
+	const struct pci_driver *drv;
+	int i;
+
+	if (p == &pci_devices)
+		return 0;
 
-	cnt = 0;
-	pci_for_each_dev(dev) {
-		const struct pci_driver *drv = pci_dev_driver(dev);
-		len = sprintf(buf, "%02x%02x\t%04x%04x\t%x",
+	dev = pci_dev_g(p);
+	drv = pci_dev_driver(dev);
+	seq_printf(m, "%02x%02x\t%04x%04x\t%x",
 			dev->bus->number,
 			dev->devfn,
 			dev->vendor,
 			dev->device,
 			dev->irq);
-		/* Here should be 7 and not PCI_NUM_RESOURCES as we need to preserve compatibility */
-		for(i=0; i<7; i++)
-			len += sprintf(buf+len, LONG_FORMAT,
-				       dev->resource[i].start | (dev->resource[i].flags & PCI_REGION_FLAG_MASK));
-		for(i=0; i<7; i++)
-			len += sprintf(buf+len, LONG_FORMAT, dev->resource[i].start < dev->resource[i].end ?
-				       dev->resource[i].end - dev->resource[i].start + 1 : 0);
-		buf[len++] = '\t';
-		if (drv)
-			len += sprintf(buf+len, "%s", drv->name);
-		buf[len++] = '\n';
-		at += len;
-		if (at >= pos) {
-			if (!*start) {
-				*start = buf + (pos - (at - len));
-				cnt = at - pos;
-			} else
-				cnt += len;
-			buf += len;
-			if (cnt >= count)
-				/*
-				 * proc_file_read() gives us 1KB of slack so it's OK if the
-				 * above printfs write a little beyond the buffer end (we
-				 * never write more than 1KB beyond the buffer end).
-				 */
-				break;
-		}
-	}
-	return (count > cnt) ? cnt : count;
+	/* Here should be 7 and not PCI_NUM_RESOURCES as we need to preserve compatibility */
+	for(i=0; i<7; i++)
+		seq_printf(m, LONG_FORMAT,
+			dev->resource[i].start |
+			(dev->resource[i].flags & PCI_REGION_FLAG_MASK));
+	for(i=0; i<7; i++)
+		seq_printf(m, LONG_FORMAT,
+			dev->resource[i].start < dev->resource[i].end ?
+			dev->resource[i].end - dev->resource[i].start + 1 : 0);
+	seq_putc(m, '\t');
+	if (drv)
+		seq_printf(m, "%s", drv->name);
+	seq_putc(m, '\n');
+	return 0;
 }
 
+static struct seq_operations proc_bus_pci_devices_op = {
+	start:	pci_seq_start,
+	next:	pci_seq_next,
+	stop:	pci_seq_stop,
+	show:	show_device
+};
+
 static struct proc_dir_entry *proc_bus_pci_dir;
 
 int pci_proc_attach_device(struct pci_dev *dev)
@@ -388,10 +408,10 @@
 
 int pci_proc_attach_bus(struct pci_bus* bus)
 {
-	struct proc_dir_entry *de;
-	char name[16];
+	struct proc_dir_entry *de = bus->procdir;
 
-	if (!(de = bus->procdir)) {
+	if (!de) {
+		char name[16];
 		sprintf(name, "%02x", bus->number);
 		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
 		if (!de)
@@ -402,11 +422,9 @@
 
 int pci_proc_detach_bus(struct pci_bus* bus)
 {
-	struct proc_dir_entry *de;
-
-	if (!(de = bus->procdir)) {
+	struct proc_dir_entry *de = bus->procdir;
+	if (de)
 		remove_proc_entry(de->name, proc_bus_pci_dir);
-	}
 	return 0;
 }
 
@@ -421,54 +439,56 @@
  * The configuration string is stored starting at buf[len].  If the
  * string would exceed the size of the buffer (SIZE), 0 is returned.
  */
-static int sprint_dev_config(struct pci_dev *dev, char *buf, int size)
+static int show_dev_config(struct seq_file *m, void *v)
 {
+	struct list_head *p = v;
+	struct pci_dev *dev;
+	struct pci_driver *drv;
 	u32 class_rev;
 	unsigned char latency, min_gnt, max_lat, *class;
-	int reg, len = 0;
+	int reg;
+
+	if (p == &pci_devices) {
+		seq_puts(m, "PCI devices found:\n");
+		return 0;
+	}
+
+	dev = pci_dev_g(p);
+	drv = pci_dev_driver(dev);
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	pci_read_config_byte (dev, PCI_LATENCY_TIMER, &latency);
 	pci_read_config_byte (dev, PCI_MIN_GNT, &min_gnt);
 	pci_read_config_byte (dev, PCI_MAX_LAT, &max_lat);
-	if (len + 160 > size)
-		return -1;
-	len += sprintf(buf + len, "  Bus %2d, device %3d, function %2d:\n",
-		       dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	seq_printf(m, "  Bus %2d, device %3d, function %2d:\n",
+	       dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	class = pci_class_name(class_rev >> 16);
 	if (class)
-		len += sprintf(buf+len, "    %s", class);
+		seq_printf(m, "    %s", class);
 	else
-		len += sprintf(buf+len, "    Class %04x", class_rev >> 16);
-	len += sprintf(buf+len, ": %s (rev %d).\n", dev->name, class_rev & 0xff);
+		seq_printf(m, "    Class %04x", class_rev >> 16);
+	seq_printf(m, ": %s (rev %d).\n", dev->name, class_rev & 0xff);
 
-	if (dev->irq) {
-		if (len + 40 > size)
-			return -1;
-		len += sprintf(buf + len, "      IRQ %d.\n", dev->irq);
-	}
+	if (dev->irq)
+		seq_printf(m, "      IRQ %d.\n", dev->irq);
 
 	if (latency || min_gnt || max_lat) {
-		if (len + 80 > size)
-			return -1;
-		len += sprintf(buf + len, "      Master Capable.  ");
+		seq_printf(m, "      Master Capable.  ");
 		if (latency)
-		  len += sprintf(buf + len, "Latency=%d.  ", latency);
+			seq_printf(m, "Latency=%d.  ", latency);
 		else
-		  len += sprintf(buf + len, "No bursts.  ");
+			seq_puts(m, "No bursts.  ");
 		if (min_gnt)
-		  len += sprintf(buf + len, "Min Gnt=%d.", min_gnt);
+			seq_printf(m, "Min Gnt=%d.", min_gnt);
 		if (max_lat)
-		  len += sprintf(buf + len, "Max Lat=%d.", max_lat);
-		len += sprintf(buf + len, "\n");
+			seq_printf(m, "Max Lat=%d.", max_lat);
+		seq_putc(m, '\n');
 	}
 
 	for (reg = 0; reg < 6; reg++) {
 		struct resource *res = dev->resource + reg;
 		unsigned long base, end, flags;
 
-		if (len + 40 > size)
-			return -1;
 		base = res->start;
 		end = res->end;
 		flags = res->flags;
@@ -476,9 +496,8 @@
 			continue;
 
 		if (flags & PCI_BASE_ADDRESS_SPACE_IO) {
-			len += sprintf(buf + len,
-				       "      I/O at 0x%lx [0x%lx].\n",
-				       base, end);
+			seq_printf(m, "      I/O at 0x%lx [0x%lx].\n",
+				base, end);
 		} else {
 			const char *pref, *type = "unknown";
 
@@ -494,65 +513,58 @@
 			      case PCI_BASE_ADDRESS_MEM_TYPE_64:
 				type = "64 bit"; break;
 			}
-			len += sprintf(buf + len,
-				       "      %srefetchable %s memory at "
+			seq_printf(m, "      %srefetchable %s memory at "
 				       "0x%lx [0x%lx].\n", pref, type,
 				       base,
 				       end);
 		}
 	}
-
-	return len;
+	return 0;
 }
 
-/*
- * Return list of PCI devices as a character string for /proc/pci.
- * BUF is a buffer that is PAGE_SIZE bytes long.
- */
-static int pci_read_proc(char *buf, char **start, off_t off,
-				int count, int *eof, void *data)
-{
-	int nprinted, len, begin = 0;
-	struct pci_dev *dev;
-
-	len = sprintf(buf, "PCI devices found:\n");
+static struct seq_operations proc_pci_op = {
+	start:	pci_seq_start,
+	next:	pci_seq_next,
+	stop:	pci_seq_stop,
+	show:	show_dev_config
+};
 
-	*eof = 1;
-	pci_for_each_dev(dev) {
-		nprinted = sprint_dev_config(dev, buf + len, PAGE_SIZE - len);
-		if (nprinted < 0) {
-			*eof = 0;
-			break;
-		}
-		len += nprinted;
-		if (len+begin < off) {
-			begin += len;
-			len = 0;
-		}
-		if (len+begin >= off+count)
-			break;
-	}
-	off -= begin;
-	*start = buf + off;
-	len -= off;
-	if (len>count)
-		len = count;
-	if (len<0)
-		len = 0;
-	return len;
+static int proc_bus_pci_dev_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &proc_bus_pci_devices_op);
 }
+static struct file_operations proc_bus_pci_dev_operations = {
+	open:		proc_bus_pci_dev_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
+static int proc_pci_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &proc_pci_op);
+}
+static struct file_operations proc_pci_operations = {
+	open:		proc_pci_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
 
 static int __init pci_proc_init(void)
 {
 	if (pci_present()) {
+		struct proc_dir_entry *entry;
 		struct pci_dev *dev;
 		proc_bus_pci_dir = proc_mkdir("pci", proc_bus);
-		create_proc_info_entry("devices", 0, proc_bus_pci_dir,
-					get_pci_dev_info);
+		entry = create_proc_entry("devices", 0, proc_bus_pci_dir);
+		if (entry)
+			entry->proc_fops = &proc_bus_pci_dev_operations;
 		pci_for_each_dev(dev) {
 			pci_proc_attach_device(dev);
 		}
-		create_proc_read_entry("pci", 0, NULL, pci_read_proc, NULL);
+		entry = create_proc_entry("pci", 0, NULL);
+		if (entry)
+			entry->proc_fops = &proc_pci_operations;
 	}
 	return 0;
 }

