Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUCJQSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbUCJQSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:18:39 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20209 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262674AbUCJQSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:18:35 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Thomas Horsten <thomas@horsten.com>
Subject: Re: [PATCH] 2.4.x Linux Medley RAID Version 7
Date: Wed, 10 Mar 2004 17:07:38 +0100
User-Agent: KMail/1.5.3
Cc: andre@linux-ide.org, <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.40.0403101515410.1120-100000@jehova.dsm.dk>
In-Reply-To: <Pine.LNX.4.40.0403101515410.1120-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403101707.38595.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 of March 2004 16:19, Thomas Horsten wrote:
> On Wed, 10 Mar 2004, Bartlomiej Zolnierkiewicz wrote:
> > I don't like the idea of having 2 drivers doing basically the same thing.
> > Please explain why we can't have one Medley software RAID driver?
> > [ Yes, I read
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0308.0/0156.html ]
>
> The existing one does not work correctly:
>
> - It detects the array in the wrong way and so only catches a fraction of
> valid Medley sets (and possibly mistakes non-Medley sets or deleted sets
> for correct ones).
>
> - It's using the wrong algorithm for dealing with striped arrays where the
> drives are of different sizes.

I know.

> The reason my patch leaves it in place is that it works for some users,
> and some people pointed out last year that the usual preferred path for
> this kind of change is to leave the existing driver in place if it works
> for some people. I would personally prefer to remove it.

It is a shame you haven't done it as a set of patches for the old one.
This way it would have been merged long time ago.

> Andre has previously stated that he had no objections to this patch (an
> earlier version).

Good but I am not Andre 8).

Ideally I would like you to split your driver on a set of patches against
sil_raid.c but it will be sufficient if you clean this patch a bit.
[ Please read Documentation/CodingStyle. ]

+	if (!inode || !inode->i_rdev)
+	{
+		return -EINVAL;
+	}

if (!inode || !inode->i_rdev)
	return -EINVAL;

+		if (!arg) return -EINVAL;

if (!arg)
	return -EINVAL;

+		if (raid[device].access != 1)
+		{
+			atomic_set(&(raid[device].valid),1);
+			return -EBUSY;
+		}

if (raid[device].access != 1) {
	atomic_set(&(raid[device].valid),1);
	return -EBUSY;
}

+	if (md->raid_type != 0x0)
+	{
+		printk(KERN_INFO "Medley RAID (%02x:%02x): Sorry, this driver currently only supports striped sets (RAID level 0).\n",
+		       major,minor);
+	}

Please try follow 80-column limit.

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,23)
+	ide_drive_t *drvinfo = ide_info_ptr(dev, 0);
+#else
+	ide_drive_t *drvinfo = get_info_ptr(dev);
+#endif

Patch for inclusion should have this cleaned up.

+	/* If this drive is not on a PCI controller, it is not Medley RAID.
+	 * Medley matches the PCI device ID with the metadata to check if it is valid. */
+	pcidev = drvinfo->hwif?drvinfo->hwif->pci_dev:NULL;
+	if (!pcidev)
+	{
+		return NULL;
+	}
+

IMHO this is redundant/bogus -> I can get drives with Medley RAID off CMD/SiI
controller and plug them into legacy ISA controller and still be happy
(hey, it is a Linux way of doing things).

+		/* A valid Medley RAID has the PCI vendor/device ID of its IDE controller,
+		 * and the correct checksum. */
+		md = (void *)(bh->b_data);
+
+		if (pcidev->vendor == md->vendor_id && pcidev->device == md->product_id)

The similar thing here - ie. I would like to replug drives to on-board Intel.
When Linux is driving RAID purely in software it shouldn't matter what
controller we are using.

Thanks,
Bartlomiej

