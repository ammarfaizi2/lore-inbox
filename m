Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129479AbRBGXP6>; Wed, 7 Feb 2001 18:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRBGXPt>; Wed, 7 Feb 2001 18:15:49 -0500
Received: from Cantor.suse.de ([213.95.15.193]:50194 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129479AbRBGXPf>;
	Wed, 7 Feb 2001 18:15:35 -0500
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs] SPEC SFS fails at low loads...
In-Reply-To: <Pine.LNX.4.21.0102071633331.712-100000@penguin.homenet>
From: Andi Kleen <ak@suse.de>
Date: 08 Feb 2001 00:15:16 +0100
In-Reply-To: Tigran Aivazian's message of "7 Feb 2001 17:37:30 +0100"
Message-ID: <ouphf26m6ez.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian <tigran@veritas.com> writes:

> Hi,
> 
> Under 2.4.1, after a little bit of running SPEC SFS (with NFSv3) I get
> these messages on the server:
> 
> vs-13042: reiserfs_read_inode2: [0 1 0x0 SD] not found
> vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
> vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
> vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
> 
> and the run aborts.
> 
> Any clues?

Reiserfs really needs 64bit of inode in the NFS file handles, otherwise
this happens as soon as you run out of the file handle cache with many
active clients. The 2.2 code did a brute force search in this case (the
handles are unique in 32bit, it's just very costly to look them up without
the other 32bit), but it usually consumed so much CPU time that people 
thought the server crashed.

There are patches to do that for knfsd for both 2.2 and 2.4, but they
haven't been merged yet. It needs a small VFS enhancement and knfsd changes.

Note that stock (unpatched) unfsd also doesn't work in all cases for other
reasons, it makes assumptions about the inode space that do not work out
on a longer used reiserfs. This has also been fixed.

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
