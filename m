Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbTKLAEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTKLAEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:04:33 -0500
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:44436 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP id S263821AbTKLAE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:04:29 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pascal Schmidt <der.eremit@email.de>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311111348190.1960-100000@home.osdl.org> (Linus
 Torvalds's message of "Tue, 11 Nov 2003 14:04:17 -0800 (PST)")
References: <Pine.LNX.4.44.0311111348190.1960-100000@home.osdl.org>
From: Daniel Pittman <daniel@rimspace.net>
Date: Wed, 12 Nov 2003 11:04:25 +1100
Message-ID: <87k766cv06.fsf@enki.rimspace.net>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Linus Torvalds wrote:
> On Tue, 11 Nov 2003, Pascal Schmidt wrote:
>> 
>> dd behaves strangly on the MO drive. I've tried with 2.6.0-test9 and
>> the patch appended to the end of this mail.
>> 
>> # dd if=testfile of=/dev/hde bs=4096 count=1
>> dd: writing `/dev/hde': no space left on device
>> 1+0 records in
>> 0+0 records out
>> 
>> # dd if=/dev/hde of=mofile bs=4096 count=1
>> 0+0 records in
>> 0+0 records out
>> 
>> Mounting the disc read-only works, however, and I can read all the
>> data on it without problems.
> 
> Ok, that's just strange. You can't even _read_ from the raw device,
> but the mount works ok?
> 
> And you got no IO errors anywhere? I don't see why the write would
> fail silently.
> 
> I wonder whether the disk capacity is set to zero. See 
> drivers/ide/ide-cd.c, and in particular the 
> 
>         /* Now try to get the total cdrom capacity. */
>         stat = cdrom_get_last_written(cdi, (long *) &toc->capacity);
>         if (stat || !toc->capacity)
>                 stat = cdrom_read_capacity(drive, &toc->capacity,
>                 sense);
>         if (stat)
>                 toc->capacity = 0x1fffff;
> 
> and see what that says.. I really think you should start sprinkling 
> printk's around the thing to determine what goes on..

The '|| !toc->capacity' part of that code exists because I have a DVD
drive that got zero capacity from the cdrom_get_last_written call.

The symptoms were exactly the same as above - I could mount and use the
thing correctly, but the raw device was not readable at all.

Maybe cdrom_read_capacity can also return zero for some broken
situations?

      Daniel

-- 
The youth gets together his materials to build a bridge to the moon, or,
perchance, a palace or temple on the earth, and, at length, the middle-aged
man concludes to build a woodshed with them.
        -- Henry David Thoreau
