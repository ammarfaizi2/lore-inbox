Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136673AbRAHDrT>; Sun, 7 Jan 2001 22:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136685AbRAHDrI>; Sun, 7 Jan 2001 22:47:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19210 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136673AbRAHDrA>; Sun, 7 Jan 2001 22:47:00 -0500
Date: Sun, 7 Jan 2001 19:46:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: parsley@roanoke.edu, linux-kernel@vger.kernel.org
Subject: Re: Patch (repost): cramfs memory corruption fix
In-Reply-To: <20010106224109.A1601@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.10.10101071938540.28661-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jan 2001, Adam J. Richter wrote:
> 
> 	This sounds like a bug that I posted a fix for a long time ago.
> cramfs calls bforget on the superblock area, destroying that block of
> the ramdisk, even when the ramdisk does not contain a cramfs file system.
> Normally, bforget is called on block that really can be trashed,
> such as blocks release by truncate or unlink. 

I'd really prefer just not letting bforget() touch BH_Protected buffers.
bforget() is also used by other things than unlink/truncate: it's used by
various partition codes etc, and it's used by the raid logic.

Now, nobody wants to use RAID on a ramdisk, but the fact is that
"bforget()" does not mean "forget the contents of this buffer", but it
really means "you can forget this cached copy even if it is dirty, we're
not likely to need it in the near future and can read it back in".

Also, if you care about memory usage, you're likely to be much better off
using ramfs rather than something like "ext2 on ramdisk". You won't get
the double buffering.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
