Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030601AbWHIJKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030601AbWHIJKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030602AbWHIJKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:10:47 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:35673 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030601AbWHIJKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:10:45 -0400
Date: Wed, 9 Aug 2006 11:10:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [patch] s390: ipl/dump on panic.
Message-ID: <20060809091043.GB6497@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] ipl/dump on panic.

It is now possible to specify a ccw/fcp dump device which is used to
automatically create a system dump in case of a kernel panic. The dump
device can be configured under /sys/firmware/dump.
In addition it is now possible to specify a ccw/fcp device which is used
for the next reboot of Linux. The reipl device can be configured under
/sys/firmware/reipl.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/Makefile     |    2 
 arch/s390/kernel/head31.S     |    3 
 arch/s390/kernel/head64.S     |    3 
 arch/s390/kernel/ipl.c        |  942 ++++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/reipl.S      |   33 +
 arch/s390/kernel/reipl64.S    |   34 +
 arch/s390/kernel/reipl_diag.c |   39 -
 arch/s390/kernel/setup.c      |  220 ---------
 arch/s390/kernel/smp.c        |   10 
 drivers/s390/cio/cio.c        |   51 +-
 include/asm-s390/cio.h        |    7 
 include/asm-s390/lowcore.h    |   13 
 include/asm-s390/setup.h      |   54 +-
 13 files changed, 1099 insertions(+), 312 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2006-08-09 10:25:53.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-08-09 10:25:54.000000000 +0200
@@ -38,6 +38,7 @@ startup:basr	%r13,0			# get base
 startup_continue:
 	basr	%r13,0			# get base
 .LPG1:	GET_IPL_DEVICE
+	mvi	__LC_AR_MODE_ID,0	# set ESA flag (mode 0)
 	lctl	%c0,%c15,.Lctl-.LPG1(%r13) # load control registers
 	l	%r12,.Lparmaddr-.LPG1(%r13) # pointer to parameter area
 					# move IPL device to lowcore
@@ -274,6 +275,8 @@ startup_continue:
 .Lparmaddr: .long PARMAREA
 .Lsccbaddr: .long .Lsccb
 	.org	0x12000
+.globl s390_readinfo_sccb
+s390_readinfo_sccb:
 .Lsccb:
 	.hword	0x1000			# length, one page
 	.byte	0x00,0x00,0x00
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-08-09 10:25:53.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-08-09 10:25:54.000000000 +0200
@@ -41,6 +41,7 @@ startup_continue:
         srl   %r13,1
 	GET_IPL_DEVICE
         lhi   %r1,1                      # mode 1 = esame
+	mvi   __LC_AR_MODE_ID,1		 # set esame flag
         slr   %r0,%r0                    # set cpuid to zero
         sigp  %r1,%r0,0x12               # switch to esame mode
 	sam64				 # switch to 64 bit mode
@@ -269,6 +270,8 @@ startup_continue:
 	.quad	PARMAREA
 
 	.org	0x12000
+.globl s390_readinfo_sccb
+s390_readinfo_sccb:
 .Lsccb:
 	.hword 0x1000			# length, one page
 	.byte 0x00,0x00,0x00
diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2006-08-09 10:25:54.000000000 +0200
@@ -0,0 +1,942 @@
+/*
+ *  arch/s390/kernel/ipl.c
+ *    ipl/reipl/dump support for Linux on s390.
+ *
+ *    Copyright (C) IBM Corp. 2005,2006
+ *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>
+ *		 Volker Sameske <sameske@de.ibm.com>
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <asm/smp.h>
+#include <asm/setup.h>
+#include <asm/cpcmd.h>
+#include <asm/cio.h>
+
+#define IPL_PARM_BLOCK_VERSION 0
+
+enum ipl_type {
+	IPL_TYPE_NONE	 = 1,
+	IPL_TYPE_UNKNOWN = 2,
+	IPL_TYPE_CCW	 = 4,
+	IPL_TYPE_FCP	 = 8,
+};
+
+#define IPL_NONE_STR	 "none"
+#define IPL_UNKNOWN_STR  "unknown"
+#define IPL_CCW_STR	 "ccw"
+#define IPL_FCP_STR	 "fcp"
+
+static char *ipl_type_str(enum ipl_type type)
+{
+	switch (type) {
+	case IPL_TYPE_NONE:
+		return IPL_NONE_STR;
+	case IPL_TYPE_CCW:
+		return IPL_CCW_STR;
+	case IPL_TYPE_FCP:
+		return IPL_FCP_STR;
+	case IPL_TYPE_UNKNOWN:
+	default:
+		return IPL_UNKNOWN_STR;
+	}
+}
+
+enum ipl_method {
+	IPL_METHOD_NONE,
+	IPL_METHOD_CCW_CIO,
+	IPL_METHOD_CCW_DIAG,
+	IPL_METHOD_CCW_VM,
+	IPL_METHOD_FCP_RO_DIAG,
+	IPL_METHOD_FCP_RW_DIAG,
+	IPL_METHOD_FCP_RO_VM,
+};
+
+enum shutdown_action {
+	SHUTDOWN_REIPL,
+	SHUTDOWN_DUMP,
+	SHUTDOWN_STOP,
+};
+
+#define SHUTDOWN_REIPL_STR "reipl"
+#define SHUTDOWN_DUMP_STR  "dump"
+#define SHUTDOWN_STOP_STR  "stop"
+
+static char *shutdown_action_str(enum shutdown_action action)
+{
+	switch (action) {
+	case SHUTDOWN_REIPL:
+		return SHUTDOWN_REIPL_STR;
+	case SHUTDOWN_DUMP:
+		return SHUTDOWN_DUMP_STR;
+	case SHUTDOWN_STOP:
+		return SHUTDOWN_STOP_STR;
+	default:
+		BUG();
+	}
+}
+
+enum diag308_subcode  {
+	DIAG308_IPL   = 3,
+	DIAG308_DUMP  = 4,
+	DIAG308_SET   = 5,
+	DIAG308_STORE = 6,
+};
+
+enum diag308_ipl_type {
+	DIAG308_IPL_TYPE_FCP = 0,
+	DIAG308_IPL_TYPE_CCW = 2,
+};
+
+enum diag308_opt {
+	DIAG308_IPL_OPT_IPL  = 0x10,
+	DIAG308_IPL_OPT_DUMP = 0x20,
+};
+
+enum diag308_rc {
+	DIAG308_RC_OK = 1,
+};
+
+static int diag308_set_works = 0;
+
+static int reipl_capabilities = IPL_TYPE_UNKNOWN;
+static enum ipl_type reipl_type = IPL_TYPE_UNKNOWN;
+static enum ipl_method reipl_method = IPL_METHOD_NONE;
+static struct ipl_parameter_block *reipl_block_fcp;
+static struct ipl_parameter_block *reipl_block_ccw;
+
+static int dump_capabilities = IPL_TYPE_NONE;
+static enum ipl_type dump_type = IPL_TYPE_NONE;
+static enum ipl_method dump_method = IPL_METHOD_NONE;
+static struct ipl_parameter_block *dump_block_fcp;
+static struct ipl_parameter_block *dump_block_ccw;
+
+static enum shutdown_action on_panic_action = SHUTDOWN_STOP;
+
+int diag308(unsigned long subcode, void *addr)
+{
+	register unsigned long _addr asm("0") = (unsigned long)addr;
+	register unsigned long _rc asm("1") = 0;
+
+	asm volatile (
+		"   diag %0,%2,0x308\n"
+		"0: \n"
+		".section __ex_table,\"a\"\n"
+#ifdef CONFIG_64BIT
+		"   .align 8\n"
+		"   .quad 0b, 0b\n"
+#else
+		"   .align 4\n"
+		"   .long 0b, 0b\n"
+#endif
+		".previous\n"
+		: "+d" (_addr), "+d" (_rc)
+		: "d" (subcode) : "cc", "memory" );
+
+	return _rc;
+}
+
+/* SYSFS */
+
+#define DEFINE_IPL_ATTR_RO(_prefix, _name, _format, _value)		\
+static ssize_t sys_##_prefix##_##_name##_show(struct subsystem *subsys,	\
+		char *page)						\
+{									\
+	return sprintf(page, _format, _value);				\
+}									\
+static struct subsys_attribute sys_##_prefix##_##_name##_attr =		\
+	__ATTR(_name, S_IRUGO, sys_##_prefix##_##_name##_show, NULL);
+
+#define DEFINE_IPL_ATTR_RW(_prefix, _name, _fmt_out, _fmt_in, _value)	\
+static ssize_t sys_##_prefix##_##_name##_show(struct subsystem *subsys,	\
+		char *page)						\
+{									\
+	return sprintf(page, _fmt_out,					\
+			(unsigned long long) _value);			\
+}									\
+static ssize_t sys_##_prefix##_##_name##_store(struct subsystem *subsys,\
+		const char *buf, size_t len)				\
+{									\
+	unsigned long long value;					\
+	if (sscanf(buf, _fmt_in, &value) != 1)				\
+		return -EINVAL;						\
+	_value = value;							\
+	return len;							\
+}									\
+static struct subsys_attribute sys_##_prefix##_##_name##_attr =		\
+	__ATTR(_name,(S_IRUGO | S_IWUSR),				\
+			sys_##_prefix##_##_name##_show,			\
+			sys_##_prefix##_##_name##_store);
+
+static void make_attrs_ro(struct attribute **attrs)
+{
+	while (*attrs) {
+		(*attrs)->mode = S_IRUGO;
+		attrs++;
+	}
+}
+
+/*
+ * ipl section
+ */
+
+static enum ipl_type ipl_get_type(void)
+{
+	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
+
+	if (!IPL_DEVNO_VALID)
+		return IPL_TYPE_UNKNOWN;
+	if (!IPL_PARMBLOCK_VALID)
+		return IPL_TYPE_CCW;
+	if (ipl->hdr.version > IPL_MAX_SUPPORTED_VERSION)
+		return IPL_TYPE_UNKNOWN;
+	if (ipl->hdr.pbt != DIAG308_IPL_TYPE_FCP)
+		return IPL_TYPE_UNKNOWN;
+	return IPL_TYPE_FCP;
+}
+
+static ssize_t ipl_type_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%s\n", ipl_type_str(ipl_get_type()));
+}
+
+static struct subsys_attribute sys_ipl_type_attr = __ATTR_RO(ipl_type);
+
+static ssize_t sys_ipl_device_show(struct subsystem *subsys, char *page)
+{
+	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
+
+	switch (ipl_get_type()) {
+	case IPL_TYPE_CCW:
+		return sprintf(page, "0.0.%04x\n", ipl_devno);
+	case IPL_TYPE_FCP:
+		return sprintf(page, "0.0.%04x\n", ipl->ipl_info.fcp.devno);
+	default:
+		return 0;
+	}
+}
+
+static struct subsys_attribute sys_ipl_device_attr =
+	__ATTR(device, S_IRUGO, sys_ipl_device_show, NULL);
+
+static ssize_t ipl_parameter_read(struct kobject *kobj, char *buf, loff_t off,
+				  size_t count)
+{
+	unsigned int size = IPL_PARMBLOCK_SIZE;
+
+	if (off > size)
+		return 0;
+	if (off + count > size)
+		count = size - off;
+	memcpy(buf, (void *)IPL_PARMBLOCK_START + off, count);
+	return count;
+}
+
+static struct bin_attribute ipl_parameter_attr = {
+	.attr = {
+		.name = "binary_parameter",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = PAGE_SIZE,
+	.read = &ipl_parameter_read,
+};
+
+static ssize_t ipl_scp_data_read(struct kobject *kobj, char *buf, loff_t off,
+	size_t count)
+{
+	unsigned int size = IPL_PARMBLOCK_START->ipl_info.fcp.scp_data_len;
+	void *scp_data = &IPL_PARMBLOCK_START->ipl_info.fcp.scp_data;
+
+	if (off > size)
+		return 0;
+	if (off + count > size)
+		count = size - off;
+	memcpy(buf, scp_data + off, count);
+	return count;
+}
+
+static struct bin_attribute ipl_scp_data_attr = {
+	.attr = {
+		.name = "scp_data",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = PAGE_SIZE,
+	.read = &ipl_scp_data_read,
+};
+
+/* FCP ipl device attributes */
+
+DEFINE_IPL_ATTR_RO(ipl_fcp, wwpn, "0x%016llx\n", (unsigned long long)
+		   IPL_PARMBLOCK_START->ipl_info.fcp.wwpn);
+DEFINE_IPL_ATTR_RO(ipl_fcp, lun, "0x%016llx\n", (unsigned long long)
+		   IPL_PARMBLOCK_START->ipl_info.fcp.lun);
+DEFINE_IPL_ATTR_RO(ipl_fcp, bootprog, "%lld\n", (unsigned long long)
+		   IPL_PARMBLOCK_START->ipl_info.fcp.bootprog);
+DEFINE_IPL_ATTR_RO(ipl_fcp, br_lba, "%lld\n", (unsigned long long)
+		   IPL_PARMBLOCK_START->ipl_info.fcp.br_lba);
+
+static struct attribute *ipl_fcp_attrs[] = {
+	&sys_ipl_type_attr.attr,
+	&sys_ipl_device_attr.attr,
+	&sys_ipl_fcp_wwpn_attr.attr,
+	&sys_ipl_fcp_lun_attr.attr,
+	&sys_ipl_fcp_bootprog_attr.attr,
+	&sys_ipl_fcp_br_lba_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ipl_fcp_attr_group = {
+	.attrs = ipl_fcp_attrs,
+};
+
+/* CCW ipl device attributes */
+
+static struct attribute *ipl_ccw_attrs[] = {
+	&sys_ipl_type_attr.attr,
+	&sys_ipl_device_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ipl_ccw_attr_group = {
+	.attrs = ipl_ccw_attrs,
+};
+
+/* UNKNOWN ipl device attributes */
+
+static struct attribute *ipl_unknown_attrs[] = {
+	&sys_ipl_type_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ipl_unknown_attr_group = {
+	.attrs = ipl_unknown_attrs,
+};
+
+static decl_subsys(ipl, NULL, NULL);
+
+/*
+ * reipl section
+ */
+
+/* FCP reipl device attributes */
+
+DEFINE_IPL_ATTR_RW(reipl_fcp, wwpn, "0x%016llx\n", "%016llx\n",
+		   reipl_block_fcp->ipl_info.fcp.wwpn);
+DEFINE_IPL_ATTR_RW(reipl_fcp, lun, "0x%016llx\n", "%016llx\n",
+		   reipl_block_fcp->ipl_info.fcp.lun);
+DEFINE_IPL_ATTR_RW(reipl_fcp, bootprog, "%lld\n", "%lld\n",
+		   reipl_block_fcp->ipl_info.fcp.bootprog);
+DEFINE_IPL_ATTR_RW(reipl_fcp, br_lba, "%lld\n", "%lld\n",
+		   reipl_block_fcp->ipl_info.fcp.br_lba);
+DEFINE_IPL_ATTR_RW(reipl_fcp, device, "0.0.%04llx\n", "0.0.%llx\n",
+		   reipl_block_fcp->ipl_info.fcp.devno);
+
+static struct attribute *reipl_fcp_attrs[] = {
+	&sys_reipl_fcp_device_attr.attr,
+	&sys_reipl_fcp_wwpn_attr.attr,
+	&sys_reipl_fcp_lun_attr.attr,
+	&sys_reipl_fcp_bootprog_attr.attr,
+	&sys_reipl_fcp_br_lba_attr.attr,
+	NULL,
+};
+
+static struct attribute_group reipl_fcp_attr_group = {
+	.name  = IPL_FCP_STR,
+	.attrs = reipl_fcp_attrs,
+};
+
+/* CCW reipl device attributes */
+
+DEFINE_IPL_ATTR_RW(reipl_ccw, device, "0.0.%04llx\n", "0.0.%llx\n",
+	reipl_block_ccw->ipl_info.ccw.devno);
+
+static struct attribute *reipl_ccw_attrs[] = {
+	&sys_reipl_ccw_device_attr.attr,
+	NULL,
+};
+
+static struct attribute_group reipl_ccw_attr_group = {
+	.name  = IPL_CCW_STR,
+	.attrs = reipl_ccw_attrs,
+};
+
+/* reipl type */
+
+static int reipl_set_type(enum ipl_type type)
+{
+	if (!(reipl_capabilities & type))
+		return -EINVAL;
+
+	switch(type) {
+	case IPL_TYPE_CCW:
+		if (MACHINE_IS_VM)
+			reipl_method = IPL_METHOD_CCW_VM;
+		else
+			reipl_method = IPL_METHOD_CCW_CIO;
+		break;
+	case IPL_TYPE_FCP:
+		if (diag308_set_works)
+			reipl_method = IPL_METHOD_FCP_RW_DIAG;
+		else if (MACHINE_IS_VM)
+			reipl_method = IPL_METHOD_FCP_RO_VM;
+		else
+			reipl_method = IPL_METHOD_FCP_RO_DIAG;
+		break;
+	default:
+		reipl_method = IPL_METHOD_NONE;
+	}
+	reipl_type = type;
+	return 0;
+}
+
+static ssize_t reipl_type_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%s\n", ipl_type_str(reipl_type));
+}
+
+static ssize_t reipl_type_store(struct subsystem *subsys, const char *buf,
+				size_t len)
+{
+	int rc = -EINVAL;
+
+	if (strncmp(buf, IPL_CCW_STR, strlen(IPL_CCW_STR)) == 0)
+		rc = reipl_set_type(IPL_TYPE_CCW);
+	else if (strncmp(buf, IPL_FCP_STR, strlen(IPL_FCP_STR)) == 0)
+		rc = reipl_set_type(IPL_TYPE_FCP);
+	return (rc != 0) ? rc : len;
+}
+
+static struct subsys_attribute reipl_type_attr =
+		__ATTR(reipl_type, 0644, reipl_type_show, reipl_type_store);
+
+static decl_subsys(reipl, NULL, NULL);
+
+/*
+ * dump section
+ */
+
+/* FCP dump device attributes */
+
+DEFINE_IPL_ATTR_RW(dump_fcp, wwpn, "0x%016llx\n", "%016llx\n",
+		   dump_block_fcp->ipl_info.fcp.wwpn);
+DEFINE_IPL_ATTR_RW(dump_fcp, lun, "0x%016llx\n", "%016llx\n",
+		   dump_block_fcp->ipl_info.fcp.lun);
+DEFINE_IPL_ATTR_RW(dump_fcp, bootprog, "%lld\n", "%lld\n",
+		   dump_block_fcp->ipl_info.fcp.bootprog);
+DEFINE_IPL_ATTR_RW(dump_fcp, br_lba, "%lld\n", "%lld\n",
+		   dump_block_fcp->ipl_info.fcp.br_lba);
+DEFINE_IPL_ATTR_RW(dump_fcp, device, "0.0.%04llx\n", "0.0.%llx\n",
+		   dump_block_fcp->ipl_info.fcp.devno);
+
+static struct attribute *dump_fcp_attrs[] = {
+	&sys_dump_fcp_device_attr.attr,
+	&sys_dump_fcp_wwpn_attr.attr,
+	&sys_dump_fcp_lun_attr.attr,
+	&sys_dump_fcp_bootprog_attr.attr,
+	&sys_dump_fcp_br_lba_attr.attr,
+	NULL,
+};
+
+static struct attribute_group dump_fcp_attr_group = {
+	.name  = IPL_FCP_STR,
+	.attrs = dump_fcp_attrs,
+};
+
+/* CCW dump device attributes */
+
+DEFINE_IPL_ATTR_RW(dump_ccw, device, "0.0.%04llx\n", "0.0.%llx\n",
+		   dump_block_ccw->ipl_info.ccw.devno);
+
+static struct attribute *dump_ccw_attrs[] = {
+	&sys_dump_ccw_device_attr.attr,
+	NULL,
+};
+
+static struct attribute_group dump_ccw_attr_group = {
+	.name  = IPL_CCW_STR,
+	.attrs = dump_ccw_attrs,
+};
+
+/* dump type */
+
+static int dump_set_type(enum ipl_type type)
+{
+	if (!(dump_capabilities & type))
+		return -EINVAL;
+	switch(type) {
+	case IPL_TYPE_CCW:
+		if (MACHINE_IS_VM)
+			dump_method = IPL_METHOD_CCW_VM;
+		else
+			dump_method = IPL_METHOD_CCW_CIO;
+		break;
+	case IPL_TYPE_FCP:
+		dump_method = IPL_METHOD_FCP_RW_DIAG;
+		break;
+	default:
+		dump_method = IPL_METHOD_NONE;
+	}
+	dump_type = type;
+	return 0;
+}
+
+static ssize_t dump_type_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%s\n", ipl_type_str(dump_type));
+}
+
+static ssize_t dump_type_store(struct subsystem *subsys, const char *buf,
+			       size_t len)
+{
+	int rc = -EINVAL;
+
+	if (strncmp(buf, IPL_NONE_STR, strlen(IPL_NONE_STR)) == 0)
+		rc = dump_set_type(IPL_TYPE_NONE);
+	else if (strncmp(buf, IPL_CCW_STR, strlen(IPL_CCW_STR)) == 0)
+		rc = dump_set_type(IPL_TYPE_CCW);
+	else if (strncmp(buf, IPL_FCP_STR, strlen(IPL_FCP_STR)) == 0)
+		rc = dump_set_type(IPL_TYPE_FCP);
+	return (rc != 0) ? rc : len;
+}
+
+static struct subsys_attribute dump_type_attr =
+		__ATTR(dump_type, 0644, dump_type_show, dump_type_store);
+
+static decl_subsys(dump, NULL, NULL);
+
+#ifdef CONFIG_SMP
+static void dump_smp_stop_all(void)
+{
+	int cpu;
+	preempt_disable();
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		while (signal_processor(cpu, sigp_stop) == sigp_busy)
+			udelay(10);
+	}
+	preempt_enable();
+}
+#else
+#define dump_smp_stop_all() do { } while (0)
+#endif
+
+/*
+ * Shutdown actions section
+ */
+
+static decl_subsys(shutdown_actions, NULL, NULL);
+
+/* on panic */
+
+static ssize_t on_panic_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%s\n", shutdown_action_str(on_panic_action));
+}
+
+static ssize_t on_panic_store(struct subsystem *subsys, const char *buf,
+			      size_t len)
+{
+	if (strncmp(buf, SHUTDOWN_REIPL_STR, strlen(SHUTDOWN_REIPL_STR)) == 0)
+		on_panic_action = SHUTDOWN_REIPL;
+	else if (strncmp(buf, SHUTDOWN_DUMP_STR,
+			 strlen(SHUTDOWN_DUMP_STR)) == 0)
+		on_panic_action = SHUTDOWN_DUMP;
+	else if (strncmp(buf, SHUTDOWN_STOP_STR,
+			 strlen(SHUTDOWN_STOP_STR)) == 0)
+		on_panic_action = SHUTDOWN_STOP;
+	else
+		return -EINVAL;
+
+	return len;
+}
+
+static struct subsys_attribute on_panic_attr =
+		__ATTR(on_panic, 0644, on_panic_show, on_panic_store);
+
+static void print_fcp_block(struct ipl_parameter_block *fcp_block)
+{
+	printk(KERN_EMERG "wwpn:      %016llx\n",
+		(unsigned long long)fcp_block->ipl_info.fcp.wwpn);
+	printk(KERN_EMERG "lun:       %016llx\n",
+		(unsigned long long)fcp_block->ipl_info.fcp.lun);
+	printk(KERN_EMERG "bootprog:  %lld\n",
+		(unsigned long long)fcp_block->ipl_info.fcp.bootprog);
+	printk(KERN_EMERG "br_lba:    %lld\n",
+		(unsigned long long)fcp_block->ipl_info.fcp.br_lba);
+	printk(KERN_EMERG "device:    %llx\n",
+		(unsigned long long)fcp_block->ipl_info.fcp.devno);
+	printk(KERN_EMERG "opt:       %x\n", fcp_block->ipl_info.fcp.opt);
+}
+
+void do_reipl(void)
+{
+	struct ccw_dev_id devid;
+	static char buf[100];
+
+	switch (reipl_type) {
+	case IPL_TYPE_CCW:
+		printk(KERN_EMERG "reboot on ccw device: 0.0.%04x\n",
+			reipl_block_ccw->ipl_info.ccw.devno);
+		break;
+	case IPL_TYPE_FCP:
+		printk(KERN_EMERG "reboot on fcp device:\n");
+		print_fcp_block(reipl_block_fcp);
+		break;
+	default:
+		break;
+	}
+
+	switch (reipl_method) {
+	case IPL_METHOD_CCW_CIO:
+		devid.devno = reipl_block_ccw->ipl_info.ccw.devno;
+		devid.ssid  = 0;
+		reipl_ccw_dev(&devid);
+		break;
+	case IPL_METHOD_CCW_VM:
+		sprintf(buf, "IPL %X", reipl_block_ccw->ipl_info.ccw.devno);
+		cpcmd(buf, NULL, 0, NULL);
+		break;
+	case IPL_METHOD_CCW_DIAG:
+		diag308(DIAG308_SET, reipl_block_ccw);
+		diag308(DIAG308_IPL, NULL);
+		break;
+	case IPL_METHOD_FCP_RW_DIAG:
+		diag308(DIAG308_SET, reipl_block_fcp);
+		diag308(DIAG308_IPL, NULL);
+		break;
+	case IPL_METHOD_FCP_RO_DIAG:
+		diag308(DIAG308_IPL, NULL);
+		break;
+	case IPL_METHOD_FCP_RO_VM:
+		cpcmd("IPL", NULL, 0, NULL);
+		break;
+	case IPL_METHOD_NONE:
+	default:
+		if (MACHINE_IS_VM)
+			cpcmd("IPL", NULL, 0, NULL);
+		diag308(DIAG308_IPL, NULL);
+		break;
+	}
+	panic("reipl failed!\n");
+}
+
+static void do_dump(void)
+{
+	struct ccw_dev_id devid;
+	static char buf[100];
+
+	switch (dump_type) {
+	case IPL_TYPE_CCW:
+		printk(KERN_EMERG "Automatic dump on ccw device: 0.0.%04x\n",
+		       dump_block_ccw->ipl_info.ccw.devno);
+		break;
+	case IPL_TYPE_FCP:
+		printk(KERN_EMERG "Automatic dump on fcp device:\n");
+		print_fcp_block(dump_block_fcp);
+		break;
+	default:
+		return;
+	}
+
+	switch (dump_method) {
+	case IPL_METHOD_CCW_CIO:
+		dump_smp_stop_all();
+		devid.devno = dump_block_ccw->ipl_info.ccw.devno;
+		devid.ssid  = 0;
+		reipl_ccw_dev(&devid);
+		break;
+	case IPL_METHOD_CCW_VM:
+		dump_smp_stop_all();
+		sprintf(buf, "STORE STATUS");
+		cpcmd(buf, NULL, 0, NULL);
+		sprintf(buf, "IPL %X", dump_block_ccw->ipl_info.ccw.devno);
+		cpcmd(buf, NULL, 0, NULL);
+		break;
+	case IPL_METHOD_CCW_DIAG:
+		diag308(DIAG308_SET, dump_block_ccw);
+		diag308(DIAG308_DUMP, NULL);
+		break;
+	case IPL_METHOD_FCP_RW_DIAG:
+		diag308(DIAG308_SET, dump_block_fcp);
+		diag308(DIAG308_DUMP, NULL);
+		break;
+	case IPL_METHOD_NONE:
+	default:
+		return;
+	}
+	printk(KERN_EMERG "Dump failed!\n");
+}
+
+/* init functions */
+
+static int __init ipl_register_fcp_files(void)
+{
+	int rc;
+
+	rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+				&ipl_fcp_attr_group);
+	if (rc)
+		goto out;
+	rc = sysfs_create_bin_file(&ipl_subsys.kset.kobj,
+				   &ipl_parameter_attr);
+	if (rc)
+		goto out_ipl_parm;
+	rc = sysfs_create_bin_file(&ipl_subsys.kset.kobj,
+				   &ipl_scp_data_attr);
+	if (!rc)
+		goto out;
+
+	sysfs_remove_bin_file(&ipl_subsys.kset.kobj, &ipl_parameter_attr);
+
+out_ipl_parm:
+	sysfs_remove_group(&ipl_subsys.kset.kobj, &ipl_fcp_attr_group);
+out:
+	return rc;
+}
+
+static int __init ipl_init(void)
+{
+	int rc;
+
+	rc = firmware_register(&ipl_subsys);
+	if (rc)
+		return rc;
+	switch (ipl_get_type()) {
+	case IPL_TYPE_CCW:
+		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+					&ipl_ccw_attr_group);
+		break;
+	case IPL_TYPE_FCP:
+		rc = ipl_register_fcp_files();
+		break;
+	default:
+		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+					&ipl_unknown_attr_group);
+		break;
+	}
+	if (rc)
+		firmware_unregister(&ipl_subsys);
+	return rc;
+}
+
+static void __init reipl_probe(void)
+{
+	void *buffer;
+
+	buffer = (void*) get_zeroed_page(GFP_KERNEL);
+	if (!buffer)
+		return;
+	if (diag308(DIAG308_STORE, buffer) == DIAG308_RC_OK)
+		diag308_set_works = 1;
+	free_page((unsigned long)buffer);
+}
+
+static int __init reipl_ccw_init(void)
+{
+	int rc;
+
+	reipl_block_ccw = (void*) get_zeroed_page(GFP_KERNEL);
+	if (!reipl_block_ccw)
+		return -ENOMEM;
+	rc = sysfs_create_group(&reipl_subsys.kset.kobj, &reipl_ccw_attr_group);
+	if (rc) {
+		free_page((unsigned long)reipl_block_ccw);
+		return rc;
+	}
+	reipl_block_ccw->hdr.len = IPL_PARM_BLK_CCW_LEN;
+	reipl_block_ccw->hdr.version = IPL_PARM_BLOCK_VERSION;
+	reipl_block_ccw->hdr.blk0_len = sizeof(reipl_block_ccw->ipl_info.ccw);
+	reipl_block_ccw->hdr.pbt = DIAG308_IPL_TYPE_CCW;
+	if (ipl_get_type() == IPL_TYPE_CCW)
+		reipl_block_ccw->ipl_info.ccw.devno = ipl_devno;
+	reipl_capabilities |= IPL_TYPE_CCW;
+	return 0;
+}
+
+static int __init reipl_fcp_init(void)
+{
+	int rc;
+
+	if ((!diag308_set_works) && (ipl_get_type() != IPL_TYPE_FCP))
+		return 0;
+	if ((!diag308_set_works) && (ipl_get_type() == IPL_TYPE_FCP))
+		make_attrs_ro(reipl_fcp_attrs);
+
+	reipl_block_fcp = (void*) get_zeroed_page(GFP_KERNEL);
+	if (!reipl_block_fcp)
+		return -ENOMEM;
+	rc = sysfs_create_group(&reipl_subsys.kset.kobj, &reipl_fcp_attr_group);
+	if (rc) {
+		free_page((unsigned long)reipl_block_fcp);
+		return rc;
+	}
+	if (ipl_get_type() == IPL_TYPE_FCP) {
+		memcpy(reipl_block_fcp, IPL_PARMBLOCK_START, PAGE_SIZE);
+	} else {
+		reipl_block_fcp->hdr.len = IPL_PARM_BLK_FCP_LEN;
+		reipl_block_fcp->hdr.version = IPL_PARM_BLOCK_VERSION;
+		reipl_block_fcp->hdr.blk0_len =
+			sizeof(reipl_block_fcp->ipl_info.fcp);
+		reipl_block_fcp->hdr.pbt = DIAG308_IPL_TYPE_FCP;
+		reipl_block_fcp->ipl_info.fcp.opt = DIAG308_IPL_OPT_IPL;
+	}
+	reipl_capabilities |= IPL_TYPE_FCP;
+	return 0;
+}
+
+static int __init reipl_init(void)
+{
+	int rc;
+
+	rc = firmware_register(&reipl_subsys);
+	if (rc)
+		return rc;
+	rc = subsys_create_file(&reipl_subsys, &reipl_type_attr);
+	if (rc) {
+		firmware_unregister(&reipl_subsys);
+		return rc;
+	}
+	rc = reipl_ccw_init();
+	if (rc)
+		return rc;
+	rc = reipl_fcp_init();
+	if (rc)
+		return rc;
+	rc = reipl_set_type(ipl_get_type());
+	if (rc)
+		return rc;
+	return 0;
+}
+
+static int __init dump_ccw_init(void)
+{
+	int rc;
+
+	dump_block_ccw = (void*) get_zeroed_page(GFP_KERNEL);
+	if (!dump_block_ccw)
+		return -ENOMEM;
+	rc = sysfs_create_group(&dump_subsys.kset.kobj, &dump_ccw_attr_group);
+	if (rc) {
+		free_page((unsigned long)dump_block_ccw);
+		return rc;
+	}
+	dump_block_ccw->hdr.len = IPL_PARM_BLK_CCW_LEN;
+	dump_block_ccw->hdr.version = IPL_PARM_BLOCK_VERSION;
+	dump_block_ccw->hdr.blk0_len = sizeof(reipl_block_ccw->ipl_info.ccw);
+	dump_block_ccw->hdr.pbt = DIAG308_IPL_TYPE_CCW;
+	dump_capabilities |= IPL_TYPE_CCW;
+	return 0;
+}
+
+extern char s390_readinfo_sccb[];
+
+static int __init dump_fcp_init(void)
+{
+	int rc;
+
+	if(!(s390_readinfo_sccb[91] & 0x2))
+		return 0; /* LDIPL DUMP is not installed */
+	if (!diag308_set_works)
+		return 0;
+	dump_block_fcp = (void*) get_zeroed_page(GFP_KERNEL);
+	if (!dump_block_fcp)
+		return -ENOMEM;
+	rc = sysfs_create_group(&dump_subsys.kset.kobj, &dump_fcp_attr_group);
+	if (rc) {
+		free_page((unsigned long)dump_block_fcp);
+		return rc;
+	}
+	dump_block_fcp->hdr.len = IPL_PARM_BLK_FCP_LEN;
+	dump_block_fcp->hdr.version = IPL_PARM_BLOCK_VERSION;
+	dump_block_fcp->hdr.blk0_len = sizeof(dump_block_fcp->ipl_info.fcp);
+	dump_block_fcp->hdr.pbt = DIAG308_IPL_TYPE_FCP;
+	dump_block_fcp->ipl_info.fcp.opt = DIAG308_IPL_OPT_DUMP;
+	dump_capabilities |= IPL_TYPE_FCP;
+	return 0;
+}
+
+#define SHUTDOWN_ON_PANIC_PRIO 0
+
+static int shutdown_on_panic_notify(struct notifier_block *self,
+				    unsigned long event, void *data)
+{
+	if (on_panic_action == SHUTDOWN_DUMP)
+		do_dump();
+	else if (on_panic_action == SHUTDOWN_REIPL)
+		do_reipl();
+	return NOTIFY_OK;
+}
+
+static struct notifier_block shutdown_on_panic_nb = {
+	.notifier_call = shutdown_on_panic_notify,
+	.priority = SHUTDOWN_ON_PANIC_PRIO
+};
+
+static int __init dump_init(void)
+{
+	int rc;
+
+	rc = firmware_register(&dump_subsys);
+	if (rc)
+		return rc;
+	rc = subsys_create_file(&dump_subsys, &dump_type_attr);
+	if (rc) {
+		firmware_unregister(&dump_subsys);
+		return rc;
+	}
+	rc = dump_ccw_init();
+	if (rc)
+		return rc;
+	rc = dump_fcp_init();
+	if (rc)
+		return rc;
+	dump_set_type(IPL_TYPE_NONE);
+	return 0;
+}
+
+static int __init shutdown_actions_init(void)
+{
+	int rc;
+
+	rc = firmware_register(&shutdown_actions_subsys);
+	if (rc)
+		return rc;
+	rc = subsys_create_file(&shutdown_actions_subsys, &on_panic_attr);
+	if (rc) {
+		firmware_unregister(&shutdown_actions_subsys);
+		return rc;
+	}
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &shutdown_on_panic_nb);
+	return 0;
+}
+
+static int __init s390_ipl_init(void)
+{
+	int rc;
+
+	reipl_probe();
+	rc = ipl_init();
+	if (rc)
+		return rc;
+	rc = reipl_init();
+	if (rc)
+		return rc;
+	rc = dump_init();
+	if (rc)
+		return rc;
+	rc = shutdown_actions_init();
+	if (rc)
+		return rc;
+	return 0;
+}
+
+__initcall(s390_ipl_init);
diff -urpN linux-2.6/arch/s390/kernel/Makefile linux-2.6-patched/arch/s390/kernel/Makefile
--- linux-2.6/arch/s390/kernel/Makefile	2006-08-09 10:25:52.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/Makefile	2006-08-09 10:25:54.000000000 +0200
@@ -6,7 +6,7 @@ EXTRA_AFLAGS	:= -traditional
 
 obj-y	:=  bitmap.o traps.o time.o process.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
-            semaphore.o s390_ext.o debug.o profile.o irq.o reipl_diag.o
+	    semaphore.o s390_ext.o debug.o profile.o irq.o ipl.o
 
 obj-y	+= $(if $(CONFIG_64BIT),entry64.o,entry.o)
 obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,reipl.o)
diff -urpN linux-2.6/arch/s390/kernel/reipl64.S linux-2.6-patched/arch/s390/kernel/reipl64.S
--- linux-2.6/arch/s390/kernel/reipl64.S	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/reipl64.S	2006-08-09 10:25:54.000000000 +0200
@@ -8,13 +8,30 @@
  */
 
 #include <asm/lowcore.h>
-		.globl	do_reipl
-do_reipl:	basr	%r13,0
-.Lpg0:		lpswe   .Lnewpsw-.Lpg0(%r13)
+		.globl	do_reipl_asm
+do_reipl_asm:	basr	%r13,0
+
+		# do store status of all registers
+
+.Lpg0:		stg	%r1,.Lregsave-.Lpg0(%r13)
+		lghi	%r1,0x1000
+		stmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-0x1000(%r1)
+		lg	%r0,.Lregsave-.Lpg0(%r13)
+		stg	%r0,__LC_GPREGS_SAVE_AREA-0x1000+8(%r1)
+		stctg	%c0,%c15,__LC_CREGS_SAVE_AREA-0x1000(%r1)
+		stam	%a0,%a15,__LC_AREGS_SAVE_AREA-0x1000(%r1)
+		stpx	__LC_PREFIX_SAVE_AREA-0x1000(%r1)
+		stfpc	__LC_FP_CREG_SAVE_AREA-0x1000(%r1)
+		stckc	.Lclkcmp-.Lpg0(%r13)
+		mvc	__LC_CLOCK_COMP_SAVE_AREA-0x1000(8,%r1),.Lclkcmp-.Lpg0(%r13)
+		stpt	__LC_CPU_TIMER_SAVE_AREA-0x1000(%r1)
+		stg	%r13, __LC_PSW_SAVE_AREA-0x1000+8(%r1)
+
+		lpswe	.Lnewpsw-.Lpg0(%r13)
 .Lpg1:		lctlg	%c6,%c6,.Lall-.Lpg0(%r13)
-                stctg   %c0,%c0,.Lctlsave-.Lpg0(%r13)
-                ni      .Lctlsave+4-.Lpg0(%r13),0xef
-                lctlg   %c0,%c0,.Lctlsave-.Lpg0(%r13)
+		stctg	%c0,%c0,.Lregsave-.Lpg0(%r13)
+		ni	.Lregsave+4-.Lpg0(%r13),0xef
+		lctlg	%c0,%c0,.Lregsave-.Lpg0(%r13)
                 lgr     %r1,%r2
         	mvc     __LC_PGM_NEW_PSW(16),.Lpcnew-.Lpg0(%r13)
                 stsch   .Lschib-.Lpg0(%r13)                                    
@@ -50,8 +67,9 @@ do_reipl:	basr	%r13,0
 		st     %r14,.Ldispsw+12-.Lpg0(%r13)
 		lpswe	.Ldispsw-.Lpg0(%r13)
                 .align 	8
+.Lclkcmp:	.quad	0x0000000000000000
 .Lall:		.quad	0x00000000ff000000
-.Lctlsave:      .quad   0x0000000000000000
+.Lregsave:	.quad	0x0000000000000000
 .Lnull:		.long   0x0000000000000000
                 .align 	16
 /*
@@ -92,5 +110,3 @@ do_reipl:	basr	%r13,0
 		.long	0x00000000,0x00000000
 		.long	0x00000000,0x00000000
 	
-
-	
diff -urpN linux-2.6/arch/s390/kernel/reipl_diag.c linux-2.6-patched/arch/s390/kernel/reipl_diag.c
--- linux-2.6/arch/s390/kernel/reipl_diag.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/reipl_diag.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,39 +0,0 @@
-/*
- * This file contains the implementation of the
- * Linux re-IPL support
- *
- * (C) Copyright IBM Corp. 2005
- *
- * Author(s): Volker Sameske (sameske@de.ibm.com)
- *
- */
-
-#include <linux/kernel.h>
-
-static unsigned int reipl_diag_rc1;
-static unsigned int reipl_diag_rc2;
-
-/*
- * re-IPL the system using the last used IPL parameters
- */
-void reipl_diag(void)
-{
-        asm volatile (
-		"   la   %%r4,0\n"
-		"   la   %%r5,0\n"
-                "   diag %%r4,%2,0x308\n"
-                "0:\n"
-		"   st   %%r4,%0\n"
-		"   st   %%r5,%1\n"
-                ".section __ex_table,\"a\"\n"
-#ifdef CONFIG_64BIT
-                "   .align 8\n"
-                "   .quad 0b, 0b\n"
-#else
-                "   .align 4\n"
-                "   .long 0b, 0b\n"
-#endif
-                ".previous\n"
-                : "=m" (reipl_diag_rc1), "=m" (reipl_diag_rc2)
-		: "d" (3) : "cc", "4", "5" );
-}
diff -urpN linux-2.6/arch/s390/kernel/reipl.S linux-2.6-patched/arch/s390/kernel/reipl.S
--- linux-2.6/arch/s390/kernel/reipl.S	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/reipl.S	2006-08-09 10:25:54.000000000 +0200
@@ -8,13 +8,30 @@
 
 #include <asm/lowcore.h>
 
-		.globl	do_reipl
-do_reipl:	basr	%r13,0
+		.globl	do_reipl_asm
+do_reipl_asm:	basr	%r13,0
 .Lpg0:		lpsw	.Lnewpsw-.Lpg0(%r13)
-.Lpg1:		lctl	%c6,%c6,.Lall-.Lpg0(%r13)
-                stctl   %c0,%c0,.Lctlsave-.Lpg0(%r13)
-                ni      .Lctlsave-.Lpg0(%r13),0xef
-                lctl    %c0,%c0,.Lctlsave-.Lpg0(%r13)
+
+		# switch off lowcore protection
+
+.Lpg1:		stctl	%c0,%c0,.Lctlsave1-.Lpg0(%r13)
+		stctl	%c0,%c0,.Lctlsave2-.Lpg0(%r13)
+		ni	.Lctlsave1-.Lpg0(%r13),0xef
+		lctl	%c0,%c0,.Lctlsave1-.Lpg0(%r13)
+
+		# do store status of all registers
+
+		stm	%r0,%r15,__LC_GPREGS_SAVE_AREA
+		stctl	%c0,%c15,__LC_CREGS_SAVE_AREA
+		mvc	__LC_CREGS_SAVE_AREA(4),.Lctlsave2-.Lpg0(%r13)
+		stam	%a0,%a15,__LC_AREGS_SAVE_AREA
+		stpx	__LC_PREFIX_SAVE_AREA
+		stckc	.Lclkcmp-.Lpg0(%r13)
+		mvc	__LC_CLOCK_COMP_SAVE_AREA(8),.Lclkcmp-.Lpg0(%r13)
+		stpt	__LC_CPU_TIMER_SAVE_AREA
+		st	%r13, __LC_PSW_SAVE_AREA+4
+
+		lctl	%c6,%c6,.Lall-.Lpg0(%r13)
                 lr      %r1,%r2
         	mvc     __LC_PGM_NEW_PSW(8),.Lpcnew-.Lpg0(%r13)
                 stsch   .Lschib-.Lpg0(%r13)                                    
@@ -46,9 +63,11 @@ do_reipl:	basr	%r13,0
 .Ldisab:	st      %r14,.Ldispsw+4-.Lpg0(%r13)
 		lpsw	.Ldispsw-.Lpg0(%r13)
                 .align 	8
+.Lclkcmp:	.quad	0x0000000000000000
 .Lall:		.long	0xff000000
 .Lnull:		.long   0x00000000
-.Lctlsave:      .long   0x00000000
+.Lctlsave1:	.long	0x00000000
+.Lctlsave2:	.long	0x00000000
                 .align 	8
 .Lnewpsw:	.long   0x00080000,0x80000000+.Lpg1
 .Lpcnew:  	.long   0x00080000,0x80000000+.Lecs
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-08-09 10:25:53.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-08-09 10:25:54.000000000 +0200
@@ -285,16 +285,9 @@ void (*_machine_power_off)(void) = machi
 /*
  * Reboot, halt and power_off routines for non SMP.
  */
-extern void reipl(unsigned long devno);
-extern void reipl_diag(void);
 static void do_machine_restart_nonsmp(char * __unused)
 {
-	reipl_diag();
-
-	if (MACHINE_IS_VM)
-		cpcmd ("IPL", NULL, 0, NULL);
-	else
-		reipl (0x10000 | S390_lowcore.ipl_device);
+	do_reipl();
 }
 
 static void do_machine_halt_nonsmp(void)
@@ -754,214 +747,3 @@ struct seq_operations cpuinfo_op = {
 	.show	= show_cpuinfo,
 };
 
-#define DEFINE_IPL_ATTR(_name, _format, _value)			\
-static ssize_t ipl_##_name##_show(struct subsystem *subsys,	\
-		char *page)					\
-{								\
-	return sprintf(page, _format, _value);			\
-}								\
-static struct subsys_attribute ipl_##_name##_attr =		\
-	__ATTR(_name, S_IRUGO, ipl_##_name##_show, NULL);
-
-DEFINE_IPL_ATTR(wwpn, "0x%016llx\n", (unsigned long long)
-		IPL_PARMBLOCK_START->fcp.wwpn);
-DEFINE_IPL_ATTR(lun, "0x%016llx\n", (unsigned long long)
-		IPL_PARMBLOCK_START->fcp.lun);
-DEFINE_IPL_ATTR(bootprog, "%lld\n", (unsigned long long)
-		IPL_PARMBLOCK_START->fcp.bootprog);
-DEFINE_IPL_ATTR(br_lba, "%lld\n", (unsigned long long)
-		IPL_PARMBLOCK_START->fcp.br_lba);
-
-enum ipl_type_type {
-	ipl_type_unknown,
-	ipl_type_ccw,
-	ipl_type_fcp,
-};
-
-static enum ipl_type_type
-get_ipl_type(void)
-{
-	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
-
-	if (!IPL_DEVNO_VALID)
-		return ipl_type_unknown;
-	if (!IPL_PARMBLOCK_VALID)
-		return ipl_type_ccw;
-	if (ipl->hdr.header.version > IPL_MAX_SUPPORTED_VERSION)
-		return ipl_type_unknown;
-	if (ipl->fcp.pbt != IPL_TYPE_FCP)
-		return ipl_type_unknown;
-	return ipl_type_fcp;
-}
-
-static ssize_t
-ipl_type_show(struct subsystem *subsys, char *page)
-{
-	switch (get_ipl_type()) {
-	case ipl_type_ccw:
-		return sprintf(page, "ccw\n");
-	case ipl_type_fcp:
-		return sprintf(page, "fcp\n");
-	default:
-		return sprintf(page, "unknown\n");
-	}
-}
-
-static struct subsys_attribute ipl_type_attr = __ATTR_RO(ipl_type);
-
-static ssize_t
-ipl_device_show(struct subsystem *subsys, char *page)
-{
-	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
-
-	switch (get_ipl_type()) {
-	case ipl_type_ccw:
-		return sprintf(page, "0.0.%04x\n", ipl_devno);
-	case ipl_type_fcp:
-		return sprintf(page, "0.0.%04x\n", ipl->fcp.devno);
-	default:
-		return 0;
-	}
-}
-
-static struct subsys_attribute ipl_device_attr =
-	__ATTR(device, S_IRUGO, ipl_device_show, NULL);
-
-static struct attribute *ipl_fcp_attrs[] = {
-	&ipl_type_attr.attr,
-	&ipl_device_attr.attr,
-	&ipl_wwpn_attr.attr,
-	&ipl_lun_attr.attr,
-	&ipl_bootprog_attr.attr,
-	&ipl_br_lba_attr.attr,
-	NULL,
-};
-
-static struct attribute_group ipl_fcp_attr_group = {
-	.attrs = ipl_fcp_attrs,
-};
-
-static struct attribute *ipl_ccw_attrs[] = {
-	&ipl_type_attr.attr,
-	&ipl_device_attr.attr,
-	NULL,
-};
-
-static struct attribute_group ipl_ccw_attr_group = {
-	.attrs = ipl_ccw_attrs,
-};
-
-static struct attribute *ipl_unknown_attrs[] = {
-	&ipl_type_attr.attr,
-	NULL,
-};
-
-static struct attribute_group ipl_unknown_attr_group = {
-	.attrs = ipl_unknown_attrs,
-};
-
-static ssize_t
-ipl_parameter_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	unsigned int size = IPL_PARMBLOCK_SIZE;
-
-	if (off > size)
-		return 0;
-	if (off + count > size)
-		count = size - off;
-
-	memcpy(buf, (void *) IPL_PARMBLOCK_START + off, count);
-	return count;
-}
-
-static struct bin_attribute ipl_parameter_attr = {
-	.attr = {
-		.name = "binary_parameter",
-		.mode = S_IRUGO,
-		.owner = THIS_MODULE,
-	},
-	.size = PAGE_SIZE,
-	.read = &ipl_parameter_read,
-};
-
-static ssize_t
-ipl_scp_data_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	unsigned int size =  IPL_PARMBLOCK_START->fcp.scp_data_len;
-	void *scp_data = &IPL_PARMBLOCK_START->fcp.scp_data;
-
-	if (off > size)
-		return 0;
-	if (off + count > size)
-		count = size - off;
-
-	memcpy(buf, scp_data + off, count);
-	return count;
-}
-
-static struct bin_attribute ipl_scp_data_attr = {
-	.attr = {
-		.name = "scp_data",
-		.mode = S_IRUGO,
-		.owner = THIS_MODULE,
-	},
-	.size = PAGE_SIZE,
-	.read = &ipl_scp_data_read,
-};
-
-static decl_subsys(ipl, NULL, NULL);
-
-static int ipl_register_fcp_files(void)
-{
-	int rc;
-
-	rc = sysfs_create_group(&ipl_subsys.kset.kobj,
-				&ipl_fcp_attr_group);
-	if (rc)
-		goto out;
-	rc = sysfs_create_bin_file(&ipl_subsys.kset.kobj,
-				   &ipl_parameter_attr);
-	if (rc)
-		goto out_ipl_parm;
-	rc = sysfs_create_bin_file(&ipl_subsys.kset.kobj,
-				   &ipl_scp_data_attr);
-	if (!rc)
-		goto out;
-
-	sysfs_remove_bin_file(&ipl_subsys.kset.kobj, &ipl_parameter_attr);
-
-out_ipl_parm:
-	sysfs_remove_group(&ipl_subsys.kset.kobj, &ipl_fcp_attr_group);
-out:
-	return rc;
-}
-
-static int __init
-ipl_device_sysfs_register(void) {
-	int rc;
-
-	rc = firmware_register(&ipl_subsys);
-	if (rc)
-		goto out;
-
-	switch (get_ipl_type()) {
-	case ipl_type_ccw:
-		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
-					&ipl_ccw_attr_group);
-		break;
-	case ipl_type_fcp:
-		rc = ipl_register_fcp_files();
-		break;
-	default:
-		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
-					&ipl_unknown_attr_group);
-		break;
-	}
-
-	if (rc)
-		firmware_unregister(&ipl_subsys);
-out:
-	return rc;
-}
-
-__initcall(ipl_device_sysfs_register);
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2006-08-09 10:25:15.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2006-08-09 10:25:54.000000000 +0200
@@ -59,9 +59,6 @@ static struct task_struct *current_set[N
 extern char vmhalt_cmd[];
 extern char vmpoff_cmd[];
 
-extern void reipl(unsigned long devno);
-extern void reipl_diag(void);
-
 static void smp_ext_bitcall(int, ec_bit_sig);
 static void smp_ext_bitcall_others(ec_bit_sig);
 
@@ -279,12 +276,7 @@ static void do_machine_restart(void * __
 	 * interrupted by an external interrupt and s390irq
 	 * locks are always held disabled).
 	 */
-	reipl_diag();
-
-	if (MACHINE_IS_VM)
-		cpcmd ("IPL", NULL, 0, NULL);
-	else
-		reipl (0x10000 | S390_lowcore.ipl_device);
+	do_reipl();
 }
 
 void machine_restart_smp(char * __unused) 
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-08-09 10:25:24.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-08-09 10:25:54.000000000 +0200
@@ -841,14 +841,26 @@ __clear_subchannel_easy(struct subchanne
 	return -EBUSY;
 }
 
-extern void do_reipl(unsigned long devno);
-static int
-__shutdown_subchannel_easy(struct subchannel_id schid, void *data)
+struct sch_match_id {
+	struct subchannel_id schid;
+	struct ccw_dev_id devid;
+	int rc;
+};
+
+static int __shutdown_subchannel_easy_and_match(struct subchannel_id schid,
+	void *data)
 {
 	struct schib schib;
+	struct sch_match_id *match_id = data;
 
 	if (stsch_err(schid, &schib))
 		return -ENXIO;
+	if (match_id && schib.pmcw.dnv &&
+		(schib.pmcw.dev == match_id->devid.devno) &&
+		(schid.ssid == match_id->devid.ssid)) {
+		match_id->schid = schid;
+		match_id->rc = 0;
+	}
 	if (!schib.pmcw.ena)
 		return 0;
 	switch(__disable_subchannel_easy(schid, &schib)) {
@@ -864,18 +876,35 @@ __shutdown_subchannel_easy(struct subcha
 	return 0;
 }
 
-void
-clear_all_subchannels(void)
+static int clear_all_subchannels_and_match(struct ccw_dev_id *devid,
+	struct subchannel_id *schid)
+{
+	struct sch_match_id match_id;
+
+	match_id.devid = *devid;
+	match_id.rc = -ENODEV;
+	local_irq_disable();
+	for_each_subchannel(__shutdown_subchannel_easy_and_match, &match_id);
+	if (match_id.rc == 0)
+		*schid = match_id.schid;
+	return match_id.rc;
+}
+
+
+void clear_all_subchannels(void)
 {
 	local_irq_disable();
-	for_each_subchannel(__shutdown_subchannel_easy, NULL);
+	for_each_subchannel(__shutdown_subchannel_easy_and_match, NULL);
 }
 
+extern void do_reipl_asm(__u32 schid);
+
 /* Make sure all subchannels are quiet before we re-ipl an lpar. */
-void
-reipl(unsigned long devno)
+void reipl_ccw_dev(struct ccw_dev_id *devid)
 {
-	clear_all_subchannels();
-	cio_reset_channel_paths();
-	do_reipl(devno);
+	struct subchannel_id schid;
+
+	if (clear_all_subchannels_and_match(devid, &schid))
+		panic("IPL Device not found\n");
+	do_reipl_asm(*((__u32*)&schid));
 }
diff -urpN linux-2.6/include/asm-s390/cio.h linux-2.6-patched/include/asm-s390/cio.h
--- linux-2.6/include/asm-s390/cio.h	2006-08-09 10:25:30.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/cio.h	2006-08-09 10:25:54.000000000 +0200
@@ -270,6 +270,11 @@ struct diag210 {
 	__u32 vrdccrft : 8;    /* real device feature (output) */
 } __attribute__ ((packed,aligned(4)));
 
+struct ccw_dev_id {
+	u8 ssid;
+	u16 devno;
+};
+
 extern int diag210(struct diag210 *addr);
 
 extern void wait_cons_dev(void);
@@ -280,6 +285,8 @@ extern void cio_reset_channel_paths(void
 
 extern void css_schedule_reprobe(void);
 
+extern void reipl_ccw_dev(struct ccw_dev_id *id);
+
 #endif
 
 #endif
diff -urpN linux-2.6/include/asm-s390/lowcore.h linux-2.6-patched/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	2006-08-09 10:25:30.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/lowcore.h	2006-08-09 10:25:54.000000000 +0200
@@ -47,6 +47,7 @@
 #define __LC_PER_ATMID			0x096
 #define __LC_PER_ADDRESS		0x098
 #define __LC_PER_ACCESS_ID		0x0A1
+#define __LC_AR_MODE_ID			0x0A3
 
 #define __LC_SUBCHANNEL_ID              0x0B8
 #define __LC_SUBCHANNEL_NR              0x0BA
@@ -106,18 +107,28 @@
 #define __LC_INT_CLOCK			0xDE8
 #endif /* __s390x__ */
 
-#define __LC_PANIC_MAGIC                0xE00
 
+#define __LC_PANIC_MAGIC		0xE00
 #ifndef __s390x__
 #define __LC_PFAULT_INTPARM             0x080
 #define __LC_CPU_TIMER_SAVE_AREA        0x0D8
+#define __LC_CLOCK_COMP_SAVE_AREA	0x0E0
+#define __LC_PSW_SAVE_AREA		0x100
+#define __LC_PREFIX_SAVE_AREA		0x108
 #define __LC_AREGS_SAVE_AREA            0x120
+#define __LC_FPREGS_SAVE_AREA		0x160
 #define __LC_GPREGS_SAVE_AREA           0x180
 #define __LC_CREGS_SAVE_AREA            0x1C0
 #else /* __s390x__ */
 #define __LC_PFAULT_INTPARM             0x11B8
+#define __LC_FPREGS_SAVE_AREA		0x1200
 #define __LC_GPREGS_SAVE_AREA           0x1280
+#define __LC_PSW_SAVE_AREA		0x1300
+#define __LC_PREFIX_SAVE_AREA		0x1318
+#define __LC_FP_CREG_SAVE_AREA		0x131C
+#define __LC_TODREG_SAVE_AREA		0x1324
 #define __LC_CPU_TIMER_SAVE_AREA        0x1328
+#define __LC_CLOCK_COMP_SAVE_AREA	0x1331
 #define __LC_AREGS_SAVE_AREA            0x1340
 #define __LC_CREGS_SAVE_AREA            0x1380
 #endif /* __s390x__ */
diff -urpN linux-2.6/include/asm-s390/setup.h linux-2.6-patched/include/asm-s390/setup.h
--- linux-2.6/include/asm-s390/setup.h	2006-08-09 10:25:53.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/setup.h	2006-08-09 10:25:54.000000000 +0200
@@ -68,39 +68,59 @@ extern unsigned int console_irq;
 #define SET_CONSOLE_3215	do { console_mode = 2; } while (0)
 #define SET_CONSOLE_3270	do { console_mode = 3; } while (0)
 
-struct ipl_list_header {
-	u32 length;
-	u8  reserved[3];
+
+struct ipl_list_hdr {
+	u32 len;
+	u8  reserved1[3];
 	u8  version;
+	u32 blk0_len;
+	u8  pbt;
+	u8  flags;
+	u16 reserved2;
 } __attribute__((packed));
 
 struct ipl_block_fcp {
-	u32 length;
-	u8  pbt;
-	u8  reserved1[322-1];
+	u8  reserved1[313-1];
+	u8  opt;
+	u8  reserved2[3];
+	u16 reserved3;
 	u16 devno;
-	u8  reserved2[4];
+	u8  reserved4[4];
 	u64 wwpn;
 	u64 lun;
 	u32 bootprog;
-	u8  reserved3[12];
+	u8  reserved5[12];
 	u64 br_lba;
 	u32 scp_data_len;
-	u8  reserved4[260];
+	u8  reserved6[260];
 	u8  scp_data[];
 } __attribute__((packed));
 
+struct ipl_block_ccw {
+	u8  load_param[8];
+	u8  reserved1[84];
+	u8  reserved2[2];
+	u16 devno;
+	u8  vm_flags;
+	u8  reserved3[3];
+	u32 vm_parm_len;
+} __attribute__((packed));
+
 struct ipl_parameter_block {
+	struct ipl_list_hdr hdr;
 	union {
-		u32 length;
-		struct ipl_list_header header;
-	} hdr;
-	struct ipl_block_fcp fcp;
+		struct ipl_block_fcp fcp;
+		struct ipl_block_ccw ccw;
+	} ipl_info;
 } __attribute__((packed));
 
-#define IPL_MAX_SUPPORTED_VERSION (0)
+#define IPL_PARM_BLK_FCP_LEN (sizeof(struct ipl_list_hdr) + \
+			      sizeof(struct ipl_block_fcp))
 
-#define IPL_TYPE_FCP (0)
+#define IPL_PARM_BLK_CCW_LEN (sizeof(struct ipl_list_hdr) + \
+			      sizeof(struct ipl_block_ccw))
+
+#define IPL_MAX_SUPPORTED_VERSION (0)
 
 /*
  * IPL validity flags and parameters as detected in head.S
@@ -108,12 +128,14 @@ struct ipl_parameter_block {
 extern u32 ipl_parameter_flags;
 extern u16 ipl_devno;
 
+void do_reipl(void);
+
 #define IPL_DEVNO_VALID		(ipl_parameter_flags & 1)
 #define IPL_PARMBLOCK_VALID	(ipl_parameter_flags & 2)
 
 #define IPL_PARMBLOCK_START	((struct ipl_parameter_block *) \
 				 IPL_PARMBLOCK_ORIGIN)
-#define IPL_PARMBLOCK_SIZE	(IPL_PARMBLOCK_START->hdr.length)
+#define IPL_PARMBLOCK_SIZE	(IPL_PARMBLOCK_START->hdr.len)
 
 #else /* __ASSEMBLY__ */
 
