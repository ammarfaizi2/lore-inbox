Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVKJLpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVKJLpr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 06:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVKJLpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 06:45:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37338 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750763AbVKJLpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 06:45:46 -0500
Date: Thu, 10 Nov 2005 12:44:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051110114452.GF2401@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz> <4372B7A8.5060904@mvista.com> <20051110095050.GC2021@elf.ucw.cz> <1131616948.27347.174.camel@baythorne.infradead.org> <20051110103823.GB2401@elf.ucw.cz> <1131619903.27347.177.camel@baythorne.infradead.org> <20051110105954.GE2401@elf.ucw.cz> <1131621090.27347.184.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131621090.27347.184.camel@baythorne.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, how do I found out? I tried switching to CFI, and it will not
> > boot (unable to mount root...). No mtd-related messages as far as I
> > can see. There's quite a lot of mtd-related config options, I set them
> > like this:
> 
> If the old sharp driver had even a _chance_ of working, then you
> presumably have four 8-bit flash chips laid out on a 32-bit bus, and
> those chips are compatible with the Intel command set.
> 
> You can CONFIG_MTD_JEDECPROBE, and you want CONFIG_MTD_MAP_BANK_WIDTH=4,
> CONFIG_MTD_CFI_I4, CONFIG_MTD_CFI_INTELEXT.
> 
> Check that your chips are listed in the table in jedec_probe.c and turn
> on all the debugging in jedec_probe.c 

As far as I can see, they are not listed :-(.

static int sharp_probe_map(struct map_info *map,struct mtd_info *mtd)
{
        map_word tmp, read0, read4;
        int width = 4;

        tmp = map_read(map, base+0);
        sharp_send_cmd(map, CMD_READ_ID, base+0);

        read0 = map_read(map, base+0);
        read4 = map_read(map, base+4);
        if (read0.x[0] == 0x00b000b0) {
                switch(read4.x[0]){
                case 0x00b000b0:
                        /* a6 - LH28F640BFHE 8 64k * 2 chip blocks*/
                        mtd->erasesize = 0x10000 * width / 2;
                        mtd->size = 0x800000 * width / 2;
                        return width;

...I've removed unneccessary code, this path is actually taken. Does
it mean that mfr == id == 0x00b0? [Notice that comment is wrong there,
probably belongs to another chip :-(]
							Pavel

-- 
Thanks, Sharp!
