Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRCMITT>; Tue, 13 Mar 2001 03:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129346AbRCMITK>; Tue, 13 Mar 2001 03:19:10 -0500
Received: from mail01.infonautics.com ([64.64.79.195]:37900 "EHLO
	mail01.infonautics.com") by vger.kernel.org with ESMTP
	id <S129321AbRCMITF>; Tue, 13 Mar 2001 03:19:05 -0500
Date: Tue, 13 Mar 2001 03:16:43 -0500
From: John Guthrie <guthrie@infonautics.com>
Message-Id: <200103130816.f2D8Gh522969@curvature.infonautics.com>
To: linux-kernel@vger.kernel.org
Subject: detection of PCI modems by the serial driver in 2.4.2
Cc: guthrie@infonautics.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I reecently purchased a new computer, and installed RedHat 7.0 on it, and then
I upgraded to 2.4.2.  When I tried to get ppp working, chat was having problems
with opening the modem.  As it turns out, the PCI modem that the computer
comes with was not being detected by the serial driver.  After taking a look
at drivers/char/serial.c, I found that serial_pci_guess_board() was
automatically returning for any board that didn't have a class of
PCI_CLASS_COMMUNICATION_SERIAL.  This of course excludes
PCI_CLASS_COMMUNICATION_MODEM.  I didn't see anything in the code that would
actually try to detect PCI modems, just PCI serial boards.  Is there a reason
for this?

I have included a patch at the end of this message which will enable the
detection of PCI modems as well as serial boards.  After I applied the patch,
the serial driver did detect my modem, and the I/O port and IRQ of the modem
correctly.  Of course, the modem then fails the "simple existence test" in
autoconfig().  But since this is a low end Compaq bought off the shelf, this
may in fact be a cheesy WinModem for all I know.  So I'm not particularly
shocked by this.

Unfortunately, the machine is up at my grilfriend's house, so I don't have
immediate access to its configuration.  The things that I can remember off
the top of my head are as follows:

750MHz AMD Duron Processor
128MB RAM
40X CD-ROM
30GB Quantum HD
20GB Maxtor HD
NVidia TNT card w/ 8MB memory
Modem brand unknown at this time.  I can get it later this week though.

RedHat 7.0

Hope this helps.  Any suggestions/advice would be appreciated?

Thanks.

Sincerely,

John Guthrie
guthrie@infonautics.com

-----------------------------PATCH FOLLOWS-----------------------------------

--- drivers/char/serial.c.old	Tue Mar 13 02:05:36 2001
+++ drivers/char/serial.c	Tue Mar 13 02:09:14 2001
@@ -4601,7 +4601,8 @@
 	 * (Should we try to make guesses for multiport serial devices
 	 * later?) 
 	 */
-	if ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL ||
+	if (!((dev->class >> 8) == PCI_CLASS_COMMUNICATION_SERIAL ||
+	      (dev->class >> 8) == PCI_CLASS_COMMUNICATION_MODEM) ||
 	    (dev->class & 0xff) > 6)
 		return 1;
