Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWBFMso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWBFMso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 07:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWBFMso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 07:48:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49766 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751108AbWBFMsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 07:48:43 -0500
Date: Mon, 6 Feb 2006 13:50:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Rafael Wysocki <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060206125035.GT13598@suse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602061402.54486.nigel@suspend2.net> <20060206105954.GD3967@elf.ucw.cz> <200602062213.24735.nigel@suspend2.net> <20060206124034.GH4101@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206124034.GH4101@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2006, Pavel Machek wrote:
> > > interface for userland, and BTW going async will not give you too much
> > > of performance advantage here...
> > 
> > How do you know that? Suspend2 has async I/O, and can write the image as 
> > fast as the drive can take it. Some testing I did a while ago showed a max 
> > throughput of 16MB/s for swsusp vs 35 (what the drive is capable of) for 
> > Suspend2. Add LZF compression and it's 70MB/s vs 16MB/s.
> 
> Userspace is perfectly capable of saturating I/O subsystem. No magical
> "async io" is needed for that. time dd if=/dev/zero of=/dev/hda
> bs=... if you don't believe me.

But the in-kernel swsusp stuff (looking at the current linus kernel now)
does write each page to the swap in a sync manner. That definitely is
pretty slow, I would not be surprised if Nigels numbers are correct. If
you repeated without write back caching enabled, a factor 10 in slowdown
as compared to async io would not surprise me.

Why don't you split the writeout into a few seperate loops? Step 1,
submission, step 2, wait for completion, step 3, check for io errors.
You could even collapse step 2+3 if you wanted, the important bit is to
queue all the io first.

> > > Current uswsusp is 3K lines of code in kernel, 1K lines of code in
> > > userspace.
> > >
> > > When we are done, we'll have perhaps 2.5K lines of code in kernel
> > > (in-kernel swap writing support goes away), and maybe 20K lines in
> > > userspace.
> > 
> > Without adding which out of async I/O, compression, encryption, swap file 
> > support, and ordinary file support?
> 
> I'll get same bandwidth as you, without need for async I/O. Async I/O
> is not really a feature, suspend speed is. (There are existing
> interfaces for doing AIO from userspace, anyway, but I'm pretty sure
> they will not be needed

If you keep writing single pages sync, you sure as hell wont get
anywhere near async io in speed...

-- 
Jens Axboe

