Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVAXUnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVAXUnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVAXUlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:41:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5082 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261642AbVAXUjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:39:52 -0500
Date: Mon, 24 Jan 2005 21:39:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Elias da Silva <silva@aurigatec.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Message-ID: <20050124203948.GR2707@suse.de>
References: <200501220327.38236.silva@aurigatec.de> <20050124083600.GA3347@suse.de> <200501242059.06307.silva@aurigatec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501242059.06307.silva@aurigatec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2005, Elias da Silva wrote:
> > On Sat, Jan 22 2005, Elias da Silva wrote:
> > > Attached patch fixes a problem of reading Video DVDs
> > > through the cdrom_ioctl interface. VMware is among
> > > the prominent victims.
> > > 
> > > The bug was introduced in kernel version 2.6.8 in the
> > > function verify_command().
> > 
> > It's not a bug, add write permission to the device for the user using
> > the drive.
> Hi.
> 
> The device already has write permission for the user using the
> drive... and this is not the point.
> 
> The point is
> 	a. the user (program) wants to read a protected DVD,
> 
> 	b. the user has permission to read the device,
> 
> 	c. since kernel 2.6.8 the user can't use his right to read a
> 	DVD media, because according to verify_command() he is forced
> 	to open the device with RW mode instead of RONLY.

Right, it's an unfortunate side effect of the command table.

> This is true for protected media because of the authentication
> process needed between "host" 	and DVD device. IMHO,
> the classification of the opcodes
> 
> 	a. GPCMD_SEND_KEY and
> 	b. GPCMD_SET_STREAMING
> 
> as only "save for write" is wrong.

You need to explain why you think that is so, since this is the core of
the argument. The only thing I can say is that perhaps SEND_KEY should
even be root only, since it has a fairly large scope. It's really a
device exclusive type situation, where is a user has exclusive access to
the device it would be ok to issue a SEND_KEY but otherwise not. It's
not clearly a read vs write thing. It's impossible to shoe-horn a more
complicated permission model on top of something as silly as read vs
write.

> Furthermore, if you use
> 	a. cdrom_ioctl (..., DVD_AUTH,...) instead of
> 	b. cdrom_ioctl (..., CDROM_SEND_PACKET,...)
> 	-> scsi_cmd_ioctl()-> sg_io()-> verify_command()
> 
> the same authentication procedure works as expected on a
> RONLY opened device!

DVD_AUTH by-passes scsi_ioctl.c, so yes.

> Please rethink your decisions introduced with verify_command()
> and make for example VMware work _again_ with Video DVDs.

It's not my decisions. The problem is that it is policy, and it has to
be restrictive to be safe.

-- 
Jens Axboe

