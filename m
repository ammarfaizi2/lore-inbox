Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVKFX7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVKFX7A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKFX7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:59:00 -0500
Received: from ns2.suse.de ([195.135.220.15]:47341 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932368AbVKFX67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:58:59 -0500
From: Neil Brown <neilb@suse.de>
To: <grfgguvf@gmail.com>
Date: Mon, 7 Nov 2005 10:58:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17262.39101.399027.796056@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Whys and hows of initrds
In-Reply-To: message from grfgguvf@gmail.com on Sunday November 6
References: <8413367b0511060924s550024b8w1113564cd6bb9340@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 6, grfgguvf@gmail.com wrote:
> Hi,
> I don't know if the LKML is a technical kernel development list or a
> newbie support list (or both?) so maybe I'm posting to the wrong
> place.
> 
> Questions:
> * Why is an initrd needed?

Because it is the best way to do the things that it does.  See next
question.

> * What does it do?

It allows various system configuration to be written as user-space code
rather than kernel-space code.  This is a *good thing* as user-space
is more forgiving, and somethings fits there more naturally.
This includes:
  module loading
  device discovery
  device configuration (e.g. raid arrays etc).
  network configuration
  root-device mounting

With an initrd, all this can be done with just memory and a processor.
Things - arbitrary things - can be done before any IO devices have
been initialised.

I heard a talk at LCA about the development of the Power5 architecture
and first getting Linux running on it.  They used debug hardware load a
kernel and an initrd image into memory, and then said 'go'.  They could
get it doing things like exercising memory and such before it even
bothered to detect and configure the PCI buss.  This isn't the sort of
thing that initrd was originally intended for (I think), but it shows
that it does give a great deal of flexibility.


> * What are the differences between an initrd and an initramdisk (if
> any)? And an initramfs?

I think initrd and initramdisk are different names for the same thing.
initramfs is different in detail but similar in purpose.

An initrd is an image of a filesystem - often cramfs or similar.  It
is loaded into a ramdisk and then the ramdisk is mounted as a
filesystem.

An initramfs works differently.  The image is a compressed CPIO
archive.  The kernel creates a 'tmpfs' - which is an internal
filesystem with no backing store - and explodes the archive into the
filesystem.

This has the advantage that the filesystem can grow in size - there
are no arbitrary limits like there have to be when you create an
initrd image.


> * Why cannot the task of initrds be done more easily?

How hard is it?  Distributions provide scripts that build them for you
with little or no effort.

Some of the tasks that an initrd can be done directly by the kernel,
but this is sub-optimal.  
It leads to code duplication as many of the tasks need to be do-able
from userspace anyway, so there is already userspace code to do it -
why bother duplicating such code in the kernel.

Also, where device discovery/configuration has to be done in the
kernel, there is a desire to keep the kernel-code minimal which tends
to reduce functionality.  It is best to do the job properly with
user-space code.

To be fair - I do agree that it could be easier than it is.  I think
that it probably just needs someone to take it on as a project, and
find out what all the disparate needs are, and put together some
infrastructure that makes it "just work" for everyone.

> * Why don't other operating systems need an equivalent? Or do they?

You would need to ask the other operating systems people that.

NeilBrown
