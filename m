Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTKKWEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTKKWEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:04:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:55198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263452AbTKKWEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:04:22 -0500
Date: Tue, 11 Nov 2003 14:04:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pascal Schmidt <der.eremit@email.de>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311112227100.1011-100000@neptune.local>
Message-ID: <Pine.LNX.4.44.0311111348190.1960-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Nov 2003, Pascal Schmidt wrote:
> 
> dd behaves strangly on the MO drive. I've tried with 2.6.0-test9 and
> the patch appended to the end of this mail.
> 
> # dd if=testfile of=/dev/hde bs=4096 count=1
> dd: writing `/dev/hde': no space left on device
> 1+0 records in
> 0+0 records out
> 
> # dd if=/dev/hde of=mofile bs=4096 count=1
> 0+0 records in
> 0+0 records out
> 
> Mounting the disc read-only works, however, and I can read all the data
> on it without problems.

Ok, that's just strange. You can't even _read_ from the raw device, but 
the mount works ok?

And you got no IO errors anywhere? I don't see why the write would fail 
silently.

I wonder whether the disk capacity is set to zero. See 
drivers/ide/ide-cd.c, and in particular the 

        /* Now try to get the total cdrom capacity. */
        stat = cdrom_get_last_written(cdi, (long *) &toc->capacity);
        if (stat || !toc->capacity)
                stat = cdrom_read_capacity(drive, &toc->capacity, sense);
        if (stat)
                toc->capacity = 0x1fffff;

and see what that says.. I really think you should start sprinkling 
printk's around the thing to determine what goes on..


		Linus

