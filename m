Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266032AbSKCXP1>; Sun, 3 Nov 2002 18:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266033AbSKCXP0>; Sun, 3 Nov 2002 18:15:26 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:7345 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S266032AbSKCXOx>; Sun, 3 Nov 2002 18:14:53 -0500
Message-ID: <3DC5AF6F.1070702@quark.didntduck.org>
Date: Sun, 03 Nov 2002 18:21:19 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cleanup bitfield endianess mess
Content-Type: multipart/mixed;
 boundary="------------090203010707060105070304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090203010707060105070304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch defines new BITFIELDx macros to clean up the #ifdef mess with 
bitfields, and starts the conversion off with the IDE/ATAPI files.

--
				Brian Gerst

--------------090203010707060105070304
Content-Type: text/plain;
 name="bitfield-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bitfield-1"

diff -urN linux-2.5.45-bk1/drivers/atm/fore200e.h linux/drivers/atm/fore200e.h
--- linux-2.5.45-bk1/drivers/atm/fore200e.h	Sun Sep 15 22:18:30 2002
+++ linux/drivers/atm/fore200e.h	Sun Nov  3 10:02:57 2002
@@ -64,24 +64,6 @@
 #define FORE200E_DEV(d)          ((struct fore200e*)((d)->dev_data))
 #define FORE200E_VCC(d)          ((struct fore200e_vcc*)((d)->dev_data))
 
-/* bitfields endian games */
-
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-#define BITFIELD2(b1, b2)                    b1; b2;
-#define BITFIELD3(b1, b2, b3)                b1; b2; b3;
-#define BITFIELD4(b1, b2, b3, b4)            b1; b2; b3; b4;
-#define BITFIELD5(b1, b2, b3, b4, b5)        b1; b2; b3; b4; b5;
-#define BITFIELD6(b1, b2, b3, b4, b5, b6)    b1; b2; b3; b4; b5; b6;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-#define BITFIELD2(b1, b2)                                    b2; b1;
-#define BITFIELD3(b1, b2, b3)                            b3; b2; b1;
-#define BITFIELD4(b1, b2, b3, b4)                    b4; b3; b2; b1;
-#define BITFIELD5(b1, b2, b3, b4, b5)            b5; b4; b3; b2; b1;
-#define BITFIELD6(b1, b2, b3, b4, b5, b6)    b6; b5; b4; b3; b2; b1;
-#else
-#error unknown bitfield endianess
-#endif
-
  
 /* ATM cell header (minus HEC byte) */
 
diff -urN linux-2.5.45-bk1/drivers/ide/ide-cd.h linux/drivers/ide/ide-cd.h
--- linux-2.5.45-bk1/drivers/ide/ide-cd.h	Wed Oct 16 01:30:48 2002
+++ linux/drivers/ide/ide-cd.h	Sun Nov  3 11:58:37 2002
@@ -125,15 +125,10 @@
 
 struct atapi_toc_entry {
 	byte reserved1;
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 adr     : 4;
-	__u8 control : 4;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 control : 4;
-	__u8 adr     : 4;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD(
+		__u8 control : 4,
+		__u8 adr     : 4
+	)
 	byte track;
 	byte reserved2;
 	union {
@@ -159,16 +154,10 @@
  	u_char  acdsc_audiostatus;
  	u_short acdsc_length;
 	u_char  acdsc_format;
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	u_char  acdsc_ctrl:     4;
-	u_char  acdsc_adr:      4;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	u_char  acdsc_adr:	4;
-	u_char  acdsc_ctrl:	4;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD2(
+		u_char  acdsc_adr:	4,
+		u_char  acdsc_ctrl:	4
+	)
 	u_char  acdsc_trk;
 	u_char  acdsc_ind;
 	union {
@@ -188,207 +177,106 @@
  */
 struct atapi_capabilities_page {
 	struct mode_page_header header;
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 parameters_saveable : 1;
-	__u8 reserved1           : 1;
-	__u8 page_code           : 6;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 page_code           : 6;
-	__u8 reserved1           : 1;
-	__u8 parameters_saveable : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD3(
+		__u8 page_code           : 6,
+		__u8 reserved1           : 1,
+		__u8 parameters_saveable : 1
+	)
 
 	byte     page_length;
 
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved2           : 2;
-	/* Drive supports reading of DVD-RAM discs */
-	__u8 dvd_ram_read        : 1;
-	/* Drive supports reading of DVD-R discs */
-	__u8 dvd_r_read          : 1;
-	/* Drive supports reading of DVD-ROM discs */
-	__u8 dvd_rom             : 1;
-	/* Drive supports reading CD-R discs with addressing method 2 */
-	__u8 method2             : 1; /* reserved in 1.2 */
-	/* Drive can read from CD-R/W (CD-E) discs (orange book, part III) */
-	__u8 cd_rw_read		 : 1; /* reserved in 1.2 */
-	/* Drive supports read from CD-R discs (orange book, part II) */
-	__u8 cd_r_read           : 1; /* reserved in 1.2 */
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	/* Drive supports read from CD-R discs (orange book, part II) */
-	__u8 cd_r_read           : 1; /* reserved in 1.2 */
-	/* Drive can read from CD-R/W (CD-E) discs (orange book, part III) */
-	__u8 cd_rw_read          : 1; /* reserved in 1.2 */
-	/* Drive supports reading CD-R discs with addressing method 2 */
-	__u8 method2             : 1;
-	/* Drive supports reading of DVD-ROM discs */
-	__u8 dvd_rom             : 1;
-	/* Drive supports reading of DVD-R discs */
-	__u8 dvd_r_read          : 1;
-	/* Drive supports reading of DVD-RAM discs */
-	__u8 dvd_ram_read        : 1;
-	__u8 reserved2		 : 2;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved3           : 2;
-	/* Drive can write DVD-RAM discs */
-	__u8 dvd_ram_write       : 1;
-	/* Drive can write DVD-R discs */
-	__u8 dvd_r_write         : 1;
-	__u8 reserved3a          : 1;
-	/* Drive can fake writes */
-	__u8 test_write          : 1;
-	/* Drive can write to CD-R/W (CD-E) discs (orange book, part III) */
-	__u8 cd_rw_write	 : 1; /* reserved in 1.2 */
-	/* Drive supports write to CD-R discs (orange book, part II) */
-	__u8 cd_r_write          : 1; /* reserved in 1.2 */
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	/* Drive can write to CD-R discs (orange book, part II) */
-	__u8 cd_r_write          : 1; /* reserved in 1.2 */
-	/* Drive can write to CD-R/W (CD-E) discs (orange book, part III) */
-	__u8 cd_rw_write	 : 1; /* reserved in 1.2 */
-	/* Drive can fake writes */
-	__u8 test_write          : 1;
-	__u8 reserved3a          : 1;
-	/* Drive can write DVD-R discs */
-	__u8 dvd_r_write         : 1;
-	/* Drive can write DVD-RAM discs */
-	__u8 dvd_ram_write       : 1;
-	__u8 reserved3           : 2;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved4           : 1;
-	/* Drive can read multisession discs. */
-	__u8 multisession        : 1;
-	/* Drive can read mode 2, form 2 data. */
-	__u8 mode2_form2         : 1;
-	/* Drive can read mode 2, form 1 (XA) data. */
-	__u8 mode2_form1         : 1;
-	/* Drive supports digital output on port 2. */
-	__u8 digport2            : 1;
-	/* Drive supports digital output on port 1. */
-	__u8 digport1            : 1;
-	/* Drive can deliver a composite audio/video data stream. */
-	__u8 composite           : 1;
-	/* Drive supports audio play operations. */
-	__u8 audio_play          : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	/* Drive supports audio play operations. */
-	__u8 audio_play          : 1;
-	/* Drive can deliver a composite audio/video data stream. */
-	__u8 composite           : 1;
-	/* Drive supports digital output on port 1. */
-	__u8 digport1            : 1;
-	/* Drive supports digital output on port 2. */
-	__u8 digport2            : 1;
-	/* Drive can read mode 2, form 1 (XA) data. */
-	__u8 mode2_form1         : 1;
-	/* Drive can read mode 2, form 2 data. */
-	__u8 mode2_form2         : 1;
-	/* Drive can read multisession discs. */
-	__u8 multisession        : 1;
-	__u8 reserved4           : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved5           : 1;
-	/* Drive can return Media Catalog Number (UPC) info. */
-	__u8 upc                 : 1;
-	/* Drive can return International Standard Recording Code info. */
-	__u8 isrc                : 1;
-	/* Drive supports C2 error pointers. */
-	__u8 c2_pointers         : 1;
-	/* R-W data will be returned deinterleaved and error corrected. */
-	__u8 rw_corr             : 1;
-	/* Subchannel reads can return combined R-W information. */
-	__u8 rw_supported        : 1;
-	/* Drive can continue a read cdda operation from a loss of streaming.*/
-	__u8 cdda_accurate       : 1;
-	/* Drive can read Red Book audio data. */
-	__u8 cdda                : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	/* Drive can read Red Book audio data. */
-	__u8 cdda                : 1;
-	/* Drive can continue a read cdda operation from a loss of streaming.*/
-	__u8 cdda_accurate       : 1;
-	/* Subchannel reads can return combined R-W information. */
-	__u8 rw_supported        : 1;
-	/* R-W data will be returned deinterleaved and error corrected. */
-	__u8 rw_corr             : 1;
-	/* Drive supports C2 error pointers. */
-	__u8 c2_pointers         : 1;
-	/* Drive can return International Standard Recording Code info. */
-	__u8 isrc                : 1;
-	/* Drive can return Media Catalog Number (UPC) info. */
-	__u8 upc                 : 1;
-	__u8 reserved5           : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	/* Drive mechanism types. */
-	mechtype_t mechtype	 : 3;
-	__u8 reserved6           : 1;
-	/* Drive can eject a disc or changer cartridge. */
-	__u8 eject               : 1;
-	/* State of prevent/allow jumper. */
-	__u8 prevent_jumper      : 1;
-	/* Present state of door lock. */
-	__u8 lock_state          : 1;
-	/* Drive can lock the door. */
-	__u8 lock                : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-
-	/* Drive can lock the door. */
-	__u8 lock                : 1;
-	/* Present state of door lock. */
-	__u8 lock_state          : 1;
-	/* State of prevent/allow jumper. */
-	__u8 prevent_jumper      : 1;
-	/* Drive can eject a disc or changer cartridge. */
-	__u8 eject               : 1;
-	__u8 reserved6           : 1;
-	/* Drive mechanism types. */
-	mechtype_t mechtype	 : 3;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved7           : 4;
-	/* Drive supports software slot selection. */
-	__u8 sss                 : 1;  /* reserved in 1.2 */
-	/* Changer can report exact contents of slots. */
-	__u8 disc_present        : 1;  /* reserved in 1.2 */
-	/* Audio for each channel can be muted independently. */
-	__u8 separate_mute       : 1;
-	/* Audio level for each channel can be controlled independently. */
-	__u8 separate_volume     : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-
-	/* Audio level for each channel can be controlled independently. */
-	__u8 separate_volume     : 1;
-	/* Audio for each channel can be muted independently. */
-	__u8 separate_mute       : 1;
-	/* Changer can report exact contents of slots. */
-	__u8 disc_present        : 1;  /* reserved in 1.2 */
-	/* Drive supports software slot selection. */
-	__u8 sss                 : 1;  /* reserved in 1.2 */
-	__u8 reserved7           : 4;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD7(
+		/* Drive supports read from CD-R discs (orange book, part II) */
+		__u8 cd_r_read           : 1, /* reserved in 1.2 */
+		/* Drive can read from CD-R/W (CD-E) discs (orange book, part III) */
+		__u8 cd_rw_read          : 1, /* reserved in 1.2 */
+		/* Drive supports reading CD-R discs with addressing method 2 */
+		__u8 method2             : 1,
+		/* Drive supports reading of DVD-ROM discs */
+		__u8 dvd_rom             : 1,
+		/* Drive supports reading of DVD-R discs */
+		__u8 dvd_r_read          : 1,
+		/* Drive supports reading of DVD-RAM discs */
+		__u8 dvd_ram_read        : 1,
+		__u8 reserved2		 : 2
+	)
+
+	BITFIELD7(
+		/* Drive can write to CD-R discs (orange book, part II) */
+		__u8 cd_r_write          : 1, /* reserved in 1.2 */
+		/* Drive can write to CD-R/W (CD-E) discs (orange book, part III) */
+		__u8 cd_rw_write	 : 1, /* reserved in 1.2 */
+		/* Drive can fake writes */
+		__u8 test_write          : 1,
+		__u8 reserved3a          : 1,
+		/* Drive can write DVD-R discs */
+		__u8 dvd_r_write         : 1,
+		/* Drive can write DVD-RAM discs */
+		__u8 dvd_ram_write       : 1,
+		__u8 reserved3           : 2
+	)
+
+	BITFIELD8(
+		/* Drive supports audio play operations. */
+		__u8 audio_play          : 1,
+		/* Drive can deliver a composite audio/video data stream. */
+		__u8 composite           : 1,
+		/* Drive supports digital output on port 1. */
+		__u8 digport1            : 1,
+		/* Drive supports digital output on port 2. */
+		__u8 digport2            : 1,
+		/* Drive can read mode 2, form 1 (XA) data. */
+		__u8 mode2_form1         : 1,
+		/* Drive can read mode 2, form 2 data. */
+		__u8 mode2_form2         : 1,
+		/* Drive can read multisession discs. */
+		__u8 multisession        : 1,
+		__u8 reserved4           : 1
+	)
+
+	BITFIELD8(
+		/* Drive can read Red Book audio data. */
+		__u8 cdda                : 1,
+		/* Drive can continue a read cdda operation from a loss of streaming.*/
+		__u8 cdda_accurate       : 1,
+		/* Subchannel reads can return combined R-W information. */
+		__u8 rw_supported        : 1,
+		/* R-W data will be returned deinterleaved and error corrected. */
+		__u8 rw_corr             : 1,
+		/* Drive supports C2 error pointers. */
+		__u8 c2_pointers         : 1,
+		/* Drive can return International Standard Recording Code info. */
+		__u8 isrc                : 1,
+		/* Drive can return Media Catalog Number (UPC) info. */
+		__u8 upc                 : 1,
+		__u8 reserved5           : 1
+	)
+
+	BITFIELD6(
+		/* Drive can lock the door. */
+		__u8 lock                : 1,
+		/* Present state of door lock. */
+		__u8 lock_state          : 1,
+		/* State of prevent/allow jumper. */
+		__u8 prevent_jumper      : 1,
+		/* Drive can eject a disc or changer cartridge. */
+		__u8 eject               : 1,
+		__u8 reserved6           : 1,
+		/* Drive mechanism types. */
+		mechtype_t mechtype	 : 3
+	)
+
+	BITFIELD5(
+		/* Audio level for each channel can be controlled independently. */
+		__u8 separate_volume     : 1,
+		/* Audio for each channel can be muted independently. */
+		__u8 separate_mute       : 1,
+		/* Changer can report exact contents of slots. */
+		__u8 disc_present        : 1,  /* reserved in 1.2 */
+		/* Drive supports software slot selection. */
+		__u8 sss                 : 1,  /* reserved in 1.2 */
+		__u8 reserved7           : 4
+	)
 
 	/* Note: the following four fields are returned in big-endian form. */
 	/* Maximum speed (in kB/s). */
@@ -404,29 +292,17 @@
 
 
 struct atapi_mechstat_header {
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 fault         : 1;
-	__u8 changer_state : 2;
-	__u8 curslot       : 5;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 curslot       : 5;
-	__u8 changer_state : 2;
-	__u8 fault         : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 mech_state    : 3;
-	__u8 door_open     : 1;
-	__u8 reserved1     : 4;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 reserved1     : 4;
-	__u8 door_open     : 1;
-	__u8 mech_state    : 3;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD3(
+		__u8 curslot       : 5,
+		__u8 changer_state : 2,
+		__u8 fault         : 1
+	)
+
+	BITFIELD3(
+		__u8 reserved1     : 4,
+		__u8 door_open     : 1,
+		__u8 mech_state    : 3
+	)
 
 	byte     curlba[3];
 	byte     nslots;
@@ -435,17 +311,11 @@
 
 
 struct atapi_slot {
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 disc_present : 1;
-	__u8 reserved1    : 6;
-	__u8 change       : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 change       : 1;
-	__u8 reserved1    : 6;
-	__u8 disc_present : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD3(
+		__u8 change       : 1,
+		__u8 reserved1    : 6,
+		__u8 disc_present : 1
+	)
 
 	byte reserved2[3];
 };
diff -urN linux-2.5.45-bk1/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.45-bk1/drivers/ide/ide-floppy.c	Wed Oct 30 20:30:10 2002
+++ linux/drivers/ide/ide-floppy.c	Sun Nov  3 12:59:46 2002
@@ -175,37 +175,23 @@
  *	Removable Block Access Capabilities Page
  */
 typedef struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	page_code	:6;	/* Page code - Should be 0x1b */
-	unsigned	reserved1_6	:1;	/* Reserved */
-	unsigned	ps		:1;	/* Should be 0 */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	ps		:1;	/* Should be 0 */
-	unsigned	reserved1_6	:1;	/* Reserved */
-	unsigned	page_code	:6;	/* Page code - Should be 0x1b */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
+	BITFIELD3(
+		unsigned	page_code	:6,	/* Page code - Should be 0x1b */
+		unsigned	reserved1_6	:1,	/* Reserved */
+		unsigned	ps		:1	/* Should be 0 */
+	)
 	u8		page_length;		/* Page Length - Should be 0xa */
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	reserved2	:6;
-	unsigned	srfp		:1;	/* Supports reporting progress of format */
-	unsigned	sflp		:1;	/* System floppy type device */
-	unsigned	tlun		:3;	/* Total logical units supported by the device */
-	unsigned	reserved3	:3;
-	unsigned	sml		:1;	/* Single / Multiple lun supported */
-	unsigned	ncd		:1;	/* Non cd optical device */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	sflp		:1;	/* System floppy type device */
-	unsigned	srfp		:1;	/* Supports reporting progress of format */
-	unsigned	reserved2	:6;
-	unsigned	ncd		:1;	/* Non cd optical device */
-	unsigned	sml		:1;	/* Single / Multiple lun supported */
-	unsigned	reserved3	:3;
-	unsigned	tlun		:3;	/* Total logical units supported by the device */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
+	BITFIELD3(
+		unsigned	reserved2	:6,
+		unsigned	srfp		:1,	/* Supports reporting progress of format */
+		unsigned	sflp		:1	/* System floppy type device */
+	)
+	BITFIELD4(
+		unsigned	tlun		:3,	/* Total logical units supported by the device */
+		unsigned	reserved3	:3,
+		unsigned	sml		:1,	/* Single / Multiple lun supported */
+		unsigned	ncd		:1	/* Non cd optical device */
+	)
 	u8		reserved[8];
 } idefloppy_capabilities_page_t;
 
@@ -213,17 +199,11 @@
  *	Flexible disk page.
  */
 typedef struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	page_code	:6;	/* Page code - Should be 0x5 */
-	unsigned	reserved1_6	:1;	/* Reserved */
-	unsigned	ps		:1;	/* The device is capable of saving the page */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	ps		:1;	/* The device is capable of saving the page */
-	unsigned	reserved1_6	:1;	/* Reserved */
-	unsigned	page_code	:6;	/* Page code - Should be 0x5 */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
+	BITFIELD3(
+		unsigned	page_code	:6,	/* Page code - Should be 0x5 */
+		unsigned	reserved1_6	:1,	/* Reserved */
+		unsigned	ps		:1	/* The device is capable of saving the page */
+	)
 	u8		page_length;		/* Page Length - Should be 0x1e */
 	u16		transfer_rate;		/* In kilobits per second */
 	u8		heads, sectors;		/* Number of heads, Number of sectors per track */
@@ -246,15 +226,10 @@
 
 typedef struct {
 	u32		blocks;			/* Number of blocks */
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	dc		:2;	/* Descriptor Code */
-	unsigned	reserved	:6;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	reserved	:6;
-	unsigned	dc		:2;	/* Descriptor Code */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
+	BITFIELD2(
+		unsigned	dc		:2,	/* Descriptor Code */
+		unsigned	reserved	:6
+	)
 	u8		length_msb;		/* Block Length (MSB)*/
 	u16		length;			/* Block Length */
 } idefloppy_capacity_descriptor_t;
@@ -390,58 +365,40 @@
  *	the ATAPI IDENTIFY DEVICE command.
  */
 struct idefloppy_id_gcw {	
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned packet_size		:2;	/* Packet Size */
-	unsigned reserved234		:3;	/* Reserved */
-	unsigned drq_type		:2;	/* Command packet DRQ type */
-	unsigned removable		:1;	/* Removable media */
-	unsigned device_type		:5;	/* Device type */
-	unsigned reserved13		:1;	/* Reserved */
-	unsigned protocol		:2;	/* Protocol type */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned protocol		:2;	/* Protocol type */
-	unsigned reserved13		:1;	/* Reserved */
-	unsigned device_type		:5;	/* Device type */
-	unsigned removable		:1;	/* Removable media */
-	unsigned drq_type		:2;	/* Command packet DRQ type */
-	unsigned reserved234		:3;	/* Reserved */
-	unsigned packet_size		:2;	/* Packet Size */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
+	BITFIELD7(
+		unsigned packet_size		:2,	/* Packet Size */
+		unsigned reserved234		:3,	/* Reserved */
+		unsigned drq_type		:2,	/* Command packet DRQ type */
+		unsigned removable		:1,	/* Removable media */
+		unsigned device_type		:5,	/* Device type */
+		unsigned reserved13		:1,	/* Reserved */
+		unsigned protocol		:2	/* Protocol type */
+	)
 };
 
 /*
  *	INQUIRY packet command - Data Format
  */
 typedef struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	device_type	:5;	/* Peripheral Device Type */
-	unsigned	reserved0_765	:3;	/* Peripheral Qualifier - Reserved */
-	unsigned	reserved1_6t0	:7;	/* Reserved */
-	unsigned	rmb		:1;	/* Removable Medium Bit */
-	unsigned	ansi_version	:3;	/* ANSI Version */
-	unsigned	ecma_version	:3;	/* ECMA Version */
-	unsigned	iso_version	:2;	/* ISO Version */
-	unsigned	response_format :4;	/* Response Data Format */
-	unsigned	reserved3_45	:2;	/* Reserved */
-	unsigned	reserved3_6	:1;	/* TrmIOP - Reserved */
-	unsigned	reserved3_7	:1;	/* AENC - Reserved */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	reserved0_765	:3;	/* Peripheral Qualifier - Reserved */
-	unsigned	device_type	:5;	/* Peripheral Device Type */
-	unsigned	rmb		:1;	/* Removable Medium Bit */
-	unsigned	reserved1_6t0	:7;	/* Reserved */
-	unsigned	iso_version	:2;	/* ISO Version */
-	unsigned	ecma_version	:3;	/* ECMA Version */
-	unsigned	ansi_version	:3;	/* ANSI Version */
-	unsigned	reserved3_7	:1;	/* AENC - Reserved */
-	unsigned	reserved3_6	:1;	/* TrmIOP - Reserved */
-	unsigned	reserved3_45	:2;	/* Reserved */
-	unsigned	response_format :4;	/* Response Data Format */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
+	BITFIELD2(
+		unsigned	device_type	:5,	/* Peripheral Device Type */
+		unsigned	reserved0_765	:3	/* Peripheral Qualifier - Reserved */
+	)
+	BITFIELD2(
+		unsigned	reserved1_6t0	:7,	/* Reserved */
+		unsigned	rmb		:1	/* Removable Medium Bit */
+	)
+	BITFIELD3(
+		unsigned	ansi_version	:3,	/* ANSI Version */
+		unsigned	ecma_version	:3,	/* ECMA Version */
+		unsigned	iso_version	:2	/* ISO Version */
+	)
+	BITFIELD4(
+		unsigned	response_format :4,	/* Response Data Format */
+		unsigned	reserved3_45	:2,	/* Reserved */
+		unsigned	reserved3_6	:1,	/* TrmIOP - Reserved */
+		unsigned	reserved3_7	:1	/* AENC - Reserved */
+	)
 	u8		additional_length;	/* Additional Length (total_length-4) */
 	u8		rsv5, rsv6, rsv7;	/* Reserved */
 	u8		vendor_id[8];		/* Vendor Identification */
@@ -456,25 +413,17 @@
  *	REQUEST SENSE packet command result - Data Format.
  */
 typedef struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	error_code	:7;	/* Current error (0x70) */
-	unsigned	valid		:1;	/* The information field conforms to SFF-8070i */
-	u8		reserved1	:8;	/* Reserved */
-	unsigned	sense_key	:4;	/* Sense Key */
-	unsigned	reserved2_4	:1;	/* Reserved */
-	unsigned	ili		:1;	/* Incorrect Length Indicator */
-	unsigned	reserved2_67	:2;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	valid		:1;	/* The information field conforms to SFF-8070i */
-	unsigned	error_code	:7;	/* Current error (0x70) */
+	BITFIELD2(
+		unsigned	error_code	:7,	/* Current error (0x70) */
+		unsigned	valid		:1	/* The information field conforms to SFF-8070i */
+	)
 	u8		reserved1	:8;	/* Reserved */
-	unsigned	reserved2_67	:2;
-	unsigned	ili		:1;	/* Incorrect Length Indicator */
-	unsigned	reserved2_4	:1;	/* Reserved */
-	unsigned	sense_key	:4;	/* Sense Key */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
+	BITFIELD4(
+		unsigned	sense_key	:4,	/* Sense Key */
+		unsigned	reserved2_4	:1,	/* Reserved */
+		unsigned	ili		:1,	/* Incorrect Length Indicator */
+		unsigned	reserved2_67	:2
+	)
 	u32		information __attribute__ ((packed));
 	u8		asl;			/* Additional sense length (n-7) */
 	u32		command_specific;	/* Additional command specific information */
@@ -497,15 +446,10 @@
 typedef struct {
 	u16		mode_data_length;	/* Length of the following data transfer */
 	u8		medium_type;		/* Medium Type */
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	reserved3	:7;
-	unsigned	wp		:1;	/* Write protect */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	wp		:1;	/* Write protect */
-	unsigned	reserved3	:7;
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
+	BITFIELD2(
+		unsigned	reserved3	:7,
+		unsigned	wp		:1	/* Write protect */
+	)
 	u8		reserved[4];
 } idefloppy_mode_parameter_header_t;
 
diff -urN linux-2.5.45-bk1/include/linux/atapi.h linux/include/linux/atapi.h
--- linux-2.5.45-bk1/include/linux/atapi.h	Sun Sep 15 22:18:25 2002
+++ linux/include/linux/atapi.h	Sun Nov  3 10:27:22 2002
@@ -80,27 +80,16 @@
 typedef union {
 	u8 all			: 8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		u8 check	: 1;	/* Error occurred */
-		u8 idx		: 1;	/* Reserved */
-		u8 corr		: 1;	/* Correctable error occurred */
-		u8 drq		: 1;	/* Data is request by the device */
-		u8 dsc		: 1;	/* Media access command finished / Buffer availability */
-		u8 reserved5	: 1;	/* Reserved */
-		u8 drdy		: 1;	/* Ignored for ATAPI commands (ready to accept ATA command) */
-		u8 bsy		: 1;	/* The device has access to the command block */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		u8 bsy		: 1;
-		u8 drdy		: 1;
-		u8 reserved5	: 1;
-		u8 dsc		: 1;
-		u8 drq		: 1;
-		u8 corr		: 1;
-		u8 idx		: 1;
-		u8 check	: 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD8(
+			u8 check	: 1,	/* Error occurred */
+			u8 idx		: 1,	/* Reserved */
+			u8 corr		: 1,	/* Correctable error occurred */
+			u8 drq		: 1,	/* Data is request by the device */
+			u8 dsc		: 1,	/* Media access command finished / Buffer availability */
+			u8 reserved5	: 1,	/* Reserved */
+			u8 drdy		: 1,	/* Ignored for ATAPI commands (ready to accept ATA command) */
+			u8 bsy		: 1	/* The device has access to the command block */
+		)
 	} b;
 } atapi_status_reg_t;
 
@@ -110,21 +99,13 @@
 typedef union {
 	u8 all			: 8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		u8 ili		: 1;	/* Illegal Length Indication */
-		u8 eom		: 1;	/* End Of Media Detected */
-		u8 abrt		: 1;	/* Aborted command - As defined by ATA */
-		u8 mcr		: 1;	/* Media Change Requested - As defined by ATA */
-		u8 sense_key	: 4;	/* Sense key of the last failed packet command */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		u8 sense_key	: 4;
-		u8 mcr		: 1;
-		u8 abrt		: 1;
-		u8 eom		: 1;
-		u8 ili		: 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD5(
+			u8 ili		: 1,	/* Illegal Length Indication */
+			u8 eom		: 1,	/* End Of Media Detected */
+			u8 abrt		: 1,	/* Aborted command - As defined by ATA */
+			u8 mcr		: 1,	/* Media Change Requested - As defined by ATA */
+			u8 sense_key	: 4	/* Sense key of the last failed packet command */
+		)
 	} b;
 } atapi_error_reg_t;
 
@@ -135,19 +116,12 @@
 typedef union {
 	u8 all			: 8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		u8 dma		: 1;	/* Using DMA or PIO */
-		u8 reserved321	: 3;	/* Reserved */
-		u8 reserved654	: 3;	/* Reserved (Tag Type) */
-		u8 reserved7	: 1;	/* Reserved */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		u8 reserved7	: 1;
-		u8 reserved654	: 3;
-		u8 reserved321	: 3;
-		u8 dma		: 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD4(
+			u8 dma		: 1,	/* Using DMA or PIO */
+			u8 reserved321	: 3,	/* Reserved */
+			u8 reserved654	: 3,	/* Reserved (Tag Type) */
+			u8 reserved7	: 1	/* Reserved */
+		)
 	} b;
 } atapi_feature_reg_t;
 
@@ -157,15 +131,10 @@
 typedef union {
 	u16 all			: 16;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		u8 low;			/* LSB */
-		u8 high;		/* MSB */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		u8 high;
-		u8 low;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD2(
+			u8 low,		/* LSB */
+			u8 high		/* MSB */
+		)
 	} b;
 } atapi_bcount_reg_t;
 
@@ -175,17 +144,11 @@
 typedef union {
 	u8 all			: 8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		u8 cod		: 1;	/* Information transferred is command (1) or data (0) */
-		u8 io		: 1;	/* The device requests us to read (1) or write (0) */
-		u8 reserved	: 6;	/* Reserved */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		u8 reserved	: 6;
-		u8 io		: 1;
-		u8 cod		: 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD3(
+			u8 cod		: 1,	/* Information transferred is command (1) or data (0) */
+			u8 io		: 1,	/* The device requests us to read (1) or write (0) */
+			u8 reserved	: 6	/* Reserved */
+		)
 	} b;
 } atapi_ireason_reg_t;
 
@@ -196,23 +159,14 @@
 typedef union {
 	u8 all			:8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		u8 sam_lun	:3;	/* Logical unit number */
-		u8 reserved3	:1;	/* Reserved */
-		u8 drv		:1;	/* The responding drive will be drive 0 (0) or drive 1 (1) */
-		u8 one5		:1;	/* Should be set to 1 */
-		u8 reserved6	:1;	/* Reserved */
-		u8 one7		:1;	/* Should be set to 1 */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		u8 one7		:1;
-		u8 reserved6	:1;
-		u8 one5		:1;
-		u8 drv		:1;
-		u8 reserved3	:1;
-		u8 sam_lun	:3;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD6(
+			u8 sam_lun	:3,	/* Logical unit number */
+			u8 reserved3	:1,	/* Reserved */
+			u8 drv		:1,	/* The responding drive will be drive 0 (0) or drive 1 (1) */
+			u8 one5		:1,	/* Should be set to 1 */
+			u8 reserved6	:1,	/* Reserved */
+			u8 one7		:1	/* Should be set to 1 */
+		)
 	} b;
 } atapi_drivesel_reg_t;
 
@@ -223,21 +177,13 @@
 typedef union {
 	u8 all			: 8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		u8 zero0	: 1;	/* Should be set to zero */
-		u8 nien		: 1;	/* Device interrupt is disabled (1) or enabled (0) */
-		u8 srst		: 1;	/* ATA software reset. ATAPI devices should use the new ATAPI srst. */
-		u8 one3		: 1;	/* Should be set to 1 */
-		u8 reserved4567	: 4;	/* Reserved */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		u8 reserved4567	: 4;
-		u8 one3		: 1;
-		u8 srst		: 1;
-		u8 nien		: 1;
-		u8 zero0	: 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD5(
+			u8 zero0	: 1,	/* Should be set to zero */
+			u8 nien		: 1,	/* Device interrupt is disabled (1) or enabled (0) */
+			u8 srst		: 1,	/* ATA software reset. ATAPI devices should use the new ATAPI srst. */
+			u8 one3		: 1,	/* Should be set to 1 */
+			u8 reserved4567	: 4	/* Reserved */
+		)
 	} b;
 } atapi_control_reg_t;
 
@@ -246,58 +192,40 @@
  *	of the ATAPI IDENTIFY DEVICE command.
  */
 struct atapi_id_gcw {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	u8 packet_size		: 2;	/* Packet Size */
-	u8 reserved234		: 3;	/* Reserved */
-	u8 drq_type		: 2;	/* Command packet DRQ type */
-	u8 removable		: 1;	/* Removable media */
-	u8 device_type		: 5;	/* Device type */
-	u8 reserved13		: 1;	/* Reserved */
-	u8 protocol		: 2;	/* Protocol type */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	u8 protocol		: 2;
-	u8 reserved13		: 1;
-	u8 device_type		: 5;
-	u8 removable		: 1;
-	u8 drq_type		: 2;
-	u8 reserved234		: 3;
-	u8 packet_size		: 2;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD7(
+		u8 packet_size		: 2,	/* Packet Size */
+		u8 reserved234		: 3,	/* Reserved */
+		u8 drq_type		: 2,	/* Command packet DRQ type */
+		u8 removable		: 1,	/* Removable media */
+		u8 device_type		: 5,	/* Device type */
+		u8 reserved13		: 1,	/* Reserved */
+		u8 protocol		: 2	/* Protocol type */
+	)
 };
 
 /*
  *	INQUIRY packet command - Data Format.
  */
 typedef struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	u8	device_type	: 5;	/* Peripheral Device Type */
-	u8	reserved0_765	: 3;	/* Peripheral Qualifier - Reserved */
-	u8	reserved1_6t0	: 7;	/* Reserved */
-	u8	rmb		: 1;	/* Removable Medium Bit */
-	u8	ansi_version	: 3;	/* ANSI Version */
-	u8	ecma_version	: 3;	/* ECMA Version */
-	u8	iso_version	: 2;	/* ISO Version */
-	u8	response_format : 4;	/* Response Data Format */
-	u8	reserved3_45	: 2;	/* Reserved */
-	u8	reserved3_6	: 1;	/* TrmIOP - Reserved */
-	u8	reserved3_7	: 1;	/* AENC - Reserved */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	u8	reserved0_765	: 3;
-	u8	device_type	: 5;
-	u8	rmb		: 1;
-	u8	reserved1_6t0	: 7;
-	u8	iso_version	: 2;
-	u8	ecma_version	: 3;
-	u8	ansi_version	: 3;
-	u8	reserved3_7	: 1;
-	u8	reserved3_6	: 1;
-	u8	reserved3_45	: 2;
-	u8	response_format : 4;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD2(
+		u8	device_type	: 5,	/* Peripheral Device Type */
+		u8	reserved0_765	: 3	/* Peripheral Qualifier - Reserved */
+	)
+	BITFIELD2(
+		u8	reserved1_6t0	: 7,	/* Reserved */
+		u8	rmb		: 1	/* Removable Medium Bit */
+	)
+	BITFIELD3(
+		u8	ansi_version	: 3,	/* ANSI Version */
+		u8	ecma_version	: 3,	/* ECMA Version */
+		u8	iso_version	: 2	/* ISO Version */
+	)
+	BITFIELD4(
+		u8	response_format : 4,	/* Response Data Format */
+		u8	reserved3_45	: 2,	/* Reserved */
+		u8	reserved3_6	: 1,	/* TrmIOP - Reserved */
+		u8	reserved3_7	: 1	/* AENC - Reserved */
+	)
 	u8	additional_length;	/* Additional Length (total_length-4) */
 	u8	rsv5, rsv6, rsv7;	/* Reserved */
 	u8	vendor_id[8];		/* Vendor Identification */
@@ -312,42 +240,28 @@
  *	REQUEST SENSE packet command result - Data Format.
  */
 typedef struct atapi_request_sense {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	u8	error_code	: 7;	/* Error Code (0x70 - current or 0x71 - deferred) */
-	u8	valid		: 1;	/* The information field conforms to standard */
+	BITFIELD2(
+		u8	error_code	: 7,	/* Error Code (0x70 - current or 0x71 - deferred) */
+		u8	valid		: 1	/* The information field conforms to standard */
+	)
 	u8	reserved1	: 8;	/* Reserved (Segment Number) */
-	u8	sense_key	: 4;	/* Sense Key */
-	u8	reserved2_4	: 1;	/* Reserved */
-	u8	ili		: 1;	/* Incorrect Length Indicator */
-	u8	eom		: 1;	/* End Of Medium */
-	u8	filemark	: 1;	/* Filemark */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	u8	valid		: 1;
-	u8	error_code	: 7;
-	u8	reserved1	: 8;
-	u8	filemark	: 1;
-	u8	eom		: 1;
-	u8	ili		: 1;
-	u8	reserved2_4	: 1;
-	u8	sense_key	: 4;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD5(
+		u8	sense_key	: 4,	/* Sense Key */
+		u8	reserved2_4	: 1,	/* Reserved */
+		u8	ili		: 1,	/* Incorrect Length Indicator */
+		u8	eom		: 1,	/* End Of Medium */
+		u8	filemark	: 1	/* Filemark */
+	)
 	u32	information __attribute__ ((packed));
 	u8	asl;			/* Additional sense length (n-7) */
 	u32	command_specific;	/* Additional command specific information */
 	u8	asc;			/* Additional Sense Code */
 	u8	ascq;			/* Additional Sense Code Qualifier */
 	u8	replaceable_unit_code;	/* Field Replaceable Unit Code */
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	u8	sk_specific1	: 7;	/* Sense Key Specific */
-	u8	sksv		: 1;	/* Sense Key Specific information is valid */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	u8	sksv		: 1;	/* Sense Key Specific information is valid */
-	u8	sk_specific1	: 7;	/* Sense Key Specific */
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD2(
+		u8	sk_specific1	: 7,	/* Sense Key Specific */
+		u8	sksv		: 1	/* Sense Key Specific information is valid */
+	)
 	u8	sk_specific[2];		/* Sense Key Specific */
 	u8	pad[2];			/* Padding to 20 bytes */
 } atapi_request_sense_result_t;
Binary files linux-2.5.45-bk1/include/linux/byteorder/.big_endian.h.swp and linux/include/linux/byteorder/.big_endian.h.swp differ
diff -urN linux-2.5.45-bk1/include/linux/byteorder/big_endian.h linux/include/linux/byteorder/big_endian.h
--- linux-2.5.45-bk1/include/linux/byteorder/big_endian.h	Sun Sep 15 22:18:26 2002
+++ linux/include/linux/byteorder/big_endian.h	Sun Nov  3 13:49:04 2002
@@ -65,4 +65,12 @@
 
 #include <linux/byteorder/generic.h>
 
+#define BITFIELD2(b1, b2)							b2; b1;
+#define BITFIELD3(b1, b2, b3)						    b3; b2; b1;
+#define BITFIELD4(b1, b2, b3, b4)					b4; b3; b2; b1;
+#define BITFIELD5(b1, b2, b3, b4, b5)				    b5; b4; b3; b2; b1;
+#define BITFIELD6(b1, b2, b3, b4, b5, b6)			b6; b5; b4; b3; b2; b1;
+#define BITFIELD7(b1, b2, b3, b4, b5, b6, b7)		    b7; b6; b5; b4; b3; b2; b1;
+#define BITFIELD8(b1, b2, b3, b4, b5, b6, b7, b8)	b8; b7; b6; b5; b4; b3; b2; b1;
+
 #endif /* _LINUX_BYTEORDER_BIG_ENDIAN_H */
diff -urN linux-2.5.45-bk1/include/linux/byteorder/little_endian.h linux/include/linux/byteorder/little_endian.h
--- linux-2.5.45-bk1/include/linux/byteorder/little_endian.h	Sun Sep 15 22:18:31 2002
+++ linux/include/linux/byteorder/little_endian.h	Sun Nov  3 10:02:12 2002
@@ -65,4 +65,12 @@
 
 #include <linux/byteorder/generic.h>
 
+#define BITFIELD2(b1, b2)				b1; b2;
+#define BITFIELD3(b1, b2, b3)				b1; b2; b3;
+#define BITFIELD4(b1, b2, b3, b4)			b1; b2; b3; b4;
+#define BITFIELD5(b1, b2, b3, b4, b5)			b1; b2; b3; b4; b5;
+#define BITFIELD6(b1, b2, b3, b4, b5, b6)		b1; b2; b3; b4; b5; b6;
+#define BITFIELD7(b1, b2, b3, b4, b5, b6, b7)		b1; b2; b3; b4; b5; b6; b7;
+#define BITFIELD8(b1, b2, b3, b4, b5, b6, b7, b8)	b1; b2; b3; b4; b5; b6; b7; b8;
+
 #endif /* _LINUX_BYTEORDER_LITTLE_ENDIAN_H */
diff -urN linux-2.5.45-bk1/include/linux/cdrom.h linux/include/linux/cdrom.h
--- linux-2.5.45-bk1/include/linux/cdrom.h	Sat Oct 19 00:31:43 2002
+++ linux/include/linux/cdrom.h	Sun Nov  3 13:14:09 2002
@@ -685,25 +685,17 @@
 } dvd_authinfo;
 
 struct request_sense {
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 valid		: 1;
-	__u8 error_code		: 7;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 error_code		: 7;
-	__u8 valid		: 1;
-#endif
+	BITFIELD2(
+		__u8 error_code		: 7,
+		__u8 valid		: 1
+	)
 	__u8 segment_number;
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved1		: 2;
-	__u8 ili		: 1;
-	__u8 reserved2		: 1;
-	__u8 sense_key		: 4;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 sense_key		: 4;
-	__u8 reserved2		: 1;
-	__u8 ili		: 1;
-	__u8 reserved1		: 2;
-#endif
+	BITFIELD4(
+		__u8 sense_key		: 4,
+		__u8 reserved2		: 1,
+		__u8 ili		: 1,
+		__u8 reserved1		: 2
+	)
 	__u8 information[4];
 	__u8 add_sense_len;
 	__u8 command_info[4];
@@ -803,34 +795,22 @@
 
 typedef struct {
 	__u16 disc_information_length;
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved1			: 3;
-        __u8 erasable			: 1;
-        __u8 border_status		: 2;
-        __u8 disc_status		: 2;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-        __u8 disc_status		: 2;
-        __u8 border_status		: 2;
-        __u8 erasable			: 1;
-	__u8 reserved1			: 3;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+	BITFIELD4(
+		__u8 disc_status		: 2,
+		__u8 border_status		: 2,
+		__u8 erasable			: 1,
+		__u8 reserved1			: 3
+	)
 	__u8 n_first_track;
 	__u8 n_sessions_lsb;
 	__u8 first_track_lsb;
 	__u8 last_track_lsb;
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 did_v			: 1;
-        __u8 dbc_v			: 1;
-        __u8 uru			: 1;
-        __u8 reserved2			: 5;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-        __u8 reserved2			: 5;
-        __u8 uru			: 1;
-        __u8 dbc_v			: 1;
-	__u8 did_v			: 1;
-#endif
+	BITFIELD4(
+		__u8 reserved2			: 5,
+		__u8 uru			: 1,
+		__u8 dbc_v			: 1,
+		__u8 did_v			: 1
+	)
 	__u8 disc_type;
 	__u8 n_sessions_msb;
 	__u8 first_track_msb;
@@ -848,33 +828,24 @@
 	__u8 track_lsb;
 	__u8 session_lsb;
 	__u8 reserved1;
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved2			: 2;
-        __u8 damage			: 1;
-        __u8 copy			: 1;
-        __u8 track_mode			: 4;
-	__u8 rt				: 1;
-	__u8 blank			: 1;
-	__u8 packet			: 1;
-	__u8 fp				: 1;
-	__u8 data_mode			: 4;
-	__u8 reserved3			: 6;
-	__u8 lra_v			: 1;
-	__u8 nwa_v			: 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-        __u8 track_mode			: 4;
-        __u8 copy			: 1;
-        __u8 damage			: 1;
-	__u8 reserved2			: 2;
-	__u8 data_mode			: 4;
-	__u8 fp				: 1;
-	__u8 packet			: 1;
-	__u8 blank			: 1;
-	__u8 rt				: 1;
-	__u8 nwa_v			: 1;
-	__u8 lra_v			: 1;
-	__u8 reserved3			: 6;
-#endif
+	BITFIELD4(
+		__u8 track_mode			: 4,
+		__u8 copy			: 1,
+		__u8 damage			: 1,
+		__u8 reserved2			: 2
+	)
+	BITFIELD5(
+		__u8 data_mode			: 4,
+		__u8 fp				: 1,
+		__u8 packet			: 1,
+		__u8 blank			: 1,
+		__u8 rt				: 1
+	)
+	BITFIELD3(
+		__u8 nwa_v			: 1,
+		__u8 lra_v			: 1,
+		__u8 reserved3			: 6
+	)
 	__u32 track_start;
 	__u32 next_writable;
 	__u32 free_blocks;
@@ -887,36 +858,27 @@
 #define CDROM_MAX_SLOTS	256
 
 struct cdrom_mechstat_header {
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 fault         : 1;
-	__u8 changer_state : 2;
-	__u8 curslot       : 5;
-	__u8 mech_state    : 3;
-	__u8 door_open     : 1;
-	__u8 reserved1     : 4;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 curslot       : 5;
-	__u8 changer_state : 2;
-	__u8 fault         : 1;
-	__u8 reserved1     : 4;
-	__u8 door_open     : 1;
-	__u8 mech_state    : 3;
-#endif
+	BITFIELD3(
+		__u8 curslot       : 5,
+		__u8 changer_state : 2,
+		__u8 fault         : 1
+	)
+	BITFIELD3(
+		__u8 reserved1     : 4,
+		__u8 door_open     : 1,
+		__u8 mech_state    : 3
+	)
 	__u8     curlba[3];
 	__u8     nslots;
 	__u16 slot_tablelen;
 };
 
 struct cdrom_slot {
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 disc_present : 1;
-	__u8 reserved1    : 6;
-	__u8 change       : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 change       : 1;
-	__u8 reserved1    : 6;
-	__u8 disc_present : 1;
-#endif
+	BITFIELD3(
+		__u8 change       : 1,
+		__u8 reserved1    : 6,
+		__u8 disc_present : 1
+	)
 	__u8 reserved2[3];
 };
 
@@ -943,48 +905,35 @@
 };
 
 typedef struct {
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 ps			: 1;
-	__u8 reserved1		: 1;
-	__u8 page_code		: 6;
+	BITFIELD3(
+		__u8 page_code		: 6,
+		__u8 reserved1		: 1,
+		__u8 ps			: 1
+	)
         __u8 page_length;
-	__u8 reserved2		: 1;
-	__u8 bufe		: 1;
-	__u8 ls_v		: 1;
-	__u8 test_write		: 1;
-        __u8 write_type		: 4;
-	__u8 multi_session	: 2; /* or border, DVD */
-	__u8 fp			: 1;
-	__u8 copy		: 1;
-	__u8 track_mode		: 4;
-	__u8 reserved3		: 4;
-	__u8 data_block_type	: 4;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 page_code		: 6;
-	__u8 reserved1		: 1;
-	__u8 ps			: 1;
-        __u8 page_length;
-        __u8 write_type		: 4;
-	__u8 test_write		: 1;
-	__u8 ls_v		: 1;
-	__u8 bufe		: 1;
-	__u8 reserved2		: 1;
-	__u8 track_mode		: 4;
-	__u8 copy		: 1;
-	__u8 fp			: 1;
-	__u8 multi_session	: 2; /* or border, DVD */
-	__u8 data_block_type	: 4;
-	__u8 reserved3		: 4;
-#endif
+	BITFIELD5(
+		__u8 write_type		: 4,
+		__u8 test_write		: 1,
+		__u8 ls_v		: 1,
+		__u8 bufe		: 1,
+		__u8 reserved2		: 1
+	)
+	BITFIELD4(
+		__u8 track_mode		: 4,
+		__u8 copy		: 1,
+		__u8 fp			: 1,
+		__u8 multi_session	: 2  /* or border, DVD */
+	)
+	BITFIELD2(
+		__u8 data_block_type	: 4,
+		__u8 reserved3		: 4
+	)
 	__u8 link_size;
 	__u8 reserved4;
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved5		: 2;
-	__u8 app_code		: 6;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 app_code		: 6;
-	__u8 reserved5		: 2;
-#endif
+	BITFIELD2(
+		__u8 app_code		: 6,
+		__u8 reserved5		: 2
+	)
 	__u8 session_format;
 	__u8 reserved6;
 	__u32 packet_size;
@@ -1017,15 +966,11 @@
 	__u16 report_key_length;
 	__u8 reserved1;
 	__u8 reserved2;
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 type_code			: 2;
-	__u8 vra			: 3;
-	__u8 ucca			: 3;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 ucca			: 3;
-	__u8 vra			: 3;
-	__u8 type_code			: 2;
-#endif
+	BITFIELD3(
+		__u8 ucca			: 3,
+		__u8 vra			: 3,
+		__u8 type_code			: 2
+	)
 	__u8 region_mask;
 	__u8 rpc_scheme;
 	__u8 reserved3;
diff -urN linux-2.5.45-bk1/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.45-bk1/include/linux/ide.h	Wed Oct 30 20:30:20 2002
+++ linux/include/linux/ide.h	Sun Nov  3 10:20:22 2002
@@ -380,23 +380,14 @@
 typedef union {
 	unsigned all			: 8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned set_geometry	: 1;
-		unsigned recalibrate	: 1;
-		unsigned set_multmode	: 1;
-		unsigned set_tune	: 1;
-		unsigned serviced	: 1;
-		unsigned reserved	: 3;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved	: 3;
-		unsigned serviced	: 1;
-		unsigned set_tune	: 1;
-		unsigned set_multmode	: 1;
-		unsigned recalibrate	: 1;
-		unsigned set_geometry	: 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD6(
+			unsigned set_geometry	: 1,
+			unsigned recalibrate	: 1,
+			unsigned set_multmode	: 1,
+			unsigned set_tune	: 1,
+			unsigned serviced	: 1,
+			unsigned reserved	: 3
+		)
 	} b;
 } special_t;
 
@@ -409,15 +400,10 @@
 typedef union {
 	unsigned all			:16;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned low		:8;	/* LSB */
-		unsigned high		:8;	/* MSB */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned high		:8;	/* MSB */
-		unsigned low		:8;	/* LSB */
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD2(
+			unsigned low		:8,	/* LSB */
+			unsigned high		:8	/* MSB */
+		)
 	} b;
 } ata_nsector_t, ata_data_t, atapi_bcount_t, ata_index_t;
 
@@ -436,27 +422,16 @@
 typedef union {
 	unsigned all			:8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned mark		:1;
-		unsigned tzero		:1;
-		unsigned abrt		:1;
-		unsigned mcr		:1;
-		unsigned id		:1;
-		unsigned mce		:1;
-		unsigned ecc		:1;
-		unsigned bdd		:1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned bdd		:1;
-		unsigned ecc		:1;
-		unsigned mce		:1;
-		unsigned id		:1;
-		unsigned mcr		:1;
-		unsigned abrt		:1;
-		unsigned tzero		:1;
-		unsigned mark		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD8(
+			unsigned mark		:1,
+			unsigned tzero		:1,
+			unsigned abrt		:1,
+			unsigned mcr		:1,
+			unsigned id		:1,
+			unsigned mce		:1,
+			unsigned ecc		:1,
+			unsigned bdd		:1
+		)
 	} b;
 } ata_error_t;
 
@@ -472,21 +447,13 @@
 typedef union {
 	unsigned all			: 8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned head		: 4;
-		unsigned unit		: 1;
-		unsigned bit5		: 1;
-		unsigned lba		: 1;
-		unsigned bit7		: 1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned bit7		: 1;
-		unsigned lba		: 1;
-		unsigned bit5		: 1;
-		unsigned unit		: 1;
-		unsigned head		: 4;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD5(
+			unsigned head		: 4,
+			unsigned unit		: 1,
+			unsigned bit5		: 1,
+			unsigned lba		: 1,
+			unsigned bit7		: 1
+		)
 	} b;
 } select_t, ata_select_t;
 
@@ -510,27 +477,16 @@
 typedef union {
 	unsigned all			:8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned check		:1;
-		unsigned idx		:1;
-		unsigned corr		:1;
-		unsigned drq		:1;
-		unsigned dsc		:1;
-		unsigned df		:1;
-		unsigned drdy		:1;
-		unsigned bsy		:1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned bsy		:1;
-		unsigned drdy		:1;
-		unsigned df		:1;
-		unsigned dsc		:1;
-		unsigned drq		:1;
-		unsigned corr           :1;
-		unsigned idx		:1;
-		unsigned check		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD8(
+			unsigned check		:1,
+			unsigned idx		:1,
+			unsigned corr		:1,
+			unsigned drq		:1,
+			unsigned dsc		:1,
+			unsigned df		:1,
+			unsigned drdy		:1,
+			unsigned bsy		:1
+		)
 	} b;
 } ata_status_t, atapi_status_t;
 
@@ -547,23 +503,14 @@
 typedef union {
 	unsigned all			: 8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned bit0		: 1;
-		unsigned nIEN		: 1;
-		unsigned SRST		: 1;
-		unsigned bit3		: 1;
-		unsigned reserved456	: 3;
-		unsigned HOB		: 1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned HOB		: 1;
-		unsigned reserved456	: 3;
-		unsigned bit3		: 1;
-		unsigned SRST		: 1;
-		unsigned nIEN		: 1;
-		unsigned bit0		: 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD6(
+			unsigned bit0		: 1,
+			unsigned nIEN		: 1,
+			unsigned SRST		: 1,
+			unsigned bit3		: 1,
+			unsigned reserved456	: 3,
+			unsigned HOB		: 1
+		)
 	} b;
 } ata_control_t;
 
@@ -578,19 +525,12 @@
 typedef union {
 	unsigned all			:8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned dma		:1;
-		unsigned reserved321	:3;
-		unsigned reserved654	:3;
-		unsigned reserved7	:1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved7	:1;
-		unsigned reserved654	:3;
-		unsigned reserved321	:3;
-		unsigned dma		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD4(
+			unsigned dma		:1,
+			unsigned reserved321	:3,
+			unsigned reserved654	:3,
+			unsigned reserved7	:1
+		)
 	} b;
 } atapi_feature_t;
 
@@ -604,17 +544,11 @@
 typedef union {
 	unsigned all			:8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned cod		:1;
-		unsigned io		:1;
-		unsigned reserved	:6;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved	:6;
-		unsigned io		:1;
-		unsigned cod		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD3(
+			unsigned cod		:1,
+			unsigned io		:1,
+			unsigned reserved	:6
+		)
 	} b;
 } atapi_ireason_t;
 
@@ -630,21 +564,13 @@
 typedef union {
 	unsigned all			:8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned ili		:1;
-		unsigned eom		:1;
-		unsigned abrt		:1;
-		unsigned mcr		:1;
-		unsigned sense_key	:4;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned sense_key	:4;
-		unsigned mcr		:1;
-		unsigned abrt		:1;
-		unsigned eom		:1;
-		unsigned ili		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD5(
+			unsigned ili		:1,
+			unsigned eom		:1,
+			unsigned abrt		:1,
+			unsigned mcr		:1,
+			unsigned sense_key	:4
+		)
 	} b;
 } atapi_error_t;
 
@@ -661,23 +587,14 @@
 typedef union {
 	unsigned all			:8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned sam_lun	:3;
-		unsigned reserved3	:1;
-		unsigned drv		:1;
-		unsigned one5		:1;
-		unsigned reserved6	:1;
-		unsigned one7		:1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned one7		:1;
-		unsigned reserved6	:1;
-		unsigned one5		:1;
-		unsigned drv		:1;
-		unsigned reserved3	:1;
-		unsigned sam_lun	:3;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
+		BITFIELD6(
+			unsigned sam_lun	:3,
+			unsigned reserved3	:1,
+			unsigned drv		:1,
+			unsigned one5		:1,
+			unsigned reserved6	:1,
+			unsigned one7		:1
+		)
 	} b;
 } atapi_select_t;
 

--------------090203010707060105070304--

