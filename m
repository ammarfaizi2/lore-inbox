Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTIYMOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 08:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbTIYMOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 08:14:47 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:9993 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261216AbTIYMOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 08:14:45 -0400
Date: Thu, 25 Sep 2003 14:14:42 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
Message-ID: <20030925121442.GC21508@win.tue.nl>
References: <UTC200309242029.h8OKTo008219.aeb@smtp.cwi.nl> <bkt3qe$imh$1@build.pdx.osdl.net> <20030924235041.GA21416@win.tue.nl> <20030925000503.GC7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925000503.GC7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 01:05:03AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:

> If there is no partition table at all and in fact they have a filesystem
> on the entire disk - let them use *entire* *disk*.  You can very well
> read /dev/sd<letter>, mount it, whatever.  Here I do have a SCSI disk
> that is not partitioned at all.  And guess what?  It works with no extra
> efforts needed:
>
> SCSI device sda: 35916548 512-byte hdwr sectors (18389 MB)
>  sda: unknown partition table
> 
> al@satch:~/kernel/2.5$ mount | grep sda
> /dev/sda on /mnt/sda type ext2 (rw)
> 
> Note that usb-storage looks like a SCSI host for the rest of kernel, so that's
> exactly the same situation - device that is expected to be partitioned but in
> reality isn't.
> 
> So what precisely are you trying to fix?

You forget two things.

First, if the kernel comes up with a bogus partition table, this
will confuse users (and user space) greatly. It is not harmless,
even though you would know how to survive.

Second, if the kernel reads random stuff from flash media that may yield
I/O errors. Such media do often not have blocks at a fixed place, but
have at the start a table that says where on the media a given block lives.
Blocks that have never been written do not occur in the table, and attempts
to read them give an I/O error. (And our famous SCSI error handling may
want to retry a few times, reset the device and retry, reset the bus
and retry .. I have seen boot times of a quarter of an hour because
the kernel was busy retrying SmartMedia accesses.)
In short - we should not read random blocks from a disk on flash media.

Andries

