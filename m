Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287918AbSAMGTK>; Sun, 13 Jan 2002 01:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSAMGTB>; Sun, 13 Jan 2002 01:19:01 -0500
Received: from ohiper1-140.apex.net ([209.250.47.155]:30991 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S287918AbSAMGSp>; Sun, 13 Jan 2002 01:18:45 -0500
Date: Sun, 13 Jan 2002 00:18:19 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [RFC][PATCH] (1/3) unchecked requst_region's in drivers/net
Message-ID: <20020113001819.A26730@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 12:14am  up 4 days,  6:43,  1 user,  load average: 1.02, 1.03, 1.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, here are the obvious patches, which I'm sending seperately as
Alan requested.  The next message will have those patches which are
approved by their respective maintainers, and the last those patches for
drivers whose maintainers didn't respond.  Those will likely require
more scrutiny.

Andrew, I have (hopefully) addressed all the issues you brought up in
the patches.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns

diff -Nru clean-2.4.17//drivers/net/irda/ali-ircc.c linux/drivers/net/irda/ali-ircc.c
--- clean-2.4.17//drivers/net/irda/ali-ircc.c	Mon Nov  5 19:23:13 2001
+++ linux/drivers/net/irda/ali-ircc.c	Thu Dec 27 14:08:34 2001
@@ -291,15 +291,13 @@
         self->io.fifo_size = 16;		/* SIR: 16, FIR: 32 Benjamin 2000/11/1 */
 	
 	/* Reserve the ioports that we need */
-	ret = check_region(self->io.fir_base, self->io.fir_ext);
-	if (ret < 0) { 
+	if (!request_region(self->io.fir_base, self->io.fir_ext, driver_name)) {
 		WARNING(__FUNCTION__ "(), can't get iobase of 0x%03x\n",
 			self->io.fir_base);
 		dev_self[i] = NULL;
 		kfree(self);
 		return -ENODEV;
 	}
-	request_region(self->io.fir_base, self->io.fir_ext, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
diff -Nru clean-2.4.17//drivers/net/wan/comx-hw-locomx.c linux/drivers/net/wan/comx-hw-locomx.c
--- clean-2.4.17//drivers/net/wan/comx-hw-locomx.c	Mon Nov  5 19:22:12 2001
+++ linux/drivers/net/wan/comx-hw-locomx.c	Thu Dec 27 14:20:11 2001
@@ -154,11 +154,9 @@
 		return -ENODEV;
 	}
 
-	if (check_region(dev->base_addr, hw->io_extent)) {
+	if (!request_region(dev->base_addr, hw->io_extent, dev->name)) {
 		return -EAGAIN;
 	}
-
-	request_region(dev->base_addr, hw->io_extent, dev->name);
 
 	hw->board.chanA.ctrlio=dev->base_addr + 5;
 	hw->board.chanA.dataio=dev->base_addr + 7;
--- linux/drivers/net/irda/irport.c~	Sat Jan 12 21:24:24 2002
+++ linux/drivers/net/irda/irport.c	Sat Jan 12 21:24:57 2002
@@ -169,13 +169,12 @@
         self->io.fifo_size = 16;
 
 	/* Lock the port that we need */
-	ret = check_region(self->io.sir_base, self->io.sir_ext);
-	if (ret < 0) { 
+	if (!request_region(self->io.sir_base, self->io.sir_ext, driver_name)) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), can't get iobase of 0x%03x\n",
 			   self->io.sir_base);
+		kfree(self);
 		return NULL;
 	}
-	request_region(self->io.sir_base, self->io.sir_ext, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
