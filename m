Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVARK4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVARK4C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 05:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVARK4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 05:56:01 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:47376 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261251AbVARKzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 05:55:50 -0500
Date: Tue, 18 Jan 2005 11:55:47 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118105547.GD8747@pclin040.win.tue.nl>
References: <20050115233530.GA2803@darkside.22.kls.lan> <20050117194635.GD22202@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117194635.GD22202@logos.cnet>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 05:46:35PM -0200, Marcelo Tosatti wrote:
> On Sun, Jan 16, 2005 at 12:35:30AM +0100, Mario Holbe wrote:

> > mounting an ext2 (ext3 as well) filesystem seems to modify the
> > block device's EOF behaviour: before the mount the device returned
> > EOF, after the mount it doesn't anymore:
> > 
> > [on a fresh booted system]
> > root@darkside:~# uname -a
> > Linux darkside 2.4.27 #1 Sat Jan 15 17:07:20 CET 2005 i686 GNU/Linux
> > root@darkside:~# dd if=/dev/hdg7 of=/dev/null
> > 9992366+0 records in
> > 9992366+0 records out
> > root@darkside:~# mount -t ext2 -o ro /dev/hdg7 /mnt
> > root@darkside:~# umount /dev/hdg7
> > root@darkside:~# dd if=/dev/hdg7 of=/dev/null
> > attempt to access beyond end of device
> > 22:07: rw=0, want=4996184, limit=4996183
> > dd: reading `/dev/hdg7': Input/output error
> > 9992360+0 records in
> > 9992360+0 records out
> > root@darkside:~# bc
> > 1249045 * 4
> > 4996180
> > 1249045 * 4 * 2
> > 9992360
> > 
> > Could somebody please explain this to me? Is this intentional?
> 
> No
> 
> Its indeed strange.

I suppose that what happens is the following:
mounting sets the blocksize to 4096.
After reading 9992360 sectors, reading the next block means reading
the next 8 sectors and that fails because only 6 sectors are left.

Test that this is what happens using blockdev --getbsz.

If you want to restore the device to full size, use
blockdev --setbsz 512.

Andries
