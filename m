Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264874AbSJ3Tta>; Wed, 30 Oct 2002 14:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264866AbSJ3Tta>; Wed, 30 Oct 2002 14:49:30 -0500
Received: from smtp3.us.dell.com ([143.166.148.134]:37639 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S264903AbSJ3TtD>; Wed, 30 Oct 2002 14:49:03 -0500
Date: Wed, 30 Oct 2002 13:55:28 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 2.5.44] EDD updates 1/4
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68BC03E6@AUSXMPC122.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.44.0210301354050.27031-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.809, 2002-10-21 15:01:15-05:00, Matt_Domsch@dell.com
  EDD: add comments, magic value defines, use snprintf always


 arch/i386/boot/setup.S   |   34 ++++++++++--
 arch/i386/kernel/edd.c   |  129 ++++++++++++++++++++++++-----------------------
 arch/i386/kernel/setup.c |    3 -
 include/asm-i386/edd.h   |    4 +
 4 files changed, 100 insertions, 70 deletions


diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Wed Oct 23 13:15:30 2002
+++ b/arch/i386/boot/setup.S	Wed Oct 23 13:15:30 2002
@@ -46,8 +46,9 @@
  * by Robert Schwebel, December 2001 <robert@schwebel.de>
  *    
  * BIOS Enhanced Disk Drive support
- * by Matt Domsch <Matt_Domsch@dell.com> September 2002 
- *
+ * by Matt Domsch <Matt_Domsch@dell.com> October 2002
+ * conformant to T13 Committee www.t13.org
+ *   projects 1572D, 1484D, 1386D, 1226DT
  */
 
 #include <linux/config.h>
@@ -549,6 +550,27 @@
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 # Do the BIOS Enhanced Disk Drive calls
+# This consists of two calls:
+#    int 13h ah=41h "Check Extensions Present"
+#    int 13h ah=48h "Get Device Parameters"
+#
+# A buffer of size EDDMAXNR*(EDDEXTSIZE+EDDPARMSIZE) is reserved for our use
+# in the empty_zero_page at EDDBUF.  The first four bytes of which are
+# used to store the device number, interface support map and version
+# results from fn41.  The following 74 bytes are used to store
+# the results from fn48.  Starting from device 80h, fn41, then fn48
+# are called and their results stored in EDDBUF+n*(EDDEXTSIZE+EDDPARMIZE).
+# Then the pointer is incremented to store the data for the next call.
+# This repeats until either a device doesn't exist, or until EDDMAXNR
+# devices have been stored.
+# The one tricky part is that ds:si always points four bytes into
+# the structure, and the fn41 results are stored at offsets
+# from there.  This removes the need to increment the pointer for
+# every store, and leaves it ready for the fn48 call.
+# A second one-byte buffer, EDDNR, in the empty_zero_page stores
+# the number of BIOS devices which exist, up to EDDMAXNR.
+# In setup.c, copy_edd() stores both empty_zero_page buffers away
+# for later use, as they would get overwritten otherwise. 
 # This code is sensitive to the size of the structs in edd.h
 edd_start:  
 						# %ds points to the bootsector
@@ -559,12 +581,12 @@
     	movb	$0x80, %dl			# BIOS device 0x80
 
 edd_check_ext:
-	movb	$0x41, %ah			# Function 41
-	movw	$0x55aa, %bx			# magic
+	movb	$CHECKEXTENSIONSPRESENT, %ah    # Function 41
+	movw	$EDDMAGIC1, %bx			# magic
 	int	$0x13				# make the call
 	jc	edd_done			# no more BIOS devices
 
-    	cmpw	$0xAA55, %bx			# is magic right?
+    	cmpw	$EDDMAGIC2, %bx			# is magic right?
 	jne	edd_next			# nope, next...
 
     	movb	%dl, %ds:-4(%si)		# store device number
@@ -574,7 +596,7 @@
         
 edd_get_device_params:  
 	movw	$EDDPARMSIZE, %ds:(%si)		# put size
-    	movb	$0x48, %ah			# Function 48
+    	movb	$GETDEVICEPARAMETERS, %ah	# Function 48
 	int	$0x13				# make the call
 						# Don't check for fail return
 						# it doesn't matter.
diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Wed Oct 23 13:15:30 2002
+++ b/arch/i386/kernel/edd.c	Wed Oct 23 13:15:30 2002
@@ -65,6 +65,8 @@
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://domsch.com/linux/edd30/results.html"
 
+#define left (count - (p - buf) - 1)
+
 /*
  * bios_dir may go away completely,
  * and it definitely won't be at the root
@@ -133,35 +135,36 @@
 };
 
 static int
-edd_dump_raw_data(char *b, void *data, int length)
+edd_dump_raw_data(char *b, int count, void *data, int length)
 {
 	char *orig_b = b;
-	char buffer1[80], buffer2[80], *b1, *b2, c;
+	char hexbuf[80], ascbuf[20], *h, *a, c;
 	unsigned char *p = data;
 	unsigned long column = 0;
-	int length_printed = 0;
+	int length_printed = 0, d;
 	const char maxcolumn = 16;
-	while (length_printed < length) {
-		b1 = buffer1;
-		b2 = buffer2;
+	while (length_printed < length && count > 0) {
+		h = hexbuf;
+		a = ascbuf;
 		for (column = 0;
 		     column < maxcolumn && length_printed < length; column++) {
-			b1 += sprintf(b1, "%02x ", (unsigned char) *p);
-			if (*p < 32 || *p > 126)
+			h += sprintf(h, "%02x ", (unsigned char) *p);
+			if (!isprint(*p))
 				c = '.';
 			else
 				c = *p;
-			b2 += sprintf(b2, "%c", c);
+			a += sprintf(a, "%c", c);
 			p++;
 			length_printed++;
 		}
 		/* pad out the line */
 		for (; column < maxcolumn; column++) {
-			b1 += sprintf(b1, "   ");
-			b2 += sprintf(b2, " ");
+			h += sprintf(h, "   ");
+			a += sprintf(a, " ");
 		}
-
-		b += sprintf(b, "%s\t%s\n", buffer1, buffer2);
+		d = snprintf(b, count, "%s\t%s\n", hexbuf, ascbuf);
+		b += d;
+		count -= d;
 	}
 	return (b - orig_b);
 }
@@ -179,18 +182,18 @@
 
 	for (i = 0; i < 4; i++) {
 		if (isprint(info->params.host_bus_type[i])) {
-			p += sprintf(p, "%c", info->params.host_bus_type[i]);
+			p += snprintf(p, left, "%c", info->params.host_bus_type[i]);
 		} else {
-			p += sprintf(p, " ");
+			p += snprintf(p, left, " ");
 		}
 	}
 
 	if (!strncmp(info->params.host_bus_type, "ISA", 3)) {
-		p += sprintf(p, "\tbase_address: %x\n",
+		p += snprintf(p, left, "\tbase_address: %x\n",
 			     info->params.interface_path.isa.base_address);
 	} else if (!strncmp(info->params.host_bus_type, "PCIX", 4) ||
 		   !strncmp(info->params.host_bus_type, "PCI", 3)) {
-		p += sprintf(p,
+		p += snprintf(p, left,
 			     "\t%02x:%02x.%01x  channel: %u\n",
 			     info->params.interface_path.pci.bus,
 			     info->params.interface_path.pci.slot,
@@ -199,12 +202,12 @@
 	} else if (!strncmp(info->params.host_bus_type, "IBND", 4) ||
 		   !strncmp(info->params.host_bus_type, "XPRS", 4) ||
 		   !strncmp(info->params.host_bus_type, "HTPT", 4)) {
-		p += sprintf(p,
+		p += snprintf(p, left,
 			     "\tTBD: %llx\n",
 			     info->params.interface_path.ibnd.reserved);
 
 	} else {
-		p += sprintf(p, "\tunknown: %llx\n",
+		p += snprintf(p, left, "\tunknown: %llx\n",
 			     info->params.interface_path.unknown.reserved);
 	}
 	return (p - buf);
@@ -223,43 +226,43 @@
 
 	for (i = 0; i < 8; i++) {
 		if (isprint(info->params.interface_type[i])) {
-			p += sprintf(p, "%c", info->params.interface_type[i]);
+			p += snprintf(p, left, "%c", info->params.interface_type[i]);
 		} else {
-			p += sprintf(p, " ");
+			p += snprintf(p, left, " ");
 		}
 	}
 	if (!strncmp(info->params.interface_type, "ATAPI", 5)) {
-		p += sprintf(p, "\tdevice: %u  lun: %u\n",
+		p += snprintf(p, left, "\tdevice: %u  lun: %u\n",
 			     info->params.device_path.atapi.device,
 			     info->params.device_path.atapi.lun);
 	} else if (!strncmp(info->params.interface_type, "ATA", 3)) {
-		p += sprintf(p, "\tdevice: %u\n",
+		p += snprintf(p, left, "\tdevice: %u\n",
 			     info->params.device_path.ata.device);
 	} else if (!strncmp(info->params.interface_type, "SCSI", 4)) {
-		p += sprintf(p, "\tid: %u  lun: %llu\n",
+		p += snprintf(p, left, "\tid: %u  lun: %llu\n",
 			     info->params.device_path.scsi.id,
 			     info->params.device_path.scsi.lun);
 	} else if (!strncmp(info->params.interface_type, "USB", 3)) {
-		p += sprintf(p, "\tserial_number: %llx\n",
+		p += snprintf(p, left, "\tserial_number: %llx\n",
 			     info->params.device_path.usb.serial_number);
 	} else if (!strncmp(info->params.interface_type, "1394", 4)) {
-		p += sprintf(p, "\teui: %llx\n",
+		p += snprintf(p, left, "\teui: %llx\n",
 			     info->params.device_path.i1394.eui);
 	} else if (!strncmp(info->params.interface_type, "FIBRE", 5)) {
-		p += sprintf(p, "\twwid: %llx lun: %llx\n",
+		p += snprintf(p, left, "\twwid: %llx lun: %llx\n",
 			     info->params.device_path.fibre.wwid,
 			     info->params.device_path.fibre.lun);
 	} else if (!strncmp(info->params.interface_type, "I2O", 3)) {
-		p += sprintf(p, "\tidentity_tag: %llx\n",
+		p += snprintf(p, left, "\tidentity_tag: %llx\n",
 			     info->params.device_path.i2o.identity_tag);
 	} else if (!strncmp(info->params.interface_type, "RAID", 4)) {
-		p += sprintf(p, "\tidentity_tag: %x\n",
+		p += snprintf(p, left, "\tidentity_tag: %x\n",
 			     info->params.device_path.raid.array_number);
 	} else if (!strncmp(info->params.interface_type, "SATA", 4)) {
-		p += sprintf(p, "\tdevice: %u\n",
+		p += snprintf(p, left, "\tdevice: %u\n",
 			     info->params.device_path.sata.device);
 	} else {
-		p += sprintf(p, "\tunknown: %llx %llx\n",
+		p += snprintf(p, left, "\tunknown: %llx %llx\n",
 			     info->params.device_path.unknown.reserved1,
 			     info->params.device_path.unknown.reserved2);
 	}
@@ -289,15 +292,15 @@
 	if (!(info->params.key == 0xBEDD || info->params.key == 0xDDBE))
 		len = info->params.length;
 
-	p += sprintf(p, "int13 fn48 returned data:\n\n");
-	p += edd_dump_raw_data(p, ((char *) edd) + 4, len);
+	p += snprintf(p, left, "int13 fn48 returned data:\n\n");
+	p += edd_dump_raw_data(p, left, ((char *) edd) + 4, len);
 
 	/* Spec violation.  Adaptec AIC7899 returns 0xDDBE
 	   here, when it should be 0xBEDD.
 	 */
-	p += sprintf(p, "\n");
+	p += snprintf(p, left, "\n");
 	if (info->params.key == 0xDDBE) {
-		p += sprintf(p,
+		p += snprintf(p, left,
 			     "Warning: Spec violation.  Key should be 0xBEDD, is 0xDDBE\n");
 		email++;
 	}
@@ -314,13 +317,13 @@
 	}
 
 	if (checksum) {
-		p += sprintf(p,
+		p += snprintf(p, left,
 			     "Warning: Spec violation.  Device Path checksum invalid.\n");
 		email++;
 	}
 
 	if (!nonzero_path) {
-		p += sprintf(p, "Error: Spec violation.  Empty device path.\n");
+		p += snprintf(p, left, "Error: Spec violation.  Empty device path.\n");
 		email++;
 		goto out;
 	}
@@ -337,7 +340,7 @@
 	}
 
 	if (warn_padding) {
-		p += sprintf(p,
+		p += snprintf(p, left,
 			     "Warning: Spec violation.  Padding should be 0x20.\n");
 		email++;
 	}
@@ -350,8 +353,8 @@
 						  info->params.interface_path.
 						  pci.function));
 		if (!pci_dev) {
-			p += sprintf(p, "Error: BIOS says this is a PCI device, but the OS doesn't know\n");
-			p += sprintf(p, "  about a PCI device at %02x:%02x.%01x\n",
+			p += snprintf(p, left, "Error: BIOS says this is a PCI device, but the OS doesn't know\n");
+			p += snprintf(p, left, "  about a PCI device at %02x:%02x.%01x\n",
 				     info->params.interface_path.pci.bus,
 				     info->params.interface_path.pci.slot,
 				     info->params.interface_path.pci.function);
@@ -365,18 +368,18 @@
 	if (found_pci) {
 		sd = edd_find_matching_scsi_device(edev);
 		if (!sd) {
-			p += sprintf(p, "Error: BIOS says this is a SCSI device, but\n");
-			p += sprintf(p, "  the OS doesn't know about this SCSI device.\n");
-			p += sprintf(p, "  Do you have it's driver module loaded?\n");
+			p += snprintf(p, left, "Error: BIOS says this is a SCSI device, but\n");
+			p += snprintf(p, left, "  the OS doesn't know about this SCSI device.\n");
+			p += snprintf(p, left, "  Do you have it's driver module loaded?\n");
 			email++;
 		}
 	}
 
 out:
 	if (email) {
-		p += sprintf(p, "\nPlease check %s\n", REPORT_URL);
-		p += sprintf(p, "to see if this has been reported.  If not,\n");
-		p += sprintf(p, "please send the information requested there.\n");
+		p += snprintf(p, left, "\nPlease check %s\n", REPORT_URL);
+		p += snprintf(p, left, "to see if this has been reported.  If not,\n");
+		p += snprintf(p, left, "please send the information requested there.\n");
 	}
 
 	return (p - buf);
@@ -391,7 +394,7 @@
 		return 0;
 	}
 
-	p += sprintf(p, "0x%02x\n", info->version);
+	p += snprintf(p, left, "0x%02x\n", info->version);
 	return (p - buf);
 }
 
@@ -406,16 +409,16 @@
 	}
 
 	if (info->interface_support & EDD_EXT_FIXED_DISK_ACCESS) {
-		p += sprintf(p, "Fixed disk access\n");
+		p += snprintf(p, left, "Fixed disk access\n");
 	}
 	if (info->interface_support & EDD_EXT_DEVICE_LOCKING_AND_EJECTING) {
-		p += sprintf(p, "Device locking and ejecting\n");
+		p += snprintf(p, left, "Device locking and ejecting\n");
 	}
 	if (info->interface_support & EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT) {
-		p += sprintf(p, "Enhanced Disk Drive support\n");
+		p += snprintf(p, left, "Enhanced Disk Drive support\n");
 	}
 	if (info->interface_support & EDD_EXT_64BIT_EXTENSIONS) {
-		p += sprintf(p, "64-bit extensions\n");
+		p += snprintf(p, left, "64-bit extensions\n");
 	}
 	return (p - buf);
 }
@@ -431,21 +434,21 @@
 	}
 
 	if (info->params.info_flags & EDD_INFO_DMA_BOUNDRY_ERROR_TRANSPARENT)
-		p += sprintf(p, "DMA boundry error transparent\n");
+		p += snprintf(p, left, "DMA boundry error transparent\n");
 	if (info->params.info_flags & EDD_INFO_GEOMETRY_VALID)
-		p += sprintf(p, "geometry valid\n");
+		p += snprintf(p, left, "geometry valid\n");
 	if (info->params.info_flags & EDD_INFO_REMOVABLE)
-		p += sprintf(p, "removable\n");
+		p += snprintf(p, left, "removable\n");
 	if (info->params.info_flags & EDD_INFO_WRITE_VERIFY)
-		p += sprintf(p, "write verify\n");
+		p += snprintf(p, left, "write verify\n");
 	if (info->params.info_flags & EDD_INFO_MEDIA_CHANGE_NOTIFICATION)
-		p += sprintf(p, "media change notification\n");
+		p += snprintf(p, left, "media change notification\n");
 	if (info->params.info_flags & EDD_INFO_LOCKABLE)
-		p += sprintf(p, "lockable\n");
+		p += snprintf(p, left, "lockable\n");
 	if (info->params.info_flags & EDD_INFO_NO_MEDIA_PRESENT)
-		p += sprintf(p, "no media present\n");
+		p += snprintf(p, left, "no media present\n");
 	if (info->params.info_flags & EDD_INFO_USE_INT13_FN50)
-		p += sprintf(p, "use int13 fn50\n");
+		p += snprintf(p, left, "use int13 fn50\n");
 	return (p - buf);
 }
 
@@ -459,7 +462,7 @@
 		return 0;
 	}
 
-	p += sprintf(p, "0x%x\n", info->params.num_default_cylinders);
+	p += snprintf(p, left, "0x%x\n", info->params.num_default_cylinders);
 	return (p - buf);
 }
 
@@ -473,7 +476,7 @@
 		return 0;
 	}
 
-	p += sprintf(p, "0x%x\n", info->params.num_default_heads);
+	p += snprintf(p, left, "0x%x\n", info->params.num_default_heads);
 	return (p - buf);
 }
 
@@ -487,7 +490,7 @@
 		return 0;
 	}
 
-	p += sprintf(p, "0x%x\n", info->params.sectors_per_track);
+	p += snprintf(p, left, "0x%x\n", info->params.sectors_per_track);
 	return (p - buf);
 }
 
@@ -500,7 +503,7 @@
 		return 0;
 	}
 
-	p += sprintf(p, "0x%llx\n", info->params.number_of_sectors);
+	p += snprintf(p, left, "0x%llx\n", info->params.number_of_sectors);
 	return (p - buf);
 }
 
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Wed Oct 23 13:15:30 2002
+++ b/arch/i386/kernel/setup.c	Wed Oct 23 13:15:30 2002
@@ -471,7 +471,8 @@
 unsigned char eddnr;
 struct edd_info edd[EDDNR];
 /**
- * copy_edd() - Copy the BIOS EDD information into a safe place.
+ * copy_edd() - Copy the BIOS EDD information
+ *              from empty_zero_page into a safe place.
  *
  */
 static inline void copy_edd(void)
diff -Nru a/include/asm-i386/edd.h b/include/asm-i386/edd.h
--- a/include/asm-i386/edd.h	Wed Oct 23 13:15:30 2002
+++ b/include/asm-i386/edd.h	Wed Oct 23 13:15:30 2002
@@ -36,6 +36,10 @@
 #define EDDMAXNR 6		/* number of edd_info structs starting at EDDBUF  */
 #define EDDEXTSIZE 4		/* change these if you muck with the structures */
 #define EDDPARMSIZE 74
+#define CHECKEXTENSIONSPRESENT 0x41
+#define GETDEVICEPARAMETERS 0x48
+#define EDDMAGIC1 0x55AA
+#define EDDMAGIC2 0xAA55
 
 #ifndef __ASSEMBLY__
 

===================================================================


This BitKeeper patch contains the following changesets:
1.809
## Wrapped with gzip_uu ##


begin 664 bkpatch19533
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
'%/N:\B$`````
`
end
-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


