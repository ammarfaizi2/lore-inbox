Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWGDSc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWGDSc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 14:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWGDSc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 14:32:57 -0400
Received: from thunk.org ([69.25.196.29]:33706 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932326AbWGDScz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 14:32:55 -0400
Date: Mon, 3 Jul 2006 21:02:40 -0400
From: Theodore Tso <tytso@mit.edu>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060704010240.GD6317@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 06:33:01PM +0200, Thomas Glanzmann wrote:
> I would like to know which new features are planed to be incorported by
> ext4. So far I only read about supporting bigger filesystems to fit
> recent hardware developments. So are there any other big goals for ext4?

Some of the ideas which have been tossed about include:

	* nanosecond timestamps, and support for time beyond the 2038
	* extents (better performance, faster fsck times)
	* persistent preallocation (valid bit in the extent)
	* larger extended attributes
	* checksums for metadata

... but the list of features are not necessarily fixed; if you have a
great ideas, patches are always appreciated.  :-)

> What I personally would like to see most in ext4 are
> 
>         * checksums for data

One of the more interesting ways of implementing this is that newer
disks will be providing a facility (at the SCSI layer, and presumably
eventually for SATA drives as well) where a checksum and some
"application" (read: filesystem) data.  The way this works, as I
understand it, is that the OS provides the sector-level checksum as
part of the write operation, which is then checked by the disk before
it is written (to catch corruption at the bus level) and written on
the disk.  On a read operation, the checksum is read, and the data
verified at the disk, as well as being passed back to the OS, so the
OS can do end-to-end level checksum checking.  More interestingly,
there is space for "applation level" (read: filesystem) tagged data,
which we could use to store information about the inode # and logical
block # that a particular data blocks is associated with.  This would
allow for a much better recoverability from the inode table getting
trashed.  

(Of course, the amount of time it would take to recover such a file
via this method for future terrabyte and pedabyte filesystems is such
that restoring from backup tapes is almost always going to be faster.
So such a scheme would only be used when some Ph.D. student has ten
years of thesis research on a disk with no backups and then
accidentally runs mkfs on the wrong partition.....  of course, one
could argue that such a stupid student doesnt *deserve* to get a Ph.D.  :-)

>         * and snapshots on filesystem basis

This requires a filesystem that is designed from the get-go to support
snapshots.  So yes, it's lilely not going to happen for ext4.
Although, if you have a really clever idea, feel free to post patches
or a detailed technical proposal for how to achieve such a goal.  :-)

						- Ted
