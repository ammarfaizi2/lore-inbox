Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKPBXd>; Wed, 15 Nov 2000 20:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129522AbQKPBXX>; Wed, 15 Nov 2000 20:23:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:41222 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129045AbQKPBXR>; Wed, 15 Nov 2000 20:23:17 -0500
Date: Wed, 15 Nov 2000 16:52:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aeb@veritas.com>
cc: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>, emoenke@gwdg.de,
        eric@andante.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4)
In-Reply-To: <20001116011138.A27272@veritas.com>
Message-ID: <Pine.LNX.4.10.10011151638420.3216-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Andries Brouwer wrote:
> 
> Has there been a kernel version that could read these?
> It looks like it proclaims blocksize 512 and uses blocksize 2048 or so.

The (de_len == 0) check in do_isofs_readdir() seems to imply that the
blocksize is always 2048. So at the very least something is inconsistent.
We use ISOFS_BUFFER_SIZE(inode) (512 in this case) for some sector sizes,
and then ISOFS_BLOCK_SIZE (2048) for others. 

But the way isofs_bmap() works, we need to work with
ISOFS_BUFFER_SIZE(inode). And I don't know if directories are always
_aligned_ at 2048 bytes even if they should be blocked at 2k.

Looking at the isofs lookup() logic, it will actually handle split
entries, instead of complaining about them. And I suspect readdir() did
too at some point, and the code was just removed (probably due to
excessive confusion) when one of the many readdir() reorganizations was
done. 

readdir() probably worked a long time ago.

Is the thing documented somewhere? It looks like we should just allow
entries that are split and not complain about them. We have the temporary
buffer for it already..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
