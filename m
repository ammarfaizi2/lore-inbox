Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVCMDlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVCMDlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 22:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVCMDlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 22:41:44 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:46597 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262657AbVCMDlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 22:41:21 -0500
Message-ID: <4233B65A.4030302@tuxrocks.com>
Date: Sat, 12 Mar 2005 20:41:14 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: LKML <linux-kernel@vger.kernel.org>, Massimo Dal Zotto <dz@debian.org>
Subject: Re: [PATCH 0/5] I8K driver facelift
References: <200502240110.16521.dtor_core@ameritech.net>
In-Reply-To: <200502240110.16521.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
| Hi,
|
| here are some changes that freshen I8K driver (Dell Inspiron/Latitude
| platform driver). The patches have been tested on Inspiron 8100.
<snip>
| Please consider for inclusion.
|
| Thanks!

These patches look pretty good.  A few comments (with a patch--tested on
my Inspiron 9200):

- - The "return i8k_smm(&regs) < 0 ? : regs.eax;" construction is nice and
tidy, but it isn't passing on the return value of the called function,
and is returning TRUE or 1 on failure.  This makes it difficult to check
the return value for valid data.  Old behavior returned negative, so
I'll return -1.

- - The I8K_VERSION string should probably be changed to something more
unique.  The version maintained outside the kernel tree by Massimo Dal
Zotto (http://www.debian.org/~dz/i8k/) is up to 1.25, so 1.14 isn't very
distinguishing.  Maybe just use the date?  Not sure here...

- - Also, some newer Dell laptops require a different function to get the
Dell signature, so the i8k_get_dell_signature test should check both
(borrowing some code from the out-of-kernel version).

- - Some newer Dell laptops report DMI_SYS_VENDOR as "Dell Inc." rather
than "Dell Computer"

- - Some of the Dell motherboards provide more than 1 temperature sensor.
~ How about a generic i8k_get_temp function, and i8k_get_cpu_temp just
calls that with sensor 0.

- - Also, I've added detection of the number of temperature sensors and
fans at init time.  This way, we aren't hardcoded to 1 sensor and 2
fans.  I couldn't figure out how to set up the sysfs entries
dynamically, but that probably should happen too.

- - Some boards don't need the I8K_FAN_MULT to get the right fan RPM (I
don't think my fans are rotating at over 90,000 RPM)!  I guess we'll
need to address this sometime, but I have not done so.

Patch follows:

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

- --- 2.6.11-a/drivers/char/i8k.c	2005-03-12 18:47:55.000000000 -0700
+++ 2.6.11-b/drivers/char/i8k.c	2005-03-12 20:29:01.000000000 -0700
@@ -28,7 +28,7 @@

~ #include <linux/i8k.h>

- -#define I8K_VERSION		"1.14 21/02/2005"
+#define I8K_VERSION		"2005-03-12"

~ #define I8K_SMM_FN_STATUS	0x0025
~ #define I8K_SMM_POWER_STATUS	0x0069
@@ -36,7 +36,8 @@
~ #define I8K_SMM_GET_FAN		0x00a3
~ #define I8K_SMM_GET_SPEED	0x02a3
~ #define I8K_SMM_GET_TEMP	0x10a3
- -#define I8K_SMM_GET_DELL_SIG	0xffa3
+#define I8K_SMM_GET_DELL_SIG1	0xfea3
+#define I8K_SMM_GET_DELL_SIG2	0xffa3
~ #define I8K_SMM_BIOS_VERSION	0x00a6

~ #define I8K_FAN_MULT		30
@@ -55,6 +56,8 @@
~ #define I8K_TEMPERATURE_BUG	1

~ static char bios_version[4];
+static int num_temps = 0;
+static int num_fans = 0;

~ MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
~ MODULE_DESCRIPTION("Driver for accessing SMM BIOS on Dell laptops");
@@ -201,10 +204,10 @@
~  */
~ static int i8k_get_fan_status(int fan)
~ {
- -	struct smm_regs regs = { .eax = I8K_SMM_GET_FAN, };
+	struct smm_regs regs = { .eax = I8K_SMM_GET_FAN, .ebx = (fan & 0xff)};

~ 	regs.ebx = fan & 0xff;
- -	return i8k_smm(&regs) < 0 ? : regs.eax & 0xff;
+	return i8k_smm(&regs) < 0 ? -1 : regs.eax & 0xff;
~ }

~ /*
@@ -215,7 +218,7 @@
~ 	struct smm_regs regs = { .eax = I8K_SMM_GET_SPEED, };

~ 	regs.ebx = fan & 0xff;
- -	return i8k_smm(&regs) < 0 ? : (regs.eax & 0xffff) * I8K_FAN_MULT;
+	return i8k_smm(&regs) < 0 ? -1 : (regs.eax & 0xffff) * I8K_FAN_MULT;
~ }

~ /*
@@ -228,15 +231,15 @@
~ 	speed = (speed < 0) ? 0 : ((speed > I8K_FAN_MAX) ? I8K_FAN_MAX : speed);
~ 	regs.ebx = (fan & 0xff) | (speed << 8);

- -	return i8k_smm(&regs) < 0 ? : i8k_get_fan_status(fan);
+	return i8k_smm(&regs) < 0 ? -1 : i8k_get_fan_status(fan);
~ }

~ /*
~  * Read the cpu temperature.
~  */
- -static int i8k_get_cpu_temp(void)
+static int i8k_get_temp(int sensor)
~ {
- -	struct smm_regs regs = { .eax = I8K_SMM_GET_TEMP, };
+	struct smm_regs regs = { .eax = I8K_SMM_GET_TEMP, .ebx = sensor };
~ 	int rc;
~ 	int temp;

@@ -268,9 +271,14 @@
~ 	return temp;
~ }

- -static int i8k_get_dell_signature(void)
+static int i8k_get_cpu_temp(void)
+{
+	return i8k_get_temp(0);
+}
+
+static int i8k_get_dell_sig_aux(int fn)
~ {
- -	struct smm_regs regs = { .eax = I8K_SMM_GET_DELL_SIG, };
+	struct smm_regs regs = { .eax = fn, };
~ 	int rc;

~ 	if ((rc = i8k_smm(&regs)) < 0)
@@ -279,6 +287,17 @@
~ 	return regs.eax == 1145651527 && regs.edx == 1145392204 ? 0 : -1;
~ }

+static int i8k_get_dell_signature(void)
+{
+	int rc;
+
+	if (((rc=i8k_get_dell_sig_aux(I8K_SMM_GET_DELL_SIG1)) < 0) &&
+	    ((rc=i8k_get_dell_sig_aux(I8K_SMM_GET_DELL_SIG2)) < 0)) {
+		return rc;
+	}
+	return 0;
+}
+
~ static int i8k_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
~ 		     unsigned long arg)
~ {
@@ -506,6 +525,13 @@
~ 		},
~ 	},
~ 	{
+		.ident = "Dell Inspiron",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
+		},
+	},
+	{
~ 		.ident = "Dell Latitude",
~ 		.matches = {
~ 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer"),
@@ -587,6 +613,11 @@
~ 	if (i8k_probe())
~ 		return -ENODEV;

+	while (i8k_get_temp(num_temps) >= 0) num_temps ++;
+	printk(KERN_INFO "i8k: found %d temperature sensors\n", num_temps);
+	while (i8k_get_fan_status(num_fans) >= 0) num_fans ++;
+	printk(KERN_INFO "i8k: found %d fans\n", num_fans);
+
~ 	/* Register the proc entry */
~ 	proc_i8k = create_proc_entry("i8k", 0, NULL);
~ 	if (!proc_i8k)



Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCM7ZZaI0dwg4A47wRAok1AKDLYIrMXLphYAeAq98OXYqxk6U1vACfQpld
qczdJm2992BjeQ/iU9RP+k4=
=nNut
-----END PGP SIGNATURE-----
