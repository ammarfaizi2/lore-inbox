Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVD0HCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVD0HCg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 03:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVD0HCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 03:02:36 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:51327 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261726AbVD0Gzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:55:39 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/6] I8K: use standard DMI interface
Date: Wed, 27 Apr 2005 01:52:52 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504270149.13450.dtor_core@ameritech.net>
In-Reply-To: <200504270149.13450.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504270152.52690.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I8K: Change to use stock dmi infrastructure instead of homegrown
     parsing code. The driver now requires box's DMI data to match
     list of supported models so driver can be safely compiled-in
     by default without fear of it poking into random SMM BIOS
     code. DMI checks can be ignored with i8k.ignore_dmi option.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 Documentation/kernel-parameters.txt |    3 
 arch/i386/kernel/dmi_scan.c         |    1 
 drivers/char/i8k.c                  |  302 ++++++------------------------------
 include/linux/dmi.h                 |    1 
 4 files changed, 58 insertions(+), 249 deletions(-)

Index: dtor/arch/i386/kernel/dmi_scan.c
===================================================================
--- dtor.orig/arch/i386/kernel/dmi_scan.c
+++ dtor/arch/i386/kernel/dmi_scan.c
@@ -414,6 +414,7 @@ static void __init dmi_decode(struct dmi
 			dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
 			dmi_printk(("Serial Number: %s\n",
 				dmi_string(dm, data[7])));
+			dmi_save_ident(dm, DMI_PRODUCT_SERIAL, 7);
 			break;
 		case 2:
 			dmi_printk(("Board Vendor: %s\n",
Index: dtor/include/linux/dmi.h
===================================================================
--- dtor.orig/include/linux/dmi.h
+++ dtor/include/linux/dmi.h
@@ -9,6 +9,7 @@ enum dmi_field {
 	DMI_SYS_VENDOR,
 	DMI_PRODUCT_NAME,
 	DMI_PRODUCT_VERSION,
+	DMI_PRODUCT_SERIAL,
 	DMI_BOARD_VENDOR,
 	DMI_BOARD_NAME,
 	DMI_BOARD_VERSION,
Index: dtor/drivers/char/i8k.c
===================================================================
--- dtor.orig/drivers/char/i8k.c
+++ dtor/drivers/char/i8k.c
@@ -20,7 +20,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <linux/apm_bios.h>
+#include <linux/dmi.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -52,18 +52,7 @@
 
 #define I8K_TEMPERATURE_BUG	1
 
-#define DELL_SIGNATURE		"Dell Computer"
-
-static char *supported_models[] = {
-	"Inspiron",
-	"Latitude",
-	NULL
-};
-
-static char system_vendor[48] = "?";
-static char product_name[48] = "?";
-static char bios_version[4] = "?";
-static char serial_number[16] = "?";
+static char bios_version[4];
 
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
 MODULE_DESCRIPTION("Driver for accessing SMM BIOS on Dell laptops");
@@ -73,6 +62,10 @@ static int force;
 module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Force loading without checking for supported models");
 
+static int ignore_dmi;
+module_param(ignore_dmi, bool, 0);
+MODULE_PARM_DESC(ignore_dmi, "Continue probing hardware even if DMI data does not match");
+
 static int restricted;
 module_param(restricted, bool, 0);
 MODULE_PARM_DESC(restricted, "Allow fan control if SYS_ADMIN capability set");
@@ -99,11 +92,10 @@ typedef struct {
 	unsigned int edi __attribute__ ((packed));
 } SMMRegisters;
 
-typedef struct {
-	u8 type;
-	u8 length;
-	u16 handle;
-} DMIHeader;
+static inline char *i8k_get_dmi_data(int field)
+{
+	return dmi_get_system_info(field) ? : "N/A";
+}
 
 /*
  * Call the System Management Mode BIOS. Code provided by Jonathan Buzzard.
@@ -163,15 +155,6 @@ static int i8k_get_bios_version(void)
 }
 
 /*
- * Read the machine id.
- */
-static int i8k_get_serial_number(unsigned char *buff)
-{
-	strlcpy(buff, serial_number, sizeof(serial_number));
-	return 0;
-}
-
-/*
  * Read the Fn key status.
  */
 static int i8k_get_fn_status(void)
@@ -328,7 +311,7 @@ static int i8k_get_dell_signature(void)
 static int i8k_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
 		     unsigned long arg)
 {
-	int val;
+	int val = 0;
 	int speed;
 	unsigned char buff[16];
 	int __user *argp = (int __user *)arg;
@@ -343,7 +326,7 @@ static int i8k_ioctl(struct inode *ip, s
 
 	case I8K_MACHINE_ID:
 		memset(buff, 0, 16);
-		val = i8k_get_serial_number(buff);
+		strlcpy(buff, i8k_get_dmi_data(DMI_PRODUCT_SERIAL), sizeof(buff));
 		break;
 
 	case I8K_FN_STATUS:
@@ -451,10 +434,10 @@ static int i8k_get_info(char *buffer, ch
 	n = sprintf(buffer, "%s %s %s %d %d %d %d %d %d %d\n",
 		    I8K_PROC_FMT,
 		    bios_version,
-		    serial_number,
+		    dmi_get_system_info(DMI_PRODUCT_SERIAL) ? : "N/A",
 		    cpu_temp,
-		    left_fan,
-		    right_fan, left_speed, right_speed, ac_power, fn_key);
+		    left_fan, right_fan, left_speed, right_speed,
+		    ac_power, fn_key);
 
 	return n;
 }
@@ -486,201 +469,23 @@ static ssize_t i8k_read(struct file *f, 
 	return len;
 }
 
-static char *__init string_trim(char *s, int size)
-{
-	int len;
-	char *p;
-
-	if ((len = strlen(s)) > size) {
-		len = size;
-	}
-
-	for (p = s + len - 1; len && (*p == ' '); len--, p--) {
-		*p = '\0';
-	}
-
-	return s;
-}
-
-/* DMI code, stolen from arch/i386/kernel/dmi_scan.c */
-
-/*
- * |<-- dmi->length -->|
- * |                   |
- * |dmi header    s=N  | string1,\0, ..., stringN,\0, ..., \0
- *                |                       |
- *                +-----------------------+
- */
-static char *__init dmi_string(DMIHeader * dmi, u8 s)
-{
-	u8 *p;
-
-	if (!s) {
-		return "";
-	}
-	s--;
-
-	p = (u8 *) dmi + dmi->length;
-	while (s > 0) {
-		p += strlen(p);
-		p++;
-		s--;
-	}
-
-	return p;
-}
-
-static void __init dmi_decode(DMIHeader * dmi)
-{
-	u8 *data = (u8 *) dmi;
-	char *p;
-
-#ifdef I8K_DEBUG
-	int i;
-	printk("%08x ", (int)data);
-	for (i = 0; i < data[1] && i < 64; i++) {
-		printk("%02x ", data[i]);
-	}
-	printk("\n");
-#endif
-
-	switch (dmi->type) {
-	case 0:		/* BIOS Information */
-		p = dmi_string(dmi, data[5]);
-		if (*p) {
-			strlcpy(bios_version, p, sizeof(bios_version));
-			string_trim(bios_version, sizeof(bios_version));
-		}
-		break;
-	case 1:		/* System Information */
-		p = dmi_string(dmi, data[4]);
-		if (*p) {
-			strlcpy(system_vendor, p, sizeof(system_vendor));
-			string_trim(system_vendor, sizeof(system_vendor));
-		}
-		p = dmi_string(dmi, data[5]);
-		if (*p) {
-			strlcpy(product_name, p, sizeof(product_name));
-			string_trim(product_name, sizeof(product_name));
-		}
-		p = dmi_string(dmi, data[7]);
-		if (*p) {
-			strlcpy(serial_number, p, sizeof(serial_number));
-			string_trim(serial_number, sizeof(serial_number));
-		}
-		break;
-	}
-}
-
-static int __init dmi_table(u32 base, int len, int num,
-			    void (*fn) (DMIHeader *))
-{
-	u8 *buf;
-	u8 *data;
-	DMIHeader *dmi;
-	int i = 1;
-
-	buf = ioremap(base, len);
-	if (buf == NULL) {
-		return -1;
-	}
-	data = buf;
-
-	/*
-	 * Stop when we see al the items the table claimed to have
-	 * or we run off the end of the table (also happens)
-	 */
-	while ((i < num) && ((data - buf) < len)) {
-		dmi = (DMIHeader *) data;
-		/*
-		 * Avoid misparsing crud if the length of the last
-		 * record is crap
-		 */
-		if ((data - buf + dmi->length) >= len) {
-			break;
-		}
-		fn(dmi);
-		data += dmi->length;
-		/*
-		 * Don't go off the end of the data if there is
-		 * stuff looking like string fill past the end
-		 */
-		while (((data - buf) < len) && (*data || data[1])) {
-			data++;
-		}
-		data += 2;
-		i++;
-	}
-	iounmap(buf);
-
-	return 0;
-}
-
-static int __init dmi_iterate(void (*decode) (DMIHeader *))
-{
-	unsigned char buf[20];
-	void __iomem *p = ioremap(0xe0000, 0x20000), *q;
-
-	if (!p)
-		return -1;
-
-	for (q = p; q < p + 0x20000; q += 16) {
-		memcpy_fromio(buf, q, 20);
-		if (memcmp(buf, "_DMI_", 5) == 0) {
-			u16 num  = buf[13] << 8 | buf[12];
-			u16 len  = buf[7] << 8 | buf[6];
-			u32 base = buf[11] << 24 | buf[10] << 16 | buf[9] << 8 | buf[8];
-#ifdef I8K_DEBUG
-			printk(KERN_INFO "DMI %d.%d present.\n",
-			       buf[14] >> 4, buf[14] & 0x0F);
-			printk(KERN_INFO "%d structures occupying %d bytes.\n",
-			       buf[13] << 8 | buf[12], buf[7] << 8 | buf[6]);
-			printk(KERN_INFO "DMI table at 0x%08X.\n",
-			       buf[11] << 24 | buf[10] << 16 | buf[9] << 8 |
-			       buf[8]);
-#endif
-			if (dmi_table(base, len, num, decode) == 0) {
-				iounmap(p);
-				return 0;
-			}
-		}
-	}
-	iounmap(p);
-	return -1;
-}
-
-/* end of DMI code */
-
-/*
- * Get DMI information.
- */
-static int __init i8k_dmi_probe(void)
-{
-	char **p;
-
-	if (dmi_iterate(dmi_decode) != 0) {
-		printk(KERN_INFO "i8k: unable to get DMI information\n");
-		return -ENODEV;
-	}
-
-	if (strncmp(system_vendor, DELL_SIGNATURE, strlen(DELL_SIGNATURE)) != 0) {
-		printk(KERN_INFO "i8k: not running on a Dell system\n");
-		return -ENODEV;
-	}
-
-	for (p = supported_models;; p++) {
-		if (!*p) {
-			printk(KERN_INFO "i8k: unsupported model: %s\n",
-			       product_name);
-			return -ENODEV;
-		}
-		if (strncmp(product_name, *p, strlen(*p)) == 0) {
-			break;
-		}
-	}
-
-	return 0;
-}
+static struct dmi_system_id __initdata i8k_dmi_table[] = {
+	{
+		.ident = "Dell Inspiron",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
+		},
+	},
+	{
+		.ident = "Dell Latitude",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude"),
+		},
+	},
+	{ }
+};
 
 /*
  * Probe for the presence of a supported laptop.
@@ -689,23 +494,30 @@ static int __init i8k_probe(void)
 {
 	char buff[4];
 	int version;
-	int smm_found = 0;
 
 	/*
 	 * Get DMI information
 	 */
-	if (i8k_dmi_probe() != 0) {
+	if (!dmi_check_system(i8k_dmi_table)) {
+		if (!ignore_dmi && !force)
+			return -ENODEV;
+
+		printk(KERN_INFO "i8k: not running on a supported Dell system.\n");
 		printk(KERN_INFO "i8k: vendor=%s, model=%s, version=%s\n",
-		       system_vendor, product_name, bios_version);
+			i8k_get_dmi_data(DMI_SYS_VENDOR),
+			i8k_get_dmi_data(DMI_PRODUCT_NAME),
+			i8k_get_dmi_data(DMI_BIOS_VERSION));
 	}
 
+	strlcpy(bios_version, i8k_get_dmi_data(DMI_BIOS_VERSION), sizeof(bios_version));
+
 	/*
 	 * Get SMM Dell signature
 	 */
 	if (i8k_get_dell_signature() != 0) {
-		printk(KERN_INFO "i8k: unable to get SMM Dell signature\n");
-	} else {
-		smm_found = 1;
+		printk(KERN_ERR "i8k: unable to get SMM Dell signature\n");
+		if (!force)
+			return -ENODEV;
 	}
 
 	/*
@@ -713,9 +525,8 @@ static int __init i8k_probe(void)
 	 */
 	version = i8k_get_bios_version();
 	if (version <= 0) {
-		printk(KERN_INFO "i8k: unable to get SMM BIOS version\n");
+		printk(KERN_WARNING "i8k: unable to get SMM BIOS version\n");
 	} else {
-		smm_found = 1;
 		buff[0] = (version >> 16) & 0xff;
 		buff[1] = (version >> 8) & 0xff;
 		buff[2] = (version) & 0xff;
@@ -723,21 +534,15 @@ static int __init i8k_probe(void)
 		/*
 		 * If DMI BIOS version is unknown use SMM BIOS version.
 		 */
-		if (bios_version[0] == '?') {
-			strcpy(bios_version, buff);
-		}
+		if (!dmi_get_system_info(DMI_BIOS_VERSION))
+			strlcpy(bios_version, buff, sizeof(bios_version));
+
 		/*
 		 * Check if the two versions match.
 		 */
-		if (strncmp(buff, bios_version, sizeof(bios_version)) != 0) {
-			printk(KERN_INFO
-			       "i8k: BIOS version mismatch: %s != %s\n", buff,
-			       bios_version);
-		}
-	}
-
-	if (!smm_found && !force) {
-		return -ENODEV;
+		if (strncmp(buff, bios_version, sizeof(bios_version)) != 0)
+			printk(KERN_WARNING "i8k: BIOS version mismatch: %s != %s\n",
+				buff, bios_version);
 	}
 
 	return 0;
@@ -751,9 +556,8 @@ int __init i8k_init(void)
 	struct proc_dir_entry *proc_i8k;
 
 	/* Are we running on an supported laptop? */
-	if (i8k_probe() != 0) {
+	if (i8k_probe())
 		return -ENODEV;
-	}
 
 	/* Register the proc entry */
 	proc_i8k = create_proc_info_entry("i8k", 0, NULL, i8k_get_info);
Index: dtor/Documentation/kernel-parameters.txt
===================================================================
--- dtor.orig/Documentation/kernel-parameters.txt
+++ dtor/Documentation/kernel-parameters.txt
@@ -548,6 +548,9 @@ running once the system is up.
 
 	i810=		[HW,DRM]
 
+	i8k.ignore_dmi	[HW] Continue probing hardware even if DMI data
+			indicates that the driver is running on unsupported
+			hardware.
 	i8k.force	[HW] Activate i8k driver even if SMM BIOS signature
 			does not match list of supported models.
 	i8k.power_status
