Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbTACAWV>; Thu, 2 Jan 2003 19:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbTACAWS>; Thu, 2 Jan 2003 19:22:18 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:36873 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S267340AbTACAWO>;
	Thu, 2 Jan 2003 19:22:14 -0500
Date: Fri, 3 Jan 2003 01:30:39 +0100
Message-Id: <200301030030.h030Udk24218@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: getblk spins endlessly in 2.4.19 SMP
X-Newsgroups: linux.kernel
In-Reply-To: <3E14906E.7F6D3226@digeo.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi - thanks for replying!

In article <3E14906E.7F6D3226@digeo.com> you wrote:
> "Peter T. Breuer" wrote:
>> 
>> get_blk() loops forever internally for in a sort piece of driver code of
>> mine.

> probably it found some buffers with the wrong ->b_size, tried to
> get rid of them via try_to_free_buffers(), failed, and then fell
> into the "oh, we're out of memory" loop.

Sounds just like what I see.

> You need to work out why grow_dev_page() is seeing buffers with
> the wrong size against the page.  Be looking for incorrect or
> missing calls to set_blocksize().

Set_blocksize was indeed not called before. I had set the size on the
kernel blksize_size array by hand. I now see that in addition to that
set_blocksize sets the bdev->bd_inode->i_blkbits value.

But I'm now calling set_blocksize when I set the device block size,
and no change.  The portable (running SMP with one processor) still
works fine.  The SMP server goes into a loop on the first call to
getblk, because get_hash_table returns NULL when asked for a block of
size 1024. Always. Same binaries. Both machines are running the same
kernel and modules.

Can you see anything that would explain the difference? Should
I call for a 4K block instead? I'm mystified. Tomorrow I'll boot
the server nosmp and see what happens.

I'll look inside grow_dev_page. It this called from free_more_memory
or from grow_buffers? Ahh .. the latter. Indeed, if it returns 0,
grow_buffers will return 0, and then we try free_more_memory,
whoch presumably does nothing, and loop.

grow_dev_page fails if find_or_create_page fails. Or if it returns a
page of the wrong size. Or if create_buffers fails. Sigh .. I guess
I get a page of the wrong size. I'll try asking for 4K instead of 1K.

Is there some way I  can "seed" things so that a call to getblk
will succeed? I mean, by making a buffer of teg right size be
available?

Peter
