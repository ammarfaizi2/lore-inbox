Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264422AbUEaJWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbUEaJWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 05:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUEaJWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 05:22:06 -0400
Received: from av9-2-sn4.m-sp.skanova.net ([81.228.10.107]:61644 "EHLO
	av9-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S264422AbUEaJVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 05:21:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no
Subject: Re: Linux 2.6.7-rc2
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 31 May 2004 11:21:39 +0200
In-Reply-To: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
Message-ID: <m3y8n93qak.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Andrew Morton:
>   o Add `make checkstack' target

The checkstack target itself works fine, but when I used it I found
that nfs_writepage_sync and nfs_readpage_sync still use a lot of stack
space:

0xc01aae14 nfs_writepage_sync:                          900
0xc01a9492 nfs_readpage_sync:                           872

Apparently, this recent fix

        http://linux.bkbits.net:8080/linux-2.5/gnupatch@40ad0ce2ZBGzb_taAzCTOJ38IXxu-w

doesn't really help, at least not with the compilers I have tested, ie
gcc 3.3.3 from FC2 and the gcc from RH9.

If I put "#if 0" around the *wdata assignment in nfs_writepage_sync,
the stack usage goes down to 36, so it looks like gcc is building a
temporary structure on the stack and then copies the whole thing to
*wdata.

Does this construct save stack space for any version of gcc? Maybe the
code should be changed to do a memset() followed by explicit
initialization of the non-zero member variables instead.

#if 0
	*wdata = (struct nfs_write_data) {
		.flags		= how,
		.cred		= NULL,
		.inode		= inode,
		.args		= {
			.fh		= NFS_FH(inode),
			.lockowner	= current->files,
			.pages		= &page,
			.stable		= NFS_FILE_SYNC,
			.pgbase		= offset,
			.count		= wsize,
		},
		.res		= {
			.fattr		= &wdata->fattr,
			.verf		= &wdata->verf,
		},
	};
#endif

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
