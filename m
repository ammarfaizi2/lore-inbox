Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbTADJah>; Sat, 4 Jan 2003 04:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbTADJah>; Sat, 4 Jan 2003 04:30:37 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:27846 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266755AbTADJa1>; Sat, 4 Jan 2003 04:30:27 -0500
Subject: Re: [PATCH] Make ide-probe more robust to non-ready devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1041672876.1346.23.camel@zion.wanadoo.fr>
References: <1041672876.1346.23.camel@zion.wanadoo.fr>
Content-Type: multipart/mixed; boundary="=-C6cy0Y4dYGr1qMfq4nah"
Organization: 
Message-Id: <1041673277.1346.29.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 04 Jan 2003 10:41:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C6cy0Y4dYGr1qMfq4nah
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is the patch, sorry ...

(Enclosed as an attachement because of mailer screwup, I'm away from my
real mail setup right now).

Ben.


On Sat, 2003-01-04 at 10:34, Benjamin Herrenschmidt wrote:
> Hi Alan !
> 
> I've needed this patch (well, this is a cleaned up version of what I
> used actually) for some time on PPC and on some embedded platforms. The
> issue that typically happens is when the kernel is booted with an IDE
> device still doing it's POST sequence (or just beeing reset, that is
> with no firmware or a firmware that doesn't wait for the device to be
> ready before booting the kernel).
> 
> The patch just waits up to 35 seconds (30 seconds per spec, plus a small
> margin to deal with a couple of bogus drives I saw that took 31 seconds)
> for the BUSY bit to go away on an HWIF.
> 
> It's mandatory in the IDE spec to pull-down D7 to ground on an inteface,
> so that an interface with no driver connected should return a value with
> bit BUSY 0x80 cleared, thus will not trigger this wait loop. I did a
> sanity check against 0xff anyway to deal with a couple of bogus
> interfaces I encountered though.
> 
> I don't expect this patch to break any existing working configuration,
> so please send to Linus for 2.5. If you accept it, I'll then send a 2.4
> version to Marcelo as well. This have been around for some time and,
> imho, should really get in now.
> 
> Regards,
> Ben.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

--=-C6cy0Y4dYGr1qMfq4nah
Content-Disposition: attachment; filename=ide-probe-2.5.diff
Content-Type: text/plain; name=ide-probe-2.5.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/ide/ide-probe.c 1.30 vs edited =====
--- 1.30/drivers/ide/ide-probe.c	Mon Dec  2 19:19:20 2002
+++ edited/drivers/ide/ide-probe.c	Sat Jan  4 10:37:35 2003
@@ -628,6 +628,68 @@
 //EXPORT_SYMBOL(hwif_register);
 
 /*
+ * Code below should be made generic, see comment near call of
+ * wait_hwif_ready() in probe_hwif()
+ */
+static int wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
+{
+	u8 stat = 0;
+	
+	while(timeout--) {
+		/* Turn this into a schedule() sleep once I'm sure
+		 * about locking issues (2.5 work ?)
+		 */
+		mdelay(1);
+		stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
+		if ((stat & BUSY_STAT) == 0)
+			break;
+		/* Assume a value of 0xff means nothing is connected to
+		 * the interface and it doesn't implement the pull-down
+		 * resistor on D7
+		 */
+		if (stat == 0xff)
+			break;
+	}
+	return ((stat & BUSY_STAT) == 0) ? 0 : -EBUSY;
+}
+
+static int wait_hwif_ready(ide_hwif_t *hwif)
+{
+	int rc;
+
+	printk("Probing IDE interface %s...\n", hwif->name);
+
+	/* Let HW settle down a bit from whatever init state we
+	 * come from */
+	mdelay(2);
+
+	/* Wait for BSY bit to go away, spec timeout is 30 seconds,
+	 * I know of at least one disk who takes 31 seconds, I use 35
+	 * here to be safe
+	 */
+	rc = wait_not_busy(hwif, 35000);
+	if (rc)
+		return rc;
+
+	/* Now make sure both master & slave are ready */
+	SELECT_DRIVE(&hwif->drives[0]);
+	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
+	mdelay(2);
+	rc = wait_not_busy(hwif, 10000);
+	if (rc)
+		return rc;
+	SELECT_DRIVE(&hwif->drives[1]);
+	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
+	mdelay(2);
+	rc = wait_not_busy(hwif, 10000);
+
+	/* Exit function with master reselected (let's be sane) */
+	SELECT_DRIVE(&hwif->drives[0]);
+	
+	return rc;
+}
+
+/*
  * This routine only knows how to look for drive units 0 and 1
  * on an interface, so any setting of MAX_DRIVES > 2 won't work here.
  */
@@ -677,6 +739,29 @@
 		disable_irq(hwif->irq);
 
 	local_irq_set(flags);
+
+	/* This is needed on some PPCs and a bunch of BIOS-less embedded
+	 * platforms. Typical cases are:
+	 * 
+	 *  - The firmware hard reset the disk before booting the kernel,
+	 *    the drive is still doing it's poweron-reset sequence, that
+	 *    can take up to 30 seconds
+	 *  - The firmware does nothing (or no firmware), the device is
+	 *    still in POST state (same as above actually).
+	 *  - Some CD/DVD/Writer combo drives tend to drive the bus during
+	 *    their reset sequence even when they are non-selected slave
+	 *    devices, thus preventing discovery of the main HD
+	 *    
+	 *  Doing this wait-for-busy should not harm any existing configuration
+	 *  (at least things won't be worse than what current code does, that
+	 *  is blindly go & talk to the drive) and fix some issues like the
+	 *  above.
+	 *  
+	 *  BenH.
+	 */
+	if (wait_hwif_ready(hwif))
+		printk(KERN_WARNING "%s: Wait for ready failed before probe !\n", hwif->name);
+
 	/*
 	 * Second drive should only exist if first drive was found,
 	 * but a lot of cdrom drives are configured as single slaves.

--=-C6cy0Y4dYGr1qMfq4nah--

