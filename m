Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSIPL5g>; Mon, 16 Sep 2002 07:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261932AbSIPL4q>; Mon, 16 Sep 2002 07:56:46 -0400
Received: from dp.samba.org ([66.70.73.150]:19913 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261855AbSIPLzZ>;
	Mon, 16 Sep 2002 07:55:25 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Experimental IDE oops dumper v0.1
Date: Mon, 16 Sep 2002 21:52:46 +1000
Message-Id: <20020916120022.AD2EA2C06F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Been on my TODO list for a while, finally got around to polishing it
off.  Some work still to do before it can be included, but you get the
idea.

Rusty.

>From oopser-0.1/MOTIVATION:

The aim of this software is to make reporting kernel oopses possible
for inexperienced users, in a way which doesn't violate their privacy
by sending out information without their knowledge.  The days of ever
Linux user being able to set up a serial console have long gone.

The hope is that significant feedback will allow statistical analysis
of hardware and software combinations, making the Linux Kernel more
stable.  Since most Linux users are on x86, with IDE disks, this is
the first aim of the oops dumper.

*Any* crashes are bad, but users tend to ignore a once-a-month lockup
(eg. panic while in X).  Hopefully this code will allow some of those
bug reports to make it back to us.

I hope that distribution vendors will pick this up, perhaps arming the
module after noticing an unclean filesystem at boot (it does, after
all, take about 60k to hold the compressed kernel symbols).  I also
ask that they coordinate with the Oops Team to arrange for a single
public anonomyzed database where users and coders can query for
problems.

Cheers!
Rusty.
Sep 16 2002.

================
Name: IDE Oops Dumper for x86
Author: Rusty Russell
Status: Tested on 2.5.34 i386 SMP

D: This is an experimental IDE oops dumper for 2.5.  To test it you
D: will need the userspace utilities from:
D:	http://www.kernel.org/pub/linux/kernel/people/rusty/oopser-0.1.tar.gz

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/arch/i386/kernel/i386_ksyms.c working-2.5.34-oopser/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.34/arch/i386/kernel/i386_ksyms.c	Sun Sep  1 12:22:57 2002
+++ working-2.5.34-oopser/arch/i386/kernel/i386_ksyms.c	Fri Sep 13 17:19:35 2002
@@ -172,3 +172,4 @@ extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+EXPORT_SYMBOL(oops_handler);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/arch/i386/kernel/traps.c working-2.5.34-oopser/arch/i386/kernel/traps.c
--- linux-2.5.34/arch/i386/kernel/traps.c	Sun Sep  1 12:22:57 2002
+++ working-2.5.34-oopser/arch/i386/kernel/traps.c	Thu Sep 12 22:50:18 2002
@@ -90,6 +90,7 @@ asmlinkage void machine_check(void);
 
 static int kstack_depth_to_print = 24;
 
+int (*oops_handler)(const char *str, struct pt_regs *regs, long err);
 
 /*
  * If the address is either in the .text section of the
@@ -279,6 +280,15 @@ spinlock_t die_lock = SPIN_LOCK_UNLOCKED
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
+	if (oops_handler) {
+		int ret;
+		local_irq_disable();
+		ret = oops_handler(str, regs, err);
+		local_irq_enable();
+		/* They had an oops handler, but it failed.  Get word out */
+		if (ret != 0)
+			printk(KERN_EMERG "Oops handler failed: %i\n", ret);
+	}
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/drivers/char/Config.in working-2.5.34-oopser/drivers/char/Config.in
--- linux-2.5.34/drivers/char/Config.in	Wed Aug 28 09:29:44 2002
+++ working-2.5.34-oopser/drivers/char/Config.in	Thu Sep 12 18:17:56 2002
@@ -206,4 +206,6 @@ fi
 
 tristate '  RAW driver (/dev/raw/rawN)' CONFIG_RAW_DRIVER
 
+dep_tristate '/dev/oopser support (EXPERIMENTAL)' CONFIG_OOPSER $CONFIG_EXPERIMENTAL
+
 endmenu
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/drivers/char/Makefile working-2.5.34-oopser/drivers/char/Makefile
--- linux-2.5.34/drivers/char/Makefile	Tue Sep 10 09:11:17 2002
+++ working-2.5.34-oopser/drivers/char/Makefile	Thu Sep 12 22:54:46 2002
@@ -99,6 +99,7 @@ obj-$(CONFIG_MWAVE) += mwave/
 obj-$(CONFIG_AGP) += agp/
 obj-$(CONFIG_DRM) += drm/
 obj-$(CONFIG_PCMCIA) += pcmcia/
+obj-$(CONFIG_OOPSER) += oopser/
 
 include $(TOPDIR)/Rules.make
 
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/drivers/char/oopser/Makefile working-2.5.34-oopser/drivers/char/oopser/Makefile
--- linux-2.5.34/drivers/char/oopser/Makefile	Thu Jan  1 10:00:00 1970
+++ working-2.5.34-oopser/drivers/char/oopser/Makefile	Mon Sep 16 18:19:16 2002
@@ -0,0 +1,28 @@
+#
+# Makefile for /dev/oopser support.
+#
+list-multi := oopser_dev.o
+
+obj-$(CONFIG_OOPSER) += oopser_dev.o
+
+oopser_dev-objs-y = interface.o dumper.o
+oopser_dev-objs-$(CONFIG_X86) += dumper_x86_ide.o regs_x86.o
+
+include $(TOPDIR)/Rules.make
+
+# Check that external references do not slip into dumper core.
+oopser_dev-leaf := dumper_x86_ide.o regs_x86.o dumper.o
+oopser_dev_ALLOWED := tainted|log_buf|log_end
+
+oopser_dev-check: $(oopser_dev-leaf)
+	@for f in $(oopser_dev-leaf); do				     \
+	    for sym in `nm $$f|fgrep ' U '|sed 's/.* U //'|grep -vwE '$(oopser_dev_ALLOWED)'`; \
+	    do								     \
+		if nm $(oopser_dev-leaf)|grep -q " [TD] $$sym\$$"; then :;   \
+		else echo $$f:1:References symbol $$sym|sed 's/.o:/.c:/'>&2; \
+	        fi;							     \
+	    done;							     \
+	done; true
+
+oopser_dev.o: $(oopser_dev-objs-y) #oopser_dev-check
+	$(LD) $(LD_RFLAG) -r -o $@ $(oopser_dev-objs-y)
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/drivers/char/oopser/decode-table.c working-2.5.34-oopser/drivers/char/oopser/decode-table.c
--- linux-2.5.34/drivers/char/oopser/decode-table.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.34-oopser/drivers/char/oopser/decode-table.c	Mon Sep 16 20:20:40 2002
@@ -0,0 +1,67 @@
+static const char huff_dec_chars[]
+	= "_0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
+struct huff_decode_table { signed char jump[2]; };
+static const struct huff_decode_table huff_decode[] = { 
+	[0] = { { 1, 2 } }, 
+	[1] = { { 2, 3 } }, 
+	[3] = { { 2, -41 } }, 
+	[5] = { { -37, 1 } }, 
+	[6] = { { -49, 1 } }, 
+	[7] = { { -58, -61 } }, 
+	[4] = { { 4, 0 } }, 
+	[8] = { { -45, -55 } }, 
+	[2] = { { 7, 8 } }, 
+	[9] = { { 2, 3 } }, 
+	[11] = { { 2, -54 } }, 
+	[13] = { { -57, 1 } }, 
+	[14] = { { 1, -47 } }, 
+	[15] = { { -60, 1 } }, 
+	[16] = { { 1, -53 } }, 
+	[17] = { { 1, 2 } }, 
+	[18] = { { -62, -5 } }, 
+	[19] = { { 1, -9 } }, 
+	[20] = { { 1, -2 } }, 
+	[21] = { { 1, -13 } }, 
+	[22] = { { -29, 1 } }, 
+	[23] = { { -21, 1 } }, 
+	[24] = { { 1, -22 } }, 
+	[25] = { { -34, 1 } }, 
+	[26] = { { -24, -31 } }, 
+	[12] = { { -63, -56 } }, 
+	[10] = { { 17, 18 } }, 
+	[27] = { { 2, 3 } }, 
+	[29] = { { -48, -52 } }, 
+	[30] = { { 1, -40 } }, 
+	[31] = { { 1, -43 } }, 
+	[32] = { { -59, 1 } }, 
+	[33] = { { 1, 2 } }, 
+	[34] = { { -4, -3 } }, 
+	[35] = { { 1, 2 } }, 
+	[36] = { { 2, 3 } }, 
+	[38] = { { -19, -6 } }, 
+	[39] = { { 1, -7 } }, 
+	[40] = { { -26, 1 } }, 
+	[41] = { { -10, 1 } }, 
+	[42] = { { 1, -8 } }, 
+	[43] = { { -23, 1 } }, 
+	[44] = { { -28, -32 } }, 
+	[37] = { { -46, 8 } }, 
+	[45] = { { 1, -1 } }, 
+	[46] = { { 1, -11 } }, 
+	[47] = { { 1, -25 } }, 
+	[48] = { { -30, 1 } }, 
+	[49] = { { 1, 2 } }, 
+	[50] = { { 2, -27 } }, 
+	[52] = { { 1, -14 } }, 
+	[53] = { { 1, -12 } }, 
+	[54] = { { 1, -36 } }, 
+	[55] = { { 1, -35 } }, 
+	[56] = { { -16, -33 } }, 
+	[51] = { { 6, 7 } }, 
+	[57] = { { -18, -20 } }, 
+	[58] = { { -15, -17 } }, 
+	[28] = { { 31, 32 } }, 
+	[59] = { { -50, 2 } }, 
+	[61] = { { -42, 1 } }, 
+	[62] = { { -38, -44 } }, 
+	[60] = { { -39, -51 } }, };
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/drivers/char/oopser/dumper.c working-2.5.34-oopser/drivers/char/oopser/dumper.c
--- linux-2.5.34/drivers/char/oopser/dumper.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.34-oopser/drivers/char/oopser/dumper.c	Mon Sep 16 21:00:29 2002
@@ -0,0 +1,208 @@
+/* This is the core dumper code.  It must *not* reference any outside
+   code, except the arch/subsystem specific routines, which is done
+   through the oopser_write and oopser_read pointer. */
+
+#include <linux/oopser.h>
+#include <linux/errno.h>
+#include <linux/ptrace.h>
+#include <linux/smp.h>
+#include <linux/version.h>
+#include <linux/compile.h>
+#include <asm/uaccess.h>
+#include "oopser_priv.h"
+#include "decode-table.c"
+
+int (*oopser_block_write)(const char dump[512], unsigned int block);
+int (*oopser_block_read)(char dump[512], unsigned int block);
+
+static char kversion[] = UTS_RELEASE " " UTS_MACHINE " " UTS_VERSION " " LINUX_COMPILER;
+
+static char page[LINUX_OOPSER_DUMP_SIZE];
+
+struct oopser_symtable *symtable = NULL;
+
+static inline int get_bit(const unsigned char *addr, unsigned int *bitnum)
+{
+	int bit;
+
+	bit = addr[*bitnum / 8] & (1 << (*bitnum % 8));
+	(*bitnum)++;
+	return !!bit;
+}
+
+static char get_char(const unsigned char *addr, unsigned int *bitnum)
+{
+	int next;
+	unsigned int cursor;
+
+	/* Start at zero: jumps are in terms of offset from current pos. */
+	for (cursor = 0;
+	     (next = huff_decode[cursor].jump[get_bit(addr, bitnum)]) > 0;
+	     cursor += next) ;
+	return huff_dec_chars[-next];
+}
+
+static void decode_name(const char *prefix,
+			const unsigned char *encnames,
+			unsigned int symnum,
+			char *outname)
+{
+	unsigned int i, bitnum;
+
+	/* Swallow previous names. */
+	for (i = 0, bitnum = 0; i < symnum; i++)
+		while (get_char(encnames, &bitnum) != 0);
+
+	if (prefix) {
+		outname = add_string(outname, prefix);
+		outname = add_string(outname, ".");
+	}
+
+	do {
+		*outname = get_char(encnames, &bitnum);
+		outname++;
+	} while (outname[-1]);
+}
+
+static int find_addr(const struct oopser_symtable *table,
+		     unsigned long off,
+		     char *outname)
+{
+	unsigned int i;
+
+	for (i = 0; off > table->symsize[i]; i++)
+		off -= table->symsize[i];
+
+	decode_name(table->prefix, table->encnames, i, outname);
+	return (int)off;
+}
+
+/* Return -ENOENT on out-of-range.  Give a 64 bytes at least for outname. */
+int symbol_decode(unsigned long addr, char *outname)
+{
+	struct oopser_symtable *i;
+
+	for (i = symtable; i; i = i->next) {
+		if (addr >= i->start_addr && addr <= i->end_addr) {
+			return find_addr(i, addr - i->start_addr, outname);
+		}
+	}
+	return -ENOENT;
+}
+
+static int write_block(int (*write)(const char dump[512], unsigned int block),
+		       unsigned int blocknum, const char *p)
+{
+	int ret;
+
+	/* If we can, check there is currently a valid signature */
+	if (oopser_block_read) {
+		static unsigned char oldcontents[512];
+		oldcontents[0] = 0;
+		ret = oopser_block_read(oldcontents, blocknum);
+		if (ret < 0)
+			return ret;
+		for (ret = 0; ret < sizeof(LINUX_OOPSER_SIGNATURE)-1; ret++)
+			if (oldcontents[ret] != LINUX_OOPSER_SIGNATURE[ret])
+				return -EBADF;
+	}
+
+	return write(p, blocknum);
+}
+	
+static int dump_stage(int (*write)(const char dump[512], unsigned int block),
+		      char *p, int size, unsigned int block)
+{
+	int ret = 0;
+
+	while (block < LINUX_OOPSER_BLOCKS && size > 0) {
+		ret = write_block(write, block, p);
+		if (ret < 0)
+			return ret;
+		p += 512;
+		size -= 512;
+		block++;
+	}
+	return block;
+}
+
+/* FIXME: Stolen from printk.c: find a better way */
+#if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
+#define LOG_BUF_LEN	(65536)
+#elif defined(CONFIG_ARCH_S390)
+#define LOG_BUF_LEN	(131072)
+#elif defined(CONFIG_SMP)
+#define LOG_BUF_LEN	(32768)
+#else	
+#define LOG_BUF_LEN	(16384)
+#endif
+#define LOG_BUF(idx) (log_buf[(idx) % LOG_BUF_LEN])
+
+static char *dump_log_buffer(char *p)
+{
+	extern char log_buf[];
+	extern unsigned long log_end;
+	unsigned int i;
+
+	/* FIXME: If < 1024 chars total in buffer.  This will give NULs */
+	for (i = 0; i < 1024; i++)
+		(*p++) = LOG_BUF(LOG_BUF_LEN + log_end - 1024 + i);
+	*p = '\0';
+	return p;
+}
+
+/* Called with interrupts off */
+int oopser_oops_handler(const char *str, struct pt_regs *regs, long err)
+{
+	char *p;
+	int blocks;
+	int (*write)(const char dump[512], unsigned int block);
+
+	write = oopser_block_write;
+	oopser_block_write = NULL;
+
+	if (!write)
+		return 0;
+
+	/* We dump on stages, getting more ambitious as we go. */
+
+	/* Stage 0: we have an oops. */
+	p = add_string(page, LINUX_OOPSER_SIGNATURE " -r\n");
+	p = add_string(p, "OOPS="); p = add_string(p, str);
+	p = add_string(p, "\nERR="); p = add_int(p, err);
+	p = add_string(p, "\nVERSION="); p = add_string(p, kversion);
+	p = add_string(p, "\n");
+	blocks = dump_stage(write, page, p - page, 0);
+	if (blocks < 0)
+		return blocks;
+
+	/* Stage 1: we have some registers. */
+	p = dump_registers(page, regs);
+	blocks = dump_stage(write, page, p - page, blocks);
+	if (blocks < 0)
+		return blocks;
+
+	/* Stage 2: Process information */
+	p = add_string(page, "CPU="); p = add_int(p,smp_processor_id());
+	p = add_string(p, "\nT="); p = add_int(p, tainted);
+	p = add_string(p, "\nProcess="); p = add_string(p, current->comm);
+	p = add_string(p, "\nPID="); p = add_int(p, current->pid);
+	p = add_string(p, "\n");
+	blocks = dump_stage(write, page, p - page, blocks);
+	if (blocks < 0)
+		return blocks;
+
+	/* Stage 3: stack, backtrace, code. */
+	p = dump_code_context(page, regs);
+	blocks = dump_stage(write, page, p - page, blocks);
+	if (blocks < 0)
+		return blocks;
+
+	/* Stage 4: last 1k of printk ring buffer. */
+	p = dump_log_buffer(page);
+	blocks = dump_stage(write, page, p - page, blocks);
+	if (blocks < 0)
+		return blocks;
+
+	return 0;
+}
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/drivers/char/oopser/dumper_x86_ide.c working-2.5.34-oopser/drivers/char/oopser/dumper_x86_ide.c
--- linux-2.5.34/drivers/char/oopser/dumper_x86_ide.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.34-oopser/drivers/char/oopser/dumper_x86_ide.c	Fri Sep 13 18:08:13 2002
@@ -0,0 +1,134 @@
+/* This is the core dumper code: x86 IDE.  It must *not* reference any
+   outside code. */
+
+#include <linux/oopser.h>
+#include <linux/hdreg.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <asm/io.h>
+#include "oopser_priv.h"
+
+static struct linux_oopser_ide ideinfo;
+
+/* Wait for at least N usecs (1 clock per cycle, 10GHz processor = 10000) */
+static inline void oopser_usec(unsigned int num_usec)
+{
+	unsigned int i;
+	for (i = 0; i < 10000 * num_usec; i++);
+}
+
+/* Wait for up to one second. */
+static int wait_for(unsigned char flag)
+{
+	unsigned int i;
+	unsigned char b;
+
+	/* Pause (at least 400ns) in case we just issued a command */
+	oopser_usec(1);
+	for (i = 0; i < 1000; i++) {
+		b = inb(HD_STATUS);
+		if (!(b & BUSY_STAT)) {
+			if (b & ERR_STAT) return 0;
+			if (b & flag) return 1;
+		}
+		oopser_usec(1000);
+	}
+	return 0;
+}
+
+static int wait_before_command(void)
+{
+	return wait_for(READY_STAT);
+}
+
+static int wait_before_data(void)
+{
+	return wait_for(DRQ_STAT);
+}
+
+static int read_one_sector(int master, unsigned int lba,
+			   unsigned char sect[512])
+{
+	/* Bits 24-27, 0x40=LBA, 0x10=slave */
+	if (!wait_before_command()) return -EIO;
+	outb(0x40 | (master ? 0 : 0x10) | ((lba >> 24) & 0x0F), HD_CURRENT);
+
+	if (!wait_before_command()) return -EIO;
+	outb(1, HD_NSECTOR); /* One sector */
+	/* Bits 0-7 of LBA address */
+	outb(lba & 0xFF, HD_SECTOR);
+	/* Bits 8-15 */
+	outb((lba >> 8) & 0xFF, HD_LCYL);
+	/* Bits 16-23 */
+	outb((lba >> 16) & 0xFF, HD_HCYL);
+	/* READ SECTOR (with retries) */
+	outb(0x20, HD_COMMAND);
+
+	/* Read one sector (256 words) */
+	if (!wait_before_data()) return -EIO;
+	insw(HD_DATA, sect, 256);
+
+#if 0
+	printk("Contents of sector %u\n", lba);
+	printk("SECTOR: %02X %02X %02X %02X %02X %02X %02X %02X ...\n",
+	       sect[0], sect[1], sect[2], sect[3], 
+	       sect[4], sect[5], sect[6], sect[7]);
+	printk("SECTOR: ... %02X %02X %02X %02X %02X %02X %02X %02X\n",
+	       sect[504], sect[505], sect[506], sect[507], 
+	       sect[508], sect[509], sect[510], sect[511]);
+#endif
+	return 0;
+}
+
+static int write_one_sector(int master, unsigned int lba,
+			    const unsigned char sect[512])
+{
+	/* Bits 24-27, 0x40=LBA, 0x10=slave */
+	if (!wait_before_command()) return -EIO;
+	outb(0x40 | (master ? 0 : 0x10) | ((lba >> 24) & 0x0F), HD_CURRENT);
+	
+	if (!wait_before_command()) return -EIO;
+	outb(1, HD_NSECTOR); /* One sector */
+	/* Bits 0-7 of LBA address */
+	outb(lba & 0xFF, HD_SECTOR);
+	/* Bits 8-15 */
+	outb((lba >> 8) & 0xFF, HD_LCYL);
+	/* Bits 16-23 */
+	outb((lba >> 16) & 0xFF, HD_HCYL);
+	/* WRITE SECTOR (with retries) */
+	outb(0x30, HD_COMMAND);
+
+	/* Write one sector (256 words) */
+	if (!wait_before_data()) return -EIO;
+	outsw(HD_DATA, sect, 256);
+	return 0;
+}
+
+int oopser_set_ide(const char *buffer, size_t len)
+{
+	if (len != sizeof(ideinfo))
+		return -EINVAL;
+	memcpy(&ideinfo, buffer, sizeof(ideinfo));
+	printk(KERN_INFO "Oopser set: %s %u...\n",
+	       ideinfo.master ? "master" : "slave",
+	       ideinfo.lba[0]);
+	return 0;
+}
+
+/* Called with interrupts off */
+int oopser_read_ide(char dump[512], unsigned int block)
+{
+	/* Wait for non-busy: if not, reset anyway */
+	wait_before_command();
+	/* Soft reset of drive (set nIEN as well) */
+	outb(0x0e, HD_CMD);
+	oopser_usec(1); /* 400ns according to spec */
+	outb(0x0a, HD_CMD);
+
+	return read_one_sector(ideinfo.master, ideinfo.lba[block], dump);
+}
+
+int oopser_write_ide(const char dump[512], unsigned int block)
+{
+	return write_one_sector(ideinfo.master, ideinfo.lba[block], dump);
+}
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/drivers/char/oopser/interface.c working-2.5.34-oopser/drivers/char/oopser/interface.c
--- linux-2.5.34/drivers/char/oopser/interface.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.34-oopser/drivers/char/oopser/interface.c	Mon Sep 16 21:10:37 2002
@@ -0,0 +1,244 @@
+/* This is the only part of the in-kernel oops dumper which can call
+   into the rest of the kernel. */
+#include "oopser_priv.h"
+#include <asm/semaphore.h>
+#include <linux/hdreg.h>
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/utsname.h>
+#include <linux/rwsem.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#define OOPS_MAJOR 240
+
+/* Protect open and close */
+static DECLARE_MUTEX(oopser_lock);
+static unsigned int use_count = 0;
+
+struct oopser_symlist *oopser_symlist;
+static int oopser_type = -1;
+
+static int oopser_open(struct inode *inode, struct file *filp)
+{
+	if (down_interruptible(&oopser_lock) != 0)
+		return -EINTR;
+
+	if (use_count) {
+		up(&oopser_lock);
+		return -EBUSY;
+	}
+
+	use_count++;
+	up(&oopser_lock);
+	return 0;
+}
+
+static int oopser_close(struct inode *inode, struct file *filp)
+{
+	down(&oopser_lock);
+	use_count--;
+	up(&oopser_lock);
+	return 0;
+}
+
+static unsigned long get_size(unsigned int num, unsigned short sizes[])
+{
+	unsigned long size = 0;
+	unsigned int i;
+
+	for (i = 0; i < num; i++)
+		size += sizes[i];
+
+	return size;
+}
+
+/* Add symbols. */
+static int add_oopser_symbols(const char *ubuffer, size_t len)
+{
+	struct linux_oopser_symbols syms;
+	struct oopser_symtable *new;
+	size_t extra;
+
+	if (len < sizeof(syms))
+		return -EINVAL;
+	if (copy_from_user(&syms, ubuffer, sizeof(syms)) != 0)
+		return -EFAULT;
+	if (len < sizeof(syms) + sizeof(unsigned short)*syms.num_syms)
+		return -EINVAL;
+	/* Check against excesses before we kmalloc */
+	if (syms.num_syms > 8192 || len > 120000)
+		return -ENOMEM;
+
+	extra = len - sizeof(syms);
+
+	new = kmalloc(sizeof(*new) + extra, GFP_KERNEL);
+	if (!new) return -ENOMEM;
+
+	/* Copy the rest (sizes, prefix, then encoded names) */
+	if (copy_from_user(&new->symsize, ubuffer + sizeof(syms), extra) != 0){
+		kfree(new);
+		return -EFAULT;
+	}
+
+	/* FIXME: Do verification --RR */
+	new->next = symtable;
+	new->prefix = (char *)&new->symsize[syms.num_syms];
+	new->start_addr = syms.base_address;
+	new->end_addr = syms.base_address
+		+ get_size(syms.num_syms, new->symsize);
+	new->encnames = (unsigned char *)(new->prefix + strlen(new->prefix)+1);
+	new->num_syms = syms.num_syms;
+	printk(KERN_INFO "oopser: %u symbols for %s added\n",
+	       new->num_syms, new->prefix);
+
+	wmb(); /* Need this before setting symtable = new */
+	symtable = new;
+	return 0;
+}
+
+/* Arm the oopser. */
+static int oopser_arm(const char *ubuffer, size_t len)
+{
+	int ret = 0;
+
+	if (len != sizeof(unsigned int)) return -EINVAL;
+
+	if (oopser_block_write) ret = -EEXIST;
+	else {
+		switch (oopser_type) {
+		case LINUX_OOPSER_TYPE_IDE:
+			printk(KERN_INFO "Oopser armed: IDE\n");
+			oopser_block_write = oopser_write_ide;
+			oopser_block_read = oopser_read_ide;
+			break;
+		default:
+			/* Oopser unset */
+			ret = -EROFS;
+		}
+	}
+
+	return ret;
+}
+
+/* Disarm the oopser. */
+static int oopser_disarm(const char *ubuffer, size_t len)
+{
+	int ret = 0;
+
+	if (len != sizeof(unsigned int)) return -EINVAL;
+
+	if (!oopser_block_write) ret = -ENOENT;
+	else {
+		oopser_block_write = NULL;
+		oopser_block_read = NULL;
+		oopser_type = -1;
+		printk(KERN_INFO "Oopser disarmed\n");
+	}
+
+	return ret;
+}
+
+/* Set the dump position. */
+static int oopser_set(const char *ubuffer, size_t len)
+{
+	char buffer[256];
+	int ret = 0;
+
+	/* Check it's not armed */
+	if (oopser_block_write) return -EBUSY;
+
+	/* Copy here, so dumper doesn't have to call copy_from_user */
+	if (len < sizeof(unsigned int)*2) return -EINVAL;
+	if (len > sizeof(buffer)) return -ENOSPC;
+	if (copy_from_user(buffer, ubuffer, len) != 0)
+		return -EFAULT;
+	memcpy(&oopser_type, buffer + sizeof(unsigned long), sizeof(int));
+
+	switch (oopser_type) {
+	case LINUX_OOPSER_TYPE_IDE:
+		ret = oopser_set_ide(buffer, len);
+		break;
+	default:
+		printk(KERN_DEBUG "oopser: unknown set type %u\n",
+		       oopser_type);
+		ret = -EINVAL;
+		break;
+	}
+	if (ret < 0)
+		oopser_type = -1;
+	return ret;
+}
+
+static ssize_t oopser_write(struct file *filp,
+			    const char *ubuffer,
+			    size_t len,
+			    loff_t *off)
+{
+	unsigned int command;
+	int ret;
+
+	if (len < sizeof(unsigned int))
+		return -EINVAL;
+
+	if (get_user(command, (unsigned int *)ubuffer) != 0)
+		return -EFAULT;
+
+	if (down_interruptible(&oopser_lock) != 0)
+		return -EINTR;
+
+	switch (command) {
+	case LINUX_OOPSER_SYMBOLS:
+		ret = add_oopser_symbols(ubuffer, len);
+		break;
+	case LINUX_OOPSER_SET:
+		ret = oopser_set(ubuffer, len);
+		break;
+	case LINUX_OOPSER_ARM:
+		ret = oopser_arm(ubuffer, len);
+		break;
+	case LINUX_OOPSER_DISARM:
+		ret = oopser_disarm(ubuffer, len);
+		break;
+	case LINUX_OOPSER_TEST:
+		goto test;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	up(&oopser_lock);
+	return ret < 0 ? (ssize_t)ret : len;
+
+ test:
+	use_count--;
+	up(&oopser_lock);
+	*((char *)0) = 0;
+}
+
+static struct file_operations oopser_fops = {
+	open:		oopser_open,
+	release:	oopser_close,
+	write:		oopser_write,
+};
+
+/* FIXME: write-protect the module pages */
+int __init init(void)
+{
+	oops_handler = oopser_oops_handler;
+	return register_chrdev(OOPS_MAJOR, "oopser", &oopser_fops);
+}
+
+void __exit fini(void)
+{
+	oops_handler = NULL;
+	unregister_chrdev(OOPS_MAJOR, "oopser");
+}
+
+module_init(init);
+module_exit(fini);
+MODULE_LICENSE("GPL");
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/drivers/char/oopser/oopser_priv.h working-2.5.34-oopser/drivers/char/oopser/oopser_priv.h
--- linux-2.5.34/drivers/char/oopser/oopser_priv.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.34-oopser/drivers/char/oopser/oopser_priv.h	Mon Sep 16 20:56:33 2002
@@ -0,0 +1,106 @@
+#ifndef _OOPSER_PRIV_H
+#define _OOPSER_PRIV_H
+#include <linux/oopser.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <asm/system.h>
+
+struct oopser_symtable
+{
+	/* Next symbol table (eg. modules) */
+	struct oopser_symtable *next;
+
+	/* Prefix for this symbol, if any */
+	char *prefix;
+
+	/* Address range this symbol table covers. */
+	unsigned long start_addr;
+	unsigned long end_addr;
+
+	/* Pointer to encoded names */
+	unsigned char *encnames;
+
+	/* How many symbols are there? */
+	unsigned short num_syms;
+
+	/* The offsets of the symbols themselves */
+	unsigned short symsize[0];
+};
+
+extern struct oopser_symtable *symtable;
+
+/* Returns < 0 on not found, or offset inside function when found */
+int symbol_decode(unsigned long addr, char *outname);
+
+/* Set once we are armed. */
+extern int (*oopser_block_write)(const char dump[512], unsigned int block);
+extern int (*oopser_block_read)(char dump[512], unsigned int block);
+int oopser_oops_handler(const char *str, struct pt_regs *regs, long err);
+
+/* IDE routines */
+extern int oopser_write_ide(const char dump[512], unsigned int block);
+extern int oopser_read_ide(char dump[512], unsigned int block);
+extern int oopser_set_ide(const char *buffer, size_t len);
+
+/* Platform-specific routines (but please keep same field names!) */
+struct pt_regs;
+extern char *dump_registers(char *p, struct pt_regs *regs);
+extern char *dump_code_context(char *p, struct pt_regs *regs);
+
+/* String routines for parts which can't access sprintf */
+/* Poor man's string routines */
+static inline char *add_string(char *p, const char *string)
+{
+	unsigned int i = 0;
+
+	do {
+		p[i] = string[i];
+	} while (string[i++]);
+
+	return p+i-1;
+}
+
+static inline char tohex(unsigned char num)
+{
+	if (num < 10) return '0' + num;
+	else return 'a' + num - 10;
+}
+
+static inline char *add_hexchar(char *p, unsigned char num)
+{
+	char digits[3];
+
+	digits[0] = tohex(num >> 4);
+	digits[1] = tohex(num & 0xF);
+	digits[2] = 0;
+	return add_string(p, digits);
+}
+
+static inline char *add_hexlong(char *p, unsigned long num)
+{
+	int i;
+
+	p = add_string(p, "0x");
+	for (i = BITS_PER_LONG - 8; i >= 0; i -= 8)
+		p = add_hexchar(p, num >> i);
+	return p;
+}
+
+static inline char *add_int(char *p, unsigned int i)
+{
+	int started = 0;
+	unsigned int mag;
+
+	for (mag = 1000000000; mag; mag /= 10) {
+		if (i/mag) {
+			*(p++) = tohex(i/mag);
+			i %= mag;
+			started = 1;
+		} else if (started || mag == 1) {
+			*(p++) = '0';
+		}
+	}
+	*p = '\0';
+	return p;
+}
+#endif /* _OOPSER_PRIV_H */
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/drivers/char/oopser/regs_x86.c working-2.5.34-oopser/drivers/char/oopser/regs_x86.c
--- linux-2.5.34/drivers/char/oopser/regs_x86.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.34-oopser/drivers/char/oopser/regs_x86.c	Mon Sep 16 20:54:04 2002
@@ -0,0 +1,119 @@
+/* x86-specific dumper code.  It must *not* reference any outside
+   code. */
+#include <linux/ptrace.h>
+#include <asm/uaccess.h>
+#include <asm/current.h>
+#include "oopser_priv.h"
+
+static char *dump_code(char *p, struct pt_regs *regs)
+{
+	unsigned int i;
+	unsigned char c;
+
+	p = add_string(p, "CODE=");
+	if (regs->eip < PAGE_OFFSET)
+		p = add_string(p, "EIP-BAD");
+	else {
+		for (i=0; i < 20; i++) {
+			if (__get_user(c, &((unsigned char*)regs->eip)[i])) {
+				p = add_string(p, "EIP-BAD");
+				break;
+			}
+			p = add_hexchar(p, c);
+			p = add_string(p, " ");
+		}
+	}
+	return add_string(p, "\n");
+}
+
+static char *dump_backtrace(char *p, unsigned long *stack)
+{
+	unsigned long addr;
+	unsigned int i = 0;
+
+	while (((long) stack & (THREAD_SIZE-1)) != 0 && i < 20) {
+		int where_in_fn;
+		char name[64];
+
+		addr = *stack++;
+		where_in_fn = symbol_decode(addr, name);
+		if (where_in_fn >= 0) {
+			p = add_string(p, "TRACE=");
+			p = add_hexlong(p, addr);
+			p = add_string(p, "(");
+			p = add_string(p, name);
+			p = add_string(p, "+");
+			p = add_int(p, where_in_fn);
+			p = add_string(p, ")\n");
+			i++;
+		}
+	}
+	return p;
+}
+
+static char *dump_stack(char *p, unsigned long *stack)
+{
+	int i;
+
+	p = add_string(p, "STACK=");
+	for (i=0; i < 24; i++) {
+		if (((long) stack & (THREAD_SIZE-1)) == 0)
+			break;
+		p = add_hexlong(p, *stack++);
+		p = add_string(p, " ");
+	}
+	return add_string(p, "\n");
+}
+
+/* This is the entry point */
+char *dump_registers(char *p, struct pt_regs *regs)
+{
+	unsigned long esp;
+	unsigned short ss;
+
+	esp = (unsigned long) (&regs->esp);
+	ss = __KERNEL_DS;
+	if (regs->xcs & 3) {
+		esp = regs->esp;
+		ss = regs->xss & 0xffff;
+	}
+
+	/* Dump the regigsters (arch-specific). */
+	p = add_string(p, "PC="); p = add_hexlong(p, regs->eip);
+	p = add_string(p, "\nREG eax="); p = add_hexlong(p, regs->eax);
+	p = add_string(p, "\nREG ebx="); p = add_hexlong(p, regs->ebx);
+	p = add_string(p, "\nREG ecx="); p = add_hexlong(p, regs->ecx);
+	p = add_string(p, "\nREG edx="); p = add_hexlong(p, regs->edx);
+	p = add_string(p, "\nREG esi="); p = add_hexlong(p, regs->esi);
+	p = add_string(p, "\nREG edi="); p = add_hexlong(p, regs->edi);
+	p = add_string(p, "\nREG ebp="); p = add_hexlong(p, regs->ebp);
+	p = add_string(p, "\nREG esp="); p = add_hexlong(p, esp);
+	p = add_string(p, "\nREG ds="); p = add_hexlong(p, regs->xds & 0xffff);
+	p = add_string(p, "\nREG es="); p = add_hexlong(p, regs->xes & 0xffff);
+	p = add_string(p, "\nREG ss="); p = add_hexlong(p, ss);
+	p = add_string(p, "\nREG xcs="); p = add_hexlong(p, regs->xcs & 0xffff);
+
+	return add_string(p, "\n");
+}
+
+char *dump_code_context(char *p, struct pt_regs *regs)
+{
+	unsigned long esp, ss;
+
+	esp = (unsigned long) (&regs->esp);
+	if (regs->xcs & 3) {
+		esp = regs->esp;
+		ss = regs->xss & 0xffff;
+	}
+
+	/* When in-kernel, we also print out the stack and code at the
+	 * time of the fault..  */
+	if (!(regs->xcs & 3)) {
+		/* Stephen Rothwell says: if this is wrong, don't try */
+		if ((0xffff & regs->xcs) == __KERNEL_CS) 
+			p = dump_code(p, regs);
+		p = dump_stack(p, (unsigned long*)esp);
+		p = dump_backtrace(p, (unsigned long*)esp);
+	}
+	return p;
+}
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/include/linux/kernel.h working-2.5.34-oopser/include/linux/kernel.h
--- linux-2.5.34/include/linux/kernel.h	Sun Sep  1 12:23:07 2002
+++ working-2.5.34-oopser/include/linux/kernel.h	Thu Sep 12 22:23:23 2002
@@ -87,6 +87,8 @@ static inline void console_verbose(void)
 		console_loglevel = 15;
 }
 
+struct pt_regs;
+extern int (*oops_handler)(const char *str, struct pt_regs *regs, long err);
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/include/linux/oopser.h working-2.5.34-oopser/include/linux/oopser.h
--- linux-2.5.34/include/linux/oopser.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.34-oopser/include/linux/oopser.h	Mon Sep 16 19:05:03 2002
@@ -0,0 +1,55 @@
+#ifndef _LINUX_OOPSER_H
+#define _LINUX_OOPSER_H
+
+#define LINUX_OOPSER_SIGNATURE "#! /sbin/oopsd "
+#define LINUX_OOPSER_DUMP_SIZE 4096
+#define LINUX_OOPSER_BLOCKS (LINUX_OOPSER_DUMP_SIZE/512)
+
+/* Each command consists of int, then data, in single write. */
+enum linux_oopser_command
+{
+	/* Followed by num syms, base address, 16-bit sizes,
+           NUL-terminated module name ("" for kernel), then Huffman
+           encoded names. */
+	LINUX_OOPSER_SYMBOLS, 
+	/* Followed by type, then struct oopser_ide etc. */
+	LINUX_OOPSER_SET,
+	/* Arm the device */
+	LINUX_OOPSER_ARM,
+	/* Disarm the device */
+	LINUX_OOPSER_DISARM,
+	/* Test (causes oops, kills process) */
+	LINUX_OOPSER_TEST,
+};
+
+enum linux_oopser_type
+{
+	LINUX_OOPSER_TYPE_IDE,
+};
+
+struct linux_oopser_ide
+{
+	unsigned int command; /* == LINUX_OOPSER_SET */
+	unsigned int type; /* == LINUX_OOPSER_TYPE_IDE */
+
+	/* Master or slave? */
+	int master;
+
+	/* Absolute block addresses. */
+	unsigned int lba[LINUX_OOPSER_BLOCKS];
+};
+
+struct linux_oopser_symbols
+{
+	unsigned int command; /* == LINUX_OOPSER_SYMBOLS */
+
+	unsigned int num_syms;
+	/* This is the kernel's idea of long, not yours */
+	unsigned long base_address;
+	/* Size of each function: num_syms long. */
+	unsigned short size[0];
+
+	/* char module_name[]; */
+	/* unsigned char huffnames[]; */
+};
+#endif /*_LINUX_OOPSER_H*/
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/kernel/ksyms.c working-2.5.34-oopser/kernel/ksyms.c
--- linux-2.5.34/kernel/ksyms.c	Tue Sep 10 09:11:21 2002
+++ working-2.5.34-oopser/kernel/ksyms.c	Mon Sep 16 13:49:13 2002
@@ -601,3 +601,5 @@ EXPORT_SYMBOL(pidhash);
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
+
+EXPORT_SYMBOL_GPL(tainted);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/kernel/printk.c working-2.5.34-oopser/kernel/printk.c
--- linux-2.5.34/kernel/printk.c	Wed Aug 28 09:29:53 2002
+++ working-2.5.34-oopser/kernel/printk.c	Thu Sep 12 22:23:11 2002
@@ -78,7 +78,7 @@ struct console *console_drivers;
  */
 static spinlock_t logbuf_lock = SPIN_LOCK_UNLOCKED;
 
-static char log_buf[LOG_BUF_LEN];
+char log_buf[LOG_BUF_LEN];
 #define LOG_BUF(idx) (log_buf[(idx) & LOG_BUF_MASK])
 
 /*
@@ -87,7 +87,7 @@ static char log_buf[LOG_BUF_LEN];
  */
 static unsigned long log_start;			/* Index into log_buf: next char to be read by syslog() */
 static unsigned long con_start;			/* Index into log_buf: next char to be sent to consoles */
-static unsigned long log_end;			/* Index into log_buf: most-recently-written-char + 1 */
+unsigned long log_end;				/* Index into log_buf: most-recently-written-char + 1 */
 static unsigned long logged_chars;		/* Number of chars produced since last read+clear operation */
 
 struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
@@ -707,3 +707,6 @@ void tty_write_message(struct tty_struct
 		tty->driver.write(tty, 0, msg, strlen(msg));
 	return;
 }
+
+EXPORT_SYMBOL_GPL(log_buf);
+EXPORT_SYMBOL_GPL(log_end);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
