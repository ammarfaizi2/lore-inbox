Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVAXRe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVAXRe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVAXRe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:34:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15754 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261492AbVAXRen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:34:43 -0500
Date: Mon, 24 Jan 2005 18:34:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Tim Fairchild <tim@bcs4me.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: DVD burning still have problems
Message-ID: <20050124173426.GP2707@suse.de>
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de> <5a4c581d050123125967a65cd7@mail.gmail.com> <200501241146.32427.tim@bcs4me.com> <1106587560.13336.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106587560.13336.9.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2005, Kasper Sandberg wrote:
> On Mon, 2005-01-24 at 11:46 +1000, Tim Fairchild wrote:
> > On Monday 24 Jan 2005 06:59, Alessandro Suardi wrote:
> > > On Sun, 23 Jan 2005 21:26:55 +0100, Volker Armin Hemmann
> > >
> > > <volker.armin.hemmann@tu-clausthal.de> wrote:
> > > > Hi,
> > > >
> > > > have you checked, that cdrecord is not suid root, and
> > > > growisofs/dvd+rw-tools is?
> > > >
> > > > I had some probs, solved with a simple chmod +s growisofs :)
> > >
> > > Lucky you. Burning as root here, cdrecord not suid. Tried also
> > >  burning with a +s growisofs, but...
> > 
> > You can test if it's the kernel/growisofs clashing by hacking the
> > drivers/block/scsi_ioctl.c  code
> > 
> > It's around line 193 in 2.6.9, and line 196 in 2.6.10
> > not sure about 2.6.11
> at line 196
> > 
> > find the code:
> > 
> >         /* Write-safe commands just require a writable open.. */
> >         if (type & CMD_WRITE_SAFE) {
> >                 if (file->f_mode & FMODE_WRITE)
> >                         return 0;
> >         }
> > 
> > edit it to something like:
> > 
> >         /* Write-safe commands just require a writable open.. */
> >         if (type & CMD_WRITE_SAFE) {
> >                 printk ("Write safe command in ");
> >                 if (file->f_mode & FMODE_WRITE)
> >                         printk ("write mode.\n");
> >                 else
> >                         printk ("read mode.\n");
> >                 return 0;
> >         }
> > 
> > Compile the kernel with that and that may make it work and burn dvd and let 
> > you know if it's growisofs sending incorrect commands. You'll get messages in 
> > dmesg like
> > 
> > Write safe command in read mode.
> > 
> > which means growisofs is still not right. Maybe later version fixed this?
> i got the latest version, and i just did this, nothing of this appeared
> in dmesg, but also, i dont see what scsi_ioctl has to do with anything?
> i dont use scsi emulation

it doesn't have anything to do with ide-scsi scsi emulation,
direct-to-device SG_IO uses drivers/block/scsi_ioctl.c (note the block/
directory, not scsi/).

strange that it doesn't catch anything...

-- 
Jens Axboe

