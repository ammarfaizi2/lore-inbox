Return-Path: <linux-kernel-owner+w=401wt.eu-S1762709AbWLJTPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762709AbWLJTPO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762533AbWLJTPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:15:14 -0500
Received: from thunk.org ([69.25.196.29]:40600 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762709AbWLJTPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:15:11 -0500
Date: Sun, 10 Dec 2006 14:15:07 -0500
From: Theodore Tso <tytso@mit.edu>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH] Add Ultrabay support for the T60p Thinkpad
Message-ID: <20061210191507.GA17240@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	ibm-acpi-devel@lists.sourceforge.net
References: <E1GtH0P-0007WV-Q5@candygram.thunk.org> <20061210124945.GA23625@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210124945.GA23625@khazad-dum.debian.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 10:49:46AM -0200, Henrique de Moraes Holschuh wrote:
> 
> Thanks, an equivalent patch is alredy merged in acpi-test, and waiting a
> push to linus.
> 
> BTW: this is an ACK if you want to merge this patch ahead of the stuff in
> acpi-test.

Great, I don't think I saw any mention of T60 support on the
linux-thinkpad mailing list, so I didn't realize this work had already
been done.  Would have saved me all of 15 minutes or so.  :-)

When is acpi-test scehduled to be merged?  If it's going to be pushed
soon into mainline, then I don't want to make any extra work for
folks.  If it's going to be a while, the patch is pretty simple and
low-risk, so hopefully it can get merged quickly.

> > have the device appear again.  (With the 1.02 BIOS the device does not
> > function when re-inserted, even after a warm boot; a cold reboot is
> > required to store the Ultrabay device's functionality.)
> 
> Nice to know that, thanks.

I wasn't quite exact in describing the problem originally, so for the
record, if you are using a 1.02/1.04 BIOS, if all you do is
disassociate the device using:

  "echo 1 > /sys/class/scsi_device/1:0:0:0/device/delete"

it's fine.  But if you apply this patch and then actually shut the bay using:

  "echo eject > /proc/acpi/ibm/bay"

Then when you re-insert the disk, it will appear to be probed, but any
attempt to read or write from the disk will return an error, and doing
a shutdown and trying to boot off of the device will also result in an
error.  Only a power-cycle will restore the Ultrabay to usability.
When I upgraded to the 2.03 BIOS, it worked just fine, so I assume
this was a BIOS and/or DSDT bug fix.

> Take a look on the experimental ACPI bay and dock support in acpi-test, it
> is even better than ibm-acpi's builtin support... and in fact, deprecates
> it.

Great, I'll have to look at it.  In the meantime, here's an updated
patch which only changes the documentation and comments.  I'll leave
it to Andrew/Linus to decide whether they want to merge this patch or
acpi-test.

						- Ted

Add Ultrabay Support for the T60p Thinkpad

The following patch adds support for obtaining the status and ejecting
Ultrabay devices for the T60p Thinkpad; my guess is that it probably
works on T60 Thinkpads and probably more recent Lenovo latops as well.

With the 2.03 BIOS I have been able to eject a SATA drive in an Ultrabay
carrier by using the commands:

  "echo 1 > /sys/class/scsi_device/1:0:0:0/device/delete"
  "echo eject > /proc/acpi/ibm/bay"

and upon re-inserting the it back into the device and issuing the
command:

 "echo 0 0 0 > /sys/class/scsi_host/host1/scan"

have the device appear again.  (With the 1.02 BIOS the device does not
function when re-inserted, even after a warm boot; a cold reboot is
required to store the Ultrabay device's functionality.)

More complicated Ultrabay eject and insert scripts can be found on the
ThinkWiki, although it's important to comment out the "hdparm -Y" as it
apparently doesn't work or do anything, and causes the eject process to
hang for about a minute.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: 2.6.19/drivers/acpi/ibm_acpi.c
===================================================================
--- 2.6.19.orig/drivers/acpi/ibm_acpi.c	2006-12-09 18:35:09.000000000 -0500
+++ 2.6.19/drivers/acpi/ibm_acpi.c	2006-12-09 18:35:42.000000000 -0500
@@ -169,6 +169,7 @@
 #endif
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
+	   "\\_SB.PCI0.IDE0.PRIM.MSTR",	/* {T,Z}]6{0,1}[p] */
 	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
     );				/* A21e, R30, R31 */
 
