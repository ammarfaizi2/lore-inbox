Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWI3DPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWI3DPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 23:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWI3DPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 23:15:39 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:36239 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750704AbWI3DPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 23:15:38 -0400
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200609300315.k8U3FYw25601@inv.it.uc3m.es>
Subject: how stop sync on last close of removable medium?
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Sat, 30 Sep 2006 05:15:34 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-message-flag: Had your Outlook virus, today?  http://www.counterpane.com/crypto-gram-0103.html#4
X-WebTV-Stationery: Standard\; BGColor=black\; TextColor=black
Reply-By: Sat, 1 Apr 2006 14:21:08 -0700
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blkdev_close calls blkdev_put, which does a sync if we were the last
opener of the device and are now closing:

          if (!--bdev->bd_openers) {
                  sync_blockdev(bdev);
                  kill_bdev(bdev);
          }

This is bad news for nbd-like devices which use a client daemon
to transfer data out of the device. If there are requests pending
when the daemon is killed off (hey, we may want to shut down!)
then the sync in the daemon's close of its device creates a deadlock.
The sync will not complete until the daemon sends pending
requests which it will not do since it is closing due to death.

Is there a mechanism to prevent this sync occuring? Say for
removable devices?

(I don't see it, due to blindness and mental density ...  I could change
blkdev_close in inode->i_fops, I suppose, but that is attached to an
inode, presumably of our special device node in the fs above, and by the
time I get to it we have already opened the device node and it seems
that changing the release method then doesn't actually do anything.
Shrug).

Peter
