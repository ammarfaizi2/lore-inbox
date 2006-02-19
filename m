Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWBSQyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWBSQyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 11:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWBSQyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 11:54:09 -0500
Received: from mx1.rowland.org ([192.131.102.7]:41479 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932121AbWBSQyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 11:54:08 -0500
Date: Sun, 19 Feb 2006 11:54:07 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Phillip Susi <psusi@cfl.rr.com>
cc: Andrew Morton <akpm@osdl.org>, <pavel@suse.cz>, <torvalds@osdl.org>,
       <mrmacman_g4@mac.com>, <alon.barlev@gmail.com>,
       <linux-kernel@vger.kernel.org>, <linux-pm@lists.osdl.org>
Subject: Re: Flames over -- Re: Which is simpler?
In-Reply-To: <43F89F55.5070808@cfl.rr.com>
Message-ID: <Pine.LNX.4.44L0.0602191142290.9165-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2006, Phillip Susi wrote:

> Andrew Morton wrote:
> >>
> >>  Hrm... interesting but sounds like that could be sticky.  For instance, 
> >>  what if the user script that does the verifying happens to be ON the 
> >>  volume to be verified?
> > 
> > Well that would be a bug.  Solutions would be a) don't put the scripts on a
> > removable/power-downable device or b) use tmpfs.
> > 
> 
> I don't see how it could be a bug, just think of the root on usb case. 
> Keeping the program locked in ram would sidestep that issue, but tmpfs 
> is pagable right?  Swap on usb?
> 
> Also, this user space program isn't going to be able to keep fully up to 
> date on what the disk looks like.  Imagine a filesystem that keeps a 
> generation counter in the super block and increments it every time it 
> writes to the disk.  The user space daemon might read that, then the fs 
> changes it, you suspend, and when you wake up, the daemon thinks the 
> media changed because it wasn't fully up to date.

There are other, harder problems associated with doing this is userspace.

Really, the device needs to be considered separately at each level of
driver processing.  At the USB level it may still appear to be the same,
but at the SCSI level it may appear different.  Or at the SCSI level it
may be the same, but at the gendisk level it may be different (different
media, partition table changed).  Or at the gendisk level it may be the
same, but at the filesystem level one or more of the partitions may be
different (superblock changed).

Each level would need its own way of checking for changes and recreating 
the appropriate data structures.  And while making the determinations, we 
would need to temporarily set the device to read-only.  Yes, userspace 
could do _some_ of the work, but it would need a lot of help from the 
kernel.

Alan Stern

