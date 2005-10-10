Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVJJNCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVJJNCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVJJNCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:02:04 -0400
Received: from [66.45.247.194] ([66.45.247.194]:21419 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1750774AbVJJNCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:02:02 -0400
Message-ID: <434A6334.4090407@linuxtv.org>
Date: Mon, 10 Oct 2005 16:48:52 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Manu Abraham <manu@linuxtv.org>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <43287712.3040503@gmail.com> <4328A3C8.6010501@linuxtv.org> <200510101403.02578@bilbo.math.uni-mannheim.de>
In-Reply-To: <200510101403.02578@bilbo.math.uni-mannheim.de>
Content-Type: multipart/mixed;
 boundary="------------010309070706020404010607"
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010309070706020404010607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rolf Eike Beer wrote:

>IIRC the call to pci_enable_device() must be the first thing you do. This will 
>do the things like assigning memory regions to the device and so on.
>
>  
>
I fixed this one

>Returning 0 in error cases is just wrong. And you free the assignments even in 
>case of success AFAICS. Try the return I introduced above and see what 
>happens.
>
>  
>
I fixed this one too ..


I have fixed most of the stuff, it is partly working, not ready yet as 
there are some more things to be added to  ..
I have attached what i was working on.


Thanks,
Manu


--------------010309070706020404010607
Content-Type: text/plain;
 name="mantis_common.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_common.h"

/*
	Mantis PCI bridge driver

	Copyright (C) 2005 Manu Abraham (manu@kromtek.com)

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#ifndef _MANTIS_COMMON_H_
#define _MANTIS_COMMON_H_

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/kernel.h>
#include <linux/pci.h>

#include "dvbdev.h"
#include "dvb_demux.h"
#include "dmxdev.h"
#include "dvb_frontend.h"
#include "dvb_net.h"
#include <linux/i2c.h>
#include "mantis_reg.h"

#define MANTIS_ERROR		0
#define MANTIS_NOTICE		1
#define MANTIS_INFO		2
#define MANTIS_DEBUG		3

#define dprintk(x, y, z, format, arg...) do {						\
	if (z) {									\
		if	((x > MANTIS_ERROR) && (x > y))					\
			printk(KERN_ERR "%s: " format "\n" , __FUNCTION__ , ##arg);	\
		else if	((x > MANTIS_NOTICE) && (x > y))				\
			printk(KERN_NOTICE "%s: " format "\n" , __FUNCTION__ , ##arg);	\
		else if ((x > MANTIS_INFO) && (x > y))					\
			printk(KERN_INFO "%s: " format "\n" , __FUNCTION__ , ##arg);	\
		else if ((x > MANTIS_DEBUG) && (x > y))					\
			printk(KERN_DEBUG "%s: " format "\n" , __FUNCTION__ , ##arg);	\
	} else {									\
		if (x > y)								\
			printk(format , ##arg);						\
	}										\
} while(0)

#define mwrite(dat, addr)	writel((dat), addr)
#define mread(addr)		readl(addr)

#define mmwrite(dat, addr)	mwrite((dat), (mantis->mantis_mmio + (addr)))
#define mmread(addr)		mread(mantis->mantis_mmio + (addr))
#define mmand(dat, addr)	mmwrite((dat) & mmread(addr), addr)
#define mmor(dat, addr)		mmwrite((dat) | mmread(addr), addr)
#define mmaor(dat, addr)	mmwrite((dat) | ((mask) & mmread(addr)), addr)


struct mantis_pci {
	/*	PCI stuff	*/
	__u16 vendor_id;
	__u16 device_id;
	__u8  latency;

	/*	Linux PCI	*/
	struct pci_dev *pdev;

	unsigned long mantis_addr;
	volatile void __iomem *mantis_mmio;

	__u8  irq;
	__u8  revision;

	__u16 mantis_card_num;
	__u16 ts_size;

	/*	RISC Core	*/
	volatile __u32 finished_block;
	volatile __u32 last_block;

	__u32 block_count;
	__u32 block_bytes;
	__u32 line_bytes;
	__u32 line_count;

	__u32 risc_pos;

	__u32 buf_size;
	__u8  *buf_cpu;
	dma_addr_t buf_dma;

	__u32 risc_size;
	__u32 *risc_cpu;
	dma_addr_t risc_dma;

	struct	tasklet_struct tasklet;

	struct	i2c_adapter adapter;
	int	i2c_rc;

	/*	DVB stuff	*/
	struct  dvb_adapter dvb_adapter;
	struct  dvb_frontend *fe;
	struct  dvb_demux demux;
	struct  dmxdev dmxdev;
	struct  dmx_frontend fe_hw;
	struct  dmx_frontend fe_mem;
	struct  dvb_net dvbnet;

	__u8	feeds;

	struct  mantis_config *config;

	__u32 mantis_int_stat;
	__u32 mantis_int_mask;

	/*	board specific		*/
	__u8  mac_address[8];
	__u32 sub_vendor_id;
	__u32 sub_device_id;
};

extern unsigned int verbose;
extern int mantis_dvb_init(struct mantis_pci *mantis);
extern int mantis_frontend_init(struct mantis_pci *mantis);
extern int mantis_dvb_exit(struct mantis_pci *mantis);
extern void mantis_dma_xfer(unsigned long data);

#endif

--------------010309070706020404010607
Content-Type: text/plain;
 name="mantis_core.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_core.c"

/*
	Mantis PCI bridge driver

	Copyright (C) 2005 Manu Abraham (manu@kromtek.com)

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include "mantis_common.h"
#include "mantis_core.h"


static int read_eeprom_byte(struct mantis_pci *mantis, u8 *data, u8 length)
{
	int err;
	struct i2c_msg msg = {
		.addr = 0x50,
		.flags = I2C_M_RD,
		.buf = data,
		.len = length
	};
	if ((err = i2c_transfer(&mantis->adapter, &msg, 1)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "ERROR: i2c read: < err=%i d0=0x%02x d1=0x%02x >", err, data[0], data[1]);
		return err;
	}
	msleep(2);

	return 0;
}

static int write_eeprom_byte(struct mantis_pci *mantis, u8 *data, u8 length)
{
	int err;
	struct i2c_msg msg = {
		.addr = 0x50,
		.flags = 0,
		.buf = data,
		.len = length
	};
	if ((err = i2c_transfer(&mantis->adapter, &msg, 1)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "ERROR: i2c write: < err=%i length=0x%02x d0=0x%02x, d1=0x%02x >", err, length, data[0], data[1]);
		return err;
	}

	return 0;
}

static int get_subdevice_id(struct mantis_pci *mantis)
{
	int err;
	static u8 sub_device_id[2];

	mantis->sub_device_id = 0;
	sub_device_id[0] = 0xfc;
	if ((err = read_eeprom_byte(mantis, &sub_device_id[0], 2)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis EEPROM read error");
		return err;
	}
	mantis->sub_device_id = (sub_device_id[0] << 8) | sub_device_id[1];
	dprintk(verbose, MANTIS_ERROR, 1, "Sub Device ID=[0x%04x]", mantis->sub_device_id);

	return 0;
}

static int get_subvendor_id(struct mantis_pci *mantis)
{
	int err;
	static u8 sub_vendor_id[2];

	mantis->sub_vendor_id = 0;
	sub_vendor_id[0] = 0xfe;
	if ((err = read_eeprom_byte(mantis, &sub_vendor_id[0], 2)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis EEPROM read error");
		return err;
	}
	mantis->sub_vendor_id = (sub_vendor_id[0] << 8) | sub_vendor_id[1];
	dprintk(verbose, MANTIS_ERROR, 1, "Sub Vendor ID=[0x%04x]", mantis->sub_vendor_id);

	return 0;
}

static int get_mac_address(struct mantis_pci *mantis)
{
	int err;

	mantis->mac_address[0] = 0x08;
	if ((err = read_eeprom_byte(mantis, &mantis->mac_address[0], 6)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis EEPROM read error");
		return err;
	}
	dprintk(verbose, MANTIS_ERROR, 1, "MAC Address=[%02x:%02x:%02x:%02x:%02x:%02x]",
		mantis->mac_address[0], mantis->mac_address[1],	mantis->mac_address[2],
		mantis->mac_address[3], mantis->mac_address[4], mantis->mac_address[5]);

	return 0;
}


struct vendorname vendorlist[] = {

	{
		.sub_vendor_name	= "Twinhan",
		.sub_vendor_id		= 0x1822,
	},

	{ }
};

struct devicetype devicelist[] = {

	{
		.sub_device_name	= "VP-1033",
		.sub_device_id		= 0x0016,
		.device_type		= FE_TYPE_SAT,
		.type_flags		= FE_TYPE_TS204,
	},

	{ }
};


int mantis_core_init(struct mantis_pci *mantis)
{
	int err;

	if ((err = mantis_i2c_init(mantis)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis I2C init failed");
		goto err;
	}
	if ((err = get_mac_address(mantis)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "get MAC address failed");
		goto err;
	}
	if ((err = get_subvendor_id(mantis)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "get Sub vendor ID failed");
		goto err;
	}
	if ((err = get_subdevice_id(mantis)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "get Sub device ID failed");
		goto err;
	}
	if ((err = mantis_dvb_init(mantis)) < 0) {
		dprintk(verbose, MANTIS_DEBUG, 1, "Mantis DVB init failed");
		goto err;
	}

	return 0;

err:
	return err;
}

int mantis_core_exit(struct mantis_pci *mantis)
{
	if (mantis_dvb_exit(mantis) < 0)
		dprintk(verbose, MANTIS_ERROR, 1, "DVB exit failed");

	if (mantis_i2c_exit(mantis) < 0)
		dprintk(verbose, MANTIS_ERROR, 1, "I2C adapter delete.. failed");

	return 0;
}

static void gpio_set_bits(struct mantis_pci *mantis, u32 bitpos, u8 value)
{
	u32 reg;

	if (value)
		reg = 0x0000;
	else
		reg = 0xffff;

	reg = (value << bitpos);

	mmwrite(mmread(MANTIS_GPIF_HIFADDR) | reg, MANTIS_GPIF_HIFADDR);
	mmwrite(0x00, MANTIS_GPIF_HIFDOUT);
	udelay(100);
	mmwrite(mmread(MANTIS_GPIF_HIFADDR) | reg, MANTIS_GPIF_HIFADDR);
	mmwrite(0x00, MANTIS_GPIF_HIFDOUT);
}

/*
 *	Tuner power supply control
 *	Note: this is different from the LNB power control
 *	
 */
void mantis_fe_powerup(struct mantis_pci *mantis)
{
	gpio_set_bits(mantis, 0x0c, 1);
	mdelay(100);
	gpio_set_bits(mantis, 0x0c, 1);
}

void mantis_fe_powerdown(struct mantis_pci *mantis)
{
	gpio_set_bits(mantis, 0x0c, 0);
}

--------------010309070706020404010607
Content-Type: text/plain;
 name="mantis_core.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_core.h"

/*
	Mantis PCI bridge driver

	Copyright (C) 2005 Manu Abraham (manu@kromtek.com)

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#ifndef _MANTIS_CORE_H_
#define _MANTIS_CORE_H_

#include "mantis_common.h"


#define FE_TYPE_SAT	0
#define FE_TYPE_CAB	1
#define FE_TYPE_TER	2

#define FE_TYPE_TS204	0
#define FE_TYPE_TS188	1


struct vendorname {
	__u8  *sub_vendor_name;
	__u32 sub_vendor_id;
};

struct devicetype {
	__u8  *sub_device_name;
	__u32 sub_device_id;
	__u8  device_type;
	__u32 type_flags;
};


extern int mantis_dma_init(struct mantis_pci *mantis);
extern int mantis_dma_exit(struct mantis_pci *mantis);
extern void mantis_dma_start(struct mantis_pci *mantis);
extern void mantis_dma_stop(struct mantis_pci *mantis);
extern int mantis_i2c_init(struct mantis_pci *mantis);
extern int mantis_i2c_exit(struct mantis_pci *mantis);
extern int mantis_core_init(struct mantis_pci *mantis);
extern int mantis_core_exit(struct mantis_pci *mantis);
extern void mantis_fe_powerup(struct mantis_pci *mantis);
extern void mantis_fe_powerdown(struct mantis_pci *mantis);


#endif

--------------010309070706020404010607
Content-Type: text/plain;
 name="mantis_dma.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_dma.c"

/*
	Mantis PCI bridge driver

	Copyright (C) 2005 Manu Abraham (manu@kromtek.com)

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include <asm/page.h>
#include <linux/vmalloc.h>
#include "mantis_common.h"

#define RISC_WRITE		(0x01 << 28)
#define RISC_JUMP		(0x07 << 28)
#define RISC_SYNC		(0x08 << 28)

#define RISC_WR_SOL		(1 << 27)
#define RISC_WR_EOL		(1 << 26)
#define RISC_IRQ		(1 << 24)

#define RISC_STATUS(status)	((((~status) & 0x0F) << 20) | ((status & 0x0F) << 16))

#define RISC_FLUSH()		mantis->risc_pos = 0
#define RISC_INSTR(opcode)	mantis->risc_cpu[mantis->risc_pos++] = cpu_to_le32(opcode)


static void mantis_free(struct mantis_pci *mantis)
{
	if (mantis->buf_cpu) {
		dprintk(verbose, MANTIS_ERROR, 1, "DMA=%lx", (unsigned long) mantis->buf_dma);
		pci_free_consistent(mantis->pdev, mantis->buf_size, mantis->buf_cpu, mantis->buf_dma);
		mantis->buf_cpu = NULL;
	}
	if (mantis->risc_cpu) {
		dprintk(verbose, MANTIS_ERROR, 1, "RISC=%lx", (unsigned long) mantis->risc_dma);
		pci_free_consistent(mantis->pdev, mantis->risc_size, mantis->risc_cpu, mantis->risc_dma);
		mantis->risc_cpu = NULL;
	}
}


static int mantis_alloc_buffers(struct mantis_pci *mantis)
{
	if (!mantis->buf_cpu) {
		mantis->buf_size = 128 * 1024;
		mantis->buf_cpu = pci_alloc_consistent(mantis->pdev, mantis->buf_size, &mantis->buf_dma);
		if (!mantis->buf_cpu) {
			dprintk(verbose, MANTIS_ERROR, 1, "DMA buffer allocation failed");
			goto err;
		}
		dprintk(verbose, MANTIS_ERROR, 1, "DMA=0x%lx cpu=0x%p size=%d",
				(unsigned long) mantis->buf_dma, mantis->buf_cpu, mantis->buf_size);
	}
	if (!mantis->risc_cpu) {
		mantis->risc_size = PAGE_SIZE;
		mantis->risc_cpu = pci_alloc_consistent(mantis->pdev, mantis->risc_size, &mantis->risc_dma);
		if (!mantis->risc_cpu) {
			dprintk(verbose, MANTIS_ERROR, 1, "RISC program allocation failed");
			mantis_free(mantis);
			goto err;
		}
		dprintk(verbose, MANTIS_ERROR, 1, "RISC=0x%lx cpu=0x%p size=%d",
				(unsigned long) mantis->risc_dma, mantis->risc_cpu, mantis->risc_size);
	}

	return 0;
err:
	dprintk(verbose, MANTIS_ERROR, 1, "Out of memory (?) .....");
	return -ENOMEM;
}

static int mantis_calc_lines(struct mantis_pci *mantis)
{
	mantis->block_bytes = mantis->buf_size >> 4;
	mantis->block_count = 1 << 4;
	mantis->line_bytes = mantis->block_bytes;
	mantis->line_count = mantis->block_count;

	while (mantis->line_bytes > 4095) {
		mantis->line_bytes >>= 1;
		mantis->line_count <<= 1;
	}
	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis RISC block bytes=[%d], line bytes=[%d], line count=[%d]",
			mantis->block_bytes, mantis->line_bytes, mantis->line_count);

	if (mantis->line_count > 255) {
		dprintk(verbose, MANTIS_ERROR, 1, "Buffer size error");
		return -EINVAL;
	}

	return 0;
}

static void mantis_risc_program(struct mantis_pci *mantis)
{
	u32 buf_pos = 0;
	u32 line;

	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis create RISC program");
	RISC_FLUSH();
	RISC_INSTR(RISC_SYNC);
	RISC_INSTR(0);

	dprintk(verbose, MANTIS_DEBUG, 1, "risc len lines %u, bytes per line %u", mantis->line_count, mantis->line_bytes);
	for (line = 0; line < mantis->line_count; line++) {
		dprintk(verbose, MANTIS_DEBUG, 1, "RISC PROG line=[%d]", line);
		if (!(buf_pos % mantis->block_bytes))
			RISC_INSTR(RISC_WRITE | RISC_WR_SOL | RISC_WR_EOL | RISC_IRQ |
						RISC_STATUS(((buf_pos / mantis->block_bytes) +
						(mantis->block_count - 1)) % mantis->block_count) | mantis->line_bytes);
		else
			RISC_INSTR(RISC_WRITE | RISC_WR_SOL | RISC_WR_EOL | mantis->line_bytes);
		RISC_INSTR(mantis->buf_dma + buf_pos);
		buf_pos += mantis->line_bytes;
	}
	RISC_INSTR(RISC_SYNC);
	RISC_INSTR(0);
	RISC_INSTR(RISC_JUMP);
	RISC_INSTR(mantis->risc_dma);
}

void mantis_dma_start(struct mantis_pci *mantis)
{
	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis Start DMA engine");
	/*
	 *	Create RISC program to be loaded to the RISC core
	 */
	mantis_risc_program(mantis);

	/*
	 *	Load the RISC program from Host to RISC
	 */
	mmwrite(cpu_to_le32(mantis->risc_dma), MANTIS_RISC_START);

	/*
	 *	Enable INT's, start DMA engine
	 *	DMA engine: Enable FIFO, Enable Data Capture
	 *	Enable RISC engine
	 */
	mmwrite(mmread(MANTIS_INT_MASK) | MANTIS_FIFO_EN | MANTIS_DCAP_EN | MANTIS_RISC_EN, MANTIS_INT_MASK);
	mmwrite(mmread(MANTIS_DMA_CTL) | MANTIS_FIFO_EN | MANTIS_DCAP_EN | MANTIS_RISC_EN, MANTIS_DMA_CTL);

}

void mantis_dma_stop(struct mantis_pci *mantis)
{
	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis Stop DMA engine");

	/*
	 *	Stop only the DMA engine, do not clear
	 *	the other interrupts
	 */
	mmwrite((mmread(MANTIS_DMA_CTL) & ~(MANTIS_FIFO_EN | MANTIS_DCAP_EN | MANTIS_RISC_EN)), MANTIS_DMA_CTL);
}


int mantis_dma_init(struct mantis_pci *mantis)
{
	int err = 0;

	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis DMA init");
	if (mantis_alloc_buffers(mantis) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Error allocating DMA buffer");

		/*
		 *	Disable all interrupts during initialization
		 *	to avoid spurious interrupts creating hell.
		 *	Clear all INT's, disable FIFO RISC.
		 */
		mmwrite(0x00, MANTIS_INT_MASK);
		mmwrite(0x00, MANTIS_DMA_CTL);

		goto err;
	}
	if ((err = mantis_calc_lines(mantis)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis calc lines failed");
		goto err;
	}

	return 0;
err:
	return err;
}

void mantis_dma_xfer(unsigned long data)
{
	struct mantis_pci *mantis = (struct mantis_pci *) data;

	while (mantis->last_block != mantis->finished_block) {
		(mantis->ts_size ? dvb_dmx_swfilter_204: dvb_dmx_swfilter)
		(&mantis->demux, &mantis->buf_cpu[mantis->last_block * mantis->block_bytes], mantis->block_bytes);
		mantis->last_block = (mantis->last_block + 1) % mantis->block_count;
	}
}

int mantis_dma_exit(struct mantis_pci *mantis)
{
	if (mantis->buf_cpu) {
		dprintk(verbose, MANTIS_ERROR, 1, "DMA=0x%lx cpu=0x%p size=%d",
				(unsigned long) mantis->buf_dma, mantis->buf_cpu, mantis->buf_size);
		pci_free_consistent(mantis->pdev, mantis->buf_size, mantis->buf_cpu, mantis->buf_dma);
		mantis->buf_cpu = NULL;
	}
	if (mantis->risc_cpu) {
		dprintk(verbose, MANTIS_ERROR, 1, "RISC=0x%lx cpu=0x%p size=%d",
				(unsigned long) mantis->risc_dma, mantis->risc_cpu, mantis->risc_size);
		pci_free_consistent(mantis->pdev, mantis->risc_size, mantis->risc_cpu, mantis->risc_dma);
		mantis->risc_cpu = NULL;
	}

	return 0;
}

--------------010309070706020404010607
Content-Type: text/plain;
 name="mantis_i2c.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_i2c.c"

/*
	Mantis PCI bridge driver

	Copyright (C) 2005 Manu Abraham (manu@kromtek.com)

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <asm/io.h>
#include <linux/ioport.h>
#include <asm/pgtable.h>
#include <asm/page.h>
#include "mantis_common.h"

#define I2C_HW_B_MANTIS		0x1c

/*
 *	Wait till we receive INT I2CRACK. I2CDONE will follow suit,
 *	since we save the states, we would have both I2CRACK and I2CDONE set
 *	we don't wait till eternity though.
 */
static int mantis_ack_wait(struct mantis_pci *mantis)
{
	u8 timeout = 0;

	/*
	 *	I2CRACK will be reset when I2CDONE is set
	 *
	 *
	 */
	while (!(mantis->mantis_int_stat & MANTIS_INT_I2CRACK)) {
		udelay(1000);
		timeout++;
		dprintk(verbose, MANTIS_DEBUG, 0, ".");
		if (timeout > 50)
			return -1;
	}

	/*
	 *	Reset STATUS flags, before we leave.
	 *	since we save states.
	 */
	dprintk(verbose, MANTIS_DEBUG, 1, "Status  ... MANTIS_INT_STAT=[0x%08x]", mantis->mantis_int_stat);
	mantis->mantis_int_stat &= (~MANTIS_INT_I2CRACK | ~MANTIS_INT_I2CDONE);

	return 0;
}

static inline void mantis_i2cint_set(struct mantis_pci *mantis)
{
	/*
	 *	We don't have a mask for I2CRACK
	 *	I2CRACK is cleared on setting I2CDONE (?)
	 */
//	mmwrite(mmread(MANTIS_INT_STAT) & MANTIS_INT_I2CRACK, MANTIS_INT_STAT);
	mmwrite(mmread(MANTIS_INT_MASK) | MANTIS_INT_I2CDONE, MANTIS_INT_MASK);
	udelay(1000);
}


static int mantis_i2c_pagewrite(struct mantis_pci *mantis, struct i2c_msg *msg)
{
	u8  i;
	u32 txd = 0;

	dprintk(verbose, MANTIS_DEBUG, 1, "Writing to [0x%02x]", msg->addr);

	for (i = 0; i < msg->len; i++) {
		dprintk(verbose, MANTIS_DEBUG, 1, "Data<W[%d]>=[0x%02x]", i, msg->buf[i]);
		txd |= (msg->addr << 25) | (msg->buf[i] << 8) | MANTIS_I2C_RATE_3 | MANTIS_I2C_STOP | MANTIS_I2C_PGMODE;
		if (i == 3)
			txd &= ~MANTIS_I2C_STOP;

		mantis_i2cint_set(mantis);
		mmwrite(txd, MANTIS_I2CDATA_CTL);

		if (mantis_ack_wait(mantis) < 0) {
			dprintk(verbose, MANTIS_DEBUG, 1, "ACK failed");
			return -1;
		}
		udelay(10);
	}

	return 0;
}

/*	FIXME! needs to be fixed, we need to put things back		*/
static int mantis_i2c_pageread(struct mantis_pci *mantis, struct i2c_msg *msg)
{
	u8 i;
	u32 rxd = 0;

	for (i = 0; i < 2; i++) {
		rxd |= ((msg->addr << 25) | (1 << 24)) | MANTIS_I2C_RATE_3 | MANTIS_I2C_STOP | MANTIS_I2C_PGMODE;
		if (i == 1)
			rxd &= ~MANTIS_I2C_STOP;
		mmwrite(mmread(MANTIS_INT_STAT) | MANTIS_INT_I2CDONE, MANTIS_INT_STAT);
		mmwrite(mmread(MANTIS_INT_MASK) | MANTIS_INT_I2CDONE, MANTIS_INT_MASK);
		udelay(1000);
		if (mantis_ack_wait(mantis) < 0)
			return -EIO;
		rxd = mmread(MANTIS_I2CDATA_CTL);
		udelay(500);
	}

	return 0;
}

///*	FIXME !	Right now writes only a byte	*/
static int mantis_i2c_writebyte(struct mantis_pci *mantis, struct i2c_msg *msg)
{
	u32 txd = 0;
	mantis->mantis_int_stat = 0;

	txd = (msg->addr << 25) | (msg->buf[0] << 16) | (msg->buf[1] << 8) | MANTIS_I2C_RATE_3;
	dprintk(verbose, MANTIS_DEBUG, 1, "Writing to [0x%02x],  Data<W>=[%02x]", msg->addr, msg->buf[1]);
	mmwrite(txd, MANTIS_I2CDATA_CTL);

	if (mantis_ack_wait(mantis) < 0) {
		dprintk(verbose, MANTIS_DEBUG, 1, "Slave did not ACK !");
		return -EIO;
	}

	return 0;
}

static int mantis_i2c_readbyte(struct mantis_pci *mantis, struct i2c_msg *msg)
{
	u32 rxd;
	u16 i;
	u8  subaddr;

	/*
	 *	Clear saved previous states
	 */
	mantis->mantis_int_stat &= (~MANTIS_INT_I2CDONE | ~MANTIS_INT_I2CRACK);
	subaddr = msg->buf[0];

	for (i = 0; i < msg->len; i++) {
		/*	Rate settings		*/
		rxd = ((msg->addr << 25) | (1 << 24)) | (subaddr << 16) | MANTIS_I2C_RATE_3;

		mmwrite(rxd, MANTIS_I2CDATA_CTL);

		/*
		 *	Enable INT_I2CDONE
		 */
		mmwrite(mmread(MANTIS_INT_MASK) | MANTIS_INT_I2CDONE, MANTIS_INT_MASK);
		udelay(1000);

		/*	Slave ACK		*/
		if (mantis_ack_wait(mantis) < 0)
			return -EIO;

		rxd = mmread(MANTIS_I2CDATA_CTL);
		udelay(500);
		msg->buf[i] = (rxd >> 8) & 0xff;
		dprintk(verbose, MANTIS_DEBUG, 1, "Reading from [0x%02x], Data<R[%d]>=[0x%02x]", msg->addr, i, msg->buf[i]);
		subaddr++;
	}

	return 0;
}

static int mantis_i2c_readbytes(struct mantis_pci *mantis, struct i2c_msg *msg)
{
	u32 rxd;
	u16 i;

	mantis->mantis_int_stat = 0;

	for (i = 0; i < msg[1].len; i++) {
		/*	Rate settings		*/
		rxd = ((msg[0].addr  << 25) | (1 << 24)) | (msg[0].buf[0] << 16) | MANTIS_I2C_RATE_3;

		mmwrite(rxd, MANTIS_I2CDATA_CTL);

		/*
		 *	Need to wait till I2CDONE, rather than slave I2CRACK
		 */
		mmwrite(mmread(MANTIS_INT_MASK) | MANTIS_INT_I2CDONE, MANTIS_INT_MASK);
		udelay(1000);
		if (mantis_ack_wait(mantis) < 0)
			return -EIO;

		rxd = mmread(MANTIS_I2CDATA_CTL);
		udelay(500);
		msg[1].buf[i] = (rxd >> 8) & 0xff;
		dprintk(verbose, MANTIS_DEBUG, 1, "Reading from [0x%02x], Data<R[%d]>=[0x%02x]", msg[0].addr, i, msg[1].buf[i]);
		msg[0].buf[0]++;
	}

	return 0;
}

/*	FIXME !	Right now writes only a byte	*/
static int mantis_i2c_writebytes(struct mantis_pci *mantis, struct i2c_msg *msg)
{
	u32 txd = 0;
	mantis->mantis_int_stat = 0;

	txd = (msg->addr << 25) | (msg->buf[0] << 16) | (msg->buf[1] << 8) | MANTIS_I2C_RATE_3;
	dprintk(verbose, MANTIS_DEBUG, 1, "Writing to [0x%02x], Data<W>=[%02x]", msg->addr, msg->buf[1]);
	mmwrite(txd, MANTIS_I2CDATA_CTL);

	if (mantis_ack_wait(mantis) < 0)
		return -EIO;

	return 0;
}

static int mantis_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msg, int num)
{
	int retval = 0;
	struct mantis_pci *mantis;

	mantis = i2c_get_adapdata(adapter);

	if (num == 4) {
		if (msg[0].flags & I2C_M_RD) {
			if ((retval = mantis_i2c_pageread(mantis, msg)) < 0)
				return retval;
		} else {
			if ((retval = mantis_i2c_pagewrite(mantis, msg)) < 0)
				return retval;
		}
	/*	 STV0299 operation (???)	*/
	} else if (num == 2) {
		mantis_i2cint_set(mantis);
		/*	Sanity check	*/
		if (msg[0].buf != NULL && msg[1].buf != NULL) {
			/*	I2C operation type	*/
			if (msg[0].flags == 0 && msg[1].flags == I2C_M_RD) {
				/*	Read	*/
				if ((retval = mantis_i2c_readbytes(mantis, msg)) < 0)
					return retval;
			} else {
				/*	Write	*/
				if ((retval = mantis_i2c_writebytes(mantis, msg)) < 0)
					return retval;
			}
		}
	/*	Normal case operation	*/
	} else {
		mantis_i2cint_set(mantis);
		if (msg[0].flags & I2C_M_RD) {
			if ((retval = mantis_i2c_readbyte(mantis, msg)) < 0)
				return retval;
		} else {
			if ((retval = mantis_i2c_writebyte(mantis, msg)) < 0)
				return retval;
		}
	}

	return num;
}

static __u32 mantis_i2c_func(struct i2c_adapter *adapter)
{
	return I2C_FUNC_SMBUS_EMUL;
}

static int mantis_attach_inform(struct i2c_client *client)
{
	struct mantis_pci *mantis;

	mantis = i2c_get_adapdata(client->adapter);
	dprintk(verbose, MANTIS_ERROR, 1, "mantis: %s i2c attach [addr = 0x%x, client=%s]",
		client->driver->name, client->addr, i2c_clientname(client));

	return 0;
}

static struct i2c_algorithm mantis_algo = {
	.name			= "Mantis I2C",
	.id			= I2C_HW_B_MANTIS,
	.master_xfer		= mantis_i2c_xfer,
	.functionality		= mantis_i2c_func,
};

static struct i2c_adapter mantis_i2c_adapter = {
	.owner			= THIS_MODULE,
	.class			= I2C_CLASS_TV_DIGITAL,
	.algo			= &mantis_algo,
	.client_register	= mantis_attach_inform,
};

int __devinit mantis_i2c_init(struct mantis_pci *mantis)
{
	memcpy(&mantis->adapter, &mantis_i2c_adapter, sizeof (mantis_i2c_adapter));
	i2c_set_adapdata(&mantis->adapter, mantis);
	mantis->i2c_rc = i2c_add_adapter(&mantis->adapter);
	if (mantis->i2c_rc < 0)
		return mantis->i2c_rc;

	dprintk(verbose, MANTIS_DEBUG, 1, "Initializing I2C ..");

	/*
	 *	I2CRACK will be reset when I2CDONE is set
	 *	Clear and setup I2C int mask
	 */
	mmwrite(mmread(MANTIS_INT_STAT) & ( ~MANTIS_INT_I2CDONE | ~MANTIS_INT_I2CRACK), MANTIS_INT_STAT);
	mmwrite(mmread(MANTIS_INT_MASK) | MANTIS_INT_I2CDONE | MANTIS_INT_I2CRACK, MANTIS_INT_MASK);
	dprintk(verbose, MANTIS_DEBUG, 1, "INT_STAT=[0x%08x], INT_MASK=[0x%08x]", mmread(MANTIS_INT_STAT), mmread(MANTIS_INT_MASK));

	return 0;
}

int __devexit mantis_i2c_exit(struct mantis_pci *mantis)
{
	dprintk(verbose, MANTIS_DEBUG, 1, "Removing I2C adapter");
	return i2c_del_adapter(&mantis->adapter);
}

--------------010309070706020404010607
Content-Type: text/plain;
 name="mantis_pci.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_pci.c"

/*
	Mantis PCI bridge driver

	Copyright (C) 2005 Manu Abraham (manu@kromtek.com)

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/page.h>
#include <linux/kmod.h>
#include <linux/vmalloc.h>
#include <linux/init.h>
#include <linux/device.h>
#include "mantis_common.h"
#include "mantis_core.h"

#include <asm/irq.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/interrupt.h>

unsigned int verbose = 1;
module_param(verbose, int, 0644);
MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");

#define PCI_VENDOR_ID_MANTIS			0x1822
#define PCI_DEVICE_ID_MANTIS_R11		0x4e35
#define DRIVER_NAME				"Mantis"

static struct pci_device_id mantis_pci_table[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11) },
	{ 0 },
};

MODULE_DEVICE_TABLE(pci, mantis_pci_table);

static irqreturn_t mantis_pci_irq(int irq, void *dev_id, struct pt_regs *regs)
{
	int count = 0, interrupts = 0;
	u32 stat = 0, mask = 0, temp;

	struct mantis_pci *mantis;

	mantis = (struct mantis_pci *) dev_id;
	if (mantis == NULL)
		dprintk(verbose, MANTIS_DEBUG, 1, "Aeio, mantis ISR");

	/*
	 *	Don't read each and everytime, but read in one shot
	 *	We need to save the states for later too ..
	 *
	 */

	stat = mmread(MANTIS_INT_STAT);
	mask = mmread(MANTIS_INT_MASK);

	/*
	 *	To speed up things, do a basic check whether it is our
	 *	interrupt.
	 *	Also, we don't have a mask for I2CRACK
	 */
	if (!(stat & (mask | MANTIS_INT_I2CRACK)) ) {
		dprintk(verbose, MANTIS_ERROR, 1, "Not ours !");
		return IRQ_NONE;
	}

	/*
	 *	The int is for us, clear int condition
	 */
	mmwrite(stat, MANTIS_INT_STAT);

	/*
	 *	Check how many 1's are in the INT_STAT, Count will reflect
	 *	no. of interrupts, we should loop count times.
	 *
	 */
	 temp = stat;
	 while (temp) {
		if (temp & 0x01) {
			interrupts++;
			dprintk(verbose, MANTIS_DEBUG, 1, "Interrupt @ %d", interrupts);
		}
		temp >>= 1;
		count++;

		/*
		 *	We should never loop more than reg. width
		 *	else, Bail out
		 */
		if (count > 32) {
			dprintk(verbose, MANTIS_ERROR, 1, "Bailing out !!");
			break;
		}
	}
	count = 0;
	while (count < interrupts) {
		if ((stat & mask) & MANTIS_INT_RISCEN) {
			dprintk(verbose, MANTIS_DEBUG, 1, "**** DMA enabl ****");
			mantis->mantis_int_stat |= MANTIS_INT_RISCEN;
			stat &= ~MANTIS_INT_RISCEN;

		/*
		 *	It's a shame that there is no mask for I2CRACK !
		 */
		} else if (stat & MANTIS_INT_I2CRACK) {
			dprintk(verbose, MANTIS_DEBUG, 1, "**** I2C R-ACK ****");
			mantis->mantis_int_stat |= MANTIS_INT_I2CRACK;
			stat &= ~MANTIS_INT_I2CRACK;

		} else if ((stat & mask) & MANTIS_INT_IRQ0) {
			dprintk(verbose, MANTIS_DEBUG, 1, "**** INT IRQ-0 ****");
			mantis->mantis_int_stat |= MANTIS_INT_IRQ0;
			stat &= ~MANTIS_INT_IRQ0;

		} else if ((stat & mask) & MANTIS_INT_IRQ1) {
			dprintk(verbose, MANTIS_DEBUG, 1, "**** INT IRQ-1 ****");
			mantis->mantis_int_stat |= MANTIS_INT_IRQ1;
			stat &= ~MANTIS_INT_IRQ1;

		} else if ((stat & mask) & MANTIS_INT_OCERR) {
			dprintk(verbose, MANTIS_DEBUG, 1, "**** INT OCERR ****");
			mantis->mantis_int_stat |= MANTIS_INT_OCERR;
			stat &= ~MANTIS_INT_OCERR;

		} else if ((stat & mask) & MANTIS_INT_PABORT) {
			dprintk(verbose, MANTIS_DEBUG, 1, "**** INT PABRT ****");
			mantis->mantis_int_stat |= MANTIS_INT_PABORT;
			stat &= ~MANTIS_INT_PABORT;

		} else if ((stat & mask) & MANTIS_INT_RIPERR) {
			dprintk(verbose, MANTIS_DEBUG, 1, "**** INT RIPRR ****");
			mantis->mantis_int_stat |= MANTIS_INT_RIPERR;
			stat &= ~MANTIS_INT_RIPERR;

		} else if ((stat & mask) & MANTIS_INT_PPERR) {
			dprintk(verbose, MANTIS_DEBUG, 1, "**** INT PPERR ****");
			mantis->mantis_int_stat |= MANTIS_INT_PPERR;
			stat &= ~MANTIS_INT_PPERR;

		} else if ((stat & mask) & MANTIS_INT_FTRGT) {
			dprintk(verbose, MANTIS_DEBUG, 1, "**** INT FTRGT ****");
			mantis->mantis_int_stat |= MANTIS_INT_FTRGT;
			stat &= ~MANTIS_INT_FTRGT;

		} else if ((stat & mask) & MANTIS_INT_RISCI) {
			mantis->finished_block = (mantis->mantis_int_stat & MANTIS_INT_RISCSTAT) >> 28;
			tasklet_schedule(&mantis->tasklet);
			stat &= ~MANTIS_INT_RISCI;

		} else if ((stat & mask) & MANTIS_INT_I2CDONE) {
			dprintk(verbose, MANTIS_DEBUG, 1, "**** I2C DONE  ****");
			mantis->mantis_int_stat |= MANTIS_INT_I2CDONE;
			stat &= ~MANTIS_INT_I2CDONE;

		} else {
			dprintk(verbose, MANTIS_DEBUG, 1, "Unknown INT ???");
		}

		count++;

		/*
		 *	Being paranoid, check whether we are too loopy !
		 */
		if (count > 32) {
			dprintk(verbose, MANTIS_ERROR, 1, "IRQ Lockup, clearing INT mask");
			dprintk(verbose, MANTIS_ERROR, 1, "Count=%d, Interrupts=%d, stat=[0x%08x]", count, interrupts, stat);
			mmwrite(0, MANTIS_INT_MASK);
			stat = 0, interrupts = 0;

			break;
		}
	}

	return IRQ_HANDLED;
}


static int __devinit mantis_pci_probe(struct pci_dev *pdev,
				const struct pci_device_id *mantis_pci_table)
{
	u8 revision, latency;
	struct mantis_pci *mantis;

	if (pci_enable_device(pdev)) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
		goto err;
	}
	mantis = kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
	if (mantis == NULL) {
		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
		return -ENOMEM;
	}
	memset(mantis, 0, sizeof (struct mantis_pci));

	mantis->mantis_addr = pci_resource_start(pdev, 0);
	if (!request_mem_region(pci_resource_start(pdev, 0),
			pci_resource_len(pdev, 0), DRIVER_NAME)) {
		goto err0;
	}

	if ((mantis->mantis_mmio =
				ioremap(mantis->mantis_addr, 0x1000)) == NULL) {
		dprintk(verbose, MANTIS_ERROR, 1, "IO remap failed");
		goto err1;
	}
	/*
	 *	Clear and disable all interrupts at startup
	 *	to avoid lockup situations
	 */
	mmwrite(0x00, MANTIS_INT_STAT);
	mmwrite(0x00, MANTIS_INT_MASK);
	if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ | SA_INTERRUPT,
						DRIVER_NAME, mantis) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ reg failed");
		goto err2;
	}
	pci_set_master(pdev);
	pci_set_drvdata(pdev, mantis);
	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
	pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
	mantis->latency = latency;
	mantis->revision = revision;
	mantis->pdev = pdev;

	/*
	 *	Setup default latency 32 if none specified
	 */
	if (!latency)
		pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 32);
	dprintk(verbose, MANTIS_ERROR, 0, "Mantis Rev %d, ", mantis->revision);
	dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d			\
	\nmemory: 0x%lx, mmio: 0x%p\n", pdev->irq, mantis->latency,		\
		mantis->mantis_addr, mantis->mantis_mmio);
	if ((mantis_dma_init(mantis)) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis DMA init failed");
		goto err0;
	}

	/*
	 *	No more PCI specific stuff !
	 */	
	if (mantis_core_init(mantis) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis core init failed");
		goto err2;
	}

	return 0;
	
	/*
	 *	Error conditions ..
	 */

err2:
	if (mantis_dma_exit(mantis) < 0)
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis DMA exit failed");

	dprintk(verbose, MANTIS_DEBUG, 1, "Err: IO Unmap");
	if (mantis->mantis_mmio)
		iounmap(mantis->mantis_mmio);
err1:
	dprintk(verbose, MANTIS_DEBUG, 1, "Err: Release regions");
	release_mem_region(pci_resource_start(pdev, 0),
				pci_resource_len(pdev, 0));
	pci_disable_device(pdev);
err0:
	dprintk(verbose, MANTIS_DEBUG, 1, "Err: Free");
	kfree(mantis);
err:
	dprintk(verbose, MANTIS_DEBUG, 1, "Err:");
	return -ENODEV;
}

static void __devexit mantis_pci_remove(struct pci_dev *pdev)
{
	struct mantis_pci *mantis = pci_get_drvdata(pdev);
	if (mantis == NULL) {
		dprintk(verbose, MANTIS_ERROR, 1, "Aeio, Mantis NULL ptr");
		return;
	}
	mantis_core_exit(mantis);
	dprintk(verbose, MANTIS_ERROR, 1, "Removing -->Mantis irq: %d,		\
		latency: %d\n memory: 0x%lx, mmio: 0x%p",
		pdev->irq, mantis->latency, mantis->mantis_addr,
		mantis->mantis_mmio);

	free_irq(pdev->irq, mantis);
	pci_release_regions(pdev);
	if (mantis_dma_exit(mantis) < 0)
		dprintk(verbose, MANTIS_ERROR, 1, "DMA exit failed");

	pci_set_drvdata(pdev, NULL);
	pci_disable_device(pdev);
	kfree(mantis);
}

static struct pci_driver mantis_pci_driver = {
	.name = DRIVER_NAME,
	.id_table = mantis_pci_table,
	.probe = mantis_pci_probe,
	.remove = mantis_pci_remove,
};

static int __devinit mantis_pci_init(void)
{
	return pci_register_driver(&mantis_pci_driver);
}

static void __devexit mantis_pci_exit(void)
{
	pci_unregister_driver(&mantis_pci_driver);
}

module_init(mantis_pci_init);
module_exit(mantis_pci_exit);

MODULE_DESCRIPTION("Mantis PCI DTV bridge driver");
MODULE_AUTHOR("Manu Abraham");
MODULE_LICENSE("GPL");

--------------010309070706020404010607
Content-Type: text/plain;
 name="mantis_reg.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_reg.h"

/*
	Mantis PCI bridge driver

	Copyright (C) 2005 Manu Abraham (manu@kromtek.com)

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#ifndef _MANTIS_REG_H_
#define _MANTIS_REG_H_

/*	Interrupts	*/
#define MANTIS_INT_STAT			0x00
#define MANTIS_INT_MASK			0x04
#define MANTIS_INT_RISCSTAT		(0xf << 28)
#define MANTIS_INT_RISCEN		(1 << 27)
#define MANTIS_INT_I2CRACK		(1 << 26)
#define MANTIS_INT_IRQ0			(1 << 11)
#define MANTIS_INT_IRQ1			(1 << 10)
#define MANTIS_INT_OCERR		(1 << 8)
#define MANTIS_INT_PABORT		(1 << 7)
#define MANTIS_INT_RIPERR		(1 << 6)
#define MANTIS_INT_PPERR		(1 << 5)
#define MANTIS_INT_FTRGT		(1 << 3)
#define MANTIS_INT_RISCI		(1 << 1)
#define MANTIS_INT_I2CDONE		(1 << 0)

/*	DMA		*/
#define MANTIS_DMA_CTL			0x08
#define	MANTIS_I2C_RD			(1 << 7)
#define MANTIS_I2C_WR			(1 << 6)
#define MANTIS_DCAP_MODE		(1 << 5)
#define MANTIS_FIFO_TP_4		(0 << 3)
#define MANTIS_FIFO_TP_8		(1 << 3)
#define MANTIS_FIFO_TP_16		(2 << 3)
#define MANTIS_FIFO_EN			(1 << 2)
#define MANTIS_DCAP_EN			(1 << 1)
#define MANTIS_RISC_EN			(1 << 0)


#define MANTIS_RISC_START		0x10
#define MANTIS_RISC_PC			0x14

/*	I2C		*/
#define MANTIS_I2CDATA_CTL		0x18
#define MANTIS_I2C_RATE_1		(0 << 6)
#define MANTIS_I2C_RATE_2		(1 << 6)
#define MANTIS_I2C_RATE_3		(2 << 6)
#define MANTIS_I2C_RATE_4		(3 << 6)
#define MANTIS_I2C_STOP			(1 << 5)
#define MANTIS_I2C_PGMODE		(1 << 3)

#define MANTIS_GPIF_HIFADDR		0xb0
#define MANTIS_GPIF_HIFDOUT		0xb4


#endif

--------------010309070706020404010607--
