Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266960AbRGHSgA>; Sun, 8 Jul 2001 14:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266963AbRGHSfu>; Sun, 8 Jul 2001 14:35:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26057 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266960AbRGHSfh>;
	Sun, 8 Jul 2001 14:35:37 -0400
Message-ID: <3B48A7F4.20BD3342@mandrakesoft.com>
Date: Sun, 08 Jul 2001 14:35:32 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gregory (Grisha) Trubetskoy" <grisha@ispol.com>
Subject: Re: ESCD Support for 2.4.6-ac1/PNPBIOS (was: reading/writing CMOS beyond 
 256 bytes?)
In-Reply-To: <E15IXCD-0004Uu-00@the-village.bc.nu> <3B48A643.124AA832@t-online.de>
Content-Type: multipart/mixed;
 boundary="------------ED29DE1257E086BD498954FE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ED29DE1257E086BD498954FE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Gunther Mayer wrote:
> 
> Hi,
> with a litte patch to linux-2.4.6ac1 (which includes PNPBIOS)
> the ESCD data is easily accessible.
> 
> Then "lsescd" will verbosely decode /proc/bus/pnp/escd.
> 
> This lets you access important info which would be beneficial for correctly
> configuring PnP in Linux (e.g. when you set an IRQ to "reserved for legacy ISA"
> in your BIOS setup or you can see what's the difference between selecting
> "_PNP OS_" to yes/no in your BIOS setup screen).

Neat!

FWIW I kernel-ified escd.h (attached), in case it is eventually useful
to some kernel code.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
--------------ED29DE1257E086BD498954FE
Content-Type: text/plain; charset=us-ascii;
 name="escd.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="escd.h"

#ifndef __ESCD_H__
#define __ESCD_H__

/***********************************************************************
                                Standard EISA format definitions
***********************************************************************/
				/* Bytes #0 and #1 of ID and Slot Information */
struct eisa_id_slot_info {
	u8 dup_cfg_num_id : 4;	/* Byte # 0:  Bits 0-3  id for duplicate CFG filenames
				   0000 - No duplicate CFG filenames
				   0001 - 1st duplicate(1ACE0105)
				   .....
				   1111 - 15th duplicate(FACE0105) */
	u8 slot_type : 2;		/* Byte # 0:  Bits 4-5
				   00 - Expansion Slot
				   01 - embedded slot
				   10 - virtual slot
				   11 - reserved(0)                */
	u8 id_readable : 1;	/* Byte # 0:  Bit  6
				   0 - ID reabable
				   1 - ID not reabable                */
	u8 dup_id_present : 1;	/* Byte # 0:  Bit 7
				   0 - no duplicate ID present
				   1 - duplicate ID present   */

	u8 board_eisa_enable_supp : 1;	/* Byte # 1: Bit 0 - board can be disabled = 1 */
	u8 board_iochkerr : 1;	/* Byte # 1: Bit 1 - IOCHKERR supported = 1 */
	u8 board_or_entry_lock : 1;	/* Byte # 1: Bit 2 - board or entries locked = 1 */
	u8 id_slot_resvrd : 3;	/* Byte # 1: Bit 3-5 - reserved */
	u8 id_slot_no_cfg_file : 1;	/* Byte # 1: Bit 6 - Board doesn't have/need cfg file = 1 */
	u8 board_config_stat : 1;	/* Byte # 1: Bit 7 - config is completed = 0 */
	/*                            - config is not completed = 1 */
};

				/* Function Information Byte #0 */
struct eisa_func_entry_info {
	u8 type_sub_type_entry : 1;	/* Bit 0 - type subtype data = 1 */
	u8 memory_entry : 1;	/* Bit 1 - mem entry data = 1 */
	u8 irq_entry : 1;	/* Bit 2 - IRQ data = 1 */
	u8 dma_entry : 1;	/* Bit 3 - DMA entry data = 1 */
	u8 port_range_entry : 1;	/* Bit 4 - port range data = 1 */
	u8 port_init_entry : 1;	/* Bit 5 - port init data = 1 */
	u8 freeform_entry : 1;	/* Bit 6 - free form data = 1 */
	u8 eisa_func_disabled : 1;	/* Bit 7 - enabled = 0, disabled = 1 */
};

				/* Memory Info struct Bytes #0-6 */
struct eisa_mem_info {
	u8 mem_rdwr : 1;	/* Bit 0 - 0 = ROM, 1 = RAM */
	u8 mem_cached : 1;	/* Bit 1 - 0 = not cached */
	u8 mem_ch_type : 1;	/* Bit 2 - 1 = WB cache, 0=WT cache */
	u8 mem_type : 2;	/* Bits3-4 -00=sys, 01=exp, 10=vir,11=oth */
	u8 mem_shared : 1;	/* Bit 5 - 0 not=shared */
	u8 mem_reserved1 : 1;	/* Bit 6 - 0 = reserved */
	u8 mem_more_entries : 1;	/* Bit 7 - last entry = 0, more = 1 */
	/* _mem data size byte */
	u8 mem_data_size : 2;	/* Bit 0-1 -00=byte,01=word,10=dwrd,11=rsv */
	u8 mem_decode_size : 2;	/* Bit 2-3 -00=20,01=24,10=32,11=rsv */
	u8 mem_reserved2 : 4;	/* Bit 4-7 -0 = reserved */
	/* memory start addr */
	u8 mem_start_addr0;	/* LSByte (divided by 0x100) mem start */
	u8 mem_start_addr1;	/* Middle Byte memory start */
	u8 mem_start_addr2;	/* MSByte memory start */
	/* memory size */
	u8 mem_size0;		/* LSByte (divided by 0x400) mem size */
	u8 mem_size1;		/* LSByte=MSByte=0 means 64MB */
};

				/* IRQ Info struct Bytes #0-1 */
struct eisa_irq_info {
	u8 irq_number : 4;	/* Bit 0-3 - IRQ Number */
	u8 irq_rsvrd : 1;	/* Bit 4 - must be 0 */
	u8 irq_trigger : 1;	/* Bit 5 - 0=Edge , 1=Level */
	u8 irq_type : 1;	/* Bit 6 - 0=Non-shared, 1=Sharable */
	u8 irq_more_entries : 1;/* Bit 7 - 0=Last Entry, 1=More entires follow */

	u8 irq_reserved;	/* Reserved (set to 0) */
};

				/* DMA Info struct Bytes #0-1 */
struct eisa_dma_info {
	u8 dma_number : 3;	/* Bits 0-2 - DMA Number(0-7) */
	u8 dma_reserved1 : 3;	/* Bits 3-5 Reserved (set to 0) */
	u8 dma_type : 1;	/* Bit 6 - 0=Non-Sharable, 1=Sharable */
	u8 dma_more_entries : 1;	/* Bit 7 - 0=Last Entry, 1=more entires follow */

	u8 dma_reserved2 : 2;	/* Bit 0-1 Reserved (set to 0) */
	u8 dma_xfer_size : 2;	/* Bits 2-3 
				   00 = 8bit  transfer
				   01 = 16bit transfer
				   10 = 32bit transfer
				   11 = 16bit transfer with byte count */
	u8 dma_timing : 2;	/* Bits 4-5
				   00 = Isa Compatible timing
				   01 = Type "A"
				   10 = Type "B"
				   11 = Type "C"(Burst) */
	u8 dma_reserved3 : 2;	/* Bits 6-7 Reserved (set to 0) */
};

				/* I/O ports Info struct Bytes #0-2 */
struct eisa_port_info {
	u8 port_count:5;	/* Bit 0-4 Number of Ports
				   0000 = 1Port
				   0001 = 2Sequential Ports (and so on)
				   1111 = 32Sequential Ports */
	u8 port_rsvrd : 1;	/* Bit 5 Reserved (set to 0) */
	u8 port_shared : 1;	/* Bit 6 0=Non-shared, 1=Sharable */
	u8 port_more_entries : 1;/* Bit 7 - 0=Last Entry, 1=More entires follow */

	u16 port_addr;		/* I/O Port Address */
};

				/* Init ports Info struct Bytes #0-2 */
struct eisa_init_data {
	u8 access_type : 2;	/* Bit 0-1
				   00 - Byte address(8-bit)
				   01 - Word address(16-bit)
				   10 - Dword address(32-bit)
				   11 - Reserved(0) */
	u8 port_mask_set : 1;	/* Bit 2
				   0 - Write value to Port(no mask)
				   1 - Use mask and value */
	u8 init_reserved : 4;	/* Reserved(0) */
	u8 more_entries : 1;	/* 0 = Last Entry
				   1 = More entries follow */
};

				/* EISA free format data definition */
struct eisa_freeform_data {
	u8 data_size;		/* Length of following data block */
	u8 data[203];	/* 203 bytes */
};

/* eisa slot function config 320 bytes structure layout definition     */
struct eisa_func_cfg_info {
	u8 comp_board_id1;	/* first byte of compressed board ID  */
	u8 comp_board_id2;	/* second byte of compressed board ID */
	u8 comp_board_id3;	/* third byte of compressed board ID  */
	u8 comp_board_id4;	/* forth byte of compressed board ID  */
	struct eisa_id_slot_info s_id_slot_info;	/* bit specific slot ID and slot info */
	u8 cfg_minor_rev_num;	/* minor revision of CFG file extension */
	u8 cfg_major_rev_num;	/* major revision of CFG file extension */
	u8 selections[26];	/* 26 bytes of selection information */
	struct eisa_func_entry_info s_func_entry_info;	/* Func status and resources stat */
	u8 type_sub_type[80];	/* 80 character type/subtype field    */
	union {
		struct {
			struct eisa_mem_info as_mem_data[9];	/* 63 bytes mem cfg data */
			struct eisa_irq_info as_irq_data[7];	/* 14 bytes IRQ config data */
			struct eisa_dma_info as_dma_data[4];	/* 8 bytes DMA channel info */
			struct eisa_port_info as_port_data[20];	/* 60 bytes I/O port info */
			u8 init_data[60];	/* 60 bytes init. data */
		} res_data;
		struct eisa_freeform_data ff_data;	/* Free format data */
	} u_func_data;
};

/***********************************************************************
                                End of Standard EISA format definitions
***********************************************************************/

/***********************************************************************/
/***********************************************************************/
/* Layout of the whole storage for the ESCD.img file                   */
/*
   1)        Escd_CFGHDR. This contains the ESCD size, signature,
   version#,  and the number of slot entries.

   2)     This is followed by board records that contain a board header
   and board data. Board header contains the size of the board record
   and the slot number for the board. The board header is specific
   to ISA systems only.

   3)     The packed data for each slot is preceeded by ESCD_brd_hdr
   that contains the size and the slot# for the slot data that
   immediately follows.

   4)     EISA format data for slot zero, the Mother-board:  data
   for functions 0-n describing MB resources

   5)    EISA data for slots 1-15 describe EXP EISA and ISA boards:
   data in standard format for functions 0-n corresponding  to devices
   associated with the expansion boards.

   6)     ESCD data for slots 1-15 describing the PnP ISA boards:
   data for functions 0-n corresponding to devices  on the expansion
   board. Unlocked PnP ISA devices are described as disabled
   functions; locked PnP devices on the board are enabled functions.
   disbled function n+1 describing extentions specific to PnP board
   type. The data uses free format spec.

   7)     ESCD data for slots 16-64 (Virtual slots) describe the
   PCI devices, one PCI board (device) per one slot: one or more
   standard EISA function(s) corresponding to the PCI function(s)
   0-7 for the PCI device that is located at Bus#,Dev# and Fun#0
   address in the system. If the configuration for this device is
   unlocked, the standard EISA format function(s) will  be disabled;
   locked PCI function(s)will be enabled.  a last function, the ECD
   describing the PCI specific information for the PCI function(s) 0-7.

   8)     There is a checksum at the end of the storage.

*/
/***********************************************************************/

/* The following structures describe the ESCD extensions.              */

struct escd_cfg_hdr {
	u16 escd_size;		/* Total Size of File/NVRAM */
	u32 signature;		/* Initialized to "ACFG" */
	u8 ver_minor;		/* Minor #, should be >= 0 */
	u8 ver_major;		/* Major #, should be >= 2 */
	u8 board_count;
	u8 escd_hdr_reserved[3];
};

struct escd_board_hdr {
	u16 board_rec_size;	/* Including this word */
	u8 slot_num;
	u8 escdb_hdr_reserved;
};

#define    ESCD_SIGNATURE                0x47464341	/* ACFG characters */

		/* Free format last funct Board Header ecd extensions */
struct escd_ff_board_hdr {
	/* Total size of 16 bytes */
	u32 signature;		/* Initialized to "ACFG" */
	u8 ver_minor;		/* should be >= 00 */
	u8 ver_major;		/* Must be set to 0x02 */
	u8 board_type;		/* Board Type as in CM defintion */
	/* 0x01=isa, 0x02=eisa, 0x04=pci */
	/* 0x08=pcmcia, 0x10=PnP Isa, 0x20=mca */
	u8 escd_hdr_reserved1;	/* Reserved */
	u16 pnp_funcs_disabled;	/* 16 PnP functions disabled bit-map */
	u16 pnp_funcs_cfg_err;	/* 16 PnP functions config error status bit-map */
	/* This reserved field will now be used  u8                           abEcd_hdr_reserved2[4];    _reserved */
	u16 pnp_funcs_cannot_config;	/* 16 PnP funct bit-map to indicate  *
				   /*   if the device is reconfigurable */
	/* For each bit 0 - Reconfigurable 1- Not reconfigurable */
	u8 escd_hdr_reserved[2];	/* Reserved */
};

				/* Free Fmt PCI device identifier and data */
struct escd_pci_dev {
	u8 bus_num;		/* PCI Bus Number (0-255) */
	u8 dev_func_num;	/* PCI defined Device (0-31) and Func 0-7) num*/
	/* Device # in bits 7:3, Function # in bits 2:0 */
	u16 device_id;		/* PCI device ID */
	u16 vendor_id;		/* PCI vendor ID */
	u8 pci_board_reserved[2];	/* Reserved */
};

				/* Free Fmt PnP ISA board identifier */
struct escd_isapnp_dev {
	u32 vendor_id;	/* PnP ISA vendor ID, 4 char */
	u32 pnp_serial_num;	/* Board/Device serial # identifier */
};

		/* PnP ISA ECD extention function, a last function per board */
struct escd_pnp_ext {
	u16 func_size;		/* Size set to 28 */
	u8 selection_size;	/* initialize to 1 */
	u8 selection_data;	/* initialize to 0 */
	u8 func_info;		/* FreeFormat, disabled bit set (set to 0xC0) */
	u8 freeform_size;	/* Size of following free fmt data, excl this
				 * byte Size set to 24: sizeof
				 * escd_ff_board_hdr + PnP specific data */
	struct escd_ff_board_hdr struct_sz;	/* sizeof struct = 16 bytes */
	struct escd_isapnp_dev pnp_dev;	/* sizeof struct =8 bytes */
};

		/* PCI ECD extention function, a last function per board/device */
struct escd_pci_ext {
	u16 func_size;		/* set to min of 28 for single PCI function */
	/* and to 86 for eight functions PCI card */
	u8 selection_size;	/* initialize to 1 */
	u8 selection_data;	/* initialize to 0 */
	u8 func_info;		/* FreeFormat, disabled bit set (set to 0xC0) */
	u8 freeform_size;	/* Size of following free fmt data, excl this byte
				   Size set to max of 80: sizeof struct escd_ff_board_hdr
				   + PnP specific data  allowed intry is 24 or 32 or 40 .. 80 */
	struct escd_ff_board_hdr struct_sz;	/* sizeof struct = 16 bytes */
	struct escd_pci_dev pci_dev[8];	/* sizeof struct = Maximum of 8*8 bytes */
	/* There will be only one pci_dev entry for each function on 
	   a multi-function  PCI card */
};

/*                      End of the ECD extensions.                    */
/***********************************************************************/

#endif /* __ESCD_H__ */

--------------ED29DE1257E086BD498954FE--

