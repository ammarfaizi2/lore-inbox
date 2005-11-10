Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVKJJwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVKJJwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVKJJwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:52:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62666 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750737AbVKJJwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:52:34 -0500
Date: Thu, 10 Nov 2005 10:50:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, dwmw2@infradead.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051110095050.GC2021@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz> <4372B7A8.5060904@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4372B7A8.5060904@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Latest mtd changes break collie...it now oopses during boot. This
> >reverts the bad patch.
> 
> What tree was this generated against?  It doesn't seem to match recent 
> linux-mtd or kernel.org trees.  It looks like the tree used had 
> different version of a couple fixes recently added to linux-mtd (removal 
> of bogus udelays and 32-bit status datatype).
> 
> I'm guessing the important part is to add a missing spin_unlock_bh(), 
> which is definitely a bug in the mtd code, but this code is so different 
> than linux-mtd CVS that it seems more resyncing is needed.  As it stands 
> now, force-fitting this patch would still leave an unbalanced 
> spin_lock_bh() without other changes.  And it does look like this driver 
> hasn't been converted to modern mtd apis.

Is there easy way to get at linux-mtd CVS? Attached is my current
version of sharp.c; map_read32/map_write32 was deleted thanks to
Richard Purdue.

							Pavel
/*
 * MTD chip driver for pre-CFI Sharp flash chips
 *
 * Copyright 2000,2001 David A. Schleef <ds@schleef.org>
 *           2000,2001 Lineo, Inc.
 *
 * $Id: sharp.c,v 1.14 2004/08/09 13:19:43 dwmw2 Exp $
 *
 * Devices supported:
 *   LH28F016SCT Symmetrical block flash memory, 2Mx8
 *   LH28F008SCT Symmetrical block flash memory, 1Mx8
 *
 * Documentation:
 *   http://www.sharpmeg.com/datasheets/memic/flashcmp/
 *   http://www.sharpmeg.com/datasheets/memic/flashcmp/01symf/16m/016sctl9.pdf
 *   016sctl9.pdf
 *
 * Limitations:
 *   This driver only supports 4x1 arrangement of chips.
 *   Not tested on anything but PowerPC.
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/types.h>
#include <linux/sched.h>
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/mtd/map.h>
#include <linux/mtd/mtd.h>
#include <linux/mtd/cfi.h>
#include <linux/delay.h>
#include <linux/init.h>

#define CMD_RESET		0xffffffff
#define CMD_READ_ID		0x90909090
#define CMD_READ_STATUS		0x70707070
#define CMD_CLEAR_STATUS	0x50505050
#define CMD_BLOCK_ERASE_1	0x20202020
#define CMD_BLOCK_ERASE_2	0xd0d0d0d0
#define CMD_BYTE_WRITE		0x40404040
#define CMD_SUSPEND		0xb0b0b0b0
#define CMD_RESUME		0xd0d0d0d0
#define CMD_SET_BLOCK_LOCK_1	0x60606060
#define CMD_SET_BLOCK_LOCK_2	0x01010101
#define CMD_SET_MASTER_LOCK_1	0x60606060
#define CMD_SET_MASTER_LOCK_2	0xf1f1f1f1
#define CMD_CLEAR_BLOCK_LOCKS_1	0x60606060
#define CMD_CLEAR_BLOCK_LOCKS_2	0xd0d0d0d0

#define SR_READY		0x80808080 // 1 = ready
#define SR_ERASE_SUSPEND	0x40404040 // 1 = block erase suspended
#define SR_ERROR_ERASE		0x20202020 // 1 = error in block erase or clear lock bits
#define SR_ERROR_WRITE		0x10101010 // 1 = error in byte write or set lock bit
#define	SR_VPP			0x08080808 // 1 = Vpp is low
#define SR_WRITE_SUSPEND	0x04040404 // 1 = byte write suspended
#define SR_PROTECT		0x02020202 // 1 = lock bit set
#define SR_RESERVED		0x01010101

#define SR_ERRORS (SR_ERROR_ERASE|SR_ERROR_WRITE|SR_VPP|SR_PROTECT)

#define BLOCK_MASK		0xfffe0000

/* Configuration options */

#define AUTOUNLOCK  /* automatically unlocks blocks before erasing */

struct mtd_info *sharp_probe(struct map_info *);

static int sharp_probe_map(struct map_info *map,struct mtd_info *mtd);

static int sharp_read(struct mtd_info *mtd, loff_t from, size_t len,
	size_t *retlen, u_char *buf);
static int sharp_write(struct mtd_info *mtd, loff_t from, size_t len,
	size_t *retlen, const u_char *buf);
static int sharp_erase(struct mtd_info *mtd, struct erase_info *instr);
static void sharp_sync(struct mtd_info *mtd);
static int sharp_suspend(struct mtd_info *mtd);
static void sharp_resume(struct mtd_info *mtd);
static void sharp_destroy(struct mtd_info *mtd);

static int sharp_write_oneword(struct map_info *map, struct flchip *chip,
	unsigned long adr, __u32 datum);
static int sharp_erase_oneblock(struct map_info *map, struct flchip *chip,
	unsigned long adr);
#ifdef AUTOUNLOCK
static inline void sharp_unlock_oneblock(struct map_info *map, struct flchip *chip,
	unsigned long adr);
#endif


struct sharp_info{
	struct flchip *chip;
	int bogus;
	int chipshift;
	int numchips;
	struct flchip chips[1];
};

struct mtd_info *sharp_probe(struct map_info *map);
static void sharp_destroy(struct mtd_info *mtd);

static struct mtd_chip_driver sharp_chipdrv = {
	.probe		= sharp_probe,
	.destroy	= sharp_destroy,
	.name		= "sharp",
	.module		= THIS_MODULE
};

static void sharp_udelay(unsigned long i) {
	if (in_interrupt()) {
		udelay(i);
	} else {
		schedule();
	}
}

struct mtd_info *sharp_probe(struct map_info *map)
{
	struct mtd_info *mtd = NULL;
	struct sharp_info *sharp = NULL;
	int width;

	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
	if(!mtd)
		return NULL;

	sharp = kmalloc(sizeof(*sharp), GFP_KERNEL);
	if(!sharp) {
		kfree(mtd);
		return NULL;
	}

	memset(mtd, 0, sizeof(*mtd));

	width = sharp_probe_map(map,mtd);
	if(!width){
		kfree(mtd);
		kfree(sharp);
		return NULL;
	}

	mtd->priv = map;
	mtd->type = MTD_NORFLASH;
	mtd->erase = sharp_erase;
	mtd->read = sharp_read;
	mtd->write = sharp_write;
	mtd->sync = sharp_sync;
	mtd->suspend = sharp_suspend;
	mtd->resume = sharp_resume;
	mtd->flags = MTD_CAP_NORFLASH;
	mtd->name = map->name;

	memset(sharp, 0, sizeof(*sharp));
	sharp->chipshift = 24;
	sharp->numchips = 1;
	sharp->chips[0].start = 0;
	sharp->chips[0].state = FL_READY;
	sharp->chips[0].mutex = &sharp->chips[0]._spinlock;
	sharp->chips[0].word_write_time = 0;
	init_waitqueue_head(&sharp->chips[0].wq);
	spin_lock_init(&sharp->chips[0]._spinlock);

	map->fldrv = &sharp_chipdrv;
	map->fldrv_priv = sharp;

	__module_get(THIS_MODULE);
	return mtd;
}

static inline void sharp_send_cmd(struct map_info *map, unsigned long cmd, unsigned long adr)
{
	map_word map_cmd;
	map_cmd.x[0] = cmd;
	map_write(map, map_cmd, adr);
}

static int sharp_probe_map(struct map_info *map,struct mtd_info *mtd)
{
	map_word tmp, read0, read4;
	unsigned long base = 0;
	int width = 4;

	tmp = map_read(map, base+0);

	sharp_send_cmd(map, CMD_READ_ID, base+0);

	read0 = map_read(map, base+0);
	read4 = map_read(map, base+4);
	if (read0.x[0] == 0x00b000b0) {
		switch(read4.x[0]){
		case 0xaaaaaaaa:
		case 0xa0a0a0a0:
			/* aa - LH28F016SCT-L95 2Mx8, 32 64k blocks*/
			/* a0 - LH28F016SCT-Z4  2Mx8, 32 64k blocks*/
			mtd->erasesize = 0x10000 * width;
			mtd->size = 0x200000 * width;
			return width;
		case 0xa6a6a6a6:
			/* a6 - LH28F008SCT-L12 1Mx8, 16 64k blocks*/
			/* a6 - LH28F008SCR-L85 1Mx8, 16 64k blocks*/
			mtd->erasesize = 0x10000 * width;
			mtd->size = 0x100000 * width;
			return width;
		case 0x00b000b0:
			/* a6 - LH28F640BFHE 8 64k * 2 chip blocks*/
			mtd->erasesize = 0x10000 * width / 2;
			mtd->size = 0x800000 * width / 2;
			return width;
		default:
			printk("Sort-of looks like sharp flash.\n");
		}
	} else if ((map_read(map, base+0).x[0] == CMD_READ_ID)){
		/* RAM, probably */
		printk("Looks like RAM\n");
		map_write(map, tmp, base+0);
	} else {
		printk("Doesn't look like sharp flash.\n");
	}

	return 0;
}

/* This function returns with the chip->mutex lock held. */
static int sharp_wait(struct map_info *map, struct flchip *chip)
{
	map_word status;
	unsigned long timeo = jiffies + HZ;
	DECLARE_WAITQUEUE(wait, current);
	int adr = 0;

retry:
	spin_lock_bh(chip->mutex);

	switch (chip->state) {
	case FL_READY:
		sharp_send_cmd(map, CMD_READ_STATUS, adr);
		chip->state = FL_STATUS;
	case FL_STATUS:
		status = map_read(map, adr);
		if ((status.x[0] & SR_READY) == SR_READY)
			break;
		spin_unlock_bh(chip->mutex);
		if (time_after(jiffies, timeo)) {
			printk("Waiting for chip to be ready timed out in erase\n");
			return -EIO;
		}
		sharp_udelay(1);
		goto retry;
	default:
		set_current_state(TASK_INTERRUPTIBLE);
		add_wait_queue(&chip->wq, &wait);

		spin_unlock_bh(chip->mutex);

		sharp_udelay(1);

		set_current_state(TASK_RUNNING);
		remove_wait_queue(&chip->wq, &wait);

		if(signal_pending(current))
			return -EINTR;

		timeo = jiffies + HZ;

		goto retry;
	}

	sharp_send_cmd(map, CMD_RESET, adr);

	chip->state = FL_READY;

	return 0;
}

static void sharp_release(struct flchip *chip)
{
	wake_up(&chip->wq);
	spin_unlock_bh(chip->mutex);
}

static int sharp_read(struct mtd_info *mtd, loff_t from, size_t len,
	size_t *retlen, u_char *buf)
{
	struct map_info *map = mtd->priv;
	struct sharp_info *sharp = map->fldrv_priv;
	int chipnum;
	int ret = 0;
	int ofs = 0;

	chipnum = (from >> sharp->chipshift);
	ofs = from & ((1 << sharp->chipshift)-1);

	*retlen = 0;

	while(len){
		unsigned long thislen;

		if(chipnum>=sharp->numchips)
			break;

		thislen = len;
		if(ofs+thislen >= (1<<sharp->chipshift))
			thislen = (1<<sharp->chipshift) - ofs;

		ret = sharp_wait(map,&sharp->chips[chipnum]);
		if(ret<0)
			break;

		map_copy_from(map,buf,ofs,thislen);

		sharp_release(&sharp->chips[chipnum]);

		*retlen += thislen;
		len -= thislen;
		buf += thislen;

		ofs = 0;
		chipnum++;
	}
	return ret;
}

static int sharp_write(struct mtd_info *mtd, loff_t to, size_t len,
	size_t *retlen, const u_char *buf)
{
	struct map_info *map = mtd->priv;
	struct sharp_info *sharp = map->fldrv_priv;
	int ret = 0;
	int i,j;
	int chipnum;
	unsigned long ofs;
	union { u32 l; unsigned char uc[4]; } tbuf;

	*retlen = 0;

	while(len){
		tbuf.l = 0xffffffff;
		chipnum = to >> sharp->chipshift;
		ofs = to & ((1<<sharp->chipshift)-1);

		j=0;
		for(i=ofs&3;i<4 && len;i++){
			tbuf.uc[i] = *buf;
			buf++;
			to++;
			len--;
			j++;
		}
		sharp_write_oneword(map, &sharp->chips[chipnum], ofs&~3, tbuf.l);
		if(ret<0)
			return ret;
		(*retlen)+=j;
	}

	return 0;
}

static int sharp_write_oneword(struct map_info *map, struct flchip *chip,
	unsigned long adr, __u32 datum)
{
	int ret;
	int try;
	int i;
	map_word status, data;

	status.x[0] = 0;
	ret = sharp_wait(map,chip);
	if (ret < 0)
		return ret;

	for(try=0;try<10;try++){
		sharp_send_cmd(map, CMD_BYTE_WRITE, adr);
		/* cpu_to_le32 -> hack to fix the writel be->le conversion */
		data.x[0] = cpu_to_le32(datum);
		map_write(map, data, adr);

		chip->state = FL_WRITING;

		sharp_send_cmd(map, CMD_READ_STATUS, adr);
		for(i=0;i<100;i++){
			status = map_read(map, adr);
			if((status.x[0] & SR_READY)==SR_READY)
				break;
		}
#ifdef AUTOUNLOCK
		if (status.x[0] & SR_PROTECT) { /* lock block */
			sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);
			sharp_unlock_oneblock(map,chip,adr);
			sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);
			sharp_send_cmd(map, CMD_RESET, adr);
			continue;
		}
#endif
		if(i==100){
			printk("sharp: timed out writing\n");
		}

		if (!(status.x[0] & SR_ERRORS))
			break;

		printk("sharp: error writing byte at addr=%08lx status=%08x\n",adr,status.x[0]);

		sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);
	}
	sharp_send_cmd(map, CMD_RESET, adr);
	chip->state = FL_READY;

	sharp_release(chip);

	return 0;
}

static int sharp_erase(struct mtd_info *mtd, struct erase_info *instr)
{
	struct map_info *map = mtd->priv;
	struct sharp_info *sharp = map->fldrv_priv;
	unsigned long adr,len;
	int chipnum, ret=0;

//printk("sharp_erase()\n");
	if(instr->addr & (mtd->erasesize - 1))
		return -EINVAL;
	if(instr->len & (mtd->erasesize - 1))
		return -EINVAL;
	if(instr->len + instr->addr > mtd->size)
		return -EINVAL;

	chipnum = instr->addr >> sharp->chipshift;
	adr = instr->addr & ((1<<sharp->chipshift)-1);
	len = instr->len;

	while(len){
		ret = sharp_erase_oneblock(map, &sharp->chips[chipnum], adr);
		if(ret)return ret;

		if (adr >= 0xfe0000) {
			adr += mtd->erasesize / 8;
			len -= mtd->erasesize / 8;
		} else {
			adr += mtd->erasesize;
			len -= mtd->erasesize;
		}
		if(adr >> sharp->chipshift){
			adr = 0;
			chipnum++;
			if(chipnum>=sharp->numchips)
				break;
		}
	}

	instr->state = MTD_ERASE_DONE;
	mtd_erase_callback(instr);

	return 0;
}

static inline int sharp_do_wait_for_ready(struct map_info *map, struct flchip *chip,
	unsigned long adr)
{
	int ret;
	unsigned long timeo;
	map_word status;
	DECLARE_WAITQUEUE(wait, current);

	sharp_send_cmd(map, CMD_READ_STATUS, adr);
	status = map_read(map, adr);

	timeo = jiffies + HZ * 10;

	while (time_before(jiffies, timeo)){
		sharp_send_cmd(map, CMD_READ_STATUS, adr);
		status = map_read(map, adr);
		if ((status.x[0] & SR_READY)==SR_READY) {
			ret = 0;
			goto out;
		}
		set_current_state(TASK_INTERRUPTIBLE);
		add_wait_queue(&chip->wq, &wait);

		spin_unlock_bh(chip->mutex);

		schedule_timeout(1);
		schedule();

		spin_lock_bh(chip->mutex);

		remove_wait_queue(&chip->wq, &wait);
		set_current_state(TASK_RUNNING);
	}
	ret = -ETIME;
out:
	return ret;
}

static int sharp_erase_oneblock(struct map_info *map, struct flchip *chip,
	unsigned long adr)
{
	int ret;
	map_word status;

	ret = sharp_wait(map,chip);
	if (ret < 0)
		return ret;

#ifdef AUTOUNLOCK
	/* This seems like a good place to do an unlock */
	sharp_unlock_oneblock(map,chip,adr);
#endif

	sharp_send_cmd(map, CMD_BLOCK_ERASE_1, adr);
	sharp_send_cmd(map, CMD_BLOCK_ERASE_2, adr);

	chip->state = FL_ERASING;

	ret = sharp_do_wait_for_ready(map,chip,adr);
	if(ret<0) {
		spin_unlock_bh(chip->mutex);
		return ret;
	}

	sharp_send_cmd(map, CMD_READ_STATUS, adr);
	status = map_read(map,adr);

	if (!(status.x[0] & SR_ERRORS)) {
		sharp_send_cmd(map, CMD_RESET, adr);
		chip->state = FL_READY;
		spin_unlock_bh(chip->mutex);
		return 0;
	}

	printk("sharp: error erasing block at addr=%08lx status=%08x\n", adr, status.x[0]);
	sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);

	sharp_release(chip);

	return -EIO;
}

#ifdef AUTOUNLOCK
static inline void sharp_unlock_oneblock(struct map_info *map, struct flchip *chip,
	unsigned long adr)
{
	map_word status;

	sharp_send_cmd(map, CMD_CLEAR_BLOCK_LOCKS_1, adr & BLOCK_MASK);
	sharp_send_cmd(map, CMD_CLEAR_BLOCK_LOCKS_2, adr & BLOCK_MASK);

	sharp_do_wait_for_ready(map,chip,adr);

	status = map_read(map, adr);

	if (!(status.x[0] & SR_ERRORS)) {
		sharp_send_cmd(map, CMD_RESET, adr);
		chip->state = FL_READY;
		return;
	}

	printk("sharp: error unlocking block at addr=%08lx status=%08lx\n", adr, status.x[0]);
	sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);
}
#endif

static void sharp_sync(struct mtd_info *mtd)
{
}

static int sharp_suspend(struct mtd_info *mtd)
{
	struct map_info *map = mtd->priv;
	struct sharp_info *sharp = map->fldrv_priv;
	int i;
	struct flchip *chip;
	int ret = 0;

	for (i = 0; !ret && i < sharp->numchips; i++) {
		chip = &sharp->chips[i];
		ret = sharp_wait(map,chip);

		if (ret) {
			ret = -EAGAIN;
		} else {
			chip->state = FL_PM_SUSPENDED;
			spin_unlock_bh(chip->mutex);
		}
	}
	return ret;
}

static void sharp_resume(struct mtd_info *mtd)
{
	struct map_info *map = mtd->priv;
	struct sharp_info *sharp = map->fldrv_priv;
	int i;
	struct flchip *chip;

	for (i = 0; i < sharp->numchips; i++) {
		chip = &sharp->chips[i];

		spin_lock_bh(chip->mutex);

		if (chip->state == FL_PM_SUSPENDED) {
			/* We need to force it back to a known state */
			sharp_send_cmd(map, CMD_RESET, chip->start);
			chip->state = FL_READY;
			wake_up(&chip->wq);
		}

		spin_unlock_bh(chip->mutex);
	}
}

static void sharp_destroy(struct mtd_info *mtd)
{
	struct map_info *map = mtd->priv;
	struct sharp_info *sharp = map->fldrv_priv;

	kfree(sharp);
}

int __init sharp_probe_init(void)
{
	printk("MTD Sharp chip driver <ds@lineo.com>\n");

	register_mtd_chip_driver(&sharp_chipdrv);

	return 0;
}

static void __exit sharp_probe_exit(void)
{
	unregister_mtd_chip_driver(&sharp_chipdrv);
}

module_init(sharp_probe_init);
module_exit(sharp_probe_exit);


MODULE_LICENSE("GPL");
MODULE_AUTHOR("David Schleef <ds@schleef.org>");
MODULE_DESCRIPTION("Old MTD chip driver for pre-CFI Sharp flash chips");


-- 
Thanks, Sharp!
