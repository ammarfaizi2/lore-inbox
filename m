Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270052AbUJHR4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270052AbUJHR4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270051AbUJHRzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:55:11 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:18354 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S270055AbUJHRkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:40:23 -0400
Date: Fri, 8 Oct 2004 19:40:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (9/12): z/VM watchdog timer.
Message-ID: <20041008174013.GA7705@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: z/VM watchdog timer.

From: Arnd Bergmann <arndb@de.ibm.com>

Add support for z/VM watchdog timer.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig            |    5 
 drivers/char/watchdog/Kconfig  |   14 +
 drivers/s390/Kconfig           |    2 
 drivers/s390/char/Makefile     |    2 
 drivers/s390/char/vmwatchdog.c |  296 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 319 insertions(+)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2004-10-08 19:19:10.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2004-10-08 19:19:16.000000000 +0200
@@ -192,6 +192,11 @@
 CONFIG_UNIX98_PTY_COUNT=2048
 
 #
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+
+#
 # S/390 character device drivers
 #
 CONFIG_TN3270=y
diff -urN linux-2.6/drivers/char/watchdog/Kconfig linux-2.6-patched/drivers/char/watchdog/Kconfig
--- linux-2.6/drivers/char/watchdog/Kconfig	2004-10-08 19:18:58.000000000 +0200
+++ linux-2.6-patched/drivers/char/watchdog/Kconfig	2004-10-08 19:19:16.000000000 +0200
@@ -336,6 +336,20 @@
 	  timer expired and no process has written to /dev/watchdog during
 	  that time.
 
+# S390 Architecture
+
+config ZVM_WATCHDOG
+	tristate "z/VM Watchdog Timer"
+	depends on WATCHDOG && ARCH_S390
+	help
+	  IBM s/390 and zSeries machines running under z/VM 5.1 or later
+	  provide a virtual watchdog timer to their guest that cause a
+	  user define Control Program command to be executed after a
+	  timeout.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called vmwatchdog.
+
 # SUPERH Architecture
 
 config SH_WDT
diff -urN linux-2.6/drivers/s390/char/Makefile linux-2.6-patched/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	2004-08-14 12:55:31.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/Makefile	2004-10-08 19:19:16.000000000 +0200
@@ -17,6 +17,8 @@
 obj-$(CONFIG_SCLP_VT220_TTY) += sclp_vt220.o
 obj-$(CONFIG_SCLP_CPI) += sclp_cpi.o
 
+obj-$(CONFIG_ZVM_WATCHDOG) += vmwatchdog.o
+
 tape-$(CONFIG_S390_TAPE_BLOCK) += tape_block.o
 tape-$(CONFIG_PROC_FS) += tape_proc.o
 tape-objs := tape_core.o tape_std.o tape_char.o $(tape-y)
diff -urN linux-2.6/drivers/s390/char/vmwatchdog.c linux-2.6-patched/drivers/s390/char/vmwatchdog.c
--- linux-2.6/drivers/s390/char/vmwatchdog.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/vmwatchdog.c	2004-10-08 19:19:16.000000000 +0200
@@ -0,0 +1,296 @@
+/*
+ * Watchdog implementation based on z/VM Watchdog Timer API
+ *
+ * The user space watchdog daemon can use this driver as
+ * /dev/vmwatchdog to have z/VM execute the specified CP
+ * command when the timeout expires. The default command is
+ * "IPL", which which cause an immediate reboot.
+ */
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/watchdog.h>
+
+#include <asm/ebcdic.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#define MAX_CMDLEN 240
+#define MIN_INTERVAL 15
+static char vmwdt_cmd[MAX_CMDLEN] = "IPL";
+static int vmwdt_conceal;
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int vmwdt_nowayout = 1;
+#else
+static int vmwdt_nowayout = 0;
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Arnd Bergmann <arndb@de.ibm.com>");
+MODULE_DESCRIPTION("z/VM Watchdog Timer");
+module_param_string(cmd, vmwdt_cmd, MAX_CMDLEN, 0644);
+MODULE_PARM_DESC(cmd, "CP command that is run when the watchdog triggers");
+module_param_named(conceal, vmwdt_conceal, bool, 0644);
+MODULE_PARM_DESC(conceal, "Enable the CONCEAL CP option while the watchdog "
+		" is active");
+module_param_named(nowayout, vmwdt_nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started"
+		" (default=CONFIG_WATCHDOG_NOWAYOUT)");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+
+static unsigned int vmwdt_interval = 60;
+static unsigned long vmwdt_is_open;
+static int vmwdt_expect_close;
+
+enum vmwdt_func {
+	/* function codes */
+	wdt_init   = 0,
+	wdt_change = 1,
+	wdt_cancel = 2,
+	/* flags */
+	wdt_conceal = 0x80000000,
+};
+
+static int __diag288(enum vmwdt_func func, unsigned int timeout,
+			    char *cmd, size_t len)
+{
+	register unsigned long __func asm("2");
+	register unsigned long __timeout asm("3");
+	register unsigned long __cmdp asm("4");
+	register unsigned long __cmdl asm("5");
+	int err;
+
+	__func = func;
+	__timeout = timeout;
+	__cmdp = virt_to_phys(cmd);
+	__cmdl = len;
+	err = 0;
+	asm volatile (
+#ifdef __s390x__
+		       "diag %2,%4,0x288\n"
+		"1:	\n"
+		".section .fixup,\"ax\"\n"
+		"2:	lghi %0,%1\n"
+		"	jg 1b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 8\n"
+		"	.quad 1b,2b\n"
+		".previous\n"
+#else
+		       "diag %2,%4,0x288\n"
+		"1:	\n"
+		".section .fixup,\"ax\"\n"
+		"2:	lhi %0,%1\n"
+		"	bras 1,3f\n"
+		"	.long 1b\n"
+		"3:	l 1,0(1)\n"
+		"	br 1\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 1b,2b\n"
+		".previous\n"
+#endif
+		: "+&d"(err)
+		: "i"(-EINVAL), "d"(__func), "d"(__timeout),
+		  "d"(__cmdp), "d"(__cmdl)
+		: "1", "cc");
+	return err;
+}
+
+static int vmwdt_keepalive(void)
+{
+	/* we allocate new memory every time to avoid having
+	 * to track the state. static allocation is not an
+	 * option since that might not be contiguous in real
+	 * storage in case of a modular build */
+	static char *ebc_cmd;
+	size_t len;
+	int ret;
+	unsigned int func;
+
+	ebc_cmd = kmalloc(MAX_CMDLEN, GFP_KERNEL);
+	if (!ebc_cmd)
+		return -ENOMEM;
+
+	len = strlcpy(ebc_cmd, vmwdt_cmd, MAX_CMDLEN);
+	ASCEBC(ebc_cmd, MAX_CMDLEN);
+	EBC_TOUPPER(ebc_cmd, MAX_CMDLEN);
+
+	func = vmwdt_conceal ? (wdt_init | wdt_conceal) : wdt_init;
+	ret = __diag288(func, vmwdt_interval, ebc_cmd, len);
+	kfree(ebc_cmd);
+
+	if (ret) {
+		printk(KERN_WARNING "%s: problem setting interval %d, "
+			"cmd %s\n", __FUNCTION__, vmwdt_interval,
+			vmwdt_cmd);
+	}
+	return ret;
+}
+
+static int vmwdt_disable(void)
+{
+	int ret = __diag288(wdt_cancel, 0, "", 0);
+	if (ret) {
+		printk(KERN_WARNING "%s: problem disabling watchdog\n",
+			__FUNCTION__);
+	}
+	return ret;
+}
+
+static int __init vmwdt_probe(void)
+{
+	/* there is no real way to see if the watchdog is supported,
+	 * so we try initializing it with a NOP command ("BEGIN")
+	 * that won't cause any harm even if the following disable
+	 * fails for some reason */
+	static char __initdata ebc_begin[] = {
+		194, 197, 199, 201, 213
+	};
+	if (__diag288(wdt_init, 15, ebc_begin, sizeof(ebc_begin)) != 0) {
+		printk(KERN_INFO "z/VM watchdog not available\n");
+		return -EINVAL;
+	}
+	return vmwdt_disable();
+}
+
+static int vmwdt_open(struct inode *i, struct file *f)
+{
+	int ret;
+	if (test_and_set_bit(0, &vmwdt_is_open))
+		return -EBUSY;
+	ret = vmwdt_keepalive();
+	if (ret)
+		clear_bit(0, &vmwdt_is_open);
+	return ret;
+}
+
+static int vmwdt_close(struct inode *i, struct file *f)
+{
+	if (vmwdt_expect_close == 42)
+		vmwdt_disable();
+	vmwdt_expect_close = 0;
+	clear_bit(0, &vmwdt_is_open);
+	return 0;
+}
+
+static struct watchdog_info vmwdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.firmware_version = 0,
+	.identity = "z/VM Watchdog Timer",
+};
+
+static int vmwdt_ioctl(struct inode *i, struct file *f,
+			  unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user((void __user *)arg, &vmwdt_info,
+					sizeof(vmwdt_info)))
+			return -EFAULT;
+		return 0;
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, (int *)arg);
+	case WDIOC_GETTEMP:
+		return -EINVAL;
+	case WDIOC_SETOPTIONS:
+		{
+			int options, ret;
+			if (get_user(options, (int __user *)arg))
+				return -EFAULT;
+			ret = -EINVAL;
+			if (options & WDIOS_DISABLECARD) {
+				ret = vmwdt_disable();
+				if (ret)
+					return ret;
+			}
+			if (options & WDIOS_ENABLECARD) {
+				ret = vmwdt_keepalive();
+			}
+			return ret;
+		}
+	case WDIOC_GETTIMEOUT:
+		return put_user(vmwdt_interval, (int __user *)arg);
+	case WDIOC_SETTIMEOUT:
+		{
+			int interval;
+			if (get_user(interval, (int __user *)arg))
+				return -EFAULT;
+			if (interval < MIN_INTERVAL)
+				return -EINVAL;
+			vmwdt_interval = interval;
+		}
+		return vmwdt_keepalive();
+	case WDIOC_KEEPALIVE:
+		return vmwdt_keepalive();
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t vmwdt_write(struct file *f, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	/* We can't seek */
+	if(ppos != &f->f_pos)
+		return -ESPIPE;
+
+	if(count) {
+		if (!vmwdt_nowayout) {
+			size_t i;
+
+			/* note: just in case someone wrote the magic character
+			 * five months ago... */
+			vmwdt_expect_close = 0;
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf+i))
+					return -EFAULT;
+				if (c == 'V')
+					vmwdt_expect_close = 42;
+			}
+		}
+		/* someone wrote to us, we should restart timer */
+		vmwdt_keepalive();
+	}
+	return count;
+}
+
+static struct file_operations vmwdt_fops = {
+	.open    = &vmwdt_open,
+	.release = &vmwdt_close,
+	.ioctl   = &vmwdt_ioctl,
+	.write   = &vmwdt_write,
+	.owner   = THIS_MODULE,
+};
+
+static struct miscdevice vmwdt_dev = {
+	.minor      = WATCHDOG_MINOR,
+	.name       = "watchdog",
+	.fops       = &vmwdt_fops,
+};
+
+static int __init vmwdt_init(void)
+{
+	int ret;
+
+	ret = vmwdt_probe();
+	if (ret)
+		return ret;
+	return misc_register(&vmwdt_dev);
+}
+module_init(vmwdt_init);
+
+static void __exit vmwdt_exit(void)
+{
+	WARN_ON(misc_deregister(&vmwdt_dev) != 0);
+}
+module_exit(vmwdt_exit);
diff -urN linux-2.6/drivers/s390/Kconfig linux-2.6-patched/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	2004-08-14 12:56:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/Kconfig	2004-10-08 19:19:16.000000000 +0200
@@ -51,6 +51,8 @@
 	  When not in use, each additional set of 256 PTYs occupy
 	  approximately 8 KB of kernel memory on 32-bit architectures.
 
+source "drivers/char/watchdog/Kconfig"
+
 comment "S/390 character device drivers"
 
 config TN3270
