Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLOTfp>; Fri, 15 Dec 2000 14:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLOTff>; Fri, 15 Dec 2000 14:35:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:24839 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129340AbQLOTfY>; Fri, 15 Dec 2000 14:35:24 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Test12 ll_rw_block error.
Date: 15 Dec 2000 11:04:50 -0800
Organization: Transmeta Corporation
Message-ID: <91dq0i$2ga$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012142208420.1308-100000@penguin.transmeta.com> <Pine.GSO.4.21.0012150150570.11106-100000@weyl.math.psu.edu> <20001215105148.E11931@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001215105148.E11931@redhat.com>,
Stephen C. Tweedie <sct@redhat.com> wrote:
>
>> What we really need is a way for VFS/VM to pass the pressure on filesystem.
>> That's it. If fs wants unusual completions for requests - let it have its
>> own queueing mechanism and submit these requests when it finds that convenient.
>
>There is a very clean way of doing this with address spaces.  It's
>something I would like to see done properly for 2.5: eliminate all
>knowledge of buffer_heads from the VM layer.

Note that you should be able to already get this effect with the current
2.4.0 tree.

The way to get the VM to ignore your buffer heads is to never mark the
buffers dirty, and instead mark the page they are on dirty along with
giving it a mapping (you can have a special per-superblock
"metadata-mapping" for stuff that isn't actually associated with any
particular file.

That way, the VM will just call writepage() for you, and you can use
that to schedule your writeouts (you don't actually need to write the
page the VM _asks_ you to write - you can just mark it dirty again and
consider the writepage to be mainly a VM pressure indicator).

Now, I also agree that we should be able to clean this up properly for
2.5.x, and actually do exactly this for the anonymous buffers, so that
the VM no longer needs to worry about buffer knowledge, and fs/buffer.c
becomes just another user of the writepage functionality.  That is not
all that hard to do, it mainly just requires some small changes to how
"mark_buffer_dirty()" works (ie it would also mark the page dirty, so
that the VM layer would know to call "writepage()"). 

I really think almost all of the VM infrastructure for this is in place,
the PageDirty code has both simplified the VM enormously and made it a
lot more powerful at the same time.

			Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
