Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWFVNlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWFVNlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWFVNlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:41:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:57581 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751787AbWFVNlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:41:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=SjjNDaq+2ifl8MMloL04c+KkkwRgLWOn7ZDHfbDPKZiK58Jaisi/2y45HmfwR/44pRIt8g5dr2vpqJNg5Cajv5VvfKBLHsQ4TXrG0kCpA75x3UYMdVf/B/3gVTPkFwc5ENQU23HyK4oqBuail/31g9aHirIXyjunZ6cec5CXr5g=
Message-ID: <449A9DE3.2030704@gmail.com>
Date: Thu, 22 Jun 2006 15:40:28 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: "Straub, Michael" <Michael.Straub@avocent.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 8/13] Equinox SST driver: driver init and shutdown
References: <4821D5B6CD3C1B4880E6E94C6E70913E01B7110D@sun-email.corp.avocent.com>
In-Reply-To: <4821D5B6CD3C1B4880E6E94C6E70913E01B7110D@sun-email.corp.avocent.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Straub, Michael napsal(a):
> Adds Equinox multi-port serial (SST) driver.
> 
> Part 8: new source file: drivers/char/eqnx/sst.c.  Driver "main".  Does
> the
> initialization and cleanup for the driver.  Verifies and initializes any
> discovered SST boards.
> 
> Major number and TTY devices names have been lanana assigned.
> 
> Signed-off-by: Mike Straub <michael.straub@avocent.com>
> 
> ---
>  sst.c | 1626
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 1626 insertions(+)
> 
> diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/sst.c
> linux-2.6.17.eqnx/drivers/char/eqnx/sst.c
> --- linux-2.6.17/drivers/char/eqnx/sst.c	1969-12-31
> 19:00:00.000000000 -0500
> +++ linux-2.6.17.eqnx/drivers/char/eqnx/sst.c	2006-06-20
> 09:50:08.000000000 -0400
> @@ -0,0 +1,1626 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +/*
> + * This driver supports the PCI models of the Equinox / Avocent SST
> boards
> + * using SSP-4 and SSP-64 ASIC technology
> + * Boards supported:
> + * SSP-4P
> + * SSP-8P
> + * SSP-16P
> + * SSP-64P
> + * SSP-128P
> + *
> + * Currently maintained by mike straub <michael.straub@avocent.com>
> + */
> +
> +/*
> + * driver "main" - discovers and initializes all SST boards
> + */
> +
> +char eqnx_version[] = "Equinox / Avocent SuperSerial Technology Device
> Driver";

static?

> +
> +#include <linux/config.h>
> +#include <linux/version.h>
> +
> +#ifdef CONFIG_MODVERSIONS
> +#define MODVERSIONS	1
> +#endif
> +
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +
> +#ifdef  MODULE_LICENSE
> +MODULE_LICENSE("GPL");
> +#endif

why ifdefs?

> +
> +#include <linux/vermagic.h>
> +#include <linux/compiler.h>
> +MODULE_INFO(vermagic, VERMAGIC_STRING);
> +static const struct modversion_info ____versions[]
> +    __attribute__ ((section("__versions"))) = {
> +};

?

> +
> +#include <linux/sched.h>
> +#include <linux/timer.h>
> +#include <linux/wait.h>
> +#include <linux/tty.h>
> +#include <linux/serial.h>
> +#include <linux/major.h>
> +#include <linux/mm.h>
> +#include <linux/ioport.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/list.h>
> +#include <linux/isapnp.h>
> +#include <asm/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/kdev_t.h>
> +#include <linux/devfs_fs_kernel.h>
> +#include <linux/device.h>
> +#include <linux/pci_ids.h>
> +
> +#include "eqnx_def.h"
> +#include "eqnx.h"
> +#include "icp.h"
> +
> +/**********************************************************************
> ***
> + *
> + * global variables and structures
> + *
> +
> ************************************************************************
> */
> +
> +/* maximum number of boards, MAXSSP may be redefined */
> +static int maxbrd = MAXSSP;
> +
> +/* number of boards and ICPs found */
> +int eqnx_nssps = 0;
> +int eqnx_nicps = 0;

static?

> +
> +/* adapter structures - one for each board */
> +struct mpdev eqnx_dev[MAXSSP];

...

> +
> +/* channel structures - one for each channel */
> +struct mpchan *eqnx_chan;

...

> +
> +/* tty driver and termios structs */
> +static struct tty_driver *eqnx_driver;
> +
> +/* default termios */
> +static struct termios eqnx_deftermios = {
> +	.c_iflag = 0,
> +	.c_oflag = 0,
> +	.c_cflag = (B9600 | CS8 | CREAD | HUPCL | CLOCAL),
> +	.c_lflag = 0,
> +	.c_cc = INIT_C_CC
> +};
> +
> +/* major numbers */
> +static int din_num;
> +
> +/*
> + * per-channel hardware queue information
> + * index 0 for SSP64 boards, index 1 for SSP4 boards
> + */
> +static struct hwq_struct sst_hwq[] = {
> +	{HWQ4SIZE, HWQ4HIWAT, HWQ4LOWAT, HWQ4RXWRAP, HWQ4TXWRAP,
> HWQ4CMDSIZE},
> +	{HWQ1SIZE, HWQ1HIWAT, HWQ1LOWAT, HWQ1RXWRAP, HWQ1TXWRAP,
> HWQ1CMDSIZE},
> +};
> +
> +/* semaphores and timers */
> +struct timer_list eqnx_timer;
> +
> +/* local buffer for copying output characters. Used in eqnx_put_char */
> +char *eqnx_txcookbuf = (char *)NULL;

what is the cast for?

> +
> +/* initial - unknown board defintion */
> +static struct brdtab_t unknown_board = {
> +	NOID, NOID, 0, 1, 0, 0, "Unknown"
> +};
> +
> +/* board definition tables */
> +static struct brdtab_t board_table[] = {
> +	{0x8, 0x8, SSP64, 1, 64, POLL40, "SST-64P"},
> +	{0x10, 0x10, SSP64, 2, 128, POLL40, "SST-128P"},
> +	{0x14, 0x88, SSP4, 2, 8, RJ, "SST-8P/RJ"},
> +	{0x14, 0x90, SSP4, 2, 8, RJ, "SST-8P/RJ"},
> +	{0x68, 0x8, SSP64, 1, 64, POLL40, "SST-64P (HP)"},
> +	{0x70, 0x10, SSP64, 2, 128, POLL40, "SST-128P (HP)"},
> +	{0x88, 0x88, SSP4, 1, 4, 0, "SST-4P"},
> +	{0x8C, 0x88, SSP4, 1, 4, RJ, "SST-4P/RJ"},
> +	{0x90, 0x90, SSP4, 2, 8, 0, "SST-8P"},
> +	{0x94, 0x90, SSP4, 2, 8, RJ, "SST-8P/RJ"},
> +	{0x98, 0x98, SSP4, 2, 8, MM, "SST-MM8P"},
> +	{0x9C, 0x98, SSP4, 1, 4, MM, "SST-MM4P"},
> +	{0xA0, 0x88, SSP4, 1, 8, 0, "SST-4C 8"},
> +	{0xA4, 0x88, SSP4, 1, 4, 0, "SST-4C 4"},
> +	{0xAC, 0x88, SSP4, 1, 4, 0, "SST-4C 0"},
> +	{0xB0, 0x90, SSP4, 2, 8, 0, "SST-8C 8"},
> +	{0xB4, 0x90, SSP4, 2, 4, 0, "SST-8C 4"},
> +	{0xB8, 0x88, SSP4, 1, 4, LP, "SST-4P/LP"},
> +	{0xBC, 0x90, SSP4, 2, 8, 0, "SST-8C 0"},
> +	{0xC0, 0x80, SSP4, 4, 16, DB25_PAN, "SST-16P CP16-DB"},
> +	{0xC4, 0x80, SSP4, 4, 16, RJ_PAN, "SST-16P CP16-RJ"},
> +	{0xC8, 0x80, SSP4, 4, 16, NOPANEL, "SST-16P No panel"},
> +	{0xD0, 0x80, SSP4, 4, 16, DB9_PAN, "SST-16P CP16-DB9"},
> +	{0xD4, 0x80, SSP4, 2, 8, 0, "SST-8P-DB"},
> +	{0xEC, 0x88, SSP4, 1, 4, 0, "SST-4P,PWR"},
> +	{0xF0, 0x90, SSP4, 2, 8, 0, "SST-8P (HP)"},
> +	{0xF4, 0x90, SSP4, 2, 8, 0, "SST-8P,PWR"},
> +	{0xFC, 0x88, SSP4, 1, 4, LP, "SST-4P/ULP"},
> +};
> +
> +#ifdef	MODULE

nope

> +static struct pci_device_id eqnx_pcibrds[] = {
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST64P, PCI_ANY_ID,
> PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST128P, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST8PRJ, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST8PRJ2, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST64PHP, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST128PHP, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST4P, PCI_ANY_ID,
> PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST4PRJ, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST8P, PCI_ANY_ID,
> PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST8PRJ3, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SSTMM8P, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SSTMM4P, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST4PC8, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST4PC4, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST4PC0, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST8PC8, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST8PC4, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST4PLP, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST8PC0, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST16PDB, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST16PRJ, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST16PNP, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST16PDB9, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST8PDB, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST4PPWR, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST8PHP, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST8PPWR, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{PCI_VENDOR_ID_EQNX, PCI_DEVICE_ID_EQNX_SST4PULP, PCI_ANY_ID,
> +	 PCI_ANY_ID},
> +	{0}
> +};

use PCI_DEVICE()

> +
> +MODULE_DEVICE_TABLE(pci, eqnx_pcibrds);
> +#endif
> +
> +/* total number of entries */
> +static int brdtab_entries = sizeof board_table / sizeof(struct
> brdtab_t);
> +
> +static char *eqnPCIcfg;
> +
> +/**********************************************************************
> ***
> + *
> + * miscellaneous definitions
> + *
> +
> ************************************************************************
> */
> +
> +/* 16K register space for each ICP */
> +#define	HWREGSLEN	0x4000
> +
> +/* serial subtype definitions */
> +#define SERIAL_TYPE_NORMAL	1
> +#define SERIAL_TYPE_CALLOUT	2
> +
> +/**********************************************************************
> ***
> + *
> + * module declarations
> + *
> +
> ************************************************************************
> */
> +
> +#ifdef MODULE

nope

> +MODULE_AUTHOR("Mike Straub - Avocent Corporation");
> +MODULE_DESCRIPTION("Equinox/Avocent SST Driver");
> +MODULE_LICENSE("GPL");
> +#endif
> +
> +/**********************************************************************
> ***
> + *
> + * function declarations
> + *
> +
> ************************************************************************
> */
> +
> +static __init void brd_mem_cfg(struct mpdev *mpd);
> +static int eqnx_pcifindbrds(struct pci_cfg *);
> +
> +static __init int mem_zero(struct mpdev *mpd, unsigned short *ramw,
> +			   int testlen);
> +static __init int mem_test(struct mpdev *mpd, int icp);
> +static __init int mem_test_dram(struct mpdev *mpd, u16 * ramw, int
> testlen);
> +static __init int mem_test_pram(struct mpdev *mpd, u16 * ramw, int
> testlen);
> +static __init int mem_test_tag(struct mpdev *mpd, u8 * ramb, int
> testlen);
> +
> +static __init int register_eqnx(void);
> +
> +extern void eqnx_chnl_sync(struct mpchan *mpc);
> +extern void sstpoll(unsigned long arg);
> +extern int eqnx_open(struct tty_struct *, struct file *);
> +extern void eqnx_close(struct tty_struct *, struct file *);
> +extern int eqnx_write(struct tty_struct *, const unsigned char *, int);
> +extern void eqnx_put_char(struct tty_struct *, unsigned char);
> +extern void eqnx_flush_chars(struct tty_struct *);
> +extern int eqnx_write_room(struct tty_struct *);
> +extern int eqnx_chars_in_buffer(struct tty_struct *);
> +extern int eqnx_chars_in_buffer(struct tty_struct *);
> +extern void eqnx_throttle(struct tty_struct *);
> +extern void eqnx_unthrottle(struct tty_struct *);
> +extern void eqnx_flush_buffer(struct tty_struct *);
> +extern void eqnx_stop(struct tty_struct *);
> +extern void eqnx_start(struct tty_struct *);
> +extern void eqnx_hangup(struct tty_struct *);
> +extern void eqnx_set_termios(struct tty_struct *, struct termios *);
> +extern int eqnx_tiocmget(struct tty_struct *, struct file *);
> +extern int eqnx_tiocmset(struct tty_struct *, struct file *, unsigned
> int,
> +			 unsigned int);
> +extern int eqnx_ioctl(struct tty_struct *, struct file *, unsigned int,
> +		      unsigned long);
> +
> +extern void eqnx_create_sysfs(struct device *);
> +extern void eqnx_remove_sysfs(struct device *);
> +extern void eqnx_create_tty_sysfs(struct class_device *);
> +extern void eqnx_remove_tty_sysfs(struct class_device *);
> +
> +/**********************************************************************
> ***
> + *
> + * tty interface struct
> + *
> +
> ************************************************************************
> */
> +static struct tty_operations eqnx_ops = {
> +	.open = eqnx_open,
> +	.close = eqnx_close,
> +	.write = eqnx_write,
> +	.put_char = eqnx_put_char,
> +	.flush_chars = eqnx_flush_chars,
> +	.write_room = eqnx_write_room,
> +	.chars_in_buffer = eqnx_chars_in_buffer,
> +	.throttle = eqnx_throttle,
> +	.unthrottle = eqnx_unthrottle,
> +	.flush_buffer = eqnx_flush_buffer,
> +	.stop = eqnx_stop,
> +	.start = eqnx_start,
> +	.hangup = eqnx_hangup,
> +	.set_termios = eqnx_set_termios,
> +	.ioctl = eqnx_ioctl,
> +	.tiocmget = eqnx_tiocmget,
> +	.tiocmset = eqnx_tiocmset,
> +};
> +
> +/*
> + * SSTMINOR(maj, min)
> + * return channel index using major and minor numbers
> + *
> + * maj	= major number
> + * min	= minor number
> + */
> +int SSTMINOR(unsigned int maj, unsigned int min)
> +{
> +	if (maj != din_num)
> +		return (-1);
> +
> +	return (min);
> +}
> +
> +/*
> + * find_board_def(id)
> + *
> + *	return pointer to board definition entry for the board
> + *	with the specified full (16-bit) id.
> + *
> + *	returns NULL if not found.
> + */
> +static struct brdtab_t *find_board_def(unsigned short id)
> +{
> +	int i;
> +	struct brdtab_t *brdtab_ptr = NULL;
> +	unsigned char primary_id = NOID, secondary_id = NOID;
> +
> +	primary_id = id & 0xFC;
> +	secondary_id = (id & 0xFF00) >> 8;
> +
> +	/*
> +	 * mask off rev-id bits, special case
> +	 * chrysler board
> +	 */
> +	if ((primary_id != 0x14) && (secondary_id != 0x88) &&
> +	    (primary_id < 0x80))
> +		primary_id &= 0xF8;
> +
> +	/*
> +	 * Now search the board table for a matching entry
> +	 */
> +	for (i = 0; i < brdtab_entries; i++) {
> +		brdtab_ptr = &board_table[i];
> +
> +		if (brdtab_ptr->primary_id == primary_id) {
> +			if ((brdtab_ptr->secondary_id == secondary_id)
> ||
> +			    (brdtab_ptr->secondary_id == NOID) ||
> +			    (secondary_id == NOID)) {
> +				break;
> +			}
> +		}
if (a) {
    if (b) {
    }
}
->
if (a && b) {
}
> +	}
> +
> +	if (i >= brdtab_entries)
> +		brdtab_ptr = NULL;
> +
> +	return brdtab_ptr;
> +}
> +
> +/*
> + * eqnx_init(kmem_start)
> + *
> + * initialization routine
> + */
> +static int __init eqnx_init(void)
> +{
> +	struct mpdev *mpd;
> +	struct mpchan *mpc;
> +	volatile struct icp_in_struct *icpi;
> +	volatile struct icp_out_struct *icpo;
> +	volatile union global_regs_u *icpg = NULL;
> +	volatile struct cout_que_struct *icpq;
> +	struct icp_struct *icp;
> +	volatile struct hwq_struct *hwq;
> +	mpaddr_t mp;
> +	int i, j, k, lmx, ii, jj, addr, duplicate, di, addr1, nextmin;
> +	u8 cchnl;
> +	volatile unsigned char *chnl_ptr;
> +	u16 no_cache, no_icp, nxt_dma, attn_ena, status, cntrl_sig;
> +	struct pci_cfg *cfgp;
> +	unsigned short numboards = 0;
> +	void *base_addr;
> +	unsigned char config, rev_id, c_code;
> +	unsigned long flags;
> +	int ssp_channels = 0, lmx_factor, pcicfg_size;
> +	volatile u8 *bus_ctrl_p;
> +
> +	printk(KERN_INFO "Loading %s Version %s\n", eqnx_version,
> VERSNUM);
> +
> +	/* initialize board structs */
> +	for (ii = 0; ii < maxbrd; ii++) {
> +		eqnx_dev[ii].mpd_alive = 0;
> +		spin_lock_init(&eqnx_dev[ii].mpd_lock);
> +	}
> +
> +	eqnx_nssps = 0;
> +	eqnx_nicps = 0;
> +	nextmin = 0;
> +
> +	pcicfg_size = sizeof(struct pci_cfg) * maxbrd;
> +	eqnPCIcfg = (char *)kmalloc(pcicfg_size, GFP_KERNEL);

not cast

> +	if (eqnPCIcfg == (char *)NULL) {

cast

> +		printk(KERN_ERR "eqnx_init: Failed eqnPCIcfg allocate of
> "
> +		       "size %d\n", pcicfg_size);
> +		return (-ENOMEM);

no (), use goto and return at the end of function

> +	}
> +
> +	memset(eqnPCIcfg, 0, pcicfg_size);

kzalloc

> +	cfgp = (struct pci_cfg *)&eqnPCIcfg[0];
> +	numboards = eqnx_pcifindbrds(cfgp);
> +
> +	if (numboards) {
> +		for (i = 0; i < numboards; i++, cfgp++) {
> +			mpd = &eqnx_dev[eqnx_nssps];
> +
> +			mpd->mpd_pdev = cfgp->pdev;
> +			mpd->mpd_board_def =
> find_board_def(mpd->mpd_pdev->
> +							    device);
> +
> +			if (mpd->mpd_board_def == NULL)
> +				mpd->mpd_board_def = &unknown_board;
> +
> +			mpd->dev = &mpd->mpd_pdev->dev;
> +			eqnx_create_sysfs(mpd->dev);
> +			dev_info(mpd->dev, "eqnx SST brd: id %4.4x
> (%s)\n",
> +				 mpd->mpd_pdev->device,
> +				 mpd->mpd_board_def->name);
> +
> +			config = cfgp->command;
> +			rev_id = cfgp->rev_id;
> +			base_addr =
> +			    (void *)((unsigned long)cfgp->base_addr_reg0
> &
> +				     PCI_BASE_ADDR_MASK);
> +			/*
> +			 * This code checks for duplicate boards.
> +			 * This happens because some brain-dead
> +			 * PCI controllers "see" multiple busses
> +			 * when there aren't multiple busses.
> +			 * So, they see the same bus multiple times,
> +			 * reporting our board on all the busses.
> +			 */
> +			duplicate = 0;
> +			for (di = 0; di < i; di++) {
> +				struct mpdev *mpd = &eqnx_dev[di];
> +
> +				if (base_addr == mpd->mpd_pmem) {
> +
> +					duplicate = 1;
> +					break;
> +				}
> +			}
> +			if (duplicate)
> +				continue;
> +			/* Make sure base address was really configured
> */
> +			if (!base_addr) {
> +				dev_err(mpd->dev, "PCI Base Addr not "
> +					"configured.\n");
> +				continue;
> +			}
> +
> +			/* 
> +			 * Look at the Memory Space Control bit to
> +			 * see if this has been configured.
> +			 */
> +			if (!(config & PCI_MSC))
> +				continue;
> +
> +			/* Make sure we don't find more boards than the
> max. */
> +			if (eqnx_nssps >= maxbrd) {
> +				mpd->mpd_cnfg_state = CNFG_STATE_FAIL;
> +				mpd->mpd_cnfg_fail = CNFG_FAIL_MAXBRD;
> +				continue;
> +			} else
> +				mpd->mpd_cnfg_state = CNFG_STATE_OK;
> +
> +			/* Mark board as being alive */
> +			mpd->mpd_alive = true;
> +
> +			/* revision */
> +			mpd->mpd_rev = rev_id;
> +
> +			mpd->mpd_nicps =
> mpd->mpd_board_def->number_of_asics;
> +			eqnx_nicps += mpd->mpd_nicps;
> +			mpd->mpd_lmx_index = 0;
> +
> +			/* Save the physical address */
> +			mpd->mpd_pmem = base_addr;
> +
> +			/* Get the memory size */
> +			if (mpd->mpd_board_def->number_of_ports >= 64)
> +				mpd->mpd_addrsz = FLAT128_MEM_LEN;
> +			else
> +				mpd->mpd_addrsz = FLAT64K_MEM_LEN;
> +
> +			if (mpd->mpd_board_def->number_of_asics == 4)
> +				/* SSP4 SST-16P */
> +				mpd->mpd_memsz = mpd->mpd_addrsz;
> +			else	/* DRAM memory size is one-half memory
> size */
> +				mpd->mpd_memsz = mpd->mpd_addrsz / 2;
> +
> +			/* PCI memory width is always 32 */
> +			mpd->mpd_mem_width = 32;
> +
> +			mpd->mpd_nchan =
> mpd->mpd_board_def->number_of_ports;
> +			mpd->mpd_minor = nextmin;
> +			nextmin += MAXCHNL_BRD;
> +
> +			eqnx_nssps++;
> +		}
> +	}
> +
> +	if (!eqnx_nssps) {
> +		printk(KERN_INFO "eqnx_init: No SST boards found.\n");
> +		return 0;
> +	}
> +
> +	eqnx_chan = (struct mpchan *)vmalloc(sizeof(struct mpchan) *
> +					     eqnx_nssps * MAXCHNL_BRD);
> +	if (eqnx_chan == (struct mpchan *)NULL) {

cast

> +		printk(KERN_ERR "eqnx_init: Failed eqnx_chan allocate of
> "
> +		       "size %d\n",
> +		       (sizeof(struct mpchan) * eqnx_nssps *
> MAXCHNL_BRD));
> +		return (-ENOMEM);
> +	}
> +	memset(eqnx_chan, 0, (sizeof(struct mpchan) * eqnx_nssps *
> +			      MAXCHNL_BRD));
> +	mpc = eqnx_chan;
> +	for (k = 0; k < eqnx_nssps; k++) {
> +		/* map Adapter memory */
> +		mpd = &eqnx_dev[k];
> +		/* skip board if dead */
> +		if (mpd->mpd_alive == 0)
> +			continue;
> +		mpd->mpd_mpc = (struct mpchan *)&eqnx_chan[k *
> MAXCHNL_BRD];
> +
> +		mpd->mpd_mem = ioremap((unsigned long)mpd->mpd_pmem,
> +				       mpd->mpd_addrsz);
> +		if (!mpd->mpd_mem) {
> +			dev_err(mpd->dev, "eqnx_init: Memory map failed
> "
> +				"for board %d\n", k + 1);
> +			/* Driver init failed */
> +			mpd->mpd_cnfg_state = CNFG_STATE_FAIL;
> +			mpd->mpd_cnfg_fail = CNFG_FAIL_MEMORY;
> +			mpd->mpd_alive = false;
> +			continue;
> +		}
> +		brd_mem_cfg(mpd);
> +		hwq = mpd->mpd_hwq;
> +
> +		if (mpd->mpd_board_def->asic == SSP64)
> +			/* SSP-64 */
> +			mpd->mpd_sspchan = MAXCHNL_ICP;
> +		else
> +			/* SSP-4 */
> +			mpd->mpd_sspchan = 4;
> +
> +		/* loop through each ICP */
> +		for (j = 0; j < (int)mpd->mpd_nicps; j++) {
> +			int mux;
> +
> +			/* reset ICP to known state */
> +			icp = &mpd->icp[j];
> +			icp->icp_minor_start = mpd->mpd_minor +
> +			    (j * mpd->mpd_sspchan);
> +			if (mpd->mpd_board_def->asic == SSP64) {
> +				/* SSP-64 */
> +				icpg = (volatile union global_regs_u *)
> +				    ((unsigned long)icp->icp_regs_start
> +
> +				     0x2000);
> +				icpg->ssp.gicp_attn = 0;
> +				icpg->ssp.gicp_initiate = 0;
> +				bus_ctrl_p =
> &(icpg->ssp.gicp_bus_cntrl);
> +
> +				/*
> +				 * set up Global Bus Control register
> with
> +				 * the CPU bus width (32 bit bus) and
> the
> +				 * 40 bit DRAM bit
> +				 */
> +				if (!j)
> +					*bus_ctrl_p =
> +					    (STERNG | DRAM_40 |
> CPU_BUS_32);
> +				else
> +					*bus_ctrl_p = (DRAM_40 |
> CPU_BUS_32);
> +			} else {
> +				/* SSP-4 */
> +				volatile union global_regs_u *icp_glo =
> +				    (volatile union global_regs_u *)
> +				    ((unsigned long)icp->icp_regs_start
> +
> +				     0x400);
> +				volatile struct icp_out_struct *icp_cout
> =
> +				    (volatile struct icp_out_struct *)
> +				    ((unsigned long)icp->icp_regs_start
> +
> +				     0x200);
> +				volatile struct icp_in_struct *icp_cin =
> +				    (volatile struct icp_in_struct *)
> +				    (icp->icp_regs_start);
> +
> +				icp_glo->ssp4.on_line = 0;
> +				/* lock input and output */
> +				icp_cin->cin_locks = 0xFF;
> +				icp_cout->cout_lck_cntrl = 0x77;
> +				/* Set Bus Control = 16 bits */
> +				bus_ctrl_p = &(icp_glo->ssp4.bus_cntrl);
> +				*bus_ctrl_p = (BUS_CNTRL_16 |
> BUS_CNTRL_WR);
> +
> +				ssp_channels = 4;
> +
> +				for (ii = 0; ii < ssp_channels; ii++) {
> +					((volatile struct icp_in_struct
> *)
> +					 ((char *)icp_cin +
> ii))->cin_locks =
> +					    0xFF;
> +					((volatile struct icp_out_struct
> *)
> +					 ((char *)icp_cout +
> +					  ii))->cout_lck_cntrl = 0x77;
> +					SSTWR16(((volatile struct
> +						  icp_out_struct *)
> +						 ((char *)icp_cout +
> +						  ii))->cout_cntrl_sig,
> 0x0F);
> +				}
> +				icp_glo->ssp4.bus_cntrl = BUS_CNTRL_16;
> +				icp_glo->ssp4.on_line = 0;
> +			}
> +
> +			if ((ii = mem_test(mpd, j))) {
> +				dev_err(mpd->dev, "eqnx_init: Memory
> test "
> +					"failed for SST board %d ICP
> %d\n",
> +					k + 1, j + 1);
> +				mpd->mpd_cnfg_state = CNFG_STATE_FAIL;
> +				mpd->mpd_cnfg_fail = CNFG_FAIL_MEM_FAIL;
> +				mpd->mpd_alive = false;
> +				continue;
> +			}
> +
> +			/* verify that pram is not cached */
> +			if (mpd->mpd_board_def->asic == SSP64) {
> +				/* SSP-64 board */
> +				icpg = (volatile union global_regs_u *)
> +				    ((unsigned long)icp->icp_regs_start
> +
> +				     0x2000);
> +				/* verify that pram is not cached */
> +				cchnl = icpg->ssp.gicp_chan;
> +				chnl_ptr = &(icpg->ssp.gicp_chan);
> +			} else {
> +				/* SSP-4 board */
> +				struct icp_struct *icp;
> +				volatile union global_regs_u *icp_glo;
> +				icp = &mpd->icp[j];
> +				icp_glo = (volatile union global_regs_u
> *)
> +				    ((unsigned long)icp->icp_regs_start
> +
> +				     0x400);
> +				cchnl = icp_glo->ssp4.chan_ctr;
> +				chnl_ptr = &(icp_glo->ssp4.chan_ctr);
> +			}
> +			no_cache = false;
> +			for (ii = 0; ii < 0x100000; ii++) {
> +				if (*chnl_ptr != cchnl) {
> +					no_cache = true;
> +					break;
> +				}
> +			}
> +			if (!no_cache) {
> +				dev_err(mpd->dev, "eqnx_init: PRAM
> memory "
> +					"appears to be cached %lx.\n",
> +					(unsigned long)mpd->mpd_mem);
> +				/* Driver init failed */
> +				mpd->mpd_cnfg_state = CNFG_STATE_FAIL;
> +				mpd->mpd_cnfg_fail =
> CNFG_FAIL_PRAM_FAIL;
> +				mpd->mpd_alive = false;
> +				continue;
> +			}
> +
> +			lmx = 0;
> +			mp = (mpaddr_t) mpd->icp[j].icp_regs_start;
> +
> +			if (mpd->mpd_board_def->asic == SSP64) {
> +				if (mpd->mpd_board_def->number_of_asics
>> 0)
> +					/* Number per ICP */
> +					ssp_channels = 64;
> +				else
> +					ssp_channels = 0;
> +			}
> +
> +			if (mpd->mpd_board_def->asic != SSP64) {
> +				/* SSP-4 */
> +				struct icp_struct *icp;
> +				volatile union global_regs_u *icp_glo;
> +				icp = &mpd->icp[j];
> +				icp_glo = (volatile union global_regs_u
> *)
> +				    ((unsigned long)icp->icp_regs_start
> +
> +				     0x400);
> +				cchnl = icp_glo->ssp4.chan_ctr;
> +				chnl_ptr = &(icp_glo->ssp4.chan_ctr);
> +				for (ii = 0; ii < 0x10000; ii++)
> +					if (*chnl_ptr != cchnl)
> +						break;
> +				icp_glo->ssp4.bus_cntrl = 0xCD;
> +				cchnl = icp_glo->ssp4.chan_ctr;
> +				for (ii = 0; ii < 0x10000; ii++)
> +					if (*chnl_ptr != cchnl)
> +						break;
> +			}
> +
> +			/* mux control sigs on SST-16P */
> +			mux = 0;
> +			if ((mpd->mpd_board_def->asic != SSP64) &&
> +			    (mpd->mpd_board_def->number_of_ports == 16))
> +				mux = 1;
> +
> +			/* loop through each channel */
> +			for (i = 0; i < ssp_channels; i++) {
> +				/*
> +				 * setup mpc virtual addresses for cpu
> access 
> +				 * of icp
> +				 */
> +				jj = mpd->mpd_minor + i +
> +				    (j * mpd->mpd_sspchan);
> +				mpc = &eqnx_chan[jj];
> +				mpc->mpc_brdno = k;
> +				mpc->mpc_chan = i;
> +				mpc->mpc_icpi =
> +				    (volatile struct icp_in_struct *)
> +				    &mp->mp_icpi[i];
> +				if (mpd->mpd_board_def->asic == SSP64)
> +					mpc->mpc_icpo =
> +					    (volatile struct
> icp_out_struct *)
> +					    &mp->mp_icpo[i];
> +				else
> +					mpc->mpc_icpo =
> +					    (volatile struct
> icp_out_struct *)
> +					    ((unsigned char
> *)(mpc->mpc_icpi) +
> +					     0x200);
> +				mpc->mpc_mpd = mpd;
> +				mpc->mpc_icp = (struct icp_struct *)
> +				    &mpd->icp[j];
> +				mpc->mpc_icpno = j;
> +
> +				if ((mpc->normaltermios = (struct
> termios *)
> +				     vmalloc(sizeof(struct termios))) ==
> +				    (struct termios *)NULL) {
> +					dev_err(mpd->dev, "eqnx_int:
> Failed "
> +						"normaltermios alloc of
> "
> +						"size %d\n",
> +						sizeof(struct termios));
> +					return (-ENOMEM);
> +				}
> +				memset(mpc->normaltermios, 0,
> +				       sizeof(struct termios));
> +				*mpc->normaltermios = eqnx_deftermios;
> +				mpc->closing_wait = CLSTIMEO;
> +				mpc->close_delay = EQNX_CLOSEDELAY;
> +
> +				/* initialize each of the wait queues */
> +				mpc->open_wait_wait = 0;
> +				init_waitqueue_head(&mpc->open_wait);
> +				init_waitqueue_head(&mpc->close_wait);
> +				init_waitqueue_head(&mpc->raw_wait);
> +
> +				mpc->mpc_input = 0;
> +				mpc->mpc_output = 0;
> +				mpc->mpc_cin_events = 0;
> +				mpc->mpc_cout_events = 0;
> +				mpc->mpc_cin_ena = 0;
> +				mpc->mpc_cout_ena = 0;
> +
> +				mpc->mpc_parity_err_cnt = 0;
> +				mpc->mpc_framing_err_cnt = 0;
> +				mpc->mpc_break_cnt = 0;
> +
> +				icpi = mpc->mpc_icpi;
> +				icpo = mpc->mpc_icpo;
> +				if (mpd->mpd_board_def->asic == SSP64) {
> +					/* SSP-64 */
> +					icpg = (volatile union
> global_regs_u *)
> +					    icpo;
> +					lmx_factor = 16;
> +				} else {
> +					icpg = (volatile union
> global_regs_u *)
> +					    ((unsigned long)icpi +
> 0x400);
> +					lmx_factor = 4;
> +				}
> +				icpq = &icpo->cout_q0;
> +				if (i == (0 * lmx_factor)) {
> +					lmx = 0;
> +					mpc->mpc_icp->lmx[lmx].lmx_mpc =
> mpc;
> +					mpc->mpc_icp->lmx[lmx].lmx_wait
> = -1;
> +				}
> +
> +				if (i == (1 * lmx_factor)) {
> +					lmx = 1;
> +					mpc->mpc_icp->lmx[lmx].lmx_mpc =
> mpc;
> +					mpc->mpc_icp->lmx[lmx].lmx_wait
> = -1;
> +				}
> +
> +				if (i == (2 * lmx_factor)) {
> +					lmx = 2;
> +					mpc->mpc_icp->lmx[lmx].lmx_mpc =
> mpc;
> +					mpc->mpc_icp->lmx[lmx].lmx_wait
> = -1;
> +				}
> +
> +				if (i == (3 * lmx_factor)) {
> +					lmx = 3;
> +					mpc->mpc_icp->lmx[lmx].lmx_mpc =
> mpc;
> +					mpc->mpc_icp->lmx[lmx].lmx_wait
> = -1;
> +				}
> +				mpc->mpc_lmxno = lmx;
> +
> +				/* icp input - assign queues, etc. */
> +				/* setup input hardware registers */
> +				icpi->cin_locks = 0xff;
> +				icpo->cout_lck_cntrl = 0xff;
> +				spin_lock_irqsave(&mpd->mpd_lock,
> flags);
> +				eqnx_chnl_sync(mpc);
> +				spin_unlock_irqrestore(&mpd->mpd_lock,
> flags);
> +				if (mpd->mpd_board_def->asic == SSP64) {
> +					/* SSP64 */
> +					addr = (i + j * MAXCHNL_ICP) * 2
> *
> +					    hwq->hwq_size;
> +					icpi->cin_dma_hi = (addr >> 16);
> +					nxt_dma = addr & 0xffff;
> +				} else {
> +					/* SSP4 */
> +					addr = i * 0x400;
> +					nxt_dma = addr & 0xffff;
> +				}
> +				SSTWR16(icpi->cin_bank_a.bank_nxt_dma,
> nxt_dma);
> +				SSTWR16(icpi->cin_bank_b.bank_nxt_dma,
> nxt_dma);
> +				SSTWR16(icpi->cin_tail_ptr_a, nxt_dma);
> +				SSTWR16(icpi->cin_tail_ptr_b, nxt_dma);
> +
> +				/* setup mpc values for input registers
> */
> +				mpc->mpc_rxq.q_begin = addr & 0xffff;
> +				mpc->mpc_rxq.q_ptr = addr & 0xffff;
> +				mpc->mpc_rxbase = 0;
> +				mpc->mpc_rxpg = 0;
> +				mpc->mpc_tgpg = 0;
> +				mpc->mpc_rxq.q_end = (addr & 0xffff) +
> +				    (hwq->hwq_size - 1);
> +				mpc->mpc_rxq.q_size = hwq->hwq_size;
> +				if (mpd->mpd_board_def->asic == SSP64) {
> +					/* SSP64 */
> +					mpc->mpc_tags = addr >> 4;
> +					mpc->mpc_rxq.q_addr = (char *)
> +					    (icp->icp_dram_start +
> +					     ((i * 2 * hwq->hwq_size) &
> +					      0xffff0000));
> +				} else {
> +					/* SSP4 */
> +					mpc->mpc_tags = 0;
> +					mpc->mpc_rxq.q_addr = (char *)
> +					    (icp->icp_dram_start +
> +					     ((i * hwq->hwq_size) &
> +					      0xffff0000));
> +				}
> +
> +				/* setup additional icp input registers
> */
> +				SSTWR16(icpi->cin_overload_lvl,
> hwq->hwq_hiwat);
> +				icpi->cin_susp_output_lmx =
> (LMX_NOT_CONN |
> +
> LMX_OFF_LINE);
> +				icpi->cin_susp_output_sig = 0x00;
> +				icpi->cin_q_cntrl = hwq->hwq_rxwrap |
> +				    EN_IXOFF_SVC;
> +				SSTWR16(icpi->cin_min_char_lvl, 1);
> +				icpi->cin_iband_flow_cntrl = 0;
> +				/* unlock input */
> +				/* Start with Bank B locked */
> +				icpi->cin_locks = 0x10 | LOCK_B;
> +
> +				/* icp output - assign data & cmd queues
> */
> +				/* setup queue 0 only for each channel
> */
> +				/* use circular output data queue */
> +				/* - no session registers */
> +
> +				status = SSTRD16(icpo->cout_status);
> +				if (mpd->mpd_board_def->asic == SSP64) {
> +					/* SSP-64 */
> +					addr = ((i + j * MAXCHNL_ICP) *
> 2 + 1) *
> +					    hwq->hwq_size;
> +					icpq->q_data_ptr_u = (addr >>
> 16);
> +					SSTWR16(icpq->q_data_ptr_l,
> +						(addr & 0xffff));
> +					icpq->q_data_q_type =
> +					    EN_CIRC_Q | EN_TX_LOW |
> +					    EN_TX_EMPTY |
> hwq->hwq_txwrap;
> +					/* permanent send data state */
> +					icpq->q_block_count =
> +					    hwq->hwq_lowat / 64;
> +					/* lowat mark in 64-byte blocks
> */
> +					status |= (i << 10);
> +				} else {
> +					/* SSP-4 */
> +					addr = i * 0x400;
> +
> SSTWR16(icpo->cout_q0.q_data_ptr_l,
> +						(addr & 0xFFFF));
> +					icpo->cout_q0.q_data_q_type =
> +					    EN_CIRC_Q | EN_TX_LOW |
> +					    EN_TX_EMPTY |
> hwq->hwq_txwrap;
> +					icpo->cout_q0.q_block_count =
> +					    hwq->hwq_lowat / 64;
> +					status |= ((i * 4) << 8);
> +				}
> +				SSTWR16(icpo->cout_status, status);
> +
> +				if (mpd->mpd_board_def->asic == SSP64) {
> +					/* SSP-64 */
> +					/* circular, size, cause empty &
> */
> +					/* lowat events */
> +					icpq->q_out_state =
> CMDQ_CONT_SND |
> +					    hwq->hwq_cmdsize;
> +					icpo->cout_ses_cntrl_a = SCR_EN;
> +					addr1 = addr;
> +				} else {
> +					/* SSP-4 */
> +					icpo->cout_q0.q_out_state =
> CMDQ_SND;
> +					icpo->cout_ses_cntrl_a = SCR_EN;
> +					addr1 = addr + 0x1000;
> +				}
> +
> +				mpc->mpc_txq.q_begin = addr1 & 0xffff;
> +				mpc->mpc_txq.q_ptr = addr1 & 0xffff;
> +				mpc->mpc_txbase = 0;
> +				mpc->mpc_txpg = 0;
> +				mpc->mpc_txq.q_end =
> +				    (addr1 & 0xffff) + (hwq->hwq_size -
> 1);
> +				mpc->mpc_txq.q_size = hwq->hwq_size;
> +				if (mpd->mpd_board_def->asic == SSP64)
> +					/* SSP-64 */
> +					mpc->mpc_txq.q_addr =
> +					    (char *)(icp->icp_dram_start
> +
> +						     (((i * 2 + 1) *
> +						       hwq->hwq_size) &
> +						      0xffff0000));
> +				else
> +					/* SSP-4 */
> +					mpc->mpc_txq.q_addr =
> +					    (char *)(icp->icp_dram_start
> +
> +						     ((i *
> hwq->hwq_size) &
> +						      0xFFFF0000));
> +
> +				/* cmd queue */
> +				if (mpd->mpd_board_def->asic == SSP64)
> +					addr = (MAXCHNL_ICP + i +
> +						(j * MAXCHNL_ICP)) *
> +					    hwq->hwq_size / 4;
> +				else
> +					addr = i * 0x400;
> +				icpq->q_cmnd_ptr_u = (addr >> 16);
> +				SSTWR16(icpq->q_cmnd_ptr_l, (addr &
> 0xffff));
> +
> +				/* output timer - setup for 10 ms
> prescale */
> +				icpo->cout_tim_scale = 2;
> +				/* place ms count here */
> +				icpo->cout_tim_reg = 0;
> +
> +				/* misc. output registers */
> +				cntrl_sig =
> SSTRD16(icpo->cout_cntrl_sig);
> +				cntrl_sig &= ~0xff;
> +				if (mux)
> +					/* mux control signals */
> +					cntrl_sig |= 0x44;
> +				SSTWR16(icpo->cout_cntrl_sig,
> cntrl_sig);
> +
> +				/* unlock output */
> +				icpo->cout_lck_cntrl = 0x02;
> +				icpo->cout_cpu_req ^= 0x04;
> +				/* force send data state */
> +			}
> +
> +			/* check sanity of ICP */
> +			/* "ring clock failure" should be on since ring
> */
> +			/* clock is off */
> +			if (mpd->mpd_board_def->asic == SSP64) {
> +				/* SSP64 */
> +				no_icp = !(icpg->ssp.gicp_attn &
> RNG_FAIL);
> +				if (!no_icp) {
> +					mpc =
> &eqnx_chan[icp->icp_minor_start];
> +					/* setup mpc structs for each
> chan */
> +					for (ii = 0; ii < ssp_channels;
> ii++,
> +					     mpc++) {
> +						/* don't enable
> lmx_cond_chng */
> +						/* until ring found */
> +						icpi = mpc->mpc_icpi;
> +						icpo = mpc->mpc_icpo;
> +						/* allow software attn
> */
> +						attn_ena =
> EN_REG_UPDT_EV;
> +						if (!(ii % 16))
> +							attn_ena |=
> ENA_LMX_CNG;
> +
> SSTWR16(icpi->cin_attn_ena,
> +							attn_ena);
> +						/* start with Bank B
> locked */
> +						icpi->cin_locks =
> LOCK_B;
> +						/* allow software attn
> */
> +
> SSTWR16(icpo->cout_attn_enbl,
> +							EN_REG_UPDT_EV);
> +						icpo->cout_lck_cntrl ^=
> +						    (LCK_EVT_A |
> LCK_EVT_B);
> +					}
> +
> +					/* setup global interval timer
> for 1 */
> +					/* second pulse */
> +					/* 0.1 seconds before decrement
> */
> +					icpg->ssp.gicp_tmr_size = 192;
> +					/* 10 decrements before pulse */
> +					icpg->ssp.gicp_tmr_count = 10;
> +					icpg->ssp.gicp_bus_cntrl |=
> GTIMER_EN;
> +
> +					/* disable watchdog */
> +					icpg->ssp.gicp_watchdog = 0;
> +
> +					/* enable global pram writes,
> dma */
> +					/* and ring clock */
> +					icpg->ssp.gicp_initiate =
> +					    (RNG_CLK_ON | ICP_PRAM_WR |
> +					     DMA_EN | DISABLE_ATTN_CLR);
> +					mpd->icp[j].icp_rng_state =
> RNG_BAD;
> +					/* set ring bad */
> +					mpd->icp[j].icp_rng_last = 0x4;
> +				} else {
> +					dev_err(mpd->dev, "eqnx_init:
> ICP %d "
> +						"not detected for board
> with "
> +						"I/O address %d\n",
> +						j + 1, k + 1);
> +					mpd->mpd_cnfg_state =
> CNFG_STATE_FAIL;
> +					mpd->mpd_cnfg_fail =
> CNFG_FAIL_ICP_FAIL;
> +					mpd->mpd_alive = false;
> +					continue;
> +				}
> +			} else {
> +				/* SSP-4 */
> +				volatile union global_regs_u *icp_glo;
> +				icp_glo = (volatile union global_regs_u
> *)
> +				    ((unsigned long)icp->icp_regs_start
> +
> +				     0x400);
> +				mpc = &eqnx_chan[icp->icp_minor_start];
> +				for (jj = 0; jj < ssp_channels; jj++,
> mpc++) {
> +					icpi = mpc->mpc_icpi;
> +					icpo = mpc->mpc_icpo;
> +					icpi->cin_q_cntrl |= 0x80;
> +					/* allow software attention */
> +					SSTWR16(icpi->cin_attn_ena,
> +						EN_REG_UPDT_EV);
> +					icpi->cin_locks = LOCK_B;
> +					/* 0.1 seconds before decrement
> */
> +					icpi->cin_tmr_preset_sz = 0x00;
> +					/* 10 decrements before pulse */
> +					icpi->cin_tmr_preset_count =
> 0x00;
> +					/* allow software attention */
> +					SSTWR16(icpo->cout_attn_enbl,
> 0x8000);
> +					icpo->cout_lck_cntrl = LOCK_B;
> +				}
> +				/* setup global interval timer for 
> +				   a 1 second pulse */
> +				/* enable it */
> +				icp_glo->ssp4.bus_cntrl |= (BUS_CNTRL_16
> |
> +							    BUS_CNTRL_WR
> |
> +
> BUS_CNTRL_DMA);
> +
> +				mpc = &eqnx_chan[icp->icp_minor_start];
> +				/* fake ldv record */
> +				icp->lmx[0].lmx_active = DEV_GOOD;
> +				icp->lmx[0].lmx_mpc = mpc;
> +				icp->lmx[0].lmx_id = 0;
> +				icp->lmx[1].lmx_active = DEV_BAD;
> +				icp->lmx[2].lmx_active = DEV_BAD;
> +				icp->lmx[3].lmx_active = DEV_BAD;
> +				icp->lmx[0].lmx_chan = 4;
> +				icp->lmx[0].lmx_speed = 3;
> +
> +				icp->lmx[0].lmx_bridge = false;
> +				icp->lmx[0].lmx_rmt_active = 0;
> +				icp->lmx[0].lmx_good_count = 0;
> +				icp->lmx[0].lmx_wait = -1;
> +				/* fake ring state flags */
> +				icp->icp_rng_state = RNG_GOOD;
> +				/* set "ring bad" last pass */
> +				icp->icp_rng_last = 0x04;
> +				icp_glo->ssp4.on_line = 0x01;
> +			}
> +		}
> +
> +		/* Store Multimodem country code and print to log */
> +		if (mpd->mpd_board_def->flags & MM) {
> +			c_code = readb(mpd->mpd_mem +
> MM_COUNTRY_CODE_REG)
> +				& 0x7F;
> +			mpd->mpd_ccode = c_code;
> +			dev_info(mpd->dev, "eqnx_init: Multimodem board
> "
> +				 "country code ID is %X\n", c_code);
> +		}
> +	}
> +
> +	mpd = eqnx_dev;
> +
> +	printk(KERN_INFO "eqnx_init: Driver Enabled for %d board%s.\n",
> +	       eqnx_nssps, (eqnx_nssps > 1) ? "s" : "");
> +
> +	/*
> +	 * Allocate temporary write buffer.
> +	 */
> +	eqnx_txcookbuf = (char *)kmalloc(XMIT_BUF_SIZE, GFP_KERNEL);
> +	if (eqnx_txcookbuf == (char *)NULL)
> +		printk(KERN_ERR "eqnx_init: failed write buffer allocate
> "
> +		       "(size=%d)\n", XMIT_BUF_SIZE);
> +
> +	/* Initialize the tty_driver structure */
> +	if (register_eqnx() != 0)
> +		return (-ENODEV);
> +
> +	init_timer(&eqnx_timer);
> +	eqnx_timer.expires = jiffies + MPTIMEO;
> +	eqnx_timer.data = 0;
> +	eqnx_timer.function = &sstpoll;
> +	add_timer(&eqnx_timer);
> +
> +#ifdef DEBUG
> +	printk(KERN_DEBUG "eqnx_init: registered EQNX driver\n");
> +#endif
> +	return 0;
> +}
> +
> +/*
> + * eqnx_cleanup()
> + * cleanup on module unload
> + */
> +void eqnx_cleanup(void)

static? _exit?

> +{
> +	struct mpdev *mpd;
> +	volatile union global_regs_u *icpg;
> +	struct icp_struct *icp;
> +	unsigned long flags;
> +	int i, n = 0, k, numchans, base;
> +
> +#ifdef DEBUG
> +	printk(KERN_DEBUG "eqnx_cleanup: trying to unregister
> eqnx_driver\n");
> +#endif
> +
> +	if (timer_pending(&eqnx_timer))
> +		del_timer(&eqnx_timer);
> +
> +	/* for each board */
> +	for (k = 0; k < eqnx_nssps; k++) {
> +		mpd = &eqnx_dev[k];
> +
> +		eqnx_remove_sysfs(mpd->dev);
> +		if (mpd->mpd_alive == 0)
> +			continue;
> +		else
> +			mpd->mpd_alive = 0;
> +
> +		numchans = mpd->mpd_nicps * mpd->mpd_sspchan;
> +		base = k * MAXCHNL_BRD;
> +
> +		for (i = 0; i < numchans; i++) {
> +			eqnx_remove_tty_sysfs(eqnx_chan[base + i].cdev);
> +			tty_unregister_device(eqnx_driver, base + i);
> +		}
> +
> +		spin_lock_irqsave(&mpd->mpd_lock, flags);
> +		if (mpd->mpd_board_def->asic == SSP64) {
> +			/* SSP64 */
> +			/* for each ICP */
> +			for (i = 0; i < (int)mpd->mpd_nicps; i++) {
> +				icp = &mpd->icp[i];
> +				icpg = (volatile union global_regs_u *)
> +				    ((unsigned long)icp->icp_regs_start
> +				     + 0x2000);
> +#ifdef	DEBUG
> +				printk(KERN_DEBUG "eqnx_cleanup: turn
> off ring "
> +				       "clock, PRAM and DMA\n");
> +#endif
> +				icpg->ssp.gicp_initiate &=
> +				    ~(RNG_CLK_ON | ICP_PRAM_WR | DMA_EN
> |
> +				      DISABLE_ATTN_CLR);
> +				icpg->ssp.gicp_attn = 0;
> +				icpg->ssp.gicp_initiate = 0;
> +				icpg->ssp.gicp_watchdog = 0;
> +			}
> +		}
> +		spin_unlock_irqrestore(&mpd->mpd_lock, flags);
> +		iounmap(mpd->mpd_mem);
> +	}
> +
> +	if (eqnx_chan != (struct mpchan *)NULL)
> +		vfree((void *)eqnx_chan);
> +	if (eqnPCIcfg != (char *)NULL)
> +		kfree((void *)eqnPCIcfg);
> +	if (eqnx_txcookbuf != (char *)NULL)
> +		kfree(eqnx_txcookbuf);

5x cast?

> +
> +	n = tty_unregister_driver(eqnx_driver);
> +
> +	if (n) {
> +		printk(KERN_WARNING "eqnx cleanup: Failed to unregister
> "
> +		       "tty driver, return = %d\n", n);
> +		return;
> +	}
> +
> +	put_tty_driver(eqnx_driver);
> +
> +}
> +
> +/*
> + * brd_mem_cfg(mpd)
> + * setup pointers to buffer, tag and cmd memory in icp structs.
> + *
> + * mpd	= board structure
> + */
> +static __init void brd_mem_cfg(struct mpdev *mpd)
> +{
> +	int i;
> +
> +	/* for each ICP */
> +	for (i = 0; i < (int)mpd->mpd_nicps; i++) {
> +		if (mpd->mpd_board_def->asic == SSP64) {
> +			/* SSP64 */
> +			mpd->icp[i].icp_regs_start = (mpaddr_t)
> +			    ((unsigned long)mpd->mpd_mem + (i *
> 0x4000));
> +			/* Special case PCI 64 port boards */
> +			if ((mpd->mpd_pdev->device & 0xF8) == 0x08)
> +				mpd->icp[i].icp_dram_start = (void *)
> +				    ((unsigned long)mpd->mpd_mem +
> +				     mpd->mpd_memsz / 2);
> +			else
> +				mpd->icp[i].icp_dram_start = (void *)
> +				    ((unsigned long)mpd->mpd_mem +
> +				     mpd->mpd_memsz + (i *
> mpd->mpd_memsz / 2));
> +			mpd->icp[i].icp_tags_start = (void *)
> +			    ((unsigned long)mpd->mpd_mem + 0x40000 +
> +			     (i * 0x20000));
> +			mpd->icp[i].icp_cmds_start = (void *)
> +			    ((unsigned long)mpd->mpd_mem + 0x40000 +
> +			     (i * 0x20000));
> +			mpd->mpd_hwq = &sst_hwq[0];
> +		} else {
> +			/* SSP4 */
> +			mpd->icp[i].icp_regs_start = (mpaddr_t)
> +			    ((unsigned long)mpd->mpd_mem +
> +			     (i * sizeof(struct ssp4_addr_space_s)));
> +			mpd->icp[i].icp_dram_start = (void *)
> +			    ((unsigned long)mpd->mpd_mem +
> +			     (i * sizeof(struct ssp4_addr_space_s)) +
> 0x1000);
> +			mpd->icp[i].icp_tags_start = (void *)
> +			    ((unsigned long)mpd->mpd_mem + 0x3000 +
> +			     (i * sizeof(struct ssp4_addr_space_s)));
> +			/* cmds doesn't exist, so point to tags */
> +			mpd->icp[i].icp_cmds_start =
> mpd->icp[i].icp_tags_start;
> +			mpd->mpd_hwq = &sst_hwq[1];
> +		}
> +	}
> +}
> +
> +/*
> + * mem_test_pram(mpd, ramw, testlen)
> + * verify processor ram memory (ICP registers) is valid.
> + *
> + * mpd	= board structure
> + * ramw	= beginning of ram buffer
> + * testlen = length of ram buffer
> + */
> +static __init int mem_test_pram(struct mpdev *mpd, u16 * ramw, int
> testlen)
> +{
> +	int ram_ok = 0, ii, jj;
> +
> +	/* test input and output registers */
> +	for (ii = 0; ii < testlen; ii += 2, ramw++) {
> +		if (mpd->mpd_board_def->asic == SSP64) {
> +			/* SSP64 */
> +			jj = ii & 0x7f;
> +			/* protect sensitive registers */
> +			if ((ii >= HWREGSLEN / 2) &&
> +			    ((jj >= 0x18 && jj < 0x20) ||
> +			     (jj >= 0x38 && jj < 0x40) ||
> +			     (jj >= 0x58 && jj < 0x60) ||
> +			     (jj >= 0x78 && jj < 0x80)))
> +				continue;
> +		}
> +
> +		*ramw = 0x55aa;
> +		ram_ok = true;
> +		if (*ramw != 0x55aa) {
> +			ram_ok = false;
> +			break;
> +		}
> +		*ramw = 0xaa55;
> +		if (*ramw != 0xaa55) {
> +			ram_ok = false;
> +			break;
> +		}
> +	}
> +
> +	if (ram_ok)
> +		return (0);
> +	return (ii);
> +}
> +
> +/*
> + * mem_test_dram(mpd, ramw, testlen)
> + * verify on-board memory is valid.
> + *
> + * mpd	= board structure
> + * ramw	= beginning of ram buffer
> + * testlen = length of ram buffer
> + */
> +static __init int mem_test_dram(struct mpdev *mpd, u16 * ramw, int
> testlen)
> +{
> +	int ram_ok, ii;
> +	u8 ram_pg;
> +
> +	ram_ok = true;
> +	ram_pg = 0;
> +	for (ii = 0; ii < testlen; ii += 2, ramw++) {
> +		*ramw = 0x55aa;
> +		if (*ramw != 0x55aa) {
> +			ram_ok = false;
> +			break;
> +		}
> +		*ramw = 0xaa55;
> +		if (*ramw != 0xaa55) {
> +			ram_ok = false;
> +			break;
> +		}
> +	}
> +
> +	if (ram_ok)
> +		return (0);
> +	return (ii);
> +}
> +
> +/*
> + * mem_test_tag(mpd, ramb, testlen)
> + * verify on-board tag memory is valid.
> + *
> + * mpd	= board structure
> + * ramb	= beginning of ram buffer
> + * testlen = length of ram buffer
> + */
> +static __init int mem_test_tag(struct mpdev *mpd, u8 * ramb, int
> testlen)
> +{
> +	int ram_ok, ii;
> +	u8 ram_pg;
> +	volatile u8 *ramb2;
> +
> +	ramb2 = ramb + 1;
> +	ram_ok = true;
> +	ram_pg = 0;
> +	for (ii = 0; ii < testlen; ii += 2, ramb += 2, ramb2 += 2) {
> +		*ramb = 0x55;
> +		*ramb2 = 0xaa;
> +		if (*ramb != 0x55 || *ramb2 != 0xaa) {
> +			ram_ok = false;
> +			break;
> +		}
> +	}
> +
> +	if (ram_ok)
> +		return (0);
> +	return (ii);
> +}
> +
> +/*
> + * mem_zero(mpd, ramw, testlen)
> + * zero processor ram memory.
> + *
> + * mpd	= board structure
> + * ramw	= beginning of ram buffer
> + * testlen = length of ram buffer
> + */
> +static __init int mem_zero(struct mpdev *mpd, unsigned short *ramw, int
> testlen)
> +{
> +	int ii, jj;
> +
> +	for (ii = 0; ii < testlen; ii += 2, ramw++) {
> +		if (mpd->mpd_board_def->asic == SSP64) {
> +			/* SSP-64 */
> +			jj = ii & 0x7f;
> +			/* protect sensitive registers */
> +			if ((ii >= HWREGSLEN / 2) &&
> +			    ((jj >= 0x18 && jj < 0x20) ||
> +			     (jj >= 0x38 && jj < 0x40) ||
> +			     (jj >= 0x58 && jj < 0x60) ||
> +			     (jj >= 0x78 && jj < 0x80)))
> +				continue;
> +		} else {
> +			/* SSP-4 */
> +			jj = ii & 0x7f;
> +			/* protect sensitive registers */
> +			if ((jj == 0x02) || (jj == 0x64) || (jj ==
> 0x72))
> +				continue;
> +		}
> +		*ramw = 0;
> +	}
> +
> +	return (0);
> +}
> +
> +/*
> + * mem_test(mpd, icp)
> + * full memory test
> + *
> + * mpd	= board structure
> + * icp	= ICP index
> + */
> +static __init int mem_test(struct mpdev *mpd, int icp)
> +{
> +	int ram_index, err = 0, testlen;
> +	u8 *ramb;
> +	u16 *ramw;
> +
> +	/* test pram  - 16-bit test */
> +	ramw = (u16 *) (mpd->icp[icp].icp_regs_start);
> +	if (mpd->mpd_board_def->asic == SSP64) {
> +		/* SSP-64 */
> +		testlen = HWREGSLEN;
> +		ram_index = mem_test_pram(mpd, ramw, testlen);
> +	} else {
> +		/* SSP-4 */
> +		testlen = 0x200;
> +		ram_index = mem_test_pram(mpd, ramw, testlen);
> +		if (!ram_index) {
> +			ramw = (u16 *) ((unsigned char *)
> +					(mpd->icp[icp].icp_regs_start) +
> 0x200);
> +			ram_index = mem_test_pram(mpd, ramw, testlen);
> +		}
> +	}
> +
> +	if (ram_index) {
> +		dev_err(mpd->dev, "eqnx_init: PRAM memory test failure,
> "
> +			"index=%d\n", ram_index);
> +		err = 1;
> +	}
> +
> +	/* test dram - word test */
> +	if (mpd->mpd_board_def->asic == SSP64) {
> +		/* SSP-64 */
> +		ramw = (u16 *) (mpd->icp[0].icp_dram_start);
> +		testlen = mpd->mpd_memsz;
> +		ram_index = mem_test_dram(mpd, ramw, testlen);
> +	} else {
> +		/* SSP-4 */
> +		testlen = 0x1000;
> +
> +		/* test input buff */
> +		ramw = (u16 *) (mpd->icp[icp].icp_dram_start);
> +		ram_index = mem_test_dram(mpd, ramw, testlen);
> +
> +		if (!ram_index) {
> +			/* test output buff */
> +			ramw = (u16 *) ((unsigned long)
> +					mpd->icp[icp].icp_dram_start +
> 0x1000);
> +			ram_index = mem_test_dram(mpd, ramw, testlen);
> +		}
> +	}
> +
> +	if (ram_index) {
> +		dev_err(mpd->dev, "eqnx_init: DRAM memory test failure,
> "
> +			"index=%d\n", ram_index);
> +		err |= 2;
> +	}
> +
> +	/* test tag dram - requires BYTE accesses! */
> +	ramb = (u8 *) (mpd->icp[0].icp_tags_start);
> +	if (mpd->mpd_board_def->asic == SSP64)
> +		/* SSP-64 */
> +		testlen = mpd->mpd_memsz / 4;
> +	else
> +		testlen = 0x400;
> +	ram_index = mem_test_tag(mpd, ramb, testlen);
> +	if (ram_index) {
> +		dev_err(mpd->dev, "eqnx_init: DRAM tags memory test
> failure, "
> +			"index=%d\n", ram_index);
> +		err |= 4;
> +	}
> +
> +	/* zero pram */
> +	ramw = (u16 *) (mpd->icp[icp].icp_regs_start);
> +	if (mpd->mpd_board_def->asic == SSP64)
> +		/* SSP-64 */
> +		testlen = HWREGSLEN;
> +	else
> +		/* SSP-4 */
> +		testlen = 0x400;
> +	mem_zero(mpd, ramw, testlen);
> +
> +	return (err);
> +}
> +
> +/*
> + * register_eqnx_devs(driver)
> + * Register eqnx devices.
> + */
> +static __init void register_eqnx_devs(struct tty_driver *driver)
> +{
> +	int i, numchans, base, brd;
> +	struct class_device *classp;
> +
> +	for (brd = 0; brd < eqnx_nssps; brd++) {
> +		numchans = eqnx_dev[brd].mpd_nicps *
> eqnx_dev[brd].mpd_sspchan;
> +		base = brd * MAXCHNL_BRD;
> +		for (i = 0; i < numchans; i++) {
> +			classp = tty_register_device(driver, base + i,
> NULL);
> +			eqnx_chan[base + i].cdev = classp;
> +			eqnx_create_tty_sysfs(classp);
> +		}
> +	}
> +}
> +
> +/*
> + * register_eqnx
> + * Register eqnx driver with tty driver.
> + */
> +static __init int register_eqnx(void)
> +{
> +	int i;
> +
> +#ifdef DEBUG
> +	printk(KERN_DEBUG "eqnx: registering the driver\n");
> +#endif
> +	eqnx_driver = alloc_tty_driver(eqnx_nssps * MAXCHNL_BRD);
> +	if (!eqnx_driver) {
> +		printk(KERN_ERR "eqnx_init: Failed alloc_tty_driver\n");
> +		return (-1);
> +	}
> +
> +	eqnx_driver->owner = THIS_MODULE;
> +	eqnx_driver->driver_name = "Equinox_SST";
> +	eqnx_driver->name = "ttyEQ";
> +	eqnx_driver->devfs_name = "tts/EQ";
> +	eqnx_driver->major = EQNX_MAJOR;
> +	eqnx_driver->minor_start = 0;
> +	eqnx_driver->minor_num = eqnx_nssps * MAXCHNL_BRD;
> +	eqnx_driver->type = TTY_DRIVER_TYPE_SERIAL;
> +	eqnx_driver->subtype = SERIAL_TYPE_NORMAL;
> +	eqnx_driver->init_termios = eqnx_deftermios;
> +	eqnx_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
> +	tty_set_operations(eqnx_driver, &eqnx_ops);
> +
> +	if (tty_register_driver(eqnx_driver)) {
> +		printk(KERN_ERR "eqnx_init: failed to register
> device\n");
> +		put_tty_driver(eqnx_driver);
> +		return (-1);
> +	}
> +
> +	din_num = eqnx_driver->major;
> +	if (din_num <= 0) {
> +		printk(KERN_ERR "eqnx_init: failed to register
> device\n");
> +		put_tty_driver(eqnx_driver);
> +		return (-1);
> +	}
> +
> +	for (i = 0; i < eqnx_nssps; i++) {
> +		eqnx_dev[i].mpd_major = din_num;
> +		eqnx_dev[i].mpd_minor_start = i * MAXCHNL_BRD;
> +	}
> +
> +	register_eqnx_devs(eqnx_driver);
> +
> +	return (0);

We are not *bsd. omit (), everywhere.

> +}
> +
> +/*
> + * eqnx_pcifindbrds(cfg)
> + *
> + * locate all PCI SST boards
> + *
> + * return: cfg with board information
> + * return: number of boards found
> + */
> +static __init int eqnx_pcifindbrds(struct pci_cfg *cfg)
> +{
> +	struct pci_dev *dev = NULL;
> +	int i, brd_index = 0;
> +	u16 devid;
> +
> +	for (i = 0; i < brdtab_entries && brd_index < maxbrd; i++) {
> +		devid = (board_table[i].secondary_id << 8) & 0xff00;
> +		devid |= board_table[i].primary_id;
> +
> +		while ((dev = pci_find_device(PCI_VENDOR_ID_EQNX, devid,
> dev))) {

Probably needs pci probing.

> +			if (pci_enable_device(dev))
> +				continue;
> +			pci_read_config_byte(dev, PCI_REVISION_ID,
> +					     &cfg->rev_id);
> +			pci_read_config_word(dev, PCI_COMMAND,
> &cfg->command);
> +			cfg->base_addr_reg0 =
> +			    (void *)pci_resource_start(dev, 0);
> +			cfg->pdev = dev;
> +			brd_index++;
> +			cfg++;
> +		}
> +	}
> +
> +	return (brd_index);
> +}
> +
> +module_init(eqnx_init);
> +module_exit(eqnx_cleanup);

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
