Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275922AbSIUPXg>; Sat, 21 Sep 2002 11:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275923AbSIUPXf>; Sat, 21 Sep 2002 11:23:35 -0400
Received: from AMarseille-201-1-6-194.abo.wanadoo.fr ([80.11.137.194]:63601
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S275922AbSIUPXe>; Sat, 21 Sep 2002 11:23:34 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>, "Andre Hedrick" <andre@linux-ide.org>
Subject: [RFC] IDE probe & waiting for busy
Date: Sat, 21 Sep 2002 17:28:30 +0200
Message-Id: <20020921152831.21705@192.168.4.1>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm back to some discussion we had a few weeks ago.

So basically, I'm faced to various cases on PPC where the firmware
will give me IDE devices just getting out of reset, still in busy
state, causing ide-probe to fail detecting them during boot.

(Typically, Apple recent Open Firmware will issue an ATA reset on
all drives just prior to booting the kernel and will not wait for
the drives to get back to ready state).

I have to use the code appended below tweaked into probe_hwif()
just before the actual probe is done. It's full of debug printk's
so I could get some diagnostic infos from users (as I don't have
all the HW to test on directly). My request would be to add
something similar (but cleaner) to the kernel (I can write the
cleaner version, I just want to make sure we agree on this first).

When we discussed that earlier, several points were raised:

 - The firmware (BIOS) should give the kernel up & running devives
per-spec. Well, the fact is that is not the case for a variety of
firmwares unfortunately. More than that, on typical embedded setups,
the kernel may be booted right from flash with almost no firmware
work and so will inherit from devices coming right from HW reset.

 - Waiting for busy means we could eventually end up waiting for
a crappy command, we shall rather interrupt whatever the drive is
doing via a execute diagnostics command. Well, the problem here is
that this may not work in some cases where the drive is busy because
it's completing it's reset cycle (Andre, can you confirm that it's
bad interrupting the reset cycle with a diagnostic command before
BUSY goes down ?) and we have no way to decide if the drive is busy
because of some command still going on or if it is busy because of
an eventual reset done prior to entering ide-probe.

My idea here is that in real life, we don't have to deal with the
case where the drive is already running some command. The cases
we have to deal with are

     - Existing working cases, that is the drive is just ready,
   my code won't change the behaviour and everything is ok
     - Drive coming out of soft or hard reset (hotplugged, or
   bad firmware, or whatever), my code will wait for the drive
   to come out of reset (that can take up to 30 seconds) and
   then let the existing probe code do the job

If you prefer still running the execute diagnostics command for
probe, then feel free to implement it ;)

static int wait_busy(ide_hwif_t *hwif, unsigned long timeout)
{
	u8 stat = 0;
	
	while(timeout--) {
		mdelay(1);
		stat = IN_BYTE(hwif->io_ports[IDE_STATUS_OFFSET]);
		if ((stat & BUSY_STAT) == 0)
			break;
  /* Assume 0xff means nothing is connected */
		if (stat == 0xff)
			break;
		if ((timeout % 1000) == 0)
			printk("stat: %02x\n", stat);
	}
	printk("wait_busy: last stat: %02x, timeout: %d\n", stat, timeout);
	return ((stat & BUSY_STAT) == 0);
}

Then, in probe_hwif():

		int rc;
		printk("Probing IDE interface %s...\n", hwif->name);
		mdelay(2); /* Probably not necesary */
  /* Timeout below should be 30 seconds per spec, I saw it
   * go up to 32 seconds with some drives, 60 seems to be a
   * good margin as an absent drive shouldn't be waited for
   * anyway
   */
		printk("Waiting busy 0...\n");
  /* Wait for whatever is currently selected so we can safely
   * touch the taskfile regs
   */
		rc = wait_busy(hwif, 60000);
  /* Now make sure both drives are really ok, and the control
   * reg is sane. XXX Some intfs may not have control regs
   */
		printk("-> %d, selecting...\n", rc);
		SELECT_DRIVE(hwif, &hwif->drives[0]);
		OUT_BYTE(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
		mdelay(2);
		printk("Waiting busy 1...\n");
		rc = wait_busy(hwif, 10000);
		printk("-> %d, selecting...\n", rc);
		SELECT_DRIVE(hwif, &hwif->drives[1]);
		OUT_BYTE(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
		mdelay(2);
		printk("Waiting busy 2...\n");
		rc = wait_busy(hwif, 10000);
		printk("-> %d, ready for probe.\n", rc);


Ben.


