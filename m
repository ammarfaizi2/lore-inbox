Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVLTCwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVLTCwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 21:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVLTCwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 21:52:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:32190 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750756AbVLTCwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 21:52:16 -0500
Subject: [RFC] Let non-root users eject their ipods?
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com, axboe@suse.de
Content-Type: text/plain
Date: Mon, 19 Dec 2005 18:51:58 -0800
Message-Id: <1135047119.8407.24.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	I'm getting a little tired of my roommates not knowing how to safely
eject their usb-flash disks from my system and I'd personally like it if
I could avoid bringing up a root shell to eject my ipod. Sure, one could
suid the eject command, but that seems just as bad as changing the
permissions in the kernel (eject wouldn't be able to check if the user
has read/write permissions on the device, allowing them to eject
anything).

I've looked around trying to find some references to why this isn't
currently allowed or how safe this is, but I couldn't find anything
except the 2.6.8/k3b thread from awhile back and it didn't speak to why
eject would need root permissions even if the user has r/w permissions
on the device.

I really know nothing about scsi ioctls, so this is probably the wrong
solution, but I figured I'd offer my head upon a stake so others could
learn what not to do and why, and maybe start some discussion on what
the proper fix should be (for the kernel or the distributions to make)
since non root users really should be able to eject the flash disk they
just plugged in.

So below is a patch that allows non-root users to eject their ipods. (It
seems it should be safe_for_write() but eject opens the device for
RDONLY, so eject may be wrong here as well). 

Comments, flames?

thanks
-john

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -188,6 +188,9 @@ static int verify_command(struct file *f
 		safe_for_write(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
 		safe_for_write(GPCMD_LOAD_UNLOAD),
 		safe_for_write(GPCMD_SET_STREAMING),
+
+		/* let me eject my damn ipod */
+		safe_for_read(ALLOW_MEDIUM_REMOVAL),
 	};
 	unsigned char type = cmd_type[cmd[0]];
 


