Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263585AbSIVEup>; Sun, 22 Sep 2002 00:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbSIVEup>; Sun, 22 Sep 2002 00:50:45 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:51977
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263585AbSIVEun>; Sun, 22 Sep 2002 00:50:43 -0400
Date: Sat, 21 Sep 2002 21:52:08 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [RFC] IDE probe & waiting for busy
In-Reply-To: <20020921152831.21705@192.168.4.1>
Message-ID: <Pine.LNX.4.10.10209212150410.25090-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben,

Catch Jeff and see if the execute diagnostics will solve the problem and
if so we can extend the state machine path to cover the Apple mess.

Thoughts?

On Sat, 21 Sep 2002, Benjamin Herrenschmidt wrote:

> I'm back to some discussion we had a few weeks ago.
> 
> So basically, I'm faced to various cases on PPC where the firmware
> will give me IDE devices just getting out of reset, still in busy
> state, causing ide-probe to fail detecting them during boot.
> 
> (Typically, Apple recent Open Firmware will issue an ATA reset on
> all drives just prior to booting the kernel and will not wait for
> the drives to get back to ready state).
> 
> I have to use the code appended below tweaked into probe_hwif()
> just before the actual probe is done. It's full of debug printk's
> so I could get some diagnostic infos from users (as I don't have
> all the HW to test on directly). My request would be to add
> something similar (but cleaner) to the kernel (I can write the
> cleaner version, I just want to make sure we agree on this first).
> 
> When we discussed that earlier, several points were raised:
> 
>  - The firmware (BIOS) should give the kernel up & running devives
> per-spec. Well, the fact is that is not the case for a variety of
> firmwares unfortunately. More than that, on typical embedded setups,
> the kernel may be booted right from flash with almost no firmware
> work and so will inherit from devices coming right from HW reset.
> 
>  - Waiting for busy means we could eventually end up waiting for
> a crappy command, we shall rather interrupt whatever the drive is
> doing via a execute diagnostics command. Well, the problem here is
> that this may not work in some cases where the drive is busy because
> it's completing it's reset cycle (Andre, can you confirm that it's
> bad interrupting the reset cycle with a diagnostic command before
> BUSY goes down ?) and we have no way to decide if the drive is busy
> because of some command still going on or if it is busy because of
> an eventual reset done prior to entering ide-probe.
> 
> My idea here is that in real life, we don't have to deal with the
> case where the drive is already running some command. The cases
> we have to deal with are
> 
>      - Existing working cases, that is the drive is just ready,
>    my code won't change the behaviour and everything is ok
>      - Drive coming out of soft or hard reset (hotplugged, or
>    bad firmware, or whatever), my code will wait for the drive
>    to come out of reset (that can take up to 30 seconds) and
>    then let the existing probe code do the job
> 
> If you prefer still running the execute diagnostics command for
> probe, then feel free to implement it ;)
> 
> static int wait_busy(ide_hwif_t *hwif, unsigned long timeout)
> {
> 	u8 stat = 0;
> 	
> 	while(timeout--) {
> 		mdelay(1);
> 		stat = IN_BYTE(hwif->io_ports[IDE_STATUS_OFFSET]);
> 		if ((stat & BUSY_STAT) == 0)
> 			break;
>   /* Assume 0xff means nothing is connected */
> 		if (stat == 0xff)
> 			break;
> 		if ((timeout % 1000) == 0)
> 			printk("stat: %02x\n", stat);
> 	}
> 	printk("wait_busy: last stat: %02x, timeout: %d\n", stat, timeout);
> 	return ((stat & BUSY_STAT) == 0);
> }
> 
> Then, in probe_hwif():
> 
> 		int rc;
> 		printk("Probing IDE interface %s...\n", hwif->name);
> 		mdelay(2); /* Probably not necesary */
>   /* Timeout below should be 30 seconds per spec, I saw it
>    * go up to 32 seconds with some drives, 60 seems to be a
>    * good margin as an absent drive shouldn't be waited for
>    * anyway
>    */
> 		printk("Waiting busy 0...\n");
>   /* Wait for whatever is currently selected so we can safely
>    * touch the taskfile regs
>    */
> 		rc = wait_busy(hwif, 60000);
>   /* Now make sure both drives are really ok, and the control
>    * reg is sane. XXX Some intfs may not have control regs
>    */
> 		printk("-> %d, selecting...\n", rc);
> 		SELECT_DRIVE(hwif, &hwif->drives[0]);
> 		OUT_BYTE(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
> 		mdelay(2);
> 		printk("Waiting busy 1...\n");
> 		rc = wait_busy(hwif, 10000);
> 		printk("-> %d, selecting...\n", rc);
> 		SELECT_DRIVE(hwif, &hwif->drives[1]);
> 		OUT_BYTE(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
> 		mdelay(2);
> 		printk("Waiting busy 2...\n");
> 		rc = wait_busy(hwif, 10000);
> 		printk("-> %d, ready for probe.\n", rc);
> 
> 
> Ben.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

