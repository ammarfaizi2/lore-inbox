Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVA1UTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVA1UTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVA1UPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:15:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9940 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262751AbVA1UOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:14:00 -0500
Date: Fri, 28 Jan 2005 20:13:59 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: sr.c kobject refcounting got buggered [Re: Ooops unmounting a defect DVD]
Message-ID: <20050128201359.GP8859@parcelfarce.linux.theplanet.co.uk>
References: <200501281842.44881.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501281842.44881.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 06:42:44PM +0100, Oliver Neukum wrote:
> I got this oops unmounting by "eject" a defect DVD on a genuine
> SCSI drive.

Looks like failing IO + close afterwards - umount is irrelevant here.
And oops itself looks like cdrom_release((void *)0x18, whatever),
called from sr_block_release().  Which is
static int sr_block_release(struct inode *inode, struct file *file)
{
        int ret;
        struct scsi_cd *cd = scsi_cd(inode->i_bdev->bd_disk);
        ret = cdrom_release(&cd->cdi, file);
and since cdi is at offset 0x18 on i386, we have
	scsi_cd(inode->i_bdev->bd_disk) == NULL
IOW,
	inode->i_bdev->bd_disk->private_data == NULL
at the time of sr_block_release().  Which would be a problem, indeed.
AFAICS, the only place that could cause that crap is
static void sr_kref_release(struct kref *kref)
{
        struct scsi_cd *cd = container_of(kref, struct scsi_cd, kref);
        struct gendisk *disk = cd->disk;

        spin_lock(&sr_index_lock);
        clear_bit(disk->first_minor, sr_index_bits);
        spin_unlock(&sr_index_lock);

        unregister_cdrom(&cd->cdi);

        disk->private_data = NULL;

        put_disk(disk);

        kfree(cd);
}

so we have scsi_cd refcount reaching zero (and scsi_cd being freed) before
the final close of /dev/sr<whatever>...
