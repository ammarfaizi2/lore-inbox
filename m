Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270925AbTGQJCW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271101AbTGQJCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:02:22 -0400
Received: from [213.39.233.138] ([213.39.233.138]:18355 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S270925AbTGQJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:01:22 -0400
Date: Thu, 17 Jul 2003 11:15:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pankaj Garg <PGarg@MEGISTO.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioremap'ing RAM
Message-ID: <20030717091559.GA28396@wohnheim.fh-wedel.de>
References: <C3F7A1AD0781F84784B5528466CA09DD01345643@megisto-sql1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C3F7A1AD0781F84784B5528466CA09DD01345643@megisto-sql1>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 July 2003 11:59:07 -0400, Pankaj Garg wrote:
> 
> I am trying to allocate a huge chunk of memory for my module. The memory is
> needed to be contiguous in physical address space and is much more than what
> kmalloc returns. I reserved some high memory at the bootup time of the
> kernel (using the command line option mem), and at the time of module
> initialization used ioremap to grab that chunk of memory. All this is
> working fine.
> 
> My module creates a table in this allocated address space. The table is not
> going out of bound.
> 
> The module sniff's the packet coming in through the network card and does a
> find on the table.
> 
> The problem is, if I load the module just after startup (within a second or
> two), the kernel crashes. If I do it a little later, say 2-3 mins later, it
> crashes after 1-2 days. 
> 
> Is there anything wrong in the way I am doing memory allocation?

There is nothing wrong in your description, but I cannot judge the
code without seeing it.  If you cannot or don't want to show the code,
look at drivers/mtd/devices/slram.c.  That drivers does exactly what
you describe and doesn't crash, at least for me.

Or you can look at my rewrite (finished yesterday, still untested),
which has nicer code, and should be more robust, once the initial bugs
are shaken out.

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike

--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1/drivers/mtd/devices/phram.c	2003-07-16 17:04:27.000000000 +0200
@@ -0,0 +1,364 @@
+/**
+ *
+ * $Id: just to make dwmw2 happy $
+ *
+ * Copyright (c) Jochen Schaeuble <psionic@psionic.de>
+ * 07/2003	rewritten by Jörn Engel <joern@wh.fh-wedel.de>
+ *
+ * DISCLAIMER:  This driver makes use of Rusty's excellent module code,
+ * so it will not work for 2.4 without changes and it wont work for 2.4
+ * as a module without major changes.  Oh well!
+ *
+ * Usage:
+ *
+ * one commend line parameter per device, each in the form:
+ *   phram=<name>,<start>,<len>
+ * <name> may be up to 63 characters.
+ * <start> and <len> can be octal, decimal or hexadecimal.  If followed
+ * by "k", "M" or "G", the numbers will be interpreted as kilo, mega or
+ * gigabytes.
+ *
+ */
+
+#include <asm/io.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mtd/mtd.h>
+
+#define ERROR(fmt, args...) printk(KERN_ERR "phram: " fmt , ## args)
+
+struct phram_mtd_list {
+	struct list_head list;
+	struct mtd_info *mtdinfo;
+};
+
+static LIST_HEAD(phram_list);
+
+
+
+int phram_erase(struct mtd_info *mtd, struct erase_info *instr)
+{
+	u_char *start = (u_char *)mtd->priv;
+
+	if (instr->addr + instr->len > mtd->size)
+		return -EINVAL;
+	
+	memset(start + instr->addr, 0xff, instr->len);
+
+	/* This'll catch a few races. Free the thing before returning :) 
+	 * I don't feel at all ashamed. This kind of thing is possible anyway
+	 * with flash, but unlikely.
+	 */
+
+	instr->state = MTD_ERASE_DONE;
+
+	if (instr->callback)
+		(*(instr->callback))(instr);
+	else
+		kfree(instr);
+
+	return 0;
+}
+
+int phram_point(struct mtd_info *mtd, loff_t from, size_t len,
+		size_t *retlen, u_char **mtdbuf)
+{
+	u_char *start = (u_char *)mtd->priv;
+
+	if (from + len > mtd->size)
+		return -EINVAL;
+	
+	*mtdbuf = start + from;
+	*retlen = len;
+	return 0;
+}
+
+void phram_unpoint(struct mtd_info *mtd, u_char *addr, loff_t from, size_t len)
+{
+}
+
+int phram_read(struct mtd_info *mtd, loff_t from, size_t len,
+		size_t *retlen, u_char *buf)
+{
+	u_char *start = (u_char *)mtd->priv;
+
+	if (from + len > mtd->size)
+		return -EINVAL;
+	
+	memcpy(buf, start + from, len);
+
+	*retlen = len;
+	return 0;
+}
+
+int phram_write(struct mtd_info *mtd, loff_t to, size_t len,
+		size_t *retlen, const u_char *buf)
+{
+	u_char *start = (u_char *)mtd->priv;
+
+	if (to + len > mtd->size)
+		return -EINVAL;
+	
+	memcpy(start + to, buf, len);
+
+	*retlen = len;
+	return 0;
+}
+
+
+
+static void unregister_devices(void)
+{
+	struct phram_mtd_list *this;
+
+	list_for_each_entry(this, &phram_list, list) {
+		del_mtd_device(this->mtdinfo);
+		iounmap(this->mtdinfo->priv);
+		kfree(this->mtdinfo);
+		kfree(this);
+	}
+}
+
+static int register_device(char *name, unsigned long start, unsigned long len)
+{
+	struct phram_mtd_list *new;
+	int ret = -ENOMEM;
+
+	new = kmalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		goto out0;
+
+	new->mtdinfo = kmalloc(sizeof(struct mtd_info), GFP_KERNEL);
+	if (!new->mtdinfo)
+		goto out1;
+	
+	memset(new->mtdinfo, 0, sizeof(struct mtd_info));
+
+	ret = -EIO;
+	new->mtdinfo->priv = ioremap(start, len);
+	if (!new->mtdinfo->priv) {
+		ERROR("ioremap failed\n");
+		goto out2;
+	}
+
+
+	new->mtdinfo->name = name;
+	new->mtdinfo->size = len;
+	new->mtdinfo->flags =	MTD_CLEAR_BITS |
+				MTD_SET_BITS |
+				MTD_WRITEB_WRITEABLE |
+				MTD_VOLATILE;
+        new->mtdinfo->erase = phram_erase;
+	new->mtdinfo->point = phram_point;
+	new->mtdinfo->unpoint = phram_unpoint;
+	new->mtdinfo->read = phram_read;
+	new->mtdinfo->write = phram_write;
+	new->mtdinfo->owner = THIS_MODULE;
+	new->mtdinfo->type = MTD_RAM;
+	new->mtdinfo->erasesize = 0x0;
+
+	ret = -EAGAIN;
+	if (add_mtd_device(new->mtdinfo)) {
+		ERROR("Failed to register new device\n");
+		goto out3;
+	}
+
+	list_add_tail(&new->list, &phram_list);
+	return 0;	
+
+out3:
+	iounmap(new->mtdinfo->priv);
+out2:
+	kfree(new->mtdinfo);
+out1:
+	kfree(new);
+out0:
+	return ret;
+}
+
+static int ustrtoul(const char *cp, char **endp, unsigned int base)
+{
+	unsigned long result = simple_strtoul(cp, endp, base);
+
+	switch (**endp) {
+	case 'G':
+		result *= 1024;
+	case 'M':
+		result *= 1024;
+	case 'k':
+		result *= 1024;
+		endp++;
+	}
+	return result;
+}
+
+static int parse_num32(uint32_t *num32, const char *token)
+{
+	char *endp;
+	unsigned long n;
+
+	n = ustrtoul(token, &endp, 0);
+	if (*endp)
+		return -EINVAL;
+
+	*num32 = n;
+	return 0;
+}
+
+static int parse_name(char **pname, const char *token)
+{
+	size_t len;
+	char *name;
+
+	len = strlen(token) + 1;
+	if (len > 64)
+		return -ENOSPC;
+
+	name = kmalloc(len, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	strcpy(name, token);
+
+	*pname = name;
+	return 0;
+}
+
+#define parse_err(fmt, args...) do {	\
+	ERROR(fmt , ## args);	\
+	return 0;		\
+} while (0)
+
+static int phram_setup(const char *val, struct kernel_param *kp)
+{
+	char buf[64+12+12], *str = buf;
+	char *token[3];
+	char *name;
+	uint32_t start;
+	uint32_t len;
+	int i, ret;
+
+	if (strnlen(val, sizeof(str)) >= sizeof(str))
+		parse_err("parameter too long\n");
+
+	strcpy(str, val);
+
+	for (i=0; i<3; i++)
+		token[i] = strsep(&str, ",");
+
+	if (str)
+		parse_err("too many arguments\n");
+
+	if (!token[2])
+		parse_err("not enough arguments\n");
+
+	ret = parse_name(&name, token[0]);
+	if (ret == -ENOMEM)
+		parse_err("out of memory\n");
+	if (ret == -ENOSPC)
+		parse_err("name too long\n");
+	if (ret)
+		return 0;
+
+	ret = parse_num32(&start, token[1]);
+	if (ret)
+		parse_err("illegal start address\n");
+
+	ret = parse_num32(&len, token[2]);
+	if (ret)
+		parse_err("illegal device length\n");
+
+	register_device(name, start, len);
+
+	return 0;
+}
+
+module_param_call(phram, phram_setup, NULL, NULL, 000);
+
+/*
+ * Just for compatibility with slram, this is horrible and should go someday.
+ */
+static int __init slram_setup(const char *val, struct kernel_param *kp)
+{
+	char buf[256], *str = buf;
+
+	if (!val || !val[0])
+		parse_err("no arguments to \"slram=\"\n");
+
+	if (strnlen(val, sizeof(str)) >= sizeof(str))
+		parse_err("parameter too long\n");
+
+	strcpy(str, val);
+
+	while (str) {
+		char *token[3];
+		char *name;
+		uint32_t start;
+		uint32_t len;
+		int i, ret;
+
+		for (i=0; i<3; i++) {
+			token[i] = strsep(&str, ",");
+			if (token[i])
+				continue;
+			parse_err("wrong number of arguments to \"slram=\"\n");
+		}
+
+		/* name */
+		ret = parse_name(&name, token[0]);
+		if (ret == -ENOMEM)
+			parse_err("of memory\n");
+		if (ret == -ENOSPC)
+			parse_err("too long\n");
+		if (ret)
+			return 1;
+
+		/* start */
+		ret = parse_num32(&start, token[1]);
+		if (ret)
+			parse_err("illegal start address\n");
+
+		/* len */
+		if (token[2][0] == '+')
+			ret = parse_num32(&len, token[2] + 1);
+		else
+			ret = parse_num32(&len, token[2]);
+
+		if (ret)
+			parse_err("illegal device length\n");
+
+		if (token[2][0] != '+') {
+			if (len < start)
+				parse_err("end < start\n");
+			len -= start;
+		}
+
+		register_device(name, start, len);
+	}
+	return 1;
+}
+
+module_param_call(slram, slram_setup, NULL, NULL, 000);
+
+
+
+int __init init_phram(void)
+{
+	printk(KERN_ERR "phram loaded\n");
+	return 0;
+}
+
+static void __exit cleanup_phram(void)
+{
+	unregister_devices();
+}
+
+module_init(init_phram);
+module_exit(cleanup_phram);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jörn Engel <joern@wh.fh-wedel.de>");
+MODULE_DESCRIPTION("MTD driver for physical RAM");
--- linux-2.6.0-test1/drivers/mtd/devices/Kconfig~phram	2003-07-16 12:01:47.000000000 +0200
+++ linux-2.6.0-test1/drivers/mtd/devices/Kconfig	2003-07-16 12:02:42.000000000 +0200
@@ -52,6 +52,16 @@
 	  you can still use it for storage or swap by using this driver to
 	  present it to the system as a Memory Technology Device.
 
+config MTD_PHRAM
+	tristate "Physical system RAM"
+	depends on MTD
+	help
+	  This is a re-implementation of the slram driver above.
+	  
+	  Use this driver to access physical memory that the kernel proper
+	  doesn't have access to, memory beyond the mem=xxx limit, nvram,
+	  memory on the video card, etc...
+
 config MTD_LART
 	tristate "28F160xx flash driver for LART"
 	depends on SA1100_LART && MTD
--- linux-2.6.0-test1/drivers/mtd/devices/Makefile~phram	2003-07-16 12:01:47.000000000 +0200
+++ linux-2.6.0-test1/drivers/mtd/devices/Makefile	2003-07-16 12:02:42.000000000 +0200
@@ -15,6 +15,7 @@
 obj-$(CONFIG_MTD_DOC2001PLUS)	+= doc2001plus.o
 obj-$(CONFIG_MTD_DOCPROBE)	+= docprobe.o docecc.o
 obj-$(CONFIG_MTD_SLRAM)		+= slram.o
+obj-$(CONFIG_MTD_PHRAM)		+= phram.o
 obj-$(CONFIG_MTD_PMC551)	+= pmc551.o
 obj-$(CONFIG_MTD_MS02NV)	+= ms02-nv.o
 obj-$(CONFIG_MTD_MTDRAM)	+= mtdram.o
