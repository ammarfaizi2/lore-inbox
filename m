Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVIAK4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVIAK4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 06:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVIAK4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 06:56:39 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:47248 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S932102AbVIAK4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 06:56:38 -0400
Message-ID: <2373.192.168.201.6.1125572193.squirrel@www.masroudeau.com>
Date: Thu, 1 Sep 2005 11:56:33 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: linux-kernel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@osdl.org>
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: [PATCH 3/4] rm -rf linux/arch/i386/boot  and Gujin bootloader
Content-Type: multipart/mixed;boundary="----=_20050901115633_65135"
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050901115633_65135
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

 This third part is open for debate: it is using some Gujin exported
 variables to search for the root filesystem: Gujin knows from which
 disk/partition it loads the KGZ kernel file - and so the real mode
 kernel function can deduce where is its root if it knows the order
 of the IDE interfaces and the initial name of the kernel at GZIP
 time (either "make /boot/kernel.kgz" or "make /kernel.kgz" with or
 without a separate partition for /boot).

Signed-off-by: Etienne Lorrain <etienne_lorrain@gujin.org>

------=_20050901115633_65135
Content-Type: text/plain; name="patch2613-3"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch2613-3"

diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13-2/arch/i386/kernel/realmode.c linux-2.6.13-3/arch/i386/kernel/realmode.c
--- linux-2.6.13-2/arch/i386/kernel/realmode.c	2005-08-31 00:25:48.000000000 +0100
+++ linux-2.6.13-3/arch/i386/kernel/realmode.c	2005-08-31 00:26:26.000000000 +0100
@@ -1250,11 +1250,569 @@ vmlinuz_CMDLINE (char *command_line, con
 	*cmdptr = '\0';
 }
 
+/**
+ ** OPTIONAL: If we want to use the data structures of Gujin to try to
+ ** find and match the root filesystem of the kernel loaded (that part
+ ** can be completely disabled):
+ **/
+#ifdef ROOT_EXTENSIVE_SEARCH
+
+struct desc_str {
+	unsigned inode;
+	unsigned filesize;
+	unsigned char disk;
+	unsigned char partition;	/* 0xFF for MBR */
+	unsigned char name_offset;	/* to after the pattern */
+        enum curdir_e { inRoot = 0, inSlashBoot, inSlashImage } curdir  : 3;
+        enum boottype_e { is_MBR, is_PBR, is_kernel_with_header,
+		is_kernel_without_header, is_initrd,
+		is_bdi_file, is_el_torito } boottype : 3;
+        unsigned char unused     : 2;
+#define NAME_LENGTH	52
+	char filename[NAME_LENGTH];
+} __attribute__ ((packed));
+
+struct gpl_compliant_str {
+	unsigned signature;
+	unsigned version;
+	unsigned feature;
+	unsigned size;
+	struct setjmp_buf {
+		unsigned esi, edi, ebp, ebx;
+		unsigned short gs, fs, es, ds;
+		unsigned short flags, ip, cs, sp, ss;
+	} __attribute__ ((packed)) jmpbuf;
+	/* unsigned short padding */
+	unsigned filename_array, gdt, regs, fourKbuffer;
+	unsigned LOADER, STATE, UI, MOUSE, DI, UTIL, BOOTWAY;
+};
+
+typedef struct {
+	unsigned char  header_id_0x01;
+	enum { platform_80x86 = 0, platform_PowerPC = 1,
+		platform_Mac = 2 } platform_id : 8;
+	unsigned short reserved;
+	unsigned char  manufacturer[0x1B - 0x04 +1];
+	unsigned short checksum;
+	unsigned char  signature1_0x55;
+	unsigned char  signature2_0xAA;
+} __attribute__ ((packed)) ISO9660_Validation_entry;
+
+typedef struct {
+	unsigned char  boot_indicator; /* 0x88: bootable, 0x00: non bootable */
+	enum { boot_media_noemul = 0, boot_media_120 = 1, boot_media_144 = 2,
+		boot_media_288 = 3, boot_media_hd = 4 } boot_media_type : 8;
+	unsigned short load_segment; /* 0x7c0 if null */
+	unsigned char  system_type;
+	unsigned char  unused;
+	unsigned short sector_count;
+	unsigned       sector_lba;
+	unsigned char  reserved[0x1F - 0x0C +1];
+} __attribute__ ((packed)) ISO9660_Default_entry;
+
+struct diskparam_str {
+	enum {	bios_chs, ebios_lba,
+		hardide_chs, hardide_lba, hardide_lba48, hardide_atapi,
+		dos_part
+	} access : 8;
+	unsigned char	disknb;	/* BIOS number or DOS letter
+				   or 0=master, non zero=slave */
+	unsigned char	biostype;	/* 1:floppy w/o change detect,
+						 2: with, 3: HD */
+	unsigned char	drivetype;	/* 1: 360K, 2: 1.2M, 3: 720K,
+					 4: 1.44M, 6: 2.88M, 0x10: ATAPI */
+	unsigned char	diskname[32];
+
+	struct ide_attribute_str {
+		unsigned smart			: 1;
+		unsigned host_protected_area	: 1;
+		unsigned security		: 1;
+		unsigned lba48			: 1;
+		unsigned removable		: 1;
+		unsigned SAORAB			: 1;
+		unsigned config_overlay		: 1;
+		unsigned reserved		: 25;
+	} ide_attribute;
+	struct error_log_str {
+		unsigned read_media			: 1;
+		unsigned write_media			: 1;
+		unsigned access_over_disk_tryed		: 1;
+		unsigned access_over_partition_tryed	: 1;
+		unsigned no_ebios_fct			: 1;
+		unsigned ebios_size_zero		: 1;
+		unsigned chs_bios_part_mismatch		: 1;
+		unsigned chs_ajusted_bootsect		: 1;
+		unsigned diskheader_ignored		: 1;
+		unsigned disk_locked			: 1;
+		unsigned disk_was_pw_locked		: 1;
+		unsigned SMART_disabled			: 1;
+		unsigned SMART_failure			: 1;
+		unsigned analyse_partition_failed	: 1;
+		unsigned NB_PARTITION_exceded		: 1;
+		unsigned partition_overlap		: 1;
+		unsigned partition_over_limit		: 1;
+		unsigned beer_checksum_error		: 1;
+		unsigned beer_in_extended_partition	: 1;
+		unsigned reserved			: 13;
+	} error_log;
+	unsigned short	bytepersector;
+	unsigned short	nbhead;		  /* DOS: MediaDescriptorByte */
+	unsigned	nbcylinder;       /* DOS: ClustersOnDisk */
+	unsigned	BEER_size;
+	unsigned long long	BEER_sector;
+	unsigned long long	BEER_HostProtectedArea_start;
+	unsigned long long	BEER_ReservedAreaBootCodeAddress;
+	unsigned long long	BEER_disksize;
+	  signed long long	fulldisk_offset; /* Nb sectors before MBR */
+	unsigned long long	fulldisk_size;	 /* only if MBR is offseted */
+	unsigned long long	nbtotalsector;
+	unsigned long long	config_max_lba;
+	unsigned short	nbsectorpertrack; /* DOS: SectorPerCluster */
+
+	unsigned short	infobit;	/* Int13/48 extensions */
+	unsigned char	ebios_version;	/* if present, used if access = ebios */
+	unsigned char	ebios_extension;
+	ebios_bitmap_t	ebios_bitmap;
+	unsigned short	reserved3;	/* ebios_bitmap is 16 bits */
+
+	unsigned char  ebios_bustype[4];	/* exactly "ISA" or "PCI" */
+	unsigned char  ebios_Interface[8];	/* exactly "ATA", "ATAPI",
+							"SCSI", "USB"...*/
+	union interface_path_u	ebios_bus;
+	union device_path_u	ebios_device;
+
+	unsigned short	reserved4;
+
+	unsigned short	ide_master_password_revision; /* if command_supported1.security */
+	unsigned short	ideIOadr;	/* if known, else 0 */
+	unsigned short	ideIOctrladr;	/* if known, else 0 */
+	unsigned char	lba_slave_mask;	/* see Phenix Bios (head | mask) */
+	unsigned char	irq;		/* if known, else 0 */
+	unsigned char	multiplemode;	/* int 0x13/0x21,0x22,0x24 or hardide,
+						set but not used. */
+	unsigned char	BEER_device_index;
+	struct config_multiword_dma_s {
+		unsigned short	mode0    : 1;
+		unsigned short	mode1    : 1; /* and below */
+		unsigned short	mode2    : 1; /* and below */
+		unsigned short	reserved : 13;
+	} __attribute__ ((packed)) initial_multiDMA, maximum_multiDMA;
+	struct config_ultra_dma_s {
+		unsigned short	mode0    : 1;
+		unsigned short	mode1    : 1; /* and below */
+		unsigned short	mode2    : 1; /* and below */
+		unsigned short	mode3    : 1; /* and below */
+		unsigned short	mode4    : 1; /* and below */
+		unsigned short	mode5    : 1; /* and below */
+		unsigned short	reserved : 10;
+	} __attribute__ ((packed)) initial_ultraDMA, maximum_ultraDMA;
+	struct config_feature_s {
+		unsigned short	smart_feature	: 1;
+		unsigned short	smart_selftest	: 1;
+		unsigned short	smart_errorlog	: 1;
+		unsigned short	security	: 1;
+		unsigned short	standby_powerup	: 1;
+		unsigned short	RW_DMA_queued	: 1;
+		unsigned short	acoustic	: 1;
+		unsigned short	host_prot_area	: 1;
+		unsigned short	lba48		: 1;
+		unsigned short	reserved	: 7;
+	} __attribute__ ((packed)) initial_feature, maximum_feature;
+	unsigned	CalibrationIdeloop; /* nanoseconds (10^-9) per loop */
+
+	/* Following three only for C/H/S partition, from standard BIOS: */
+	unsigned short	bios_nbcylinder;	/* max 1024 */
+	unsigned char	bios_nbhead;		/* max 256 */
+	unsigned char	bios_nbsectorpertrack;	/* max 63 */
+
+	unsigned char	bootable;	/* nonzero: bootable,
+				 > 1 when special bootsector recognised */
+	unsigned char	OSdisknumber;	/* as written in the boot block */
+
+	unsigned short	nbpartition;
+	unsigned short	nbOSnumber;
+	unsigned short	reserved5;
+	/* Following value is current extended primary partition,
+	   if there is more than one extended primary partition. */
+	union {
+		unsigned    first_ext_partition_start; /* NOT A LONG LONG */
+		ISO9660_Validation_entry *ElToritoValidation; /* first one only */
+		ISO9660_Default_entry *ElToritoCatalog; /* array index >= 1 */
+	};
+	struct partition_str {
+		unsigned long long	start, length;
+		/* OSnumber should be equal to the # in /dev/hda#: */
+		unsigned char	type, OSnumber;
+		struct partition_misc_str {
+			/* order as found on disk: */
+			unsigned char order		: 6;
+			unsigned char fsanalyse_toobig	: 1;
+			unsigned char fsanalyse_error	: 1;
+			unsigned char maybe_root	: 1;
+			unsigned char fat_bootable	: 1;
+			unsigned char beer_partition	: 1;
+			unsigned char swap_partition	: 1;
+			unsigned char reserved		: 2;
+			enum part_state {
+				part_invalid = 0, part_active,
+				part_inactive, part_extended
+			} active		: 2;
+		} __attribute__ ((packed)) misc;
+#define MAX_DISKNAMESIZE	(64-20) /* bigger than "floppy" */
+		unsigned char	name[MAX_DISKNAMESIZE];
+	} __attribute__ ((packed)) *partition;
+
+	unsigned	nbfreelist;
+	struct freelist_str {
+		unsigned long long start, length;
+	} *freelist;
+	char set_max_password[32];
+	} *param;
+
+struct disk_interface_str {
+	unsigned	nbdisk;
+	unsigned char	max_disk, max_partition, max_freelist, max_IDE_found;
+	unsigned short	sizeof_diskparam_str, sizeof_partition_str;
+	unsigned short	sizeof_freelist_str, sizeof_IDE_found_str;
+	unsigned char	nb_bios_fd, nb_bios_hd, cannot_reset_floppy,
+			nb_bios_blacklist;
+	unsigned char	bios_blacklist[4];
+	unsigned	reserved1[2];
+	unsigned char	(*readsector) (struct diskparam_str *dp, int partition,
+				unsigned long long lba, unsigned number,
+				farptr buffer);
+	unsigned char	(*writesector) (struct diskparam_str *dp, int partition,
+				unsigned long long lba, unsigned number,
+				farptr buffer);
+	int		(*ideSecurity) (struct diskparam_str *, char *,
+					 unsigned);
+	unsigned long long last_lba_read_or_write;
+	struct diskparam_str *param;
+	unsigned	nb_IDE_found;
+	struct IDE_found_str {
+		unsigned short	ideIOadr;
+		unsigned short	ideIOctrladr;
+		unsigned char	irq;
+		unsigned char	bios_order;
+		unsigned short	reserved;
+	} *IDE_found;
+};
+
+CODE static inline int
+add_hexletter (unsigned short *val, unsigned char hexletter)
+{
+	if (hexletter >= '0' && hexletter <= '9')
+		*val = (*val << 4) + hexletter - '0';
+	else if (hexletter >= 'a' && hexletter <= 'f')
+		*val = (*val << 4) + hexletter - 'a' + 10;
+	else if (hexletter >= 'A' && hexletter <= 'F')
+		*val = (*val << 4) + hexletter - 'A' + 10;
+	else
+		return 1;
+	return 0;
+}
+
+/* If the "ide[0-9]=" are already given on the command line, that may
+   indicate the user wants a special order - and we probe that order
+   to guess the root partition: */
+CODE static inline void
+init_IDE_found_from_cmdline (struct IDE_found_str *IDE_found,
+		const unsigned nb_IDE_found, const char *cmdptr)
+{
+	while (*cmdptr) {
+		if (cmdptr[0] == 'i' && cmdptr[1] == 'd' && cmdptr[2] == 'e'
+			&& cmdptr[3] >= '0' && cmdptr[3] <= '9'
+			&& cmdptr[4] == '='
+			&& cmdptr[5] == '0' && cmdptr[6] == 'x') {
+			unsigned short IOaddr = 0, IOctrladr = 0;
+			unsigned short index = cmdptr[3] - '0';
+			unsigned char irq = 0;
+
+			cmdptr += 7;
+			while (add_hexletter (&IOaddr, *cmdptr) == 0)
+				cmdptr++;
+			/* Why did you read up to here? Don't you trust me? */
+			if (cmdptr[0] == ',' && cmdptr[1] == '0'
+					     && cmdptr[2] == 'x') {
+				cmdptr += 3;
+				while (add_hexletter (&IOctrladr, *cmdptr) == 0)
+					cmdptr++;
+				if (*cmdptr == ',') {
+					cmdptr++;
+					while (*cmdptr >= '0' && *cmdptr <= '9')
+						irq = (irq * 10) + *cmdptr++ - '0';
+				}
+			}
+
+			/* first unknown char shall be spacing or end of string */
+			if (   (*cmdptr == ' ' || *cmdptr == '\0')
+			    && index < nb_IDE_found)
+				IDE_found[index] = (struct IDE_found_str) {
+					.ideIOadr	= IOaddr,
+					.ideIOctrladr	= IOctrladr,
+					.irq		= irq,
+					.bios_order	= 0xFF,
+					.reserved	= 0
+					};
+		}
+		else
+			cmdptr++;
+	}
+}
+
+/* If no "ide[0-9]=" given, we use the BIOS order found by Gujin;
+  if Gujin knows more IDEs (just one ide added like: ide2=0x...
+  but not ide0= and ide1=) add the obvious missing ones,
+  without erasing nor offseting the user given information: */
+CODE static inline void
+init_IDE_found_from_DI (struct IDE_found_str *IDE_found,
+		const unsigned nb_IDE_found,
+		const struct disk_interface_str *DI)
+{
+	unsigned cpt;
+
+	for (cpt = 0; cpt < DI->nb_IDE_found; cpt++) {
+		unsigned i, j;
+		for (i = 0; i < nb_IDE_found; i++)
+			if (IDE_found[i].ideIOadr == DI->IDE_found[cpt].ideIOadr)
+				break;
+		if (i < nb_IDE_found)
+			continue; /* already given */
+		for (j = 0; j < nb_IDE_found; j++)
+			if (IDE_found[j].ideIOadr == 0)
+				break; /* first unused */
+		if (j < nb_IDE_found)
+			IDE_found[j] = DI->IDE_found[cpt];
+	}
+}
+
+CODE static inline void
+finalise_cmdline (struct IDE_found_str *IDE_found, unsigned nb_IDE_found,
+		  char *command_line)
+{
+	static CONST char itoa_array[] = "0123456789abcdef";
+	unsigned cpt;
+	char *cmdptr = command_line;
+
+	while (*cmdptr != '\0')
+		cmdptr++;
+	for (cpt = 0; cpt < nb_IDE_found; cpt++) {
+		unsigned short val;
+		if (   IDE_found[cpt].ideIOadr == 0
+		    || IDE_found[cpt].bios_order == 0xFF)
+			continue;
+		if (cmdptr - command_line > 1024)
+			break;
+		*cmdptr++ = ' ';
+		*cmdptr++ = 'i'; *cmdptr++ = 'd'; *cmdptr++ = 'e';
+		*cmdptr++ = '0' + cpt;
+		*cmdptr++ = '='; *cmdptr++ = '0'; *cmdptr++ = 'x';
+		val = IDE_found[cpt].ideIOadr;
+		if (val & 0xF000)
+			*cmdptr++ = itoa_array[val >> 12];
+		*cmdptr++ = itoa_array[(val >> 8) & 0x0F];
+		*cmdptr++ = itoa_array[(val >> 4) & 0x0F];
+		*cmdptr++ = itoa_array[(val >> 0) & 0x0F];
+		val = IDE_found[cpt].ideIOctrladr;
+		if (val) {
+			*cmdptr++ = ',';
+			*cmdptr++ = '0';
+			*cmdptr++ = 'x';
+			if (val & 0xF000)
+				*cmdptr++ = itoa_array[val >> 12];
+			*cmdptr++ = itoa_array[(val >> 8) & 0x0F];
+			*cmdptr++ = itoa_array[(val >> 4) & 0x0F];
+			*cmdptr++ = itoa_array[(val >> 0) & 0x0F];
+			val = IDE_found[cpt].irq; /* < 100 */
+			if (val) {
+				*cmdptr++ = ',';
+				*cmdptr++ = itoa_array[val / 10];
+				*cmdptr++ = itoa_array[val % 10];
+			}
+		}
+		*cmdptr = '\0';
+	}
+}
+
+/* root= parameter not present, set it depending on system_desc->disk,
+   system_desc->partition and the number of slash in the kernel name as
+   found in the GZIP name field.
+   Note that we assume that IF the kernel file loaded was in the top
+   directory AND the partition size is too small, it is a "/boot"
+   partition and the real root is the NEXT partition of type 0x83 if it exists.
+   Gujin prefers a lot having only one root partition containning everything
+   including "/boot", but try to stay compatible. */
+CODE static inline void
+add_root_parameter (const struct desc_str *system_desc, char *cmdptr,
+			const struct IDE_found_str IDE_found[10],
+			const unsigned nb_IDE_found,
+			const struct disk_interface_str *DI,
+			const unsigned nb_slash_in_kernelname)
+ {
+	const struct diskparam_str *const dp = &DI->param[system_desc->disk];
+	const unsigned min_part_size = 640 * 1024 * 1024 / dp->bytepersector;
+	unsigned OSnumber = dp->partition[system_desc->partition].OSnumber;
+	static CONST char root_pattern[] = " root=/dev/";
+
+	if (   system_desc->curdir == inRoot
+	    && nb_slash_in_kernelname != 1 /* not really created in root dir */
+	    && dp->partition[system_desc->partition].length < min_part_size) {
+		/* find the next bigger 0x83 partition on same disk: */
+		unsigned partition;
+		for (partition = system_desc->partition;
+		    partition < dp->nbpartition;
+		    partition++)
+			if (   dp->partition[partition].length > min_part_size
+			    && dp->partition[partition].type == 0x83) {
+				OSnumber = dp->partition[partition].OSnumber;
+				break;
+			}
+	}
+
+	if (dp->ideIOadr != 0) {
+		/* seriously looks like an IDE disk, isn't it? */
+		unsigned cptide;
+		for (cptide = 0; cptide < nb_IDE_found; cptide++)
+			if (dp->ideIOadr == IDE_found[cptide].ideIOadr)
+				break;
+		if (cptide < nb_IDE_found) {
+			const char *ptr = root_pattern;
+			while (*ptr)
+				*cmdptr++ = *ptr++;
+			*cmdptr++ = 'h';
+			*cmdptr++ = 'd';
+			*cmdptr++ = 'a' + 2 * cptide + !!(dp->lba_slave_mask & 0x10);
+			*cmdptr++ = '0' + OSnumber;
+			*cmdptr = '\0';
+		}
+	} else {
+		/* count number of [E]BIOS hard disks and compare to the
+		number of IDE hard disk to know if there are SCSI disks: */
+		unsigned cpt_bios_disk = 0, cpt_ide_disk = 0, cptdisk;
+		unsigned char maybe_scsi = 0;
+		const char *ptr = root_pattern;
+
+		for (cptdisk = 0; cptdisk < DI->nbdisk; cptdisk++) {
+			if (  DI->param[cptdisk].access == bios_chs
+			   || DI->param[cptdisk].access == ebios_lba) {
+				if (DI->param[cptdisk].disknb >= 0x80) {
+					cpt_bios_disk++;
+					if (DI->param[cptdisk].ideIOadr == 0)
+						maybe_scsi = 1;
+				} /* else floppy disk */
+			}
+			else if (DI->param[cptdisk].access == hardide_chs
+			    || DI->param[cptdisk].access == hardide_lba
+			    || DI->param[cptdisk].access == hardide_lba48)
+				cpt_ide_disk++; /* not CDROM, not empty IDE */
+		}
+		while (*ptr)
+			*cmdptr++ = *ptr++;
+		/* If we have the same amount or less BIOS disks than IDE
+		disks, we assume we have a normal (or a very old w/o EBIOS) PC
+		without SCSI or USB drives, then assume BIOS mapping like
+		IDE mapping: 0x80 master on IDE0; else we assume all SCSI
+		drives are after the BIOS/IDE drives: */
+		if (maybe_scsi != 0 && cpt_bios_disk > cpt_ide_disk
+			&& dp->disknb >= 0x80 + cpt_bios_disk)
+			*cmdptr++ = 's';
+		else {
+			cpt_bios_disk = 0; /* no sda to hda correction */
+			*cmdptr++ = 'h';
+		}
+		*cmdptr++ = 'd';
+		/* If bootsector OSdisknumber initialised to something
+			else than 0 or 0x80, we assume the user forced
+			it and use that value ('a' for number 0x80): */
+		if ((dp->OSdisknumber & 0x7F) != 0)
+			*cmdptr++ = 'a' + (dp->OSdisknumber & 0x7F);
+		else
+			*cmdptr++ = 'a' + dp->disknb - 0x80 - cpt_bios_disk;
+		*cmdptr++ = '0' + OSnumber;
+		*cmdptr = '\0';
+	}
+}
+
+CODE static void
+vmlinuz_ROOT (const struct desc_str *system_desc,
+	      const struct gpl_compliant_str *togpl,
+	      char *command_line, unsigned nb_slash_in_kernelname)
+{
+	struct IDE_found_str IDE_found[10] = {};
+	const struct disk_interface_str *DI =
+		 (const struct disk_interface_str *)togpl->DI;
+	char *cmdptr;
+
+#if 0
+	DBG("togpl = 0x", (unsigned)togpl, ": ");
+	DBG("signature = 0x", togpl->signature, ", ");
+	DBG("version = 0x", togpl->version, ", ");
+	DBG("feature = 0x", togpl->feature, ", ");
+	DBG("size = 0x", togpl->size, ", ");
+	DBG("offsetof(struct gpl_compliant_str, DI) + 4 = 0x",
+		 offsetof(struct gpl_compliant_str, DI) + 4, "\r\n");
+	DBG_WAIT();
+#endif
+
+	if (togpl == 0 || togpl->signature != 16980327
+	    || (togpl->version >> 8) != 1 || (togpl->feature & 1) == 0
+	    || togpl->size <= offsetof(struct gpl_compliant_str, DI) + 4)
+		return;
+
+	init_IDE_found_from_cmdline (IDE_found,
+		sizeof(IDE_found)/sizeof(IDE_found[0]), command_line);
+	init_IDE_found_from_DI (IDE_found,
+		sizeof(IDE_found)/sizeof(IDE_found[0]), DI);
+
+#if 0
+	{
+	unsigned cpt;
+
+	for (cpt = 0; cpt < sizeof(IDE_found)/sizeof(IDE_found[0]); cpt++) {
+		DBG("IDE_found[cpt = 0x", cpt, "] : ");
+		DBG("ideIOadr = 0x", IDE_found[cpt].ideIOadr, ", ");
+		DBG("ideIOctrladr = 0x", IDE_found[cpt].ideIOctrladr, ", ");
+		DBG("irq = 0x", IDE_found[cpt].irq, ", ");
+		DBG("bios_order = 0x", IDE_found[cpt].bios_order, "\r\n");
+		}
+	DBG_WAIT();
+	}
+#endif
+
+	/* If "root=" is given, do not try to guess it: */
+	for (cmdptr = command_line; *cmdptr != '\0'; cmdptr++)
+		if (cmdptr[0] == 'r' && cmdptr[1] == 'o' && cmdptr[2] == 'o'
+			&& cmdptr[3] == 't' && cmdptr[4] == '=')
+			break;
+
+	/* sizeof struct diskparam_str 256, sizeof struct partition_str 64 */
+	if (*cmdptr == '\0'
+	    && sizeof (struct diskparam_str) == DI->sizeof_diskparam_str
+	    && sizeof (struct partition_str) == DI->sizeof_partition_str
+	    && DI->param[system_desc->disk].bytepersector != 0)
+		add_root_parameter (system_desc, cmdptr, IDE_found,
+				sizeof(IDE_found)/sizeof(IDE_found[0]),
+				DI, nb_slash_in_kernelname);
+
+	/* Add this after "root=", limited command line length */
+	finalise_cmdline (IDE_found,
+		sizeof(IDE_found)/sizeof(IDE_found[0]), command_line);
+}
+
+#else	/* ROOT_EXTENSIVE_SEARCH */
+
 struct desc_str;
 struct gpl_compliant_str;
+#define vmlinuz_ROOT(a, b, c, d)	/* nothing */
+
+#endif	/* ROOT_EXTENSIVE_SEARCH */
 
 CODE static inline void
-vmlinuz_DISKS (union drive_info *drive1, union drive_info *drive2)
+vmlinuz_DISKS (union drive_info *drive1, union drive_info *drive2
+#ifdef ROOT_EXTENSIVE_SEARCH
+		, const struct disk_interface_str *DI
+#endif
+		)
 {
 	unsigned nbsect;
 	unsigned char status, disk = 0x80;
@@ -1262,6 +1820,18 @@ vmlinuz_DISKS (union drive_info *drive1,
 	farptr vectoradr = (farptr)(0x41 * 4);
 
 	while (disk <= 0x81) {
+#ifdef ROOT_EXTENSIVE_SEARCH
+		/* Some old and common SCSI card will do an invalid
+		instruction exception in _BIOSDISK_gettype, if the
+		BIOS has not been updated */
+		int cpt;
+		for (cpt = 0; cpt < DI->nb_bios_blacklist; cpt++)
+			if (DI->bios_blacklist[cpt] == disk)
+				break;
+		if (cpt < DI->nb_bios_blacklist)
+			continue;
+#endif
+
 		if (_BIOSDISK_gettype (disk, &nbsect, &status) == 0)
 			*drive = get_drive_info (vectoradr);
 		disk++;
@@ -1366,7 +1936,11 @@ linux_set_params (unsigned local_return_
 	vmlinuz_APM (&LnxParam->apm_bios_info);
 
 	LnxParam->X86SpeedStepSmi = _X86SpeedStepSmi();
-	vmlinuz_DISKS (&LnxParam->drive1, &LnxParam->drive2);
+	vmlinuz_DISKS (&LnxParam->drive1, &LnxParam->drive2
+#ifdef ROOT_EXTENSIVE_SEARCH
+			, (const struct disk_interface_str *)togpl->DI
+#endif
+			);
 	vmlinuz_CONFIG (&LnxParam->sys_desc_table);
 	/* do vmlinuz_EDID() before vmlinuz_E820() so that if the later
 	 function describes more than 18 (and less than 32) blocks of memory,
@@ -1417,6 +1991,8 @@ linux_set_params (unsigned local_return_
 		     ptr++)
 			if (*ptr == '/')
 				nb_slash_in_kernelname++;
+	vmlinuz_ROOT (system_desc, togpl, LnxParam->command_line,
+			nb_slash_in_kernelname);
 
 	test_vgaprint();
 
diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13-2/include/asm-i386/realmode.h linux-2.6.13-3/include/asm-i386/realmode.h
--- linux-2.6.13-2/include/asm-i386/realmode.h	2005-08-31 00:25:48.000000000 +0100
+++ linux-2.6.13-3/include/asm-i386/realmode.h	2005-08-31 00:26:26.000000000 +0100
@@ -9,6 +9,10 @@
  * loosing the EDD and EDID infomation which moved in Linux-2.6.12
  */
 
+/* try really hard to figure out the root filesystem when not given
+   on command line, uses Gujin data structures (GPL kernel) */
+#define ROOT_EXTENSIVE_SEARCH
+
 /* 16 bits segment in MSB, 16 bits offset in LSB: */
 typedef unsigned farptr;
 
diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13-2/Makefile linux-2.6.13-3/Makefile
--- linux-2.6.13-2/Makefile	2005-08-31 00:25:48.000000000 +0100
+++ linux-2.6.13-3/Makefile	2005-08-31 00:26:26.000000000 +0100
@@ -1106,7 +1106,8 @@ help:
 	@echo  'Other generic targets:'
 	@echo  '  all		  - Build all targets marked with [*]'
 	@echo  '* vmlinux	  - Build the bare kernel'
-	@echo  '  /boot/linux.kgz ROOT=/dev/hda1   - replace "hda1" with your root filesystem'
+	@echo  "  /boot/linux-$(KERNELRELEASE).kgz - create a boot kernel for the Gujin bootloader"
+	@echo  '  /boot/linux.kgz ROOT=/dev/hda1   - do not autodetect root filesystem at boot time'
 	@echo  '  /boot/linux.kgz ROOT=auto        - root filesystem from current /proc/cmdline'
 	@echo  '* modules	  - Build all modules'
 	@echo  '  modules_install - Install all modules'
------=_20050901115633_65135--


