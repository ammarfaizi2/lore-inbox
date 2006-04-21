Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWDUUyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWDUUyK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWDUUyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:54:10 -0400
Received: from waste.org ([64.81.244.121]:54175 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932458AbWDUUyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:54:09 -0400
Date: Fri, 21 Apr 2006 15:50:42 -0500
From: Matt Mackall <mpm@selenic.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Pavel Machek <pavel@suse.cz>, Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
Message-ID: <20060421205042.GN15445@waste.org>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com> <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com> <20060420134713.GA2360@ucw.cz> <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com> <20060421163930.GA1648@elf.ucw.cz> <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 09:44:59PM +0100, Hugh Dickins wrote:
> On Fri, 21 Apr 2006, Pavel Machek wrote:
> > 
> > Not sure why it needs time. Waiting for disk to spin up?
> 
> I don't know, and can't hear, but doubt it (I can't see why
> it'd need disk spun up just to do an ata_dev_set_xfermode).
> 
> > Will it recover from the timeout?
> 
> No, after that wait for 30 seconds, it degenerates into attempting I/O,
> getting errors, remounting the root readonly, can't get much further.
> 
> > Would sticking ata_set_mode() at the end of timeout routine help?
> 
> Well, moving the ata_set_mode after the ata_start_drive does help:
> then the ata_start_drive times out and fails, but that does not seem
> to matter at all, and the ata_set_mode then succeeds and all is well.
> I guess that amounts to what you meant; but all the same, I won't be
> alone in preferring to wait 2 seconds than 30 seconds!
> 
> But you've made me try a bit harder, and the patch below, waiting for
> ATA_BUSY to clear, copying a line used in several other places there,
> fixes it in a much more satisfactory way than mdelay(2000).  (I checked
> how long it in fact was waiting, saw various waits between 0.8s and 1.3s).
> 
> This is a patch I'd not be ashamed to send Jeff Garzik cc linux-ide,
> even if we can't name precisely why it's ATA_BUSY then.  But I'll
> give it a day or so of real-life suspend/resuming first - Arkadiusz
> and I both noticed we're more likely to resume successfully after
> a brief suspend, so longer suspends are needed for proper testing.

Well this looks like definite progress. Does kind of look like
spinning up.

> +		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);

Huh. That function actually "busy sleeps". How aptly named.

-- 
Mathematics is the supreme nostalgia of our time.
