Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVKJMID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVKJMID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVKJMID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:08:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43203 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750799AbVKJMIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:08:02 -0500
Date: Thu, 10 Nov 2005 13:07:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051110120708.GG2401@elf.ucw.cz>
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

Ok, I got a little bit more forward.

I created entry like this:
        {
                .mfr_id         = 0x00b0,
                .dev_id         = 0x00b0,
                .name           = "Collie hack",
                .uaddr          = {
                        [0] = MTD_UADDR_UNNECESSARY,    /* x8 */
                },
                .DevSize        = SIZE_4MiB,
                .CmdSet         = P_ID_INTEL_EXT,
                .NumEraseRegions= 1,
                .regions        = {
                        ERASEINFO(0x10000,8),
                }
}

(Which is probably wrong, I just made up the data), and set name in
collie.c to "jedec_probe". That made jedec_probe.c go alive, and it
prints...

Found: Collie hack
sa1100-0: Found 4 x8 devices at 0x0 in 32-bit bank
Sum of regions (200000) != total size of set of interleaved chips (1000000)
gen_probe: No Supported Vendor Command set found

sharp.c sets

			width = 4;
                        mtd->erasesize = 0x10000 * width / 2;
                        mtd->size = 0x800000 * width / 2;

...that is
		width = 4;
		erazesize = 0x20000;
		size      = 0x1000000;

Does it mean ERASEINFO(0x20000,7) should do the trick?

							Pavel
-- 
Thanks, Sharp!
