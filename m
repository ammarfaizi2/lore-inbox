Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265965AbUFEAwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbUFEAwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 20:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUFEAwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 20:52:54 -0400
Received: from palrel11.hp.com ([156.153.255.246]:63966 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S266121AbUFEAwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 20:52:25 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16577.6469.833064.763671@napali.hpl.hp.com>
Date: Fri, 4 Jun 2004 17:52:21 -0700
To: Michael_E_Brown@dell.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: EFI-support for SMBIOS driver
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

The patch below adds EFI support to the SMBIOS driver.  Since EFI
already knows the address of the SMBIOS, this avoids having to scan
for the table.  It also enables use of the driver on ia64 machines.
The patch also adds code to handle the case where the SMBIOS table
resides in memory, which is the case at least for HP's zx1-based ia64
machines.  If CONFIG_EFI is off, the resulting code should be
unchanged (except for replacing a readb() loop into a
memcpy_fromio()).

One observation: I believe find_table_max_address() is missing some
readb() calls (it's dereferencing ioremap'pped addresses directly).  I
didn't try to fix that since I wasn't sure why it wasn't done in the
first place.

Do you have a test-program that's using /sys/firmware/smbios?

If the patch looks OK, please apply.

Thanks,

	--david

===== drivers/firmware/smbios.c 1.2 vs edited =====
--- 1.2/drivers/firmware/smbios.c	Wed Apr 28 04:50:49 2004
+++ edited/drivers/firmware/smbios.c	Fri Jun  4 17:48:20 2004
@@ -27,6 +27,7 @@
 
 
 #include <linux/module.h>
+#include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <asm/io.h>
@@ -53,6 +54,37 @@
  * show them. */
 static struct sysfs_ops smbios_attr_ops = { };
 
+#ifdef CONFIG_EFI
+  static int smbios_in_memory;	/* does smbios reside in normal memory? */
+#else
+# define smbios_in_memory	0
+#endif
+
+static inline void *
+smbios_map (unsigned long addr, unsigned long size)
+{
+	if (smbios_in_memory)
+		return phys_to_virt(addr);
+	else
+		return ioremap(addr, size);
+}
+
+static inline void
+smbios_unmap (void *addr)
+{
+	if (!smbios_in_memory)
+		iounmap(addr);
+}
+
+static inline void
+smbios_memcpy (void *dst, void *src, size_t len)
+{
+	if (smbios_in_memory)
+		memcpy(dst, src, len);
+	else
+		memcpy_fromio(dst, src, len);
+}
+
 static __init int
 checksum_eps(struct smbios_table_entry_point *table_eps)
 {
@@ -65,15 +97,44 @@
 	return( checksum == 0 );
 }
 
+static int
+valid_table (struct smbios_table_entry_point *table_eps)
+{
+	return (memcmp(table_eps->anchor, "_SM_", 4) == 0 &&
+		checksum_eps(table_eps));
+}
+
 static __init int
 find_table_entry_point(struct smbios_device *sdev)
 {
 	struct smbios_table_entry_point *table_eps = &(sdev->table_eps);
+#ifdef CONFIG_EFI
+	unsigned long addr;
+	void *header;
+
+	if (!efi.smbios) {
+		printk(KERN_INFO "SMBIOS table entry point not found\n");
+		return -ENODEV;
+	}
+	addr = virt_to_phys(efi.smbios);
+	smbios_in_memory = (efi_mem_attributes(addr) & EFI_MEMORY_WB) != 0;
+
+	header = smbios_map(addr, sizeof(*table_eps));
+	if (!header)
+		return -ENODEV;
+
+	smbios_memcpy(table_eps, header, sizeof(*table_eps));
+	smbios_unmap(header);
+
+	if (valid_table(table_eps))
+		return 0;
+
+	printk(KERN_INFO "SMBIOS table at %p appears to be invalid\n", efi.smbios);
+#else
 	u32 fp = 0xF0000;
 	while (fp < 0xFFFFF) {
 		isa_memcpy_fromio(table_eps, fp, sizeof(*table_eps));
-		if (memcmp(table_eps->anchor, "_SM_", 4)==0 &&
-					checksum_eps(table_eps)) {
+		if (valid_table(table_eps)) {
 			return 0;
 		}
 		fp += 16;
@@ -81,6 +142,7 @@
 
 	printk(KERN_INFO "SMBIOS table entry point not found in "
 			"0xF0000 - 0xFFFFF\n");
+#endif
 	return -ENODEV;
 }
 
@@ -93,8 +155,8 @@
 	 *   -- hit structure type 127
 	 */
 
-	u8 *buf = ioremap(sdev->table_eps.table_address,
-			sdev->table_eps.table_length);
+	u8 *buf = smbios_map(sdev->table_eps.table_address,
+			     sdev->table_eps.table_length);
 	u8 *ptr = buf;
 	int count = 0, keep_going = 1;
 	int max_count = sdev->table_eps.table_num_structs;
@@ -113,7 +175,7 @@
 		++count;
 	}
 	sdev->smbios_table_real_length = (ptr - buf);
-	iounmap(buf);
+	smbios_unmap(buf);
 
 	if( count != max_count )
 		printk(KERN_INFO "Warning: SMBIOS table structure count"
@@ -158,22 +220,16 @@
 	struct smbios_device *sdev = &the_smbios_device;
 	u8 *buf;
 	unsigned int count = sdev->smbios_table_real_length - pos;
-	int i = 0;
 	count = count < size ? count : size;
 
 	if (pos > sdev->smbios_table_real_length)
 		return 0;
 
-	buf = ioremap(sdev->table_eps.table_address, sdev->smbios_table_real_length);
+	buf = smbios_map(sdev->table_eps.table_address, sdev->smbios_table_real_length);
 	if (buf == NULL)
 		return -ENXIO;
-
-	/* memcpy( buffer, buf+pos, count ); */
-	for (i = 0; i < count; ++i) {
-		buffer[i] = readb( buf+pos+i );
-	}
-
-	iounmap(buf);
+	smbios_memcpy(buffer, buf + pos, count);
+	smbios_unmap(buf);
 
 	return count;
 }
