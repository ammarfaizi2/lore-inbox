Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbQKBRVI>; Thu, 2 Nov 2000 12:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKBRU7>; Thu, 2 Nov 2000 12:20:59 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46597 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129042AbQKBRUo>;
	Thu, 2 Nov 2000 12:20:44 -0500
Date: Thu, 2 Nov 2000 17:17:17 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: Linux-2.4.0-test10
Message-ID: <20001102171717.L1876@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com> <E13qiR9-0008FT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E13qiR9-0008FT-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Oct 31, 2000 at 08:55:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 31, 2000 at 08:55:13PM +0000, Alan Cox wrote:
> 
> Questions:
> 	Has the O_SYNC stuff been fixed so that more than ext2 honours this
> 	flag ?

Not yet.

Linus, the last patch I sent you on this didn't make it in --- is it
worth my while resending, or do we need to rethink how to do this?

2.2 O_SYNC is actually broken too --- it doesn't sync all metadata (in
particular, it doesn't update the inode), but I'd rather fix that for
2.4 rather than change 2.2, as the main users of O_SYNC, databases,
are writing to preallocated files anyway.

The patch I sent fully implements O_SYNC (actually, it implements
O_DSYNC, which is allowed to skip the inode sync if the only attribute
which has changed is the timestamps) and fdatasync.  It's easy for me
to make the DSYNC selectable via sysctl for full SU compliance, and I
know of other unixes that already do this --- you really don't want
existing database applications suddenly to start seeking to the inode
block for every O_SYNC write.

There are two parts to the implementation here --- the separation of
O_DIRTY into two bits, a "fully-dirty" bit and a "timestamp-dirty"
bit, and the use of a linked list of buffer_heads against each inode
to track all dirty data.  It is possible to do without the latter, but
that requires either doing a full mapping tree walk after O_SYNC to
flush indirect blocks, or doing indirect writes synchronously as we
write out the data.  f[data]sync can't do the sync-indirect-write
trick, so is still required to walk the whole indirect tree on fsync,
which can get expensive on large files.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
