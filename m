Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263534AbTEDGrh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 02:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTEDGrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 02:47:36 -0400
Received: from verein.lst.de ([212.34.181.86]:62476 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263534AbTEDGrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 02:47:35 -0400
Date: Sun, 4 May 2003 09:00:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] how to fix is_local_disk()?
Message-ID: <20030504090003.A7285@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/char/sysrq.c we have this nice piece of code:

/* do_emergency_sync helper function */
/* Guesses if the device is a local hard drive */
static int is_local_disk(struct block_device *bdev)
{
	switch (MAJOR(bdev->bd_dev)) {
	case IDE0_MAJOR:
	<...>
	case SCSI_DISK0_MAJOR:
	<...>
	case XT_DISK_MAJOR:
		return 1;
	default:
		return 0;
}

now this has a bunch of problems:

(1) it's horribly out of data.  e.g. it only lists half of the scsi
majors and nothing but ide and xt in addition to it.  Second it tries
to guess local disks by majors which obviously doesn't work with
dynamic device number allocation or sub-major ranges.  The easiest fix
would be to add a GENHD_FL_LOCAL flags for struct gendisk so
is_local_disk just becomes:

static int is_local_disk(struct block_device *bdev)
{
	return (bdev->bd_disk->flags & GENHD_FL_LOCAL);
}

but do we actually want to keep this code?  And it yes shouldn't
we have a reverse flag for don't emergency sync instead as the
number of block drivers needing this is probably much much smaller..
