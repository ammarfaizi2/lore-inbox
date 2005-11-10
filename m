Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVKJLBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVKJLBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 06:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVKJLBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 06:01:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60642 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750785AbVKJLBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 06:01:10 -0500
Date: Thu, 10 Nov 2005 11:59:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Todd Poynor <tpoynor@mvista.com>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051110105954.GE2401@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz> <4372B7A8.5060904@mvista.com> <20051110095050.GC2021@elf.ucw.cz> <1131616948.27347.174.camel@baythorne.infradead.org> <20051110103823.GB2401@elf.ucw.cz> <1131619903.27347.177.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131619903.27347.177.camel@baythorne.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That said... I can certainly do few experiments. Switching map_name
> > from "sharp" to "cfi" should be theoretically enough to get new code
> > up?
> 
> That's if the chips are actually compliant with the Common Flash
> Interface. Otherwise, use the 'jedec_probe' method to identify them,
> which will still end up using the same actual back-end driver.

Well, how do I found out? I tried switching to CFI, and it will not
boot (unable to mount root...). No mtd-related messages as far as I
can see. There's quite a lot of mtd-related config options, I set them
like this:

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AFS_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_AMDSTD_RETRY=0
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
CONFIG_MTD_OBSOLETE_CHIPS=y
# CONFIG_MTD_AMDSTD is not set
# CONFIG_MTD_SHARP is not set
# CONFIG_MTD_JEDEC is not set
# CONFIG_MTD_XIP is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_ARM_INTEGRATOR is not set
CONFIG_MTD_SA1100=y
# CONFIG_MTD_IMPA7 is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLKMTD is not set
# CONFIG_MTD_BLOCK2MTD is not set

There's this kind of strange code in sharp.c; is it the thing I need
to rewrite into cfi_probe?

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

?
							Pavel
-- 
Thanks, Sharp!
