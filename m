Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbTACBCE>; Thu, 2 Jan 2003 20:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbTACBCE>; Thu, 2 Jan 2003 20:02:04 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24458
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267393AbTACBCD>; Thu, 2 Jan 2003 20:02:03 -0500
Subject: Re: [CHECKER] 24 more buffer overruns in 2.5.48
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: acc@cs.stanford.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
In-Reply-To: <20030103003708.GA2861@Xenon.stanford.edu>
References: <20030103003708.GA2861@Xenon.stanford.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Jan 2003 01:53:36 +0000
Message-Id: <1041558816.24900.112.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG] Possibly the caller's fault.
> /u1/acc/linux/2.5.48/drivers/ide/ide-lib.c:380:ide_get_best_pio_mode: ERROR:BUFFER:380:380:Array bounds error: ide_pio_timings[6] indexed with [255] [Callstack: /u1/acc/linux/2.5.48/drivers/ide/legacy/qd65xx.c:272:ide_get_best_pio_mode(_, _, 255, _)] 
> 		pio_mode = max_mode;
> 		cycle_time = 0;
> 	}
> 	if (d) {
> 		d->pio_mode = pio_mode;
> 
> Error --->
> 		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
> 		d->use_iordy = use_iordy;
> 		d->overridden = overridden;
> 		d->blacklisted = blacklisted;

I can't construct a scenario in which this can occur.

> ---------------------------------------------------------
> [BUG] Bug in caller.
> /u1/acc/linux/2.5.48/drivers/media/video/bt856.c:100:bt856_setbit: ERROR:BUFFER:100:100:Array bounds error: dev->reg[128] indexed with [220] [Callstack: /u1/acc/linux/2.5.48/drivers/media/video/bt856.c:146:bt856_setbit(<len=160, off=0>, 220, 3, 1)] 
> 	return i2c_probe(adap, &addr_data , bt856_attach);
> }
> 
> static int bt856_setbit(struct bt856 *dev, int subaddr, int bit, int data)
> {
> 
> Error --->
> 	return i2c_smbus_write_byte_data(dev->client, subaddr,(dev->reg[subaddr] & ~(1 << bit)) | (data ? (1 << bit) : 0));
> }

Yep. Looks like a conversion error

> [BUG] Loop should be while(n < nbytes)?

Looks more like it needs if bytes%3 -> ERROR check


> [BUG] [GEM] The caller is probably at fault: look at the call chain.
> /u1/acc/linux/2.5.48/drivers/video/fbgen.c:180:do_install_cmap: ERROR:BUFFER:180:180:Array bounds error: fb_display[63] indexed with [-1] [Callstack: /u1/acc/linux/2.5.48/drivers/video/aty128fb.c:1746:aty128fb_set_var(_, -1, _) -> /u1/acc/linux/2.5.48/drivers/video/aty128fb.c:1406:do_install_cmap(-1, _)] 
> 
> void do_install_cmap(int con, struct fb_info *info)
> {
>     if (con != info->currcon)
> 	return;

currcon can never be -1. I don't think the compiler can ever deduce that
detail though.



