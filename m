Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268462AbTBNQVh>; Fri, 14 Feb 2003 11:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268453AbTBNQVh>; Fri, 14 Feb 2003 11:21:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34346 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267282AbTBNQUv>; Fri, 14 Feb 2003 11:20:51 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       ecc"<ecc@yahoogroups.com>"@frodo.biederman.org
Subject: Re: ECC drivers 
References: <20030213172701.492c9aee.rddunlap@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Feb 2003 09:29:36 -0700
In-Reply-To: <20030213172701.492c9aee.rddunlap@osdl.org>
Message-ID: <m1bs1e7rm7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


O.k. To get the conversation going...


"Randy.Dunlap" <rddunlap@osdl.org> writes:

> Hi Eric,
> 
> On 2002-Oct-30 you wrote:
> 
> Assuming they work.  No offense to the guys who got the ball rolling, but
> the architecture is lousy, and every driver I have messed with does not
> work correctly, and I wind up reimplementing it before I can use it.
> 
> I actually like the idea of ECC drivers, and routinely make certain
> there is a working ECC driver on the systems I ship.  It is so much
> very easier to catch memory errors with good ECC error reporting.  But
> unless I have slept soundly through a fundamental change, the
> linux-ecc project currently does not ship quality drivers.  The
> infrastructure is bad, and the code is not quite correct. 
> 
> If you want I can dig up the drivers I am currently using and send
> them to you.
> 
> I even have a working memory scrub routine.
> 
> Eric
> --
> 
> I'd like to get these.  Have you posted them anywhere?
> If so, I missed them.


O.k. I have finally dug these things up.  My apologies for the delay.
I get preoccupied.

This code is not clean or beautiful.  For cases like the E7500 chipset where
the work has been put in and the code tested it works.  And the memory scrub
code works as well.

One of my projects in the next little while is to research and see if I can
find a clean infrastructure for this kind of code.  All drivers in one
file sucks.  And there are a few related things.

Additional credits to: Jim Garlick <garlick@llnl.gov> for testing this
code out and being a picky user...



Eric

/*
 * ECC kernel module (C) 1998, 1999 Dan Hollis <goemon at anime dot net>
 * http://www.anime.net/~goemon/linux-ecc/
 * Portions thanks to
 *	Michael O'Reilly <michael at metal dot iinet dot net dot au>
 *	Osma Ahvenlampi <oa at spray dot fi>
 *	Martin Maney <maney at pobox dot com>
 *	Peter Heckert <peter.heckert at arcormail dot de>
 *      Ishikawa <ishikawa at yk dot rim dot or dot jp>
 *	Jaakko Hyvti <jaakko dot hyvatti at iki dot fi>
 *	Christopher Hoover <ch at murgatroid dot com >
 *	Jonathan Lundell <jlundell at resilience dot com>
 */

#define DEBUG	0

#if 0
#if (LINUX_VERSION_CODE < 0x020401)
#define __KERNEL__
#define MODULE
#endif
#endif

#include <linux/config.h>
#include <linux/version.h>
#if (LINUX_VERSION_CODE < 0x020401)
#ifdef CONFIG_MODVERSIONS
#include <linux/modversions.h>
#endif
#endif
#include <linux/module.h>

#include <linux/mm.h>
#include <linux/sched.h>
#include <linux/delay.h>
#include <linux/pci.h>
#include <linux/timer.h>
#include <asm/io.h>
#include <linux/proc_fs.h>
#if (LINUX_VERSION_CODE >= 0x020401)
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#endif
#include <linux/sysctl.h>
#include <asm/uaccess.h>
#include <asm/page.h>
#include <asm/pgtable.h>
#include <linux/highmem.h>

static void scrub_page_virt(u32 p_4k_blk);

#define	ECC_VER	"development"

static int ecc_scrub = -1;

static spinlock_t ecc_lock = SPIN_LOCK_UNLOCKED;
static struct timer_list ecc_timer;
static struct pci_dev *bridge = NULL;
static struct pci_dev *bridge_ck = NULL;
static u32 tolm;
static u32 remapbase;
static u32 remaplimit;
static u16 vendor, device;
static int scrub_needed;
static int scrub_row;

/* memory types */
#define BANK_EMPTY	0	/* Empty bank */
#define BANK_RESERVED	1	/* Reserved bank type */
#define BANK_UNKNOWN	2	/* Unknown bank type */
#define BANK_FPM	3	/* Fast page mode */
#define BANK_EDO	4	/* Extended data out */
#define BANK_BEDO	5	/* Burst Extended data out */
#define BANK_SDR	6	/* Single data rate SDRAM */
#define BANK_DDR	7	/* Double data rate SDRAM */
#define BANK_RDR	8	/* Registered SDRAM */
#define BANK_RMBS	9	/* Rambus DRAM */

/* Memory bank info */
#define MAX_BANKS	16	/* do any chipsets support more? */
static struct bankstruct
{
	u32 endaddr;		/* bank ending address */
	u32 endaddr_4k;		/* bank ending address 4k blocks */
	u32 mbecount;		/* total number of MBE errors */
	u32 sbecount;		/* total number of SBE errors */
	u32 sbe_dimm_a;		/* cumulative number of SBE errors in dimm a */
	u32 sbe_dimm_b;		/* cumulative number of SBE errors in dimm b */
	u8 eccmode;		/* ECC enabled for this bank? */
	u8 mtype;		/* memory bank type */
	u8 bank;		/* memory bank number  */
} bank[MAX_BANKS];

static int use_4k_blocks=0;
static int use_ab_dimm=0;

/* These are tunable by either module parameter or sysctl */
int panic_on_uncorrected = 0;
int log_uncorrected = 1;
int log_corrected = 1;
int poll_msec = 1000;

#ifdef CONFIG_SYSCTL
static ctl_table ecc_table[] = {
        {1, "panic_on_uncorrected",
                &panic_on_uncorrected, sizeof(int), 0644, NULL, &proc_dointvec},
        {2, "log_uncorrected",
                &log_uncorrected, sizeof(int), 0644, NULL, &proc_dointvec},
        {3, "log_corrected",
                &log_corrected, sizeof(int), 0644, NULL, &proc_dointvec},
        {4, "poll_msec",
                &poll_msec, sizeof(int), 0644, NULL, &proc_dointvec},
        {0}
};

static ctl_table ecc_root_table[] = {
        {CTL_DEBUG, "ecc", NULL, 0, 0555, ecc_table},
        {0}
};

static struct ctl_table_header *ecc_sysctl_header = NULL;
#endif /* CONFIG_SYSCTL */

#define ue_printk(fmt,args...) do { \
    if (panic_on_uncorrected) panic("ECC: Uncorrected error " fmt,##args); \
    else if (log_uncorrected) printk(KERN_EMERG "ECC: Uncorrected error " fmt,##args); \
} while(0)
#define ce_printk(fmt,args...) do { \
    if (log_corrected) printk(KERN_WARNING "ECC: Corrected error " fmt,##args); \
} while(0)



/* chipset ECC capabilities and mode */
#define ECC_NONE	0	/* Doesnt support ECC (or is BIOS disabled) */
#define ECC_RESERVED	1	/* Reserved ECC type */
#define ECC_PARITY	2	/* Detects parity errors */
#define ECC_DETECT	3	/* Detects ECC errors */
#define ECC_CORRECT	4	/* Detects ECC errors and corrects SBE */
#define ECC_AUTO	5	/* Detects ECC errors and has hardware scrubber */
#define ECC_SKIP	6	/* Wrong bridge; keep looking */

static struct ChipsetInfo
{
	int ecc_cap;		/* chipset ECC capabilities */
	int ecc_mode;		/* current ECC mode */
	void (*check)(void);	/* pointer to ecc checking routine */
	void (*clear_err)(void);/* pointer to error clear routine */
#if 0
/*
 * I dont think we care about SERR at the moment.
 * We may if/when we hook into an NMI handler.
 */
	int SERR;		/* SERR enabled? */
	int SERR_MBE;		/* SERR on multi-bit error? */
	int SERR_SBE;		/* SERR on single-bit error? */
#endif
	int MBE_flag_address;	/* pci offset for mbe register */
	int MBE_flag_shift;	/* bits to shift for mbe flag */
	int MBE_flag_mask;	/* mask for mbe flag */
	int MBE_row_shift;	/* bits to shift for mbe row flag */
	int MBE_row_mask;	/* mask for mbe register (shifted) */
	int SBE_flag_address;	/* pci offset for sbe register */
	int SBE_flag_shift;	/* bits to shift for sbe flag */
	int SBE_flag_mask;	/* mask for sbe flag */
	int SBE_row_shift;	/* bits to shift for sbe row flag */	
	int SBE_row_mask;	/* mask for sbe register (shifted) */
	int MBE_err_address1;	/* pci offset for mbe address register */
	int MBE_err_shift1;	/* bits to shift for mbe address register */
	int MBE_err_address2;	/* pci offset for mbe address register */
	int MBE_err_shift2;	/* bits to shift for mbe address register */
	u32 MBE_err_mask;	/* mask for mbe address register */
	int MBE_err_flag;	/* MBE error flag */
	int MBE_err_row;	/* MBE row */
	u32 MBE_addr;		/* address of last MBE */
	int SBE_err_address1;	/* pci offset for sbe address register */
	int SBE_err_shift1;	/* bits to shift for sbe address register */
	int SBE_err_address2;	/* pci offset for sbe address register */
	int SBE_err_shift2;	/* bits to shift for sbe address register */
	u32 SBE_err_mask;	/* mask for sbe address register */
	int SBE_err_flag;	/* SBE error flag */
	int SBE_err_row;	/* SBE row */
	u32 SBE_addr;		/* address of last SBE */
} cs;


static inline unsigned int pci_byte(int offset)
{
	u8 value;
	pci_read_config_byte(bridge, offset, &value);
	return value & 0xFF;
}

static inline unsigned int pci_word(int offset)
{
	u16 value;
	pci_read_config_word(bridge, offset, &value);
	return value;
}

static inline unsigned int pci_dword(int offset)
{
	u32 value;
	pci_read_config_dword(bridge, offset, &value);
	return value;
}

/* write all or some bits in a byte-register*/
static inline void pci_write_bits8(int offset,u8 value,u8 mask)
{ 
	if (mask != 0xff){
		u8 buf;
		pci_read_config_byte(bridge,offset, &buf);
		value &=mask;
		buf &= ~mask;
		value |= buf;
	}
	pci_write_config_byte(bridge,offset,value);
}  

/* write all or some bits in a word-register*/
static inline void pci_write_bits16(int offset,u16 value,u16 mask)
{ 
	if (mask != 0xffff){
		u16 buf;
		pci_read_config_word(bridge,offset, &buf);
		value &=mask;
		buf &= ~mask;
		value |= buf;
	}
	pci_write_config_word(bridge,offset,value);
}  

static int find_row(unsigned long err_addr)
{
	int row = -1, loop;
	for(loop=0; loop < MAX_BANKS; loop++) {
		if (err_addr <= bank[loop].endaddr) {
			row=loop;
			break;
		}
	}
	if (row == -1)
		panic("ECC: could not look up error address %lx", err_addr);
	return row;
}

/* NOTE: find_row_4k() accounts for unpopulated low banks. */
static int find_row_4k(u32 block_4k)
{
	int row = -1, first_bank = 0, loop;
	for(loop=0; loop < MAX_BANKS; loop++) {
		if (first_bank && bank[loop].endaddr_4k == 0)
			break;
		if(block_4k <= bank[loop].endaddr_4k) {
			row=loop;
			break;
		}
		if (bank[loop].endaddr_4k != 0) 
			first_bank = 1;
	}
	if (row == -1)
		panic("ECC: could not look up 4k error address %lx", 
				(long unsigned int)block_4k);
	return row;
}


/*
 *	generic ECC check routine
 *
 *	This routine assumes that the MBE and SBE error status consist of:
 *	 * one or more bits in a status byte that are non-zero on error
 *	 * zero or more bits in a status byte that encode the row
 *	It accomodates both the case where both the MBE and SBE data are
 *	packed into a single byte (all chipsets currently known to me) as
 *	well as the case where the MBE and SBE information are contained in
 *	separate locations.  The status byte is read only once for the packed
 *	case in case the status value should be altered by being read.
 */

static void generic_check(void)
{
	int status = pci_byte(cs.MBE_flag_address);
	if ((status >> cs.MBE_flag_shift) & cs.MBE_flag_mask)
	{
		int row = (status >> cs.MBE_row_shift) & cs.MBE_row_mask;
		ue_printk("in DRAM row %d\n", row);
		if (cs.MBE_err_address1)
		{
			cs.MBE_addr =
			( pci_word(cs.MBE_err_address1 << cs.MBE_err_shift1) |
			  pci_word(cs.MBE_err_address2 << cs.MBE_err_shift2) ) &
			  cs.MBE_err_mask;
			ue_printk("at memory address %lx\n", (long unsigned int)cs.MBE_addr);
		}
		scrub_needed = 2;
		scrub_row = row;
		bank[row].mbecount++;
	}
	if (cs.SBE_flag_address != cs.MBE_flag_address)
		status = pci_byte(cs.SBE_flag_address);
	if ((status >> cs.SBE_flag_shift) & cs.SBE_flag_mask)
	{
		int row = (status >> cs.SBE_row_shift) & cs.SBE_row_mask;
		ce_printk("in DRAM row %d\n", row);
		if (cs.SBE_err_address1)
		{
			cs.SBE_addr =
			( pci_word(cs.SBE_err_address1 << cs.SBE_err_shift1) |
			  pci_word(cs.SBE_err_address2 << cs.SBE_err_shift2) ) &
			  cs.SBE_err_mask;
			ce_printk("at memory address %lx\n", (long unsigned int)cs.SBE_addr);
		}
		scrub_needed = 1;
		scrub_row = row;
		bank[row].sbecount++;
	}
}

/* VIA specific error clearing */
static void clear_via_err(void)
{
	pci_write_bits8(0x6f,0xff,0xff);
	/* as scrubbing is unimplemented, we reset it here */
	scrub_needed = 0;
}

/* unified VIA probe */
static void probe_via(void)
{
	int loop, ecc_ctrl, dimmslots = 3, bankshift = 23;
	int m_mem[] = { BANK_FPM, BANK_EDO, BANK_DDR, BANK_SDR };
	switch (device) {
		case 0x0391: /* VIA VT8371   - KX133		*/
			dimmslots = 4;
			bankshift = 24;
		case 0x0595: /* VIA VT82C595 - VP2,VP2/97	*/
			m_mem[2] = BANK_RESERVED;
			cs.ecc_cap = ECC_CORRECT;
			break;
		case 0x0501: /* VIA VT8501   - MVP4		*/
		case 0x0597: /* VIA VT82C597 - VP3		*/
		case 0x0598: /* VIA VT82C598 - MVP3		*/
			cs.ecc_cap = ECC_CORRECT;
			break;
		case 0x3099: /* VIA VT8366/VT8367 - KT266/KT266A/KT333 */
			m_mem[0] = BANK_SDR;
			m_mem[1] = BANK_RESERVED;
			m_mem[3] = BANK_RESERVED;
		case 0x0691: /* VIA VT82C691 - Apollo PRO 	*/
			     /* VIA VT82C693A - Apollo Pro133 (rev 40?) */
			     /* VIA VT82C694X - Apollo Pro133A (rev 8x,Cx)
				has 4 dimm slots */
		case 0x0694: /* VIA VT82C694XDP - Apollo PRO133A smp */
			dimmslots = 4;
		case 0x0693: /* VIA VT82C693 - Apollo PRO-Plus 	*/
			bankshift = 24;
			cs.ecc_cap = ECC_CORRECT;
			break;
		case 0x3128: /* VIA VT8753/VT8753A - P4X266/P4X266A */
		case 0x3148: /* VIA VT8751 - P4M266 */
		case 0x3168: /* VIA VT8754 - P4M333 */
			/* datasheet is vague here, we guess sbe/mbe are reported from the same registers */
			cs.SBE_err_address1 = 0xD0;
			cs.SBE_err_shift1 = 0;
			cs.SBE_err_address2 = 0xD2;
			cs.SBE_err_shift2 = 16;
			cs.MBE_err_address1 = 0xD0;
			cs.MBE_err_shift1 = 0;
			cs.MBE_err_address2 = 0xD2;
			cs.MBE_err_shift2 = 0;
		case 0x3156: /* VIA VT8372/VT8375 - KN266/KM266 */
			m_mem[0] = BANK_SDR;
			m_mem[1] = BANK_RESERVED;
			m_mem[3] = BANK_RESERVED;
			dimmslots = 4;
		case 0x0305: /* VIA VT8363 - KT133 */
			     /* VIA VT8363A - KT133A (rev 8) */
			bankshift = 24;
			cs.ecc_cap = ECC_NONE;
			break;
		case 0x0585: /* VIA VT82C585 - VP,VPX,VPX/97	*/
		default:
			cs.ecc_cap = ECC_NONE;
			return;
	}
	ecc_ctrl = pci_byte(0x6E);
	cs.ecc_mode = (ecc_ctrl>>7)&1 ? cs.ecc_cap : ECC_NONE;

	cs.check = generic_check;
	if (cs.ecc_mode != ECC_NONE) {
		cs.clear_err = clear_via_err;
		/* clear initial errors */
		cs.clear_err();
	}
	cs.MBE_flag_address = 0x6F;
	cs.MBE_flag_shift = 7;
	cs.MBE_flag_mask = 1;
	cs.MBE_row_shift = 4;
	cs.MBE_row_mask = 7;
	cs.SBE_flag_address = 0x6F;
	cs.SBE_flag_shift = 3;
	cs.SBE_flag_mask = 1;
	cs.SBE_row_shift = 0;
	cs.SBE_row_mask = 7;

	for(loop=0;loop<6;loop++)
		bank[loop].endaddr = (unsigned long)pci_byte(0x5a+loop)<<bankshift;
	if(dimmslots==4)
	{
		bank[6].endaddr = (unsigned long)pci_byte(0x56)<<bankshift;
		bank[7].endaddr = (unsigned long)pci_byte(0x57)<<bankshift;
	}
	for(loop=0;loop<dimmslots;loop++)
	{
		bank[loop*2].mtype = m_mem[(pci_byte(0x60)>>(loop*2))&3];
		bank[(loop*2)+1].mtype = m_mem[(pci_byte(0x60)>>(loop*2))&3];
		bank[loop*2].eccmode = (ecc_ctrl>>(loop))&1 ? cs.ecc_mode : ECC_NONE;
		bank[(loop*2)+1].eccmode = (ecc_ctrl>>(loop))&1 ? cs.ecc_mode : ECC_NONE;
	}
}

static void check_cnb20he(void)
{
	unsigned long mesr;
	int row;

	mesr = pci_dword(0x94); /* mesr0 */
	row = (int)(mesr>>27)&0x7;
	if((mesr>>31)&1)
	{
		ue_printk("in DRAM row %d\n", row);
		scrub_needed |= 2;
		bank[row].mbecount++;
	}
	if((mesr>>30)&1)
	{
		ce_printk("in DRAM row %d\n", row);
		scrub_needed |= 1;
		bank[row].sbecount++;
	}
	if (scrub_needed)
	{
		/*
		 * clear error flag bits that were set by writing 1 to them
		 * we hope the error was a fluke or something :)
		 */
		unsigned long value = scrub_needed<<30;
		pci_write_config_dword(bridge, 0x94, value);
		scrub_needed = 0;
	}

	mesr = pci_dword(0x98); /* mesr1 */
	row = (int)(mesr>>27)&0x7;
	if((mesr>>31)&1)
	{
		ue_printk("in DRAM row %d\n", row);
		scrub_needed |= 2;
		bank[row].mbecount++;
	}
	if((mesr>>30)&1)
	{
		ce_printk("in DRAM row %d\n", row);
		scrub_needed |= 1;
		bank[row].sbecount++;
	}
	if (scrub_needed)
	{
		/*
		 * clear error flag bits that were set by writing 1 to them
		 * we hope the error was a fluke or something :)
		 */
		unsigned long value = scrub_needed<<30;
		pci_write_config_dword(bridge, 0x98, value);
		scrub_needed = 0;
        }
}

static void probe_cnb20he(void)
{
	int loop, efcr, mccr;

	cs.ecc_cap = ECC_AUTO;
	efcr = pci_byte(0xE0);
	mccr = pci_word(0x92);
	cs.ecc_mode = (efcr>>2)&1 ? (mccr&1 ? ECC_AUTO : ECC_CORRECT) : ECC_NONE;

	cs.check = check_cnb20he;

	for(loop=0;loop<8;loop++)
	{
#if 0
		int attr = pci_byte(0x7c+loop/2);
		if (loop & 1) attr >>= 4;
		attr &= 0x0f;
		ce_printk("row %d 0x%x\n", loop, attr);
#endif
		bank[loop].mtype = BANK_SDR;
		bank[loop].eccmode = cs.ecc_mode;
                bank[loop].endaddr = pci_byte(0x81+loop*2)<<24;
	}
}
static void check_cnb30le(void)
{
	unsigned long mesr;
	unsigned char errsts;
	unsigned char eccsyn;
	unsigned row, ca, ra;
	int i;
	char *ename;
	int ebit;
	static unsigned char cnb30_syndrome_dbits[64] = {
		0xC1, 0xC2, 0xC4, 0xC8, 0xA1, 0xA2, 0xA4, 0xA8, /*  0- 7 */
		0x91, 0x92, 0x94, 0x98, 0x61, 0x62, 0x64, 0x68, /*  8-15 */
		0x51, 0x52, 0x54, 0x58, 0x31, 0x32, 0x34, 0x38, /* 16-23 */
		0xF8, 0x4F, 0x70, 0xD0, 0x0E, 0x0B, 0xF1, 0x2F, /* 24-31 */
		0x1C, 0x2C, 0x4C, 0x8C, 0x1A, 0x2A, 0x4A, 0x8A, /* 32-39 */
		0x19, 0x29, 0x49, 0x89, 0x16, 0x26, 0x46, 0x86, /* 40-47 */
		0x15, 0x25, 0x45, 0x85, 0x13, 0x23, 0x43, 0x83, /* 48-55 */
		0x8F, 0xF4, 0x07, 0x0D, 0xE0, 0xB0, 0x1F, 0xF2  /* 56-63 */ };
	static unsigned char cnb30_syndrome_cbits[8] = {
		0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 };

	errsts = pci_byte(0x47);
	if ((errsts & 0x06) == 0)
		return;	/* no ECC errors */

	mesr = pci_dword(0x94);
	row = (mesr>>29) & 0x7;
	ca = (mesr>>15) & 0x3fff;
	ra = mesr & 0x7fff;
	eccsyn = pci_byte(0xe8);	/* ECC syndrome register */
	if (errsts & 0x04) {
#if 1
		/* for normal operation, don't fill up logs with ra/ca */
		ue_printk("at row=%d syn=%02x\n", row, eccsyn);
#else
		ue_printk("at row=%d ca.ra=%04x.%04x syn=%02x\n", row, ca, ra, eccsyn);
#endif
		bank[row].mbecount++;
		if (errsts & 0x02)
			bank[row].sbecount++;
	} else if (errsts & 0x02) {
		ebit = 0;
		ename = "?";
		for (i=0; i<64; ++i) {
			if (cnb30_syndrome_dbits[i] == eccsyn) {
				ebit = i;
				ename = "d";
				break;
			}
		}
		for (i=0; i<8; ++i) {
			if (cnb30_syndrome_cbits[i] == eccsyn) {
				ebit = i;
				ename = "c";
				break;
			}
		}
#if 1
		/* for normal operation, don't fill up logs with ra/ca */
		ce_printk("row=%d syn=%02x bit=%s%d\n", row, eccsyn, ename, ebit);
#else
		ce_printk("row=%d ca.ra=%04x.%04x syn=%02x bit=%s%d\n", row, ca, ra, eccsyn, ename, ebit);
#endif
		bank[row].sbecount++;
	}
	pci_write_config_byte(bridge, 0x47, (errsts & 0x06)); /* clear error */
}

static void probe_cnb30le(void)
{
	int loop, papc, tmp, efcr;
	unsigned char mrpr = 0;

	if ((bridge->devfn & 0x07) != 0) {
		/* we need function 0 of the bridge */
		cs.ecc_cap = ECC_SKIP;
		return;
	}
	cs.ecc_cap = ECC_AUTO;

	papc = tmp = pci_byte(0x48);
	if (ecc_scrub == 0)
		papc &= ~0x01;	/* turn off scrubbing */
	else if (ecc_scrub == 1)
		papc |= 0x01;	/* turn on scrubbing */
	if (papc != tmp)
		pci_write_config_byte(bridge, 0x48, papc);	/* update scrubbing */
		
	efcr = pci_byte(0xe0);
	if (efcr & 0x04) {
		/* ecc enabled */
		if (papc & 0x01)
			cs.ecc_mode = ECC_AUTO;	/* scrubbing enabled */
		else
			cs.ecc_mode = ECC_CORRECT;	/* scrubbing disabled */
		pci_write_config_byte(bridge, 0x47, 0x06); /* clear errors */
	} else {
		cs.ecc_mode = ECC_NONE;	/* ecc disabled */
	}

	cs.check = check_cnb30le;

	for(loop=0;loop<8;loop++)
	{
		int attr = pci_byte(0x7c+loop/2);
		if (loop & 1) attr >>= 4;
		attr &= 0x0f;
#if 0
		printk(KERN_ERR "ECC: row %d 0x%x\n", loop, attr);
#endif
		bank[loop].mtype = BANK_SDR;
		bank[loop].eccmode = cs.ecc_mode;
                bank[loop].endaddr = pci_byte(0x81+loop*2)<<24;
		if (attr || bank[loop].endaddr)
			mrpr |= 1 << loop;
	}
	pci_write_config_byte(bridge, 0x90, mrpr); /* rows present */
}

/*
 * 450gx probing is buggered at the moment. help me obi-wan.
 */

static void probe_450gx(void)
{
	int loop, dramc, merrcmd;
	u32 nbxcfg;
	int m_mem[] = { BANK_EDO, BANK_SDR, BANK_RDR, BANK_RESERVED };
/*	int ddim[] = { ECC_NONE, ECC_DETECT, ECC_CORRECT, ECC_AUTO }; */
	nbxcfg = pci_word(0x50) | (pci_word(0x52)<<16);
	dramc = pci_byte(0x57);
	merrcmd = pci_word(0xC0);
	cs.ecc_cap = ECC_AUTO;
	cs.ecc_mode = (merrcmd>>1)&1 ? ECC_AUTO : ECC_DETECT;
	for(loop=0;loop<8;loop++)
	{
		bank[loop].endaddr=(unsigned long)pci_byte(0x60+loop)<<23;
		/* 450gx doesnt allow mixing memory types. bleah. */
		bank[loop].mtype = m_mem[(dramc>>3)&3];
		/* yes, bit is _zero_ if ecc is _enabled_. */
		bank[loop].eccmode = ( !((nbxcfg>>(loop+24))&1) ? cs.ecc_mode : ECC_NONE);
	}

	cs.check = generic_check;
	cs.MBE_flag_address = 0xC2;
	cs.MBE_flag_shift = 0;
	cs.MBE_flag_mask = 1;
	cs.MBE_row_shift = 5;
	cs.MBE_row_mask = 7;
	cs.SBE_flag_address = 0xC2;
	cs.SBE_flag_shift = 1;
	cs.SBE_flag_mask = 1;
	cs.SBE_row_shift = 1;
	cs.SBE_row_mask = 7;

	cs.MBE_err_address1 = 0xA8;
	cs.MBE_err_shift1 = 0;
	cs.MBE_err_address2 = 0xAA;
	cs.MBE_err_shift2 = 16;
	cs.MBE_err_mask = 0xFFFFFFFC;

	cs.SBE_err_address1 = 0x74;
	cs.SBE_err_shift1 = 0;
	cs.SBE_err_address2 = 0x76;
	cs.SBE_err_shift2 = 16;
	cs.SBE_err_mask = 0xFFFFFFFC;
}

static void check_450nx(void)
{
	u16 mel0 = pci_word(0xB0);
	u16 mel1 = pci_word(0xB2);
	if (mel0 & 3) {
		u8 mea0 = pci_byte(0xA8);
		printk(KERN_ERR "ECC: ");
		switch (mel0 & 3){
			case 1: printk("SBE");
				bank[(mea0>>3)&0x1F].sbecount++;
				break;
			case 2: printk("MBE");
				bank[(mea0>>3)&0x1F].mbecount++;
				break;
			case 3: printk("SBE and MBE");
				bank[(mea0>>3)&0x1F].sbecount++;
				bank[(mea0>>3)&0x1F].mbecount++;
				break;
		}
		printk(" Detected, bank %d (card %d bank %d row %d)\n",
			(mea0>>3)&0x1F, (mea0>>7)&1, (mea0>>4)&7, (mea0>>3)&1 );
		pci_write_config_word(bridge, 0xB0, 0);
		pci_write_config_byte(bridge, 0xA8, 0);
	}
	if (mel1 & 3) {
		u8 mea1 = pci_byte(0xA9);
		switch (mel1 & 3){
			case 1: printk(KERN_ERR "ECC: SBE");
				bank[(mea1>>3)&0x1F].sbecount++;
				break;
			case 2: printk(KERN_ERR "ECC: MBE");
				bank[(mea1>>3)&0x1F].mbecount++;
				break;
			case 3: printk(KERN_ERR "ECC: SBE and MBE");
				bank[(mea1>>3)&0x1F].sbecount++;
				bank[(mea1>>3)&0x1F].mbecount++;
				break;
		}
		printk(" Detected, bank %d (card %d bank %d row %d)\n",
			(mea1>>3)&0x1F, (mea1>>7)&1, (mea1>>4)&7, (mea1>>3)&1 );
		pci_write_config_word(bridge, 0xB2, 0);
		pci_write_config_byte(bridge, 0xA9, 0);
	}
}

static void probe_450nx(void)
{
	int loop, ecccmd, dbc;
	u32 lastaddr;
	ecccmd = pci_byte(0xB8);
	if (ecccmd & 8) { /* mss */
		cs.ecc_mode = ECC_AUTO;
	} else if (ecccmd & 1) { /* mcs */
		cs.ecc_mode = ECC_CORRECT;
	} else if (ecccmd & 6) { /* mrs & mrm */
		cs.ecc_mode = ECC_DETECT;
	} else {
		cs.ecc_mode = ECC_NONE;
	}
	cs.ecc_cap = ECC_AUTO;
	cs.check = check_450nx;

	lastaddr = 0L;
	for(loop=0;loop<8;loop++)
	{
		dbc = pci_word(0x80+loop*2);
		if (dbc & 0x2000) /* bank present */
		{
			if (dbc & 0x4000) /* single row */
			{
				bank[loop*2].endaddr=(dbc & 0x03FF)<<25;
				bank[loop*2].mtype = BANK_EDO;
				bank[loop*2].eccmode = cs.ecc_mode;
				lastaddr=(dbc & 0x03FF)<<25;
			} else { /* double row */
				bank[loop*2].endaddr=lastaddr+((((dbc & 0x03FF)<<25)-lastaddr)>>1);
				bank[loop*2].mtype = BANK_EDO;
				bank[loop*2].eccmode = cs.ecc_mode;
				bank[loop*2+1].endaddr=(dbc & 0x03FF)<<25;
				bank[loop*2+1].mtype = BANK_EDO;
				bank[loop*2+1].eccmode = cs.ecc_mode;
				lastaddr=(dbc & 0x03FF)<<25;
			}
		}
	}
}

/* there seems to be NO WAY to distinguish 440zx from 440bx!! >B( */
static void probe_440bx(void)
{
	int loop, dramc, errcmd;
	u32 nbxcfg;
	int m_mem[] = { BANK_EDO, BANK_SDR, BANK_RDR, BANK_RESERVED };
	int ddim[] = { ECC_NONE, ECC_DETECT, ECC_CORRECT, ECC_AUTO };
	nbxcfg = pci_word(0x50) | (pci_word(0x52)<<16);
	dramc = pci_byte(0x57);
	errcmd = pci_byte(0x90);
	cs.ecc_cap = ECC_AUTO;
	cs.ecc_mode = ddim[(nbxcfg>>7)&3];

	cs.check = generic_check;
	cs.MBE_flag_address = 0x91;
	cs.MBE_flag_shift = 4;
	cs.MBE_flag_mask = 1;
	cs.MBE_row_shift = 5;
	cs.MBE_row_mask = 7;
	cs.SBE_flag_address = 0x91;
	cs.SBE_flag_shift = 0;
	cs.SBE_flag_mask = 1;
	cs.SBE_row_shift = 1;
	cs.SBE_row_mask = 7;

	cs.MBE_err_address1 = 80;
	cs.MBE_err_shift1 = 0;
	cs.MBE_err_address2 = 82;
	cs.MBE_err_shift2 = 16;
	cs.MBE_err_mask = 0xFFFFF000;

	cs.SBE_err_address1 = 80;
	cs.SBE_err_shift1 = 0;
	cs.SBE_err_address2 = 82;
	cs.SBE_err_shift2 = 16;
	cs.SBE_err_mask = 0xFFFFF000;

	for(loop=0;loop<8;loop++)
	{
		bank[loop].endaddr=(unsigned long)pci_byte(0x60+loop)<<23;
		/* 440bx doesnt allow mixing memory types. bleah. */
		bank[loop].mtype = m_mem[(dramc>>3)&3];
		/* yes, bit is _zero_ if ecc is _enabled_. */
		bank[loop].eccmode = !((nbxcfg>>(loop+24))&1);
	}
}

/* no way to tell 440ex from 440lx!? grr. */
static void probe_440lx(void)
{
	int loop, drt, paccfg, errcmd;
	int m_mem[] = { BANK_EDO, BANK_RESERVED, BANK_SDR, BANK_EMPTY };
	int ddim[] = { ECC_NONE, ECC_DETECT, ECC_RESERVED, ECC_CORRECT } ;
	paccfg = pci_word(0x50);
	drt = pci_byte(0x55) | (pci_byte(0x56)<<8);
	errcmd = pci_byte(0x90);
	/* 440ex doesnt support ecc, but no way to tell if its 440ex! */
	cs.ecc_cap = ECC_CORRECT;
	cs.ecc_mode = ddim[(paccfg>>7)&3];

	cs.check = generic_check;
	cs.MBE_flag_address = 0x91;
	cs.MBE_flag_shift = 4;
	cs.MBE_flag_mask = 1;
	cs.MBE_row_shift = 5;
	cs.MBE_row_mask = 7;
	cs.SBE_flag_address = 0x91;
	cs.SBE_flag_shift = 0;
	cs.SBE_flag_mask = 1;
	cs.SBE_row_shift = 1;
	cs.SBE_row_mask = 7;

	for(loop=0;loop<8;loop++)
	{
		bank[loop].endaddr = (unsigned long)pci_byte(0x60+loop)<<23;
		bank[loop].mtype = m_mem[(drt>>(loop*2))&3];
		bank[loop].eccmode = cs.ecc_mode;
	}
}

static void probe_440fx(void)
{
	int loop, drt, pmccfg, errcmd;
	int m_mem[] = { BANK_FPM, BANK_EDO, BANK_BEDO, BANK_EMPTY };
	int ddim[] = { ECC_NONE, ECC_PARITY, ECC_DETECT, ECC_CORRECT };
	pmccfg = pci_word(0x50);
	drt = pci_byte(0x55) | (pci_byte(0x56)<<8);
	errcmd = pci_byte(0x90);
	for(loop=0;loop<8;loop++)
	{
		bank[loop].endaddr=(unsigned long)pci_byte(0x60+loop)<<23;
		bank[loop].mtype = m_mem[(drt>>(loop*2))&3];
	}
	cs.ecc_cap = ECC_CORRECT;
	cs.ecc_mode = ddim[(pmccfg>>4)&3];

	cs.check = generic_check;
	cs.MBE_flag_address = 0x91;
	cs.MBE_flag_shift = 4;
	cs.MBE_flag_mask = 1;
	cs.MBE_row_shift = 5;
	cs.MBE_row_mask = 7;
	cs.SBE_flag_address = 0x91;
	cs.SBE_flag_shift = 0;
	cs.SBE_flag_mask = 1;
	cs.SBE_row_shift = 1;
	cs.SBE_row_mask = 7;
}

static void probe_430hx(void)
{
	int pcicmd, pcon, errcmd, drt, loop;
	pcicmd = pci_word(0x4);
	pcon = pci_byte(0x50);
	drt = pci_byte(0x68);
	errcmd = pci_byte(0x90);
	cs.ecc_cap = ECC_CORRECT;
	cs.ecc_mode = (pcon>>7)&1 ? ECC_CORRECT : ECC_PARITY;

	cs.check = generic_check;
	cs.MBE_flag_address = 0x91;
	cs.MBE_flag_shift = 4;
	cs.MBE_flag_mask = 1;
	cs.MBE_row_shift = 5;
	cs.MBE_row_mask = 7;
	cs.SBE_flag_address = 0x91;
	cs.SBE_flag_shift = 0;
	cs.SBE_flag_mask = 1;
	cs.SBE_row_shift = 1;
	cs.SBE_row_mask = 7;

	for(loop=0;loop<8;loop++)
	{
		bank[loop].endaddr=(unsigned long)pci_byte(0x60+loop)<<22;
		bank[loop].mtype = (drt>>loop)&1 ? BANK_EDO : BANK_FPM;
		bank[loop].eccmode = cs.ecc_mode;
	}
}

static void check_820(void)
{
	int errsts = pci_word(0xC8);
	if ((errsts>>1) & 1)
	{
		u32 eap = pci_dword(0xC4) & 0xFFFFF000;
		char errsyn = pci_byte(0xC7);
		ue_printk("at memory address %lx\n row %d syndrome %x\n",
			(long unsigned int)eap, find_row(eap), errsyn);
		scrub_needed = 2;
		scrub_row = find_row(eap);
		bank[scrub_row].mbecount++;
	}
	if ((errsts) & 1)
	{
		u32 eap = pci_dword(0xC4) & 0xFFFFF000;
		char errsyn = pci_byte(0xC7);
		ce_printk("at memory address %lx row %d syndrome %x\n",
			(long unsigned int)eap, find_row(eap), errsyn);
		scrub_needed = 1;
		scrub_row = find_row(eap);
		bank[scrub_row].sbecount++;
	}
}

void probe_820(void)
{
	int loop, mchcfg;
	int ddim[] = { ECC_NONE, ECC_DETECT, ECC_CORRECT, ECC_AUTO };
	mchcfg = pci_word(0xBE);
	cs.ecc_cap = ECC_AUTO;
	cs.ecc_mode = ddim[(mchcfg>>7)&3];

	cs.check = check_820;

	for(loop=0;loop<8;loop++)
	{
		bank[loop].endaddr=(unsigned long)pci_word(0x60+(loop*2))<<23;
		bank[loop].mtype = BANK_RMBS;
		bank[loop].eccmode = cs.ecc_mode;
	}
}

static void check_840(void)
{
	int errsts = pci_word(0xE2);
	if ((errsts>>9) & 1)
	{
		u32 eap = pci_dword(0xE4) & 0xFFFFF800;
		ue_printk("at memory address %lx\n row %d syndrome %x",
			(long unsigned int)eap, find_row(eap), errsts&0xFF);
		scrub_needed = 2;
		scrub_row = find_row(eap);
		bank[scrub_row].mbecount++;
	}
	if ((errsts>>10) & 1)
	{
		u32 eap = pci_dword(0xE4) & 0xFFFFF800;
		ce_printk("at memory address %lx row %d syndrome %x\n",
			(long unsigned int)eap, find_row(eap), errsts&0xFF);
		scrub_needed = 1;
		scrub_row = find_row(eap);
		bank[scrub_row].sbecount++;
	}
}

static void probe_840(void)
{
	int loop, mchcfg;
	int ddim[] = { ECC_NONE, ECC_RESERVED, ECC_CORRECT, ECC_AUTO };
	mchcfg = pci_word(0x50);
	cs.ecc_cap = ECC_AUTO;
	cs.ecc_mode = ddim[(mchcfg>>7)&3];

	cs.check = check_840;

	for(loop=0;loop<16;loop++)
	{
		bank[loop].endaddr=(unsigned long)pci_word(0x60+(loop*2))<<23;
		bank[loop].mtype = BANK_RMBS;
		bank[loop].eccmode = cs.ecc_mode;
	}
}

static void check_845(void)
{
	int errsts = pci_word(0xC8);
	if ((errsts>>1) & 1)
	{
		u32 eap = (pci_dword(0x8C) & 0xFFFFFFFE)<<4;
		char derrsyn = pci_byte(0x86);
		ue_printk("at memory address %lx\n row %d syndrome %x\n",
			(long unsigned int)eap, find_row(eap), derrsyn);
		scrub_needed = 2;
		scrub_row = find_row(eap);
		bank[scrub_row].mbecount++;
	}
	if (errsts & 1)
	{
		u32 eap = (pci_dword(0x8C) & 0xFFFFFFFE)<<4;
		char derrsyn = pci_byte(0x86);
		ce_printk("at memory address %lx row %d syndrome %x\n",
			(long unsigned int)eap, find_row(eap), derrsyn);
		scrub_needed = 1;
		scrub_row = find_row(eap);
		bank[scrub_row].sbecount++;
	}
}

static void probe_845(void)
{
	int loop;
	u32 drc;
	int m_mem[] = { BANK_SDR, BANK_DDR, BANK_RESERVED, BANK_RESERVED };
	int ddim[] = { ECC_NONE, ECC_RESERVED, ECC_CORRECT, ECC_RESERVED };
	drc = pci_dword(0x7C);
	cs.ecc_cap = ECC_CORRECT;
	cs.ecc_mode = ddim[(drc>>20)&3];

	cs.check = check_845;

	for(loop=0;loop<8;loop++)
	{
		bank[loop].endaddr=(unsigned long)pci_byte(0x60+loop)<<24;
		bank[loop].mtype = m_mem[drc&3];
		bank[loop].eccmode = cs.ecc_mode;
	}
}

static void check_850(void)
{
	int errsts = pci_word(0xC8);
	if ((errsts>>1) & 1)
	{
		u32 eap = pci_dword(0xE4) & 0xFFFFE000;
		char derrsyn = pci_word(0xE2) & 0xFF;
		ue_printk("at memory address %lx\n row %d syndrome %x\n",
			(long unsigned int)eap, find_row(eap), derrsyn);
		scrub_needed = 2;
		scrub_row = find_row(eap);
		bank[scrub_row].mbecount++;
	}
	if (errsts & 1)
	{
		u32 eap = pci_dword(0xE4) & 0xFFFFE000;
		char derrsyn = pci_byte(0xE2) & 0xFF;
		ce_printk("at memory address %lx row %d syndrome %x\n",
			(long unsigned int)eap, find_row(eap), derrsyn);
		scrub_needed = 1;
		scrub_row = find_row(eap);
		bank[scrub_row].sbecount++;
	}
}

static void probe_850(void)
{
	int loop;
	int mchcfg;
	int ddim[] = { ECC_NONE, ECC_RESERVED, ECC_CORRECT, ECC_RESERVED };
	mchcfg = pci_word(0x50);
	cs.ecc_cap = ECC_CORRECT;
	cs.ecc_mode = ddim[(mchcfg>>7)&3];

	cs.check = check_850;

	for(loop=0;loop<16;loop++)
	{
		bank[loop].endaddr=(unsigned long)pci_word(0x60+(loop*2))<<24;
		bank[loop].mtype = BANK_RMBS;
		bank[loop].eccmode = cs.ecc_mode;
	}
}

/* i860 identification */
#define I860_DID_VAL		0x2531	/* i860 MCH device ID */

/* i860 register addresses - device 0 */
#define I860_ERRSTS		0xC8	/* error status register (16b) */
#define I860_EAP		0xE4	/* error address pointer reg (32b) */
#define I860_DERRCTL_STS	0xE2	/* dram error control/stat reg (16b) */
#define I860_MCHCFG		0x50	/* MCH configuration register (16b) */
#define I860_GBA		0x60	/* RDRAM device group boundary addr */
					/*     16 registers (16b/reg) */

/* 860 specific error clearing */
static void clear_860_err(void)
{
	pci_write_bits16(I860_ERRSTS, 3, 3);
	/* as scrubbing is unimplemented, we reset it here */
	scrub_needed = 0;
	cs.clear_err = 0;
}            

static void check_860(void)
{
	u16 errsts = pci_word(I860_ERRSTS);
	if ((errsts>>1) & 1)
	{
		u32 eap = (pci_dword(I860_EAP) & 0xFFFFFE00)<<2;
		int channel = pci_dword(I860_EAP) & 1;
		unsigned char derrsyn = pci_word(I860_DERRCTL_STS) & 0xFF;
		ue_printk("at memory address %08lx bank %d syndrome %02x channel %s\n",
			(long unsigned int)eap, find_row(eap), derrsyn,
			channel == 0 ? "A" : "B");
		scrub_needed = 2;
		scrub_row = find_row(eap);
		bank[scrub_row].mbecount++;
		cs.clear_err = clear_860_err;
	}
	if (errsts & 1)
	{
		u32 eap = (pci_dword(I860_EAP) & 0xFFFFFE00)<<2;
		int channel = pci_dword(I860_EAP) & 1;
		unsigned char derrsyn = pci_word(I860_DERRCTL_STS) & 0xFF;
		ce_printk("at memory address %08lx bank %d syndrome %02x channel %s\n",
			(long unsigned int)eap, find_row(eap), derrsyn,
			channel == 0 ? "A" : "B");
		scrub_needed = 1;
		scrub_row = find_row(eap);
		bank[scrub_row].sbecount++;
		cs.clear_err = clear_860_err;
	}

	/* Panic for other error conditions we don't specifically deal with */
	if (errsts & 0xfc)
		panic("ECC: MCH ERRSTS register contains 0x%x\n", errsts);
}

static void probe_860(void)
{
	int loop;
	u16 drc;
	int ddim[] = { ECC_NONE, ECC_RESERVED, ECC_CORRECT, ECC_RESERVED };
	drc = pci_word(I860_MCHCFG);
	cs.ecc_cap = ECC_CORRECT;
	cs.ecc_mode = ddim[(drc>>7)&3];

	cs.check = check_860;

	for(loop=0;loop<16;loop++)
	{
		bank[loop].endaddr=(unsigned long)pci_word(I860_GBA+(loop*2))<<24;
		bank[loop].mtype = BANK_RMBS;
		bank[loop].eccmode = cs.ecc_mode;
	}
	clear_860_err();
}

static char find_e7500_dimm(u16 syndrome)
{
	if((syndrome & 0xff00)==0)
		return('A');
	if((syndrome & 0x00ff)==0)
		return('B');
	if((syndrome & 0xf000)==0)
		return('A');
	if((syndrome & 0x0f00)==0)
		return('A');
	return('B');
}

static u32 remapped_mem(u32 blk_4k)
{
	u32 remap;

	if(blk_4k < tolm)
		return(blk_4k);
	if((blk_4k >= 0x100000)&&(blk_4k < remapbase))
		return(blk_4k);
	remap = (blk_4k - tolm) + remapbase;
	if(remap < remaplimit)
		return(remap);	
	printk(KERN_ERR "Invalid 4k block %x - out of range\n",blk_4k);
	return(tolm-1);
}

/* E7500 register addresses - device 0 function 0 */
#define E7500_DRB		0x60	/* dram row boundary register (8b) */
#define E7500_DRA		0x70	/* dram row attribute register (8b) */
#define E7500_DRC		0x7C	/* dram configuration register (32b) */
#define E7500_TOLM		0xC4	/* dram top of low memory reg (16b) */
#define E7500_REMAPBASE		0xC6	/* dram remap base address reg (16b) */
#define E7500_REMAPLIMIT	0xC8	/* dram remap limit address reg (16b) */
/* E7500 register addresses - device 0 function 1 */
#define E7500_DRAM_FERR		0x80	/* dram first error register (8b) */
#define E7500_DRAM_NERR		0x82	/* dram next error register (8b) */
#define E7500_DRAM_CELOG_ADD	0xA0	/* dram first correctable memory */
					/*     error address register (32b) */
#define E7500_DRAM_UELOG_ADD	0xB0	/* dram first uncorrectable memory */
					/*     error address register (32b) */
#define E7500_DRAM_CELOG_SYNDROME 0xD0	/* dram first correctable memory */
					/*     error syndrome register (16b) */


static void e7500_process_correctable_error(void)
{
	int index;
	u32 error_1b, block_4k, remapped_4k;
	u16 syndrome;
	char dimm;

	/* read the error address */
	pci_read_config_dword(bridge_ck,E7500_DRAM_CELOG_ADD, 
				&error_1b);
	block_4k = error_1b >>6;  /* convert the address to 4k block */
	index=find_row_4k(block_4k); /* get the bank index */
	/* read the syndrome */
	pci_read_config_word(bridge_ck,E7500_DRAM_CELOG_SYNDROME,
			&syndrome);
	dimm = find_e7500_dimm(syndrome); /* convert the syndrome to dimm A or B */
	ce_printk("at 4k memory address %lx bank %d dimm %c syndrome %x\n",
			(long unsigned int)block_4k, index, dimm,
			syndrome);

	bank[index].sbecount++;
	if(dimm == 'A')
		bank[index].sbe_dimm_a++;
	if(dimm == 'B')
		bank[index].sbe_dimm_b++;
	/* get the virtual address */
	remapped_4k = remapped_mem(block_4k);
	scrub_page_virt(remapped_4k); /* scrub the 4k block */
}

static void e7500_process_correctable_error_no_info(void)
{
	ce_printk("at unknown memory address and bank\n");
}

static void e7500_process_uncorrectable_error(void)
{
	int index;
	u32 error_2b, block_4k;

	/* read the error address */
	pci_read_config_dword(bridge_ck,E7500_DRAM_UELOG_ADD,
			&error_2b);
	block_4k = error_2b >>6;  /* convert to 4k address */
	index=find_row_4k(block_4k);  /* find the bank index */
	ue_printk("at 4k memory address %lx bank %d (CE-A %d CE-B %d)\n",
			(long unsigned int)block_4k, index,
			bank[index].sbe_dimm_a, bank[index].sbe_dimm_b);
	bank[index].mbecount++;
}

static void e7500_process_uncorrectable_error_no_info(void)
{
	ue_printk("at unknown memory address and bank\n");
}


static void check_e7500(void)
{
	u8  error_one, error_next;

	pci_read_config_byte(bridge_ck,E7500_DRAM_FERR,&error_one);
	pci_read_config_byte(bridge_ck,E7500_DRAM_NERR,&error_next);

	if(error_one & 1) { /* check first error correctable */
		e7500_process_correctable_error();
		if(error_next & 1) {  /* check next error correctable */
			e7500_process_correctable_error_no_info();
		}
		if(error_next & 2) {  /* check next error uncorrectable */
			e7500_process_uncorrectable_error();
		}
	}
	else if(error_one & 2) { /* check first error uncorrectable */
		e7500_process_uncorrectable_error();
		if(error_next & 1) {  /* check next error correctable */
			e7500_process_correctable_error();
		}
		if(error_next & 2) {  /* check next error uncorrectable */
			e7500_process_uncorrectable_error_no_info();
		}
	}

	/* clear any error bits */
	if(error_one & 3) {
		pci_write_config_byte(bridge_ck,E7500_DRAM_FERR,
				(error_one & 3));
	}
	if(error_next & 3) {
		pci_write_config_byte(bridge_ck,E7500_DRAM_NERR,
				(error_next & 3));
	}
}

static void probe_e7500(void)
{
	int loop,index;
	u32 drc;
	int ddim[] = { ECC_NONE, ECC_RESERVED, ECC_CORRECT, ECC_RESERVED };
	u8 error_one, error_next;
	u16 pci_data;

	drc = pci_dword(E7500_DRC);
	cs.ecc_cap = ECC_CORRECT;
	cs.ecc_mode = ddim[(drc>>20)&3];

	cs.check = check_e7500;
	use_4k_blocks=1;
	use_ab_dimm=1;

	/* The dram row boundary (DRB) reg values are boundary address
	 * for each DRAM row with a granularity of 64MB.  DRB regs are
	 * cumulative; therefore DRB7 will contain the total memory contained
	 * in all eight rows.
	 */
	for(loop=0;loop<8;loop++)
	{
		bank[loop].endaddr_4k=
			(unsigned long)pci_byte(E7500_DRB+(loop))<<14;
	}

	for(loop=index=0;loop<8;) {
		/* If double-sided, use odd DRB as endaddr.
		 * If single sided, odd DRB is equal to even anyway.
		 */
		bank[index].endaddr_4k=bank[loop+1].endaddr_4k;
		bank[index].mtype = BANK_DDR;
		bank[index].eccmode = cs.ecc_mode;
		index++;
		loop+=2;
	}
	for(;index<8;index++)
		bank[index].endaddr_4k=0;

	bridge_ck = pci_find_device(vendor,0x2541,bridge_ck);
	if(!bridge_ck) {
		printk(KERN_ERR "Device not found vendor %x device 0x2541\n",
			vendor);
	}

	/* load the top of low memory, remap base, and remap limit vars */
	pci_read_config_word(bridge, E7500_TOLM, &pci_data);
	tolm = ((u32)pci_data) << 4;
	pci_read_config_word(bridge, E7500_REMAPBASE, &pci_data);
	remapbase = ((u32)pci_data) << 14;
	pci_read_config_word(bridge, E7500_REMAPLIMIT, &pci_data);
	remaplimit = ((u32)pci_data) << 14;
	printk("tolm = %x, remapbase = %x, remaplimit = %x\n",tolm,remapbase,remaplimit);

	/* clear any pending errors, or initial state bits */
	pci_read_config_byte(bridge_ck,E7500_DRAM_FERR,&error_one);
	error_one &= 3;
	if(error_one) {
		pci_write_config_byte(bridge_ck,E7500_DRAM_FERR,
				error_one);
	}
	pci_read_config_byte(bridge_ck,E7500_DRAM_NERR,&error_next);
	error_next &= 3;
	if(error_next) {
		pci_write_config_byte(bridge_ck,E7500_DRAM_NERR,
				error_next);
	}

	if (cs.ecc_mode != ECC_CORRECT)
		printk("ECC: warning: ECC mode not enabled\n");
}

static void check_amd751(void)
{
	int eccstat = pci_word(0x58);
	int csbits = eccstat & 0x3F;
	int row;
	switch (csbits)
	{
		case 1: row = 0; break;
		case 2: row = 1; break;
		case 4: row = 2; break;
		case 8: row = 3; break;
		case 16: row = 4; break;
		case 32: row = 5; break;
		default: row = 6;
	}
	switch ((eccstat>>8)&3)
	{
		case 1: printk(KERN_ERR "ECC: MBE Detected in DRAM row %d\n", row);
			scrub_needed=2;
			bank[row].mbecount++;
			break;
		case 2: printk(KERN_ERR "ECC: SBE Detected in DRAM row %d\n", row);
			scrub_needed=1;
			bank[row].sbecount++;
			break;
		case 3: printk(KERN_ERR "ECC: SBE and MBE Detected in DRAM row %d\n", row);
			scrub_needed=1;
			bank[row].sbecount++;
			break;
	}
	if (scrub_needed)
	{
		/*
		 * clear error flag bits that were set by writing 0 to them
		 * we hope the error was a fluke or something :)
		 */
		int value = eccstat & 0xFCFF;
		pci_write_config_word(bridge, 0x58, value);
		scrub_needed = 0;
        }
}

static void probe_amd751(void)
{
	int loop;
	cs.ecc_cap = ECC_CORRECT;
	cs.ecc_mode = (pci_byte(0x5a)>>2)&1 ? ECC_CORRECT : ECC_NONE;
	cs.check = check_amd751;
	for(loop=0;loop<6;loop++)
	{
		unsigned flag = pci_byte(0x40+loop*2);
		/* bank address mask. */
		unsigned mask = (flag&0x7F)>>1;
		/* actually starting address */
		bank[loop].endaddr=(unsigned long)(pci_word(0x40+loop*2)&0xFF80)<<(23-7);
		/* only when bank is populated */
		if((flag&1)&&(mask!=0)){
			/* mask+1 * 8mb appears to be bank size */
			bank[loop].endaddr += (mask + 1) * 8 * (1024 * 1024); /* -1? */
		}
		bank[loop].mtype = flag&1 ? BANK_SDR : BANK_EMPTY;
		bank[loop].eccmode = cs.ecc_mode;
	}
}

static void check_amd76x(void)
{
	unsigned long eccstat = pci_dword(0x48);
	if(eccstat & 0x100)
	{
		int row = (eccstat >> 4) & 0xf;
		ue_printk("in DRAM row %d\n", row);
		bank[row].mbecount++;
	}
	if(eccstat & 0x200)
	{
		int row = eccstat & 0xf;
		ce_printk("in DRAM row %d\n", row);
		bank[row].sbecount++;
	}
	if(eccstat & 0x300) /* clear ECC_Status */
		pci_write_config_dword(bridge, 0x48, eccstat);
}

static void probe_amd76x(void)
{
	static const int modetab[] = {ECC_NONE, ECC_DETECT, ECC_CORRECT, ECC_AUTO};
	int loop;
	unsigned long addr = 0;
	cs.ecc_cap = ECC_AUTO;
	cs.ecc_mode = modetab [(pci_dword(0x48)>>10)&3];
	cs.check = check_amd76x;

	for(loop=0;loop<8;loop++)
	{
		unsigned long r = pci_dword(0xc0+(loop*4));
		bank[loop].mtype = r & 1 ? BANK_DDR : BANK_EMPTY;
		if (r & 1)
			addr += ((r & 0xff80) << 16) + 0x800000;
		bank[loop].endaddr = addr;
		bank[loop].eccmode = cs.ecc_mode;
	}
	pci_write_config_dword(bridge, 0x48, pci_dword(0x48) | 0x300);
}

static void probe_sis(void)
{
	int loop;
	u32 endaddr;
	int m_mem[] = { BANK_FPM, BANK_EDO, BANK_RESERVED, BANK_SDR };
	int dramsize[] = { 256, 1024, 4096, 16384, 1024, 2048, 4096,
		8192, 512, 1024, 2048, 0, 0, 0, 0, 0 };
	int sdramsize[] = { 1024, 4096, 4096, 8192, 2048, 8192,
		8192, 16384, 4096, 16384, 16384, 32768, 2048, 0, 0, 0 };

	cs.ecc_cap = ECC_CORRECT;

	cs.check = generic_check;

	cs.MBE_flag_address = 0x64;
	cs.MBE_flag_shift = 4;
	cs.MBE_flag_mask = 1;
	cs.MBE_row_shift = 5;
	cs.MBE_row_mask = 7;

	cs.SBE_flag_address = 0x64;
	cs.SBE_flag_shift = 3;
	cs.SBE_flag_mask = 1;
	cs.SBE_row_shift = 5;
	cs.SBE_row_mask = 7;

	cs.MBE_err_address1 = 0x64;
	cs.MBE_err_shift1 = 0;
	cs.MBE_err_address2 = 0x66;
	cs.MBE_err_shift2 = 16;
	cs.MBE_err_mask = 0xFFFFF000;

	cs.SBE_err_address1 = 0x64;
	cs.SBE_err_shift1 = 0;
	cs.SBE_err_address2 = 0x66;
	cs.SBE_err_shift2 = 16;
	cs.MBE_err_mask = 0xFFFFF000;

	endaddr = 0;
	for(loop=0;loop<3;loop++)
	{
		/* populated bank? */
		if ((pci_byte(0x63)>>loop)&1)
		{
			u32 banksize;
			int mtype = pci_byte(0x60+loop);

			bank[loop*2].mtype = m_mem[(mtype>>6)&3];
			if(bank[loop*2].mtype == BANK_SDR)
			{
				banksize = sdramsize[mtype&15]*1024;
			} else {
				banksize = dramsize[mtype&15]*1024;
			}
			endaddr += banksize;
			bank[loop*2].endaddr = endaddr;
			/* double sided dimm? */
			if ((mtype>>5)&1)
			{
				bank[(loop*2)+1].mtype = bank[loop*2].mtype;
				endaddr += banksize;
				bank[(loop*2)+1].endaddr = endaddr;
			}
		} else {
			bank[loop*2].mtype = BANK_EMPTY;
			bank[(loop*2)+1].mtype = BANK_EMPTY;
			bank[loop*2].endaddr = endaddr;
			bank[(loop*2)+1].endaddr = endaddr;
		}
	}
	cs.ecc_mode = ECC_NONE;
	for(loop=0;loop<6;loop++)
	{
		int eccmode = (pci_byte(0x74)>>loop)&1;
		bank[loop].eccmode = eccmode;
		if(eccmode)
			cs.ecc_mode = ECC_CORRECT;
	}
}

static void probe_aladdin4(void)
{
	int loop;
	int m_mem[] = { BANK_FPM, BANK_EDO, BANK_RESERVED, BANK_SDR };
	cs.ecc_cap = ECC_CORRECT;
	cs.ecc_mode = pci_byte(0x49)&1 ? ECC_CORRECT : ECC_PARITY;

	cs.check = generic_check;

	cs.MBE_flag_address = 0x4a;
	cs.MBE_flag_shift = 4;
	cs.MBE_flag_mask = 1;
	cs.MBE_row_shift = 5;
	cs.MBE_row_mask = 7;

	cs.SBE_flag_address = 0x4a;
	cs.SBE_flag_shift = 0;
	cs.SBE_flag_mask = 1;
	cs.SBE_row_shift = 1;
	cs.SBE_row_mask = 7;

	for(loop=0;loop<8;loop++)
	{
		bank[loop].endaddr = (unsigned long)(pci_byte(0x61+(loop*2))&15)<<27|(pci_byte(0x60+(loop*2))<<20);
		bank[loop].mtype = m_mem[(pci_byte(0x61+(loop*2))>>4)&3];
		bank[loop].eccmode = ( cs.ecc_mode == ECC_CORRECT ? ECC_CORRECT : ECC_NONE );
	}
}

static void probe_aladdin5(void)
{
	int loop;
	int m_mem[] = { BANK_FPM, BANK_EDO, BANK_RDR, BANK_SDR };
	cs.ecc_cap = ECC_CORRECT;
	cs.ecc_mode = pci_byte(0x50)&1 ? ECC_CORRECT : ECC_PARITY;

	cs.check = generic_check;

	cs.MBE_flag_address = 0x51;
	cs.MBE_flag_shift = 4;
	cs.MBE_flag_mask = 1;
	cs.MBE_row_shift = 5;
	cs.MBE_row_mask = 7;

	cs.SBE_flag_address = 0x51;
	cs.SBE_flag_shift = 0;
	cs.SBE_flag_mask = 1;
	cs.SBE_row_shift = 1;
	cs.SBE_row_mask = 7;

	for(loop=0;loop<8;loop++)
	{
		/* DBxCII not disabled address mapping? */
		if(pci_byte(0x61+(loop*2))&0xF0)
		{
			/* endaddr always 1 unit low, granularity 1mb */
			bank[loop].endaddr = (unsigned long)((pci_byte(0x61+(loop*2))&15)<<27|(pci_byte(0x60+(loop*2))<<20))+1048576;
			bank[loop].mtype = m_mem[(pci_byte(0x61+(loop*2))>>4)&3];
			bank[loop].eccmode = ( cs.ecc_mode == ECC_CORRECT ? ECC_CORRECT : ECC_NONE );
		}
	}
}

static void scrub_page_virt(u32 p_4k_blk)
{
        struct page *pg;
	volatile u32 *virt_addr;
	int i;

	if(p_4k_blk > max_mapnr)
		return;		/* pointer is beyond memory, so bail */
	pg = mem_map + p_4k_blk;

	virt_addr = kmap_atomic(pg,KM_BOUNCE_READ);

	for(i = 0; i < 1024; i++, virt_addr++) {	
		/* Very carefully read and write to memory atomically
		 * so we are interrupt and smp safe manner.
		 */
		__asm__ __volatile__(
			"lock; addl $0, %0"
			:: "m" (*virt_addr));
	}
	kunmap_atomic(pg,KM_BOUNCE_READ);
}

#if 0
/*
 * memory scrubber routines, not ready to be used yet...
 */
/* start at 16mb */
static unsigned long start = 4096;
static unsigned long pages = 1;
/* other architectures have different page sizes... */
static unsigned long step = 4096;

static char buff[8192] = {0,};

/*
 * Michael's page scrubber routine
 */
static void scrub_page(unsigned long volatile * p)
{
	int i;
	int len, err = 0;
	unsigned long *q;
	q = (unsigned long *) ((((int)buff)+4095) & ~4095);

	if (((int)p) >= 640 * 1024 && ((int)p) < 1024 * 1024)
		return;

	cli();	/* kill interrupts */
	err = pci_byte(0x91);
	outb(0x11, PCI_DATA + 1); /* clear the memory error indicator */

	for (i = 0; i < step / 4 ; ++i)
		q[i] = p[i];
	for (i = 0; i < step / 4 ; ++i)
		p[i] = q[i];
	err = inb(PCI_DATA + 1);
	sti();
	if (err & 0x11) {
		printk(KERN_ERR "ECC: Memory error @ %08x (0x%02x)\n", p, err);
		return 1;
	}
	return 0;
}

static void scrub(void)
{
	int i,j = 0;
	for (i = 0; i < pages; ++i) {
		j = scrub_page(start);
		start += step;
	}
	if (!j) {
		/*
		 * Hmm... This is probably a very bad situation.
		 */
		printk(KERN_ERR "ECC: Scrubbed, no errors found?!\n");
		scrub_needed=0;
		return;
	}
	if (scrub_needed==2) {
		/*
		 * TODO: We should determine what process owns the memory
		 * and send a SIGBUS to it. We should also printk something
		 * along the lines of
		 * "ECC: Process (PID) killed with SIGBUS due to uncorrectable memory error at 0xDEADBEEF"
		 */
		scrub_needed=0;
	}
}
#endif

static void check_ecc(unsigned long);

/*
 * Check ECC status every second.
 * SMP safe, doesn't use NMI, and auto-rate-limits.
 */
static void check_ecc(unsigned long dummy) 
{
	spin_lock (&ecc_lock);

	if (!scrub_needed)
		if (cs.check)
			cs.check();
	if (cs.clear_err)
		cs.clear_err();

	ecc_timer.expires = jiffies + (HZ * poll_msec) /1000;
	add_timer(&ecc_timer);

	spin_unlock (&ecc_lock);
}

#ifdef CONFIG_PROC_FS
static char *ecc_mode[] = {
	"no", "?", "par", "det", "ecc", "scrub", "?"
};

static char *ecc_type[] = { 
	"None", "Reserved", "Parity checking", "ECC detection",
	"ECC detection and correction", "ECC with hardware scrubber",
	"Skip"
};

static char *dram_type[] = { 
	"Empty", "Reserved", "Unknown", "FPM", "EDO",
		"BEDO", "SDR", "DDR", "RDR", "RMBS" 
};

static int ecc_proc_output(char *buf)
{	
	int loop;
	u32 last_mem, mem_end;
	char *p = buf;

	p += sprintf(p, "Chipset ECC capability : %s\n", ecc_type[cs.ecc_cap]);
	p += sprintf(p, "Current ECC mode : %s\n", ecc_type[cs.ecc_mode]);
	p += sprintf(p, "Bank\tSize-MB\tType\tECC\tCE\tUE\tCE-A\tCE-B\n");
	
	mem_end = 0;
	for (loop=0;loop<MAX_BANKS;loop++){
		if(use_4k_blocks)
			last_mem=bank[loop].endaddr_4k;
		else
			last_mem=bank[loop].endaddr;
		if (last_mem>mem_end) {
			p += sprintf(p, "%d\t", loop);
			if(use_4k_blocks){
				p += sprintf(p, "%4d\t", 
				     (int)((last_mem-mem_end)>>8));
			}
			else {
				p += sprintf(p, "%d\t", 
				     (int)((last_mem-mem_end)>>20));
			}
			p += sprintf(p, "%s\t", dram_type[bank[loop].mtype]);
			p += sprintf(p, "%s\t", 
				     ecc_mode[bank[loop].eccmode]);
			p += sprintf(p, "%ld\t", 
				     (unsigned long) bank[loop].sbecount);
			p += sprintf(p, "%ld\t", 
				     (unsigned long) bank[loop].mbecount);
			if(use_ab_dimm) {
			    p += sprintf(p, "%ld\t%ld\n", 
				     (unsigned long) bank[loop].sbe_dimm_a,
				     (unsigned long) bank[loop].sbe_dimm_b);
			} else {
			    p += sprintf(p, "-\t-\n");
			}
			mem_end=last_mem;
		}
	}

	p += sprintf(p, "Total\t\t%d\n", 
			(int)(use_4k_blocks ? (mem_end>>8) : (mem_end>>20)));

	return p - buf;
}

static int ecc_read_proc(char *page, char **start, off_t off,
                         int count, int *eof, void *data)
{
	int len;

	spin_lock_bh (&ecc_lock);

        len = ecc_proc_output (page);
        if (len <= off+count) *eof = 1;
        *start = page + off;
        len -= off;
        if (len>count) len = count;
        if (len<0) len = 0;

	spin_unlock_bh (&ecc_lock);

        return len;
}
#endif

struct cs_table_struct {
	int vendor;		/* pci vendor id */
	int device;		/* pci device id */
	void (*probe)(void);	/* pointer to chipset probing routine */
	char *csname;		/* chipset name */
};

static struct cs_table_struct cs_table[] = {
	/* AMD */
	{ 0x1022, 0x7006, probe_amd751, "amd751" },
	{ 0x1022, 0x700c, probe_amd76x, "amd760mp" },
	{ 0x1022, 0x700e, probe_amd76x, "amd760" },
	/* Motorola */
	{ 0x1057, 0x4802, 0, "falcon" }, /* not yet supported */
	{ 0x1057, 0x4803, 0, "hawk" }, /* not yet supported */
	/* Apple */
	{ 0x106b, 0x0001, 0, "bandit" }, /* not yet supported */
	/* SiS */
	{ 0x1039, 0x0600, probe_sis, "sis600" }, /* programatically same as 5600 */
	{ 0x1039, 0x0620, 0, "sis620" }, /* 620 doesnt support ecc */
	{ 0x1039, 0x5600, probe_sis, "sis5600" },
	/* ALi */
	{ 0x10b9, 0x1531, probe_aladdin4, "m1531" },
	{ 0x10b9, 0x1541, probe_aladdin5, "m1541" },
	{ 0x10b9, 0x1647, 0, "m1647" }, /* magik1 - no documentation yet */
	/* VIA */
	{ 0x1106, 0x0305, probe_via, "vt8363" }, /* kt133/km133 */
	{ 0x1106, 0x0391, probe_via, "vt8371" }, /* kx133 */
	{ 0x1106, 0x0501, probe_via, "vt8501" }, /* mvp4 */
	{ 0x1106, 0x0585, probe_via, "vt82c585" }, /* vp/vpx */
	{ 0x1106, 0x0595, probe_via, "vt82c597" }, /* vp2 */
	{ 0x1106, 0x0597, probe_via, "vt82c597" }, /* vp3 */
	{ 0x1106, 0x0598, probe_via, "vt82c598" }, /* mvp3 */
	{ 0x1106, 0x0691, probe_via, "vt82c691" }, /* pro133/pro133a */
	{ 0x1106, 0x0693, probe_via, "vt82c693" }, /* pro+ */
	{ 0x1106, 0x0694, probe_via, "vt82c694" }, /* pro133a */
	{ 0x1106, 0x3099, probe_via, "vt8366/vt8367" }, /* kt266/kt266a/kt333 */
	{ 0x1106, 0x3128, probe_via, "vt8753/vt8753a" }, /* p4x266/p4x266a */
	{ 0x1106, 0x3148, probe_via, "vt8751" }, /* p4m266 */
	{ 0x1106, 0x3156, probe_via, "vt8372/vt8375" }, /* kn266/km266 */
	{ 0x1106, 0x3168, probe_via, "vt8754" }, /* p4m333 */
	/* Serverworks */
	{ 0x1166, 0x0008, probe_cnb20he, "CNB20HE" }, /* CNB20HE - serverset iii he */
	{ 0x1166, 0x0009, probe_cnb30le, "CNB20LE/CNB30LE" }, /* serverset iii le */
	/* Intel */
	{ 0x8086, 0x1130, 0, "i815" }, /* doesnt support ecc */
	{ 0x8086, 0x122d, 0, "430fx" }, /* doesnt support ecc */
	{ 0x8086, 0x1237, probe_440fx, "440fx" },
	{ 0x8086, 0x1250, probe_430hx, "430hx" },
	{ 0x8086, 0x2500, probe_820, "i820" },
	{ 0x8086, 0x1A21, probe_840, "i840" },
	{ 0x8086, 0x1A30, probe_845, "i845" },
	{ 0x8086, 0x2530, probe_850, "i850/i850e" },
	{ 0x8086, 0x2531, probe_860, "i860" },
	{ 0x8086, 0x2540, probe_e7500, "e7500" },
	{ 0x8086, 0x7030, 0, "430vx" }, /* doesnt support ecc */
	{ 0x8086, 0x7120, 0, "i810" }, /* 810 doesnt support ecc */
	{ 0x8086, 0x7122, 0, "i810dc" },
	{ 0x8086, 0x7124, 0, "i810e" }, /* 810e doesnt support ecc */
	{ 0x8086, 0x7180, probe_440lx, "440lx/ex" },
	{ 0x8086, 0x7190, probe_440bx, "440bx/zx" },
	{ 0x8086, 0x7192, probe_440bx, "440bx/zx" },
	{ 0x8086, 0x71A0, probe_440bx, "440bx/gx" },
	{ 0x8086, 0x71A2, probe_440bx, "440bx/gx" },
	{ 0x8086, 0x84C5, probe_450gx, "450gx" },
	{ 0x8086, 0x84CA, probe_450nx, "450nx" },
	{ 0, 0, 0 }
};

static int find_chipset(void) {

	if (!pci_present()) {
		printk(KERN_ERR "ECC: No PCI bus.\n");
		return 0;
	}

	while ((bridge = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, bridge)))
	{
		int loop = 0;
		pci_read_config_word(bridge, PCI_VENDOR_ID, &vendor);
		pci_read_config_word(bridge, PCI_DEVICE_ID, &device);
		while(cs_table[loop].vendor)
		{
			if( (vendor == cs_table[loop].vendor) &&
			    (device == cs_table[loop].device) )
			{
				if(cs_table[loop].probe)
				{
					cs_table[loop].probe();
					if (cs.ecc_cap == ECC_SKIP)
						break;
					printk(KERN_ERR "ECC: Found memory controller %x:%x - %s\n", vendor, device, cs_table[loop].csname);
					return 1;
				} else {
					printk(KERN_WARNING "ECC: Unsupported device %x:%x.\n", vendor, device);
					return 0;
				}
			}
			loop++;
		}
		if (cs.ecc_cap == ECC_SKIP)
			cs.ecc_cap = ECC_NONE;	/* probe said keep looking */
		else
			printk(KERN_DEBUG "ECC: Unknown device %x:%x.\n", vendor, device);
	}
	printk(KERN_ERR "ECC: Can't find host bridge.\n");
	return 0;
}

#if (LINUX_VERSION_CODE < 0x020401)
static int init_module(void)
#else
static int __init ecc_init(void) 
#endif
{
	int loop;
#if (LINUX_VERSION_CODE < 0x020401)
#ifdef CONFIG_PROC_FS
	struct proc_dir_entry *ent;
#endif
#endif
	spin_lock_bh (&ecc_lock);

	printk(KERN_INFO "ECC: monitor version %s\n", ECC_VER);
	if (poll_msec != 1000)
		printk(KERN_INFO "ECC: interval=%d ticks\n", poll_msec/1000);

	for (loop=0;loop<MAX_BANKS;loop++) {
		bank[loop].endaddr = 0;
		bank[loop].endaddr_4k = 0;
		bank[loop].sbecount = 0;
		bank[loop].mbecount = 0;
		bank[loop].sbe_dimm_a = 0;
		bank[loop].sbe_dimm_b = 0;
		bank[loop].eccmode = 0;
		bank[loop].mtype = ECC_RESERVED;
	}

	if (!find_chipset()) {
		spin_unlock_bh (&ecc_lock);
		return -ENODEV;
	}

	init_timer(&ecc_timer);
	ecc_timer.function = check_ecc;
	ecc_timer.expires = jiffies + (HZ * poll_msec) /1000;
	add_timer(&ecc_timer);

	/* must unlock bh before create_proc_entry call */
	spin_unlock_bh (&ecc_lock);

#ifdef CONFIG_PROC_FS
#if (LINUX_VERSION_CODE < 0x020401)
	ent = create_proc_entry("ram", S_IFREG | S_IRUGO, 0);
	if (ent) {
		ent->nlink = 1;
		ent->read_proc = ecc_read_proc;
	}
#else
	create_proc_read_entry("ram", 0, 0, ecc_read_proc, 0);
#endif
#endif
#ifdef CONFIG_SYSCTL
        ecc_sysctl_header = register_sysctl_table(ecc_root_table, 1);
#endif /* CONFIG_SYSCTL */
	return 0; 
}

#if (LINUX_VERSION_CODE < 0x020401)
static void cleanup_module(void) 
#else
static void __exit ecc_exit(void) 
#endif
{
	spin_lock (&ecc_lock);

#ifdef CONFIG_PROC_FS
	remove_proc_entry("ram", 0);
#endif
#ifdef CONFIG_SYSCTL
        if (ecc_sysctl_header) {
                unregister_sysctl_table(ecc_sysctl_header);
                ecc_sysctl_header = NULL;
        }
#endif /* CONFIG_SYSCTL */

	del_timer_sync(&ecc_timer);

	printk(KERN_DEBUG "ECC: unloaded.\n");

	spin_unlock (&ecc_lock);
}

EXPORT_NO_SYMBOLS;

MODULE_AUTHOR("Dan Hollis <goemon at anime dot net> et al");
MODULE_DESCRIPTION("ECC Module");
#if (LINUX_VERSION_CODE > 0x020408)
MODULE_LICENSE("GPL");
MODULE_PARM(ecc_scrub, "i");
MODULE_PARM_DESC(ecc_scrub, "Force ECC scrubbing: 0=off 1=on (serversetIIIle)");
MODULE_PARM(panic_on_uncorrected, "i");
MODULE_PARM_DESC(panic_on_uncorrected, "Panic on uncorrected error: 0=off 1=on");
MODULE_PARM(log_uncorrected, "i");
MODULE_PARM_DESC(log_uncorrected, "Log uncorrectable error to console: 0=off 1=on");
MODULE_PARM(log_corrected, "i");
MODULE_PARM_DESC(log_corrected, "Log correctable error to console: 0=off 1=on");
MODULE_PARM(poll_msec, "i");
MODULE_PARM_DESC(poll_msec, "Polling interval: msec");

module_init(ecc_init);
module_exit(ecc_exit);
#endif

