Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263836AbUDTWNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbUDTWNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUDTWM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:12:57 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:1246 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S264584AbUDTWA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 18:00:29 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-ia64@vger.kernel.org
Subject: [PATCH] add some EFI device smarts
Date: Tue, 20 Apr 2004 16:00:26 -0600
User-Agent: KMail/1.6.1
Cc: Matt Tolentino <matthew.e.tolentino@intel.com>,
       Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404201600.26207.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against current 2.6 BK adds efi_get_variable() and
efi_uart_console_only().

The first thing I want to use this for is smarter console detection.
In the absence of a "console=" argument, we currently always default
to a VGA console.  But if the EFI ConOut variable includes only UART
devices, we ought to take advantage of that and use a serial console
instead.

This is based on previous work by Khalid Aziz and Alex Williamson.

(Like much of the EFI stuff, this really isn't ia64-specific.  Maybe
it's time to move some of it under drivers/efi?  If there's interest,
I can look at doing that.)

===== arch/ia64/kernel/efi.c 1.31 vs edited =====
--- 1.31/arch/ia64/kernel/efi.c	Mon Apr 12 04:21:11 2004
+++ edited/arch/ia64/kernel/efi.c	Tue Apr 20 14:46:28 2004
@@ -747,6 +747,71 @@
 	return 0;
 }
 
+int
+efi_get_variable(char *name, unsigned char *data, unsigned long *size)
+{
+	efi_status_t status;
+	efi_guid_t vendor_guid;
+	efi_char16_t name_unicode[128];
+	char name_utf8[ARRAY_SIZE(name_unicode) + 1];
+	unsigned long name_size;
+	int i;
+
+	memset(name_unicode, 0, sizeof(name_unicode));
+	for (;;) {
+		name_size = sizeof(name_unicode);
+		status = efi.get_next_variable(&name_size, name_unicode,
+			&vendor_guid);
+		if (status != EFI_SUCCESS)
+			return -EINVAL;
+
+		/* Convert Unicode to normal chars */
+		for (i = 0; i < (name_size/sizeof(name_unicode[0])); i++)
+			name_utf8[i] = name_unicode[i] & 0xff;
+		name_utf8[i] = 0;
+
+		if (strcmp(name_utf8, name))
+			continue;
+
+		status = efi.get_variable(name_unicode, &vendor_guid, NULL,
+			size, data);
+		if (status != EFI_SUCCESS)
+			return -EINVAL;
+
+		return 0;
+	}
+}
+
+int __init
+efi_uart_console_only(void)
+{
+	unsigned char data[1024];
+	unsigned long size = sizeof(data);
+	efi_generic_dev_path_t *hdr, *end_addr;
+	int uart = 0;
+
+	if (efi_get_variable("ConOut", data, &size) < 0)
+		return 0;
+
+	hdr = (efi_generic_dev_path_t *) data;
+	end_addr = (efi_generic_dev_path_t *) ((u8 *) data + size);
+	while (hdr < end_addr) {
+		if (hdr->type == EFI_DEV_MSG &&
+		    hdr->sub_type == EFI_DEV_MSG_UART)
+			uart = 1;
+		else if (hdr->type == EFI_DEV_END_PATH ||
+			  hdr->type == EFI_DEV_END_PATH2) {
+			if (!uart)
+				return 0;
+			if (hdr->sub_type == EFI_DEV_END_ENTIRE)
+				return 1;
+			uart = 0;
+		}
+		hdr = (efi_generic_dev_path_t *) ((u8 *) hdr + hdr->length);
+	}
+	return 0;	/* malformed path (no end) */
+}
+
 static void __exit
 efivars_exit (void)
 {
===== include/linux/efi.h 1.7 vs edited =====
--- 1.7/include/linux/efi.h	Tue Feb  3 22:29:14 2004
+++ edited/include/linux/efi.h	Tue Apr 20 14:47:46 2004
@@ -294,6 +294,8 @@
 extern u64 efi_get_iobase (void);
 extern u32 efi_mem_type (unsigned long phys_addr);
 extern u64 efi_mem_attributes (unsigned long phys_addr);
+extern int efi_get_variable (char *name, unsigned char *data, unsigned long *size);
+extern int __init efi_uart_console_only (void);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 					struct resource *data_resource);
 extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
@@ -322,6 +324,49 @@
 #define EFI_VARIABLE_BOOTSERVICE_ACCESS 0x0000000000000002
 #define EFI_VARIABLE_RUNTIME_ACCESS     0x0000000000000004
 
+/*
+ * EFI Device Path information
+ */
+#define EFI_DEV_HW			0x01
+#define  EFI_DEV_PCI				 1
+#define  EFI_DEV_PCCARD				 2
+#define  EFI_DEV_MEM_MAPPED			 3
+#define  EFI_DEV_VENDOR				 4
+#define  EFI_DEV_CONTROLLER			 5
+#define EFI_DEV_ACPI			0x02
+#define   EFI_DEV_BASIC_ACPI			 1
+#define   EFI_DEV_EXPANDED_ACPI			 2
+#define EFI_DEV_MSG			0x03
+#define   EFI_DEV_MSG_ATAPI			 1
+#define   EFI_DEV_MSG_SCSI			 2
+#define   EFI_DEV_MSG_FC			 3
+#define   EFI_DEV_MSG_1394			 4
+#define   EFI_DEV_MSG_USB			 5
+#define   EFI_DEV_MSG_USB_CLASS			15
+#define   EFI_DEV_MSG_I20			 6
+#define   EFI_DEV_MSG_MAC			11
+#define   EFI_DEV_MSG_IPV4			12
+#define   EFI_DEV_MSG_IPV6			13
+#define   EFI_DEV_MSG_INFINIBAND		 9
+#define   EFI_DEV_MSG_UART			14
+#define   EFI_DEV_MSG_VENDOR			10
+#define EFI_DEV_MEDIA			0x04
+#define   EFI_DEV_MEDIA_HARD_DRIVE		 1
+#define   EFI_DEV_MEDIA_CDROM			 2
+#define   EFI_DEV_MEDIA_VENDOR			 3
+#define   EFI_DEV_MEDIA_FILE			 4
+#define   EFI_DEV_MEDIA_PROTOCOL		 5
+#define EFI_DEV_BIOS_BOOT		0x05
+#define EFI_DEV_END_PATH		0x7F
+#define EFI_DEV_END_PATH2		0xFF
+#define   EFI_DEV_END_INSTANCE			0x01
+#define   EFI_DEV_END_ENTIRE			0xFF
+
+typedef struct {
+	u8 type;
+	u8 sub_type;
+	u16 length;
+} efi_generic_dev_path_t;
 
 /*
  * efi_dir is allocated in arch/ia64/kernel/efi.c.
