Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUDUM75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUDUM75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 08:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUDUM75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 08:59:57 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:29629 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261186AbUDUM7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 08:59:43 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH] add some EFI device smarts
Date: Wed, 21 Apr 2004 06:59:22 -0600
User-Agent: KMail/1.6.1
Cc: linux-ia64@vger.kernel.org, Matt Tolentino <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
References: <200404201600.26207.bjorn.helgaas@hp.com> <20040420235038.GB29850@lists.us.dell.com>
In-Reply-To: <20040420235038.GB29850@lists.us.dell.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210659.22884.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 April 2004 5:50 pm, Matt Domsch wrote:
> Matt T. had done the work to move it under drivers/efi, though now
> that there's a drivers/firmware, that's more appropraite.

Sounds good.  I'll let Matt T. worry about that for now.

> > +		/* Convert Unicode to normal chars */
> > +		for (i = 0; i < (name_size/sizeof(name_unicode[0])); i++)
> > +			name_utf8[i] = name_unicode[i] & 0xff;
> > +		name_utf8[i] = 0;
> 
> I've never had a clear understanding of this.  It's not really UTF8
> (else straight ASCII text could be used), but more like UCS2.

I don't understand Unicode either.  Maybe the attached is a little
closer?  The EFI spec (1.10, table 2-2) says strings are stored in
UTF-16, and I think that UTF-16 is the same as ASCII for
(0 < c <= 0x7f).

I also stuck in the GUID stuff and removed the typedef (I prefer
the plain structs myself, but was just following the existing style ;-)).

Oh, BTW, my changes are in efi.c, not efivars.c, so no Kconfig
or modular build implications. 

I'll try to post the patch that calls efi_uart_console_only() today.
I just didn't want these EFI changes to get buried in the rest of
that.  Thanks a lot for the feedback!

Bjorn

===== arch/ia64/kernel/efi.c 1.31 vs edited =====
--- 1.31/arch/ia64/kernel/efi.c	Mon Apr 12 04:21:11 2004
+++ edited/arch/ia64/kernel/efi.c	Wed Apr 21 06:31:33 2004
@@ -747,6 +747,72 @@
 	return 0;
 }
 
+int
+efi_get_variable(char *name, efi_guid_t guid, unsigned char *data,
+	unsigned long *size, u32 *attributes)
+{
+	efi_status_t status;
+	efi_guid_t vendor_guid;
+	efi_char16_t name_utf16[128];
+	char name_ascii[ARRAY_SIZE(name_utf16) + 1];
+	unsigned long name_size;
+	int i;
+
+	memset(name_utf16, 0, sizeof(name_utf16));
+	for (;;) {
+		name_size = sizeof(name_utf16);
+		status = efi.get_next_variable(&name_size, name_utf16,
+			&vendor_guid);
+		if (status != EFI_SUCCESS)
+			return -EINVAL;
+
+		/* Convert UTF-16 to ASCII */
+		for (i = 0; i < (name_size/sizeof(name_utf16[0])); i++)
+			name_ascii[i] = name_utf16[i] & 0x7f;
+		name_ascii[i] = 0;
+
+		if (strcmp(name_ascii, name) || efi_guidcmp(guid, vendor_guid))
+			continue;
+
+		status = efi.get_variable(name_utf16, &guid, attributes,
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
+	struct efi_generic_dev_path *hdr, *end_addr;
+	int uart = 0;
+
+	if (efi_get_variable("ConOut", EFI_GLOBAL_VARIABLE_GUID, data, &size, NULL) < 0)
+		return 0;
+
+	hdr = (struct efi_generic_dev_path *) data;
+	end_addr = (struct efi_generic_dev_path *) ((u8 *) data + size);
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
+		hdr = (struct efi_generic_dev_path *) ((u8 *) hdr + hdr->length);
+	}
+	return 0;	/* malformed path (no end) */
+}
+
 static void __exit
 efivars_exit (void)
 {
===== arch/ia64/kernel/efivars.c 1.15 vs edited =====
--- 1.15/arch/ia64/kernel/efivars.c	Tue Feb 10 19:51:27 2004
+++ edited/arch/ia64/kernel/efivars.c	Wed Apr 21 06:41:25 2004
@@ -191,10 +191,9 @@
 	       variable_name_size);
 	memcpy(&(new_efivar->var.VendorGuid), vendor_guid, sizeof(efi_guid_t));
 
-	/* Convert Unicode to normal chars (assume top bits are 0),
-	   ala UTF-8 */
+	/* Convert UTF-16 to ASCII (assume top bits are 0) */
 	for (i=0; i< (int) (variable_name_size / sizeof(efi_char16_t)); i++) {
-		short_name[i] = variable_name[i] & 0xFF;
+		short_name[i] = variable_name[i] & 0x7F;
 	}
 
 	/* This is ugly, but necessary to separate one vendor's
===== include/linux/efi.h 1.7 vs edited =====
--- 1.7/include/linux/efi.h	Tue Feb  3 22:29:14 2004
+++ edited/include/linux/efi.h	Wed Apr 21 06:25:22 2004
@@ -212,6 +212,9 @@
 #define UGA_IO_PROTOCOL_GUID \
     EFI_GUID(  0x61a4d49e, 0x6f68, 0x4f1b, 0xb9, 0x22, 0xa8, 0x6e, 0xed, 0xb, 0x7, 0xa2 )
 
+#define EFI_GLOBAL_VARIABLE_GUID \
+    EFI_GUID(  0x8be4df61, 0x93ca, 0x11d2, 0xaa, 0x0d, 0x00, 0xe0, 0x98, 0x03, 0x2b, 0x8c )
+
 typedef struct {
 	efi_guid_t guid;
 	unsigned long table;
@@ -294,6 +297,8 @@
 extern u64 efi_get_iobase (void);
 extern u32 efi_mem_type (unsigned long phys_addr);
 extern u64 efi_mem_attributes (unsigned long phys_addr);
+extern int efi_get_variable (char *name, efi_guid_t guid, unsigned char *data, unsigned long *size, u32 *attributes);
+extern int __init efi_uart_console_only (void);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 					struct resource *data_resource);
 extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
@@ -322,6 +327,49 @@
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
+struct efi_generic_dev_path {
+	u8 type;
+	u8 sub_type;
+	u16 length;
+} __attribute ((packed));
 
 /*
  * efi_dir is allocated in arch/ia64/kernel/efi.c.
