Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281568AbRKZLNA>; Mon, 26 Nov 2001 06:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281564AbRKZLMx>; Mon, 26 Nov 2001 06:12:53 -0500
Received: from full134.sara.unitn.it ([193.205.210.134]:53752 "EHLO
	dizzy.dz.net") by vger.kernel.org with ESMTP id <S280930AbRKZLMm> convert rfc822-to-8bit;
	Mon, 26 Nov 2001 06:12:42 -0500
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200111261111.fAQBBUpG011037@dizzy.dz.net>
Subject: [PATCH] latest version of i8k driver
To: torvalds@transmeta.com
Date: Mon, 26 Nov 2001 12:11:29 +0100 (MET)
CC: linux-kernel@vger.kernel.org, alan@redhat.com, marcelo@conectiva.com.br
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the latest version of the i8k driver. I have changed the i8k_probe
again and now it loads cleanly on most Dell Inspiron and Latitude laptops.
I have also disabled by default the power status since this information is
already available from apm. The patch is against linux-2.4.15.


--- linux-2.4.15.orig/Documentation/Configure.help	Mon Nov 26 11:15:22 2001
+++ linux/Documentation/Configure.help	Sat Nov 24 13:31:04 2001
@@ -17321,23 +17307,24 @@
   Say Y if you intend to run this kernel on a Toshiba portable.
   Say N otherwise.
 
-Dell Inspiron 8000 support
+Dell laptop support
 CONFIG_I8K
   This adds a driver to safely access the System Management Mode
-  of the CPU on the Dell Inspiron 8000. The System Management Mode
-  is used to read cpu temperature and cooling fan status and to
-  control the fans on the I8K portables.
-
-  This driver has been tested only on the Inspiron 8000 but it may
-  also work with other Dell laptops. You can force loading on other
-  models by passing the parameter `force=1' to the module. Use at
-  your own risk.
-
-  For information on utilities to make use of this driver see the
-  I8K Linux utilities web site at:
-  <http://www.debian.org/~dz/i8k/>
+  of the CPU on the Dell Inspiron and Latitude laptops. The System
+  Management Mode is used to read cpu temperature, cooling fan
+  status and Fn-keys status on Dell laptops. It can also be used
+  to switch the fans on and off.
+
+  The driver has been developed and tested on an Inspiron 8000
+  but it should work on any Dell Inspiron or Latitude laptop.
+  You can force loading on unsupported models by passing the
+  parameter `force=1' to the module. Use at your own risk.
+
+  For more information on this driver and for utilities that make
+  use of the module see the I8K Linux Utilities web site at:
+  <http://www.debian.org/~dz/i8k/>.
 
-  Say Y if you intend to run this kernel on a Dell Inspiron 8000.
+  Say Y if you intend to run this kernel on a Dell laptop.
   Say N otherwise.
 
 /dev/cpu/microcode - Intel IA32 CPU microcode support
--- linux-2.4.15.orig/MAINTAINERS	Mon Nov 26 11:15:22 2001
+++ linux/MAINTAINERS	Mon Nov 26 11:29:20 2001
@@ -404,6 +404,12 @@
 L:	linux-decnet-user@lists.sourceforge.net
 S:	Maintained
 
+DELL LAPTOP SMM DRIVER
+P:	Massimo Dal Zotto
+M:	dz@debian.org
+W:	http://www.debian.org/~dz/i8k/
+S:	Maintained
+
 DEVICE NUMBER REGISTRY
 P:	H. Peter Anvin
 M:	hpa@zytor.com
--- linux-2.4.15.orig/arch/i386/config.in	Mon Nov 26 11:15:23 2001
+++ linux/arch/i386/config.in	Sat Nov 24 13:41:12 2001
@@ -149,7 +149,7 @@
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
-tristate 'Dell Inspiron 8000 support' CONFIG_I8K
+tristate 'Dell laptop support' CONFIG_I8K
 
 tristate '/dev/cpu/microcode - Intel IA32 CPU microcode support' CONFIG_MICROCODE
 tristate '/dev/cpu/*/msr - Model-specific register support' CONFIG_X86_MSR
--- linux-2.4.15.orig/drivers/char/i8k.c	Sat Nov  3 02:46:47 2001
+++ linux/drivers/char/i8k.c	Sat Nov 24 11:43:26 2001
@@ -1,5 +1,7 @@
 /*
- * i8k.c -- Linux driver for accessing the SMM BIOS on Dell I8000 laptops
+ * i8k.c -- Linux driver for accessing the SMM BIOS on Dell laptops.
+ *	    See http://www.debian.org/~dz/i8k/ for more information
+ *	    and for latest version of this driver.
  *
  * Copyright (C) 2001  Massimo Dal Zotto <dz@debian.org>
  *
@@ -19,15 +21,13 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <asm/io.h>
+#include <linux/apm_bios.h>
 #include <asm/uaccess.h>
+#include <asm/io.h>
 
 #include <linux/i8k.h>
 
-#define I8K_VERSION		"1.1 02/11/2001"
-#define I8K_BIOS_SIGNATURE	"Dell System Inspiron 8000"
-#define I8K_BIOS_SIGNATURE_ADDR 0x000ec000
-#define I8K_BIOS_VERSION_OFFSET	32
+#define I8K_VERSION		"1.7 21/11/2001"
 
 #define I8K_SMM_FN_STATUS	0x0025
 #define I8K_SMM_POWER_STATUS	0x0069
@@ -35,31 +35,47 @@
 #define I8K_SMM_GET_FAN		0x00a3
 #define I8K_SMM_GET_SPEED	0x02a3
 #define I8K_SMM_GET_TEMP	0x10a3
+#define I8K_SMM_GET_DELL_SIG	0xffa3
 #define I8K_SMM_BIOS_VERSION	0x00a6
 
 #define I8K_FAN_MULT		30
 #define I8K_MAX_TEMP		127
 
-#define I8K_FN_NONE		0x08
-#define I8K_FN_UP		0x09
-#define I8K_FN_DOWN		0x0a
-#define I8K_FN_MUTE		0x0c
+#define I8K_FN_NONE		0x00
+#define I8K_FN_UP		0x01
+#define I8K_FN_DOWN		0x02
+#define I8K_FN_MUTE		0x04
+#define I8K_FN_MASK		0x07
+#define I8K_FN_SHIFT		8
 
 #define I8K_POWER_AC		0x05
 #define I8K_POWER_BATTERY	0x01
 
 #define I8K_TEMPERATURE_BUG	1
 
-static char bios_version[4] = "?";
-static char bios_machine_id[16] = "?";
+#define DELL_SIGNATURE		"Dell Computer"
+
+static char *supported_models[] = {
+    "Inspiron",
+    "Latitude",
+    NULL
+};
+
+static char system_vendor[48] = "?";
+static char product_name [48] = "?";
+static char bios_version [4]  = "?";
+static char serial_number[16] = "?";
 
 int force = 0;
+int power_status = 0;
 
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
-MODULE_DESCRIPTION("Driver for accessing the SMM BIOS on Dell I8000 laptops");
+MODULE_DESCRIPTION("Driver for accessing SMM BIOS on Dell laptops");
 MODULE_LICENSE("GPL");
 MODULE_PARM(force, "i");
-MODULE_PARM_DESC(force, "Force loading without checking for an Inspiron 8000");
+MODULE_PARM(power_status, "i");
+MODULE_PARM_DESC(force, "Force loading without checking for supported models");
+MODULE_PARM_DESC(power_status, "Report power status in /proc/i8k");
 
 static ssize_t i8k_read(struct file *, char *, size_t, loff_t *);
 static int i8k_ioctl(struct inode *, struct file *, unsigned int,
@@ -79,12 +95,19 @@
     unsigned int edi __attribute__ ((packed));
 } SMMRegisters;
 
+typedef struct {
+    u8	type;
+    u8	length;
+    u16	handle;
+} DMIHeader;
+
 /*
- * Call the System Management Mode BIOS.
+ * Call the System Management Mode BIOS. Code provided by Jonathan Buzzard.
  */
 static int i8k_smm(SMMRegisters *regs)
 {
     int rc;
+    int eax = regs->eax;
 
     asm("pushl %%eax\n\t" \
 	"movl 0(%%eax),%%edx\n\t" \
@@ -112,7 +135,7 @@
 	: "a" (regs)
 	: "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
 
-    if ((rc != 0) || ((regs->eax & 0xffff) == 0xffff)) {
+    if ((rc != 0) || ((regs->eax & 0xffff) == 0xffff) || (regs->eax == eax)) {
 	return -EINVAL;
     }
 
@@ -137,11 +160,12 @@
 }
 
 /*
- * Read the machine id. Not yet implemented.
+ * Read the machine id.
  */
-static int i8k_get_machine_id(unsigned char *buff)
+static int i8k_get_serial_number(unsigned char *buff)
 {
-    return -EINVAL;
+    strncpy(buff, serial_number, 16);
+    return 0;
 }
 
 /*
@@ -157,7 +181,7 @@
 	return rc;
     }
 
-    switch ((regs.eax & 0xff00) >> 8) {
+    switch ((regs.eax >> I8K_FN_SHIFT) & I8K_FN_MASK) {
     case I8K_FN_UP:
 	return I8K_VOL_UP;
     case I8K_FN_DOWN:
@@ -281,6 +305,23 @@
     return temp;
 }
 
+static int i8k_get_dell_signature(void)
+{
+    SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+    int rc;
+
+    regs.eax = I8K_SMM_GET_DELL_SIG;
+    if ((rc=i8k_smm(&regs)) < 0) {
+	return rc;
+    }
+
+    if ((regs.eax == 1145651527) && (regs.edx == 1145392204)) {
+	return 0;
+    } else {
+	return -1;
+    }
+}
+
 static int i8k_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
 		     unsigned long arg)
 {
@@ -299,7 +340,7 @@
 
     case I8K_MACHINE_ID:
 	memset(buff, 0, 16);
-	val = i8k_get_machine_id(buff);
+	val = i8k_get_serial_number(buff);
 	break;
 
     case I8K_FN_STATUS:
@@ -375,13 +416,17 @@
     int n, fn_key, cpu_temp, ac_power;
     int left_fan, right_fan, left_speed, right_speed;
 
-    cpu_temp    = i8k_get_cpu_temp();
-    left_fan    = i8k_get_fan_status(I8K_FAN_LEFT);
-    right_fan   = i8k_get_fan_status(I8K_FAN_RIGHT);
-    left_speed  = i8k_get_fan_speed(I8K_FAN_LEFT);
-    right_speed = i8k_get_fan_speed(I8K_FAN_RIGHT);
-    ac_power    = i8k_get_power_status();
-    fn_key      = i8k_get_fn_status();
+    cpu_temp     = i8k_get_cpu_temp();			/* 11100 탎 */
+    left_fan     = i8k_get_fan_status(I8K_FAN_LEFT);	/*   580 탎 */
+    right_fan    = i8k_get_fan_status(I8K_FAN_RIGHT);	/*   580 탎 */
+    left_speed   = i8k_get_fan_speed(I8K_FAN_LEFT);	/*   580 탎 */
+    right_speed  = i8k_get_fan_speed(I8K_FAN_RIGHT);	/*   580 탎 */
+    fn_key       = i8k_get_fn_status();			/*   750 탎 */
+    if (power_status) {
+	ac_power = i8k_get_power_status();		/* 14700 탎 */
+    } else {
+	ac_power = -1;
+    }
 
     /*
      * Info:
@@ -400,7 +445,7 @@
     n = sprintf(buffer, "%s %s %s %d %d %d %d %d %d %d\n",
 		I8K_PROC_FMT,
 		bios_version,
-		bios_machine_id,
+		serial_number,
 		cpu_temp,
 		left_fan,
 		right_fan,
@@ -438,76 +483,253 @@
     return len;
 }
 
+static char* __init string_trim(char *s, int size)
+{
+    int len;
+    char *p;
+
+    if ((len = strlen(s)) > size) {
+	len = size;
+    }
+
+    for (p=s+len-1; len && (*p==' '); len--,p--) {
+	*p = '\0';
+    }
+
+    return s;
+}
+
+/* DMI code, stolen from arch/i386/kernel/dmi_scan.c */
+
 /*
- * Probe for the presence of an Inspiron I8000.
+ * |<-- dmi->length -->|
+ * |                   |
+ * |dmi header    s=N  | string1,\0, ..., stringN,\0, ..., \0
+ *                |                       |
+ *                +-----------------------+
  */
-static int i8k_probe(void)
+static char* __init dmi_string(DMIHeader *dmi, u8 s)
 {
-    unsigned char *buff, *p;
-    unsigned char bios_vers[4];
-    int version;
+    u8 *p;
+
+    if (!s) {
+	return "";
+    }
+    s--;
+
+    p = (u8 *)dmi + dmi->length;
+    while (s > 0) {
+	p += strlen(p);
+	p++;
+	s--;
+    }
+
+    return p;
+}
+
+static void __init dmi_decode(DMIHeader *dmi)
+{
+    u8 *data = (u8 *) dmi;
+    char *p;
+
+#ifdef I8K_DEBUG
+    int i;
+    printk("%08x ", (int)data);
+    for (i=0; i<data[1] && i<64; i++) {
+	printk("%02x ", data[i]);
+    }
+    printk("\n");
+#endif
+
+    switch (dmi->type) {
+    case  0:	/* BIOS Information */
+	p = dmi_string(dmi,data[5]);
+	if (*p) {
+	    strncpy(bios_version, p, sizeof(bios_version));
+	    string_trim(bios_version, sizeof(bios_version));
+	}
+	break;	
+    case 1:	/* System Information */
+	p = dmi_string(dmi,data[4]);
+	if (*p) {
+	    strncpy(system_vendor, p, sizeof(system_vendor));
+	    string_trim(system_vendor, sizeof(system_vendor));
+	}
+	p = dmi_string(dmi,data[5]);
+	if (*p) {
+	    strncpy(product_name, p, sizeof(product_name));
+	    string_trim(product_name, sizeof(product_name));
+	}
+	p = dmi_string(dmi,data[7]);
+	if (*p) {
+	    strncpy(serial_number, p, sizeof(serial_number));
+	    string_trim(serial_number, sizeof(serial_number));
+	}
+	break;
+    }
+}
+
+static int __init dmi_table(u32 base, int len, int num, void (*fn)(DMIHeader*))
+{
+    u8 *buf;
+    u8 *data;
+    DMIHeader *dmi;
+    int i = 1;
+
+    buf = ioremap(base, len);
+    if (buf == NULL) {
+	return -1;
+    }
+    data = buf;
 
     /*
-     * Until Dell tell us how to reliably check for an Inspiron system
-     * look for a signature at a fixed location in the BIOS memory.
-     * Ugly but safe.
+     * Stop when we see al the items the table claimed to have
+     * or we run off the end of the table (also happens)
      */
-    if (!force) {
-	buff = ioremap(I8K_BIOS_SIGNATURE_ADDR, I8K_BIOS_VERSION_OFFSET+4);
-	if (buff == NULL) {
-	    printk("i8k: ioremap failed\n");
-	    return -ENODEV;
+    while ((i<num) && ((data-buf) < len)) {
+	dmi = (DMIHeader *)data;
+	/*
+	 * Avoid misparsing crud if the length of the last
+	 * record is crap
+	 */
+	if ((data-buf+dmi->length) >= len) {
+	    break;
+	}
+	fn(dmi);
+	data += dmi->length;
+	/*
+	 * Don't go off the end of the data if there is
+	 * stuff looking like string fill past the end
+	 */
+	while (((data-buf) < len) && (*data || data[1])) {
+	    data++;
 	}
-	if (strncmp(buff,I8K_BIOS_SIGNATURE,sizeof(I8K_BIOS_SIGNATURE)) != 0) {
-	    printk("i8k: Inspiron 8000 BIOS signature not found\n");
-	    iounmap(buff);
-	    return -ENODEV;
+	data += 2;
+	i++;
+    }
+    iounmap(buf);
+
+    return 0;
+}
+
+static int __init dmi_iterate(void (*decode)(DMIHeader *))
+{
+    unsigned char buf[20];
+    long fp = 0x000e0000L;
+    fp -= 16;
+
+    while (fp < 0x000fffffL) {
+	fp += 16;
+	isa_memcpy_fromio(buf, fp, 20);
+	if (memcmp(buf, "_DMI_", 5)==0) {
+	    u16 num  = buf[13]<<8  | buf[12];
+	    u16 len  = buf [7]<<8  | buf [6];
+	    u32 base = buf[11]<<24 | buf[10]<<16 | buf[9]<<8 | buf[8];
+#ifdef I8K_DEBUG
+	    printk(KERN_INFO "DMI %d.%d present.\n",
+		   buf[14]>>4, buf[14]&0x0F);
+	    printk(KERN_INFO "%d structures occupying %d bytes.\n",
+		   buf[13]<<8 | buf[12],
+		   buf [7]<<8 | buf[6]);
+	    printk(KERN_INFO "DMI table at 0x%08X.\n",
+		   buf[11]<<24 | buf[10]<<16 | buf[9]<<8 | buf[8]);
+#endif
+	    if (dmi_table(base, len, num, decode)==0) {
+		return 0;
+	    }
 	}
-	strncpy(bios_vers, buff+I8K_BIOS_VERSION_OFFSET, 3);
-	bios_vers[3] = '\0';
-	iounmap(buff);
-    }
-    if (force >= 2) {
-	buff = ioremap(0x000c0000, 0x00100000-0x000c0000);
-	if (buff == NULL) {
-	    printk("i8k: ioremap failed\n");
+    }
+    return -1;
+}
+/* end of DMI code */
+
+/*
+ * Get DMI information.
+ */
+static int __init i8k_dmi_probe(void)
+{
+    char **p;
+
+    if (dmi_iterate(dmi_decode) != 0) {
+	printk(KERN_INFO "i8k: unable to get DMI information\n");
+	return -ENODEV;
+    }
+
+    if (strncmp(system_vendor,DELL_SIGNATURE,strlen(DELL_SIGNATURE)) != 0) {
+	printk(KERN_INFO "i8k: not running on a Dell system\n");
+	return -ENODEV;
+    }
+
+    for (p=supported_models; ; p++) {
+	if (!*p) {
+	    printk(KERN_INFO "i8k: unsupported model: %s\n", product_name);
 	    return -ENODEV;
 	}
-	for (p=buff; (p-buff)<(0x00100000-0x000c0000); p+=16) {
-	    if (strncmp(p,I8K_BIOS_SIGNATURE,sizeof(I8K_BIOS_SIGNATURE))==0) {
-		printk("i8k: Inspiron 8000 BIOS signature found at %08x\n",
-		       0x000c0000+(p-buff));
-		break;
-	    }
+	if (strncmp(product_name,*p,strlen(*p)) == 0) {
+	    break;
 	}
-	iounmap(buff);
     }
 
+    return 0;
+}
+
+/*
+ * Probe for the presence of a supported laptop.
+ */
+static int __init i8k_probe(void)
+{
+    char buff[4];
+    int version;
+    int smm_found = 0;
+
     /*
-     * Next try to get the BIOS version with an SMM call. If this
-     * fails SMM can't be reliably used on this system.
+     * Get DMI information
      */
-    version = i8k_get_bios_version();
-    if (version <= 0) {
-	printk("i8k: unable to get BIOS version\n");
-	return -ENODEV;
+    if (i8k_dmi_probe() != 0) {
+	printk(KERN_INFO "i8k: vendor=%s, model=%s, version=%s\n",
+	       system_vendor, product_name, bios_version);
     }
-    bios_version[0] = (version >> 16) & 0xff;
-    bios_version[1] = (version >>  8) & 0xff;
-    bios_version[2] = (version)       & 0xff;
-    bios_version[3] = '\0';
 
     /*
-     * Finally check if the two versions match.
+     * Get SMM Dell signature
      */
-    if (!force) {
-	if (strncmp(bios_version,bios_vers,sizeof(bios_version)) != 0) {
-	    printk("i8k: BIOS version mismatch: %s != %s\n",
-		   bios_version, bios_vers);
-	    return -ENODEV;
+    if (i8k_get_dell_signature() != 0) {
+	printk(KERN_INFO "i8k: unable to get SMM Dell signature\n");
+    } else {
+	smm_found = 1;
+    }
+
+    /*
+     * Get SMM BIOS version.
+     */
+    version = i8k_get_bios_version();
+    if (version <= 0) {
+	printk(KERN_INFO "i8k: unable to get SMM BIOS version\n");
+    } else {
+	smm_found = 1;
+	buff[0] = (version >> 16) & 0xff;
+	buff[1] = (version >>  8) & 0xff;
+	buff[2] = (version)       & 0xff;
+	buff[3] = '\0';
+	/*
+	 * If DMI BIOS version is unknown use SMM BIOS version.
+	 */
+	if (bios_version[0] == '?') {
+	    strcpy(bios_version, buff);
+	}
+	/*
+	 * Check if the two versions match.
+	 */
+	if (strncmp(buff,bios_version,sizeof(bios_version)) != 0) {
+	    printk(KERN_INFO "i8k: BIOS version mismatch: %s != %s\n",
+		   buff, bios_version);
 	}
     }
 
+    if (!smm_found && !force) {
+	return -ENODEV;
+    }
+
     return 0;
 }
 
@@ -518,7 +740,7 @@
 {
     struct proc_dir_entry *proc_i8k;
 
-    /* Are we running on an Inspiron 8000 laptop? */
+    /* Are we running on an supported laptop? */
     if (i8k_probe() != 0) {
 	return -ENODEV;
     }
@@ -532,7 +754,7 @@
     SET_MODULE_OWNER(proc_i8k);
 
     printk(KERN_INFO
-	   "Inspiron 8000 SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
+	   "Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
 	   I8K_VERSION);
 
     return 0;
--- linux-2.4.15.orig/include/linux/i8k.h	Sat Nov  3 02:46:47 2001
+++ linux/include/linux/i8k.h	Sat Nov 24 11:43:26 2001
@@ -1,5 +1,5 @@
 /*
- * i8k.h -- Linux driver for accessing the SMM BIOS on Dell I8000 laptops
+ * i8k.h -- Linux driver for accessing the SMM BIOS on Dell laptops
  *
  * Copyright (C) 2001  Massimo Dal Zotto <dz@debian.org>
  *
@@ -36,9 +36,9 @@
 #define I8K_FAN_HIGH		2
 #define I8K_FAN_MAX		I8K_FAN_HIGH
 
-#define I8K_VOL_UP		0x01
-#define I8K_VOL_DOWN		0x02
-#define I8K_VOL_MUTE		0x03
+#define I8K_VOL_UP		1
+#define I8K_VOL_DOWN		2
+#define I8K_VOL_MUTE		4
 
 #define I8K_AC			1
 #define I8K_BATTERY		0


-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: dz@debian.org                |
|  Via Marconi, 141                phone: ++39-461534251               |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                                  http://www.debian.org/~dz/   |
|  gpg:   2DB65596  3CED BDC6 4F23 BEDA F489 2445 147F 1AEA 2DB6 5596  |
+----------------------------------------------------------------------+
