Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbTFLAIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbTFLAIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:08:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30626 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264622AbTFLAIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:08:14 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
From: Andy Pfiffer <andyp@osdl.org>
To: Christophe Saout <christophe@saout.de>, adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
	 <1055369326.1158.252.camel@andyp.pdx.osdl.net>
	 <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
Content-Type: text/plain
Organization: 
Message-Id: <1055377253.1222.8.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 17:20:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 16:21, Christophe Saout wrote:
> Am Don, 2003-06-12 um 00.08 schrieb Andy Pfiffer:
> > On Fri, 2003-05-09 at 13:55, Andy Pfiffer wrote:
> > > On Fri, 2003-05-09 at 13:04, Christophe Saout wrote:
> > > > Am Fre, 2003-05-09 um 21.04 schrieb Andy Pfiffer:
> > > > 
> > > > > [...]
> > > > >  I had an unrelated
> > > > > delay in posting this due to some strange behavior of late with LILO and
> > > > > my ext3-mounted /boot partition (/sbin/lilo would say that it updated,
> > > > > but a subsequent reboot would not include my new kernel)
> > > > 
> > > > So I'm not the only one having this problem... I think I first saw this
> > > > with 2.5.68 but I'm not sure.
<snip>
> > I have taken another look at this, and can confirm the following:
> > 
> > 1. 2.5.67 works as expected.
> > 2. 2.5.68, 2.5.69, and 2.5.70 do not.
> > 3. ext2 vs. ext3 for /boot: no effect (ie, .68, .69, .70 demonstrate the
> > problem independent of the filesystem used for /boot).
> 
> I found out that flushb /dev/<boot_device> helps, syncing doesn't. Not
> 100% sure if that's right, because right now I'm always doing both, but
> I remember having only synced before and that didn't help.

<snip>

A little more digging reveals this thread from May 14, 2003:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105296774516509&w=2

Applying the kludge in Adam's message:

--- linux-2.5.69/fs/block_dev.c.orig	2003-05-14 17:43:40.000000000 -0700
+++ linux-2.5.69/fs/block_dev.c	2003-05-14 17:44:29.000000000 -0700
@@ -635,14 +635,24 @@
 int blkdev_put(struct block_device *bdev, int kind)
 {
 	int ret = 0;
 	struct inode *bd_inode = bdev->bd_inode;
 	struct gendisk *disk = bdev->bd_disk;
 
 	down(&bdev->bd_sem);
+
+	/* AJR start */
+	switch (kind) {
+	case BDEV_FILE:
+	case BDEV_FS:
+		sync_blockdev(bd_inode->i_bdev);
+		break;
+	}
+	/* AJR end */
+
 	lock_kernel();
 	if (!--bdev->bd_openers) {
 		switch (kind) {
 		case BDEV_FILE:
 		case BDEV_FS:
 			sync_blockdev(bd_inode->i_bdev);
 			break;

made things work for me in 2.5.68.
I suspect it will make things work for .70 as well.

So now the important question: is it wrong to not sync_blockdev() until
the count drops to 0?

Andy


