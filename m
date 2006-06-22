Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWFVIaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWFVIaO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWFVIaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:30:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11167 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964928AbWFVIaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:30:11 -0400
Date: Thu, 22 Jun 2006 01:29:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Milan Broz <mbroz@redhat.com>
Cc: agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
Message-Id: <20060622012957.97697208.akpm@osdl.org>
In-Reply-To: <449A51A2.4080601@redhat.com>
References: <20060621193121.GP4521@agk.surrey.redhat.com>
	<20060621205206.35ecdbf8.akpm@osdl.org>
	<449A51A2.4080601@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 10:15:30 +0200
Milan Broz <mbroz@redhat.com> wrote:

> Andrew Morton wrote:
> > On Wed, 21 Jun 2006 20:31:21 +0100
> > Alasdair G Kergon <agk@redhat.com> wrote:
> > 
> >> From: Milan Broz <mbroz@redhat.com>
> >>  
> >> Extend the core device-mapper infrastructure to accept arbitrary ioctls
> >> on a mapped device provided that it has exactly one target and it is 
> >> capable of supporting ioctls.
> > 
> > I don't understand that.  We're taking an ioctl against a dm device and
> > we're passing it through to an underlying device?  Or something else?
> 
> Solving this situation: logical volume (say /dev/mapper/lv1) mapped in dm 
> to single device (/dev/sda):
> 
> If there is need to send ioctl you must know that /dev/mapper/lv1
> is mapped to /dev/sda (and use /dev/sda for ioctl).
> This is dm work -  so send ioctl to /dev/mapper/lv1 directly
> and let dm decide what to do.

OK.  I do think dm needs to remember /dev/sda's file* to get this right
though.  That's where the ->ioctl methods are.

> This is supported only for single mapping. If there are more than one target
> it will return -ENOTTY.
> 
> >> [We can't use unlocked_ioctl because we need 'inode': 'file' might be NULL.
> >> Is it worth changing this?]
> > 
> > It _should_ be possible to use unlocked_ioctl() - unlocked_ioctl() would be
> > pretty useless if someone was passing it a NULL file*.  More details?
> 
> yes, 
> (I prefer change block code to not pass NULL and use unlocked_ioctl,
> - Alasdair ?)
> 
> see
> 
> drivers/char/raw.c:
> 126: return blkdev_ioctl(bdev->bd_inode, *NULL*, command, arg);

Oh dear.  raw_open() doesn't have a file* for the device.

> and block/ioctl.c: [file = NULL here]
> 206: if (disk->fops->unlocked_ioctl)
> 207:	return disk->fops->unlocked_ioctl(*file*, cmd, arg);


