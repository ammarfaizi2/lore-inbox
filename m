Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbVKPDOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVKPDOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbVKPDOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:14:21 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:18566 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S965197AbVKPDOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:14:20 -0500
Message-ID: <437AA3EA.4030405@metaparadigm.com>
Date: Wed, 16 Nov 2005 11:13:46 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: userspace block driver?
References: <4371A4ED.9020800@pobox.com>
In-Reply-To: <4371A4ED.9020800@pobox.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>
> Has anybody put any thought towards how a userspace block driver would
> work?
>
> Consider a block device implemented via an SSL network connection.  I
> don't want to put SSL in the kernel, which means the only other
> alternative is to pass data to/from a userspace daemon.
>
> Anybody have any favorite methods?  [similar to] mmap'd packet socket?
> ramfs?


Here is a user block device i've been using for my own userspace block
device drivers for some years now:

  http://gort.metaparadigm.com/userblk/

This code is 2.6 based. 2.6 has made it much more reliable to do this
due to the separation of writeback into the 'pdflush' thread lessening
the likely hood of deadlocks. I've had very good results with this code
under quite heavy memory pressure (you need a carefully written
userspace which mlocks itself into memory and avoids doing certain things).

I wrote it because the nbd and enbd implementations didn't provide a
nice and/or simple interface for a local userspace daemon.

enbd was closer to what I needed but when I looked at it I thought it's
blocking on a ioctl was an ugly design - plus it was overcomplicated
with enbd specific features.

I chose to use a kernel <-> user comms model based on Alan Cox's psdev
with a char device using read and write and a mmap area for the block
request data (potentially allowing me to implement zero copy in the
future by mapping the bio into the user address space).

It is named 'ub' as it was written way before the USB driver although as
I hadn't published my work no one was aware of this. I should come up
with a new name. Perhaps 'bdu'?

I'm actually using the code in a production environment on a lab of 25
linux machines with a hybrid network block device / local disk caching
implementation in userspace (to make netboot less disk intensive -
similar to how Apple's netboot system work's). The userspace
implementation also does local COW onto disk (to avoid the need for a
stateless readonly type linux system which is hard to achieve). I have
source for this available if anyone is interested. The link above only
contains a simple userspace example implementation.

The 'metaboot' system which uses 'ub' does a lot of smart things such as
'commit' and 'rollback' of block deltas and has a cache coherency
protocol to only invalidate changed blocks on clients local caches so I
can upgrade a bunch of quasi netboot/cache machines with minimal network
traffic (much more scalable then normal fatclient netbooting).

I can put up a webpage with links to CVS, etc it anyone is interested.

~mc
