Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVAHNHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVAHNHb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVAHNHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:07:31 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:56074 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261152AbVAHNHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:07:17 -0500
Date: Sat, 8 Jan 2005 14:07:11 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>, Pierre Ossman <drzeus-list@drzeus.cx>,
       Al Viro <viro@ftp.uk.linux.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC block removable flag
Message-ID: <20050108130711.GD6052@pclin040.win.tue.nl>
References: <41D3646F.5050408@drzeus.cx> <20041230095448.A9500@flint.arm.linux.org.uk> <41D4253D.8070006@drzeus.cx> <20050107123947.B23665@flint.arm.linux.org.uk> <20050107140035.GA5920@pclin040.win.tue.nl> <20050108110957.D7065@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108110957.D7065@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: pastinakel.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 11:09:57AM +0000, Russell King wrote:
> On Fri, Jan 07, 2005 at 03:00:35PM +0100, Andries Brouwer wrote:
> > On Fri, Jan 07, 2005 at 12:39:47PM +0000, Russell King wrote:
> > > Can anyone comment on the purpose of this (GENHD_FL_REMOVABLE) flag?
> > > Al?  Jens?
> > 
> > GENHD_FL_REMOVABLE is set by a number of drivers (floppy, CDROM, ...).
> > It is used in two places:
> > (1) to fill the file /sys/block/*/removable
> > (2) in genhd to suppress listing a nonpartitioned removable device
> > in /proc/partitions.
> > 
> > In other words, it is for user space only, precisely as Pierre Ossman said.
> 
> Your point 2 isn't user space though.

?? (1) Is about filling /sys/... and (2) about filling /proc/...
Both only have info for user space. The kernel does not react
to this flag.

> Also, it's buggy.  Consider a SCSI PCMCIA card with SCSI disks attached.
> When you eject that card, your SCSI disks disappear, yet they aren't
> marked as removable.  If user space is relying on /sys/block/*/removable
> to tell it if things may go away, then user space is buggy.

I think user space is pragmatic rather than correct.
When undesirable things happen someone will complain,
and the problem will be corrected somehow.

The distinction removable / non-removable is too primitive,
there are many variations involving chains of devices.

> Maybe it's for devices which may be present (eg, floppy driver), but
> which have removable media (eg, floppy disk), rather than removable
> devices?

I told you what it does. But you ask what it is intended for.
Then you must go to the person who first introduced it.
I guess that might have been Richard Gooch. The flag came in
in patch-2.3.46 with devfs. If it is was set, devfs would set
DEVFS_FL_REMOVABLE.

+- Added DEVFS_FL_REMOVABLE flag
+
+- Check for disc change when listing directories with
+  removable media devices

One has code like

+    if (flags & DEVFS_FL_REMOVABLE)
+    {
+       de->u.fcb.removable = TRUE;
+       ++de->parent->u.dir.num_removable;
+    }

and

+static void scan_dir_for_removable (struct devfs_entry *dir)
+/*  [SUMMARY] Scan a directory for removable media devices and check media.
+    <dir> The directory.
+    [RETURNS] Nothing.
+*/
+{
+    struct devfs_entry *de;
+
+    if (dir->u.dir.num_removable < 1) return;
+    for (de = dir->u.dir.first; de != NULL; de = de->next)
+    {
+       if (!de->registered) continue;
+       if ( !S_ISBLK (de->mode) ) continue;
+       if (!de->u.fcb.removable) continue;
+       check_disc_changed (de);
+    }
+}   /*  End Function scan_dir_for_removable  */

So here you have it. It is a devfs thing and could have been
removed when devfs was removed. However, today it is exported
in sysfs, and one must worry about possible users in user space.

Andries
