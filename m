Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVARICf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVARICf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVARICf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:02:35 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:19987 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261177AbVARICR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:02:17 -0500
Date: Tue, 18 Jan 2005 09:02:14 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Daniel Drake <dsd@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, Joseph Fannin <jhf@rivenstone.net>,
       linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       William Park <opengeometry@yahoo.ca>
Subject: Re: [PATCH] Wait and retry mounting root device (revised)
Message-ID: <20050118080214.GB8747@pclin040.win.tue.nl>
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net> <41EC7A60.9090707@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC7A60.9090707@gentoo.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 02:54:24AM +0000, Daniel Drake wrote:

> Retry up to 20 times if mounting the root device fails.  This fixes booting
> from usb-storage devices, which no longer make their partitions immediately
> available.
> 
> This should allow booting from root=/dev/sda1 and root=8:1 style 
> parameters, whilst not breaking booting from RAID or initrd :)
> I have also cleaned up the mount_block_root() function a bit.

+	if (err == -EACCES && (flags | MS_RDONLY) == 0)
+		err = sys_mount(name, "/root", fs, flags | MS_RDONLY, data);
+

It is rather unlikely that (flags | MS_RDONLY) == 0 ...

I don't like the 20 - so arbitrary.
And since we are going to panic anyway, why not wait indefinitely?

Suppose we have kernel command line options
	rootdev=, rootpttype=, root=, rootfstype=, rootwait=
telling the kernel what device is the root device,
what type of partition table it has,
on which partition the root filesystem lives,
what type of filesystem it has,
and whether we want to wait until it becomes available instead of panicking.

If we wait, possibly after the first failure to mount, do a printk
to tell the user: waiting for device to become available.

rootwait can have several values: for example, with a boot/root floppy combo,
we want the user to hit enter or so before accessing the device.

Andries
