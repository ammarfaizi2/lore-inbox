Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282483AbRLKSOU>; Tue, 11 Dec 2001 13:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282491AbRLKSOJ>; Tue, 11 Dec 2001 13:14:09 -0500
Received: from [195.63.194.11] ([195.63.194.11]:46347 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S282483AbRLKSNz>; Tue, 11 Dec 2001 13:13:55 -0500
Message-ID: <3C164A5B.CA0C6CBC@evision-ventures.com>
Date: Tue, 11 Dec 2001 19:03:07 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: GOTO Masanori <gotom@debian.org>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [PATCH] direct IO breaks root filesystem
In-Reply-To: <Pine.LNX.4.33.0112110932070.8613-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 11 Dec 2001, GOTO Masanori wrote:
> >
> > Accessing with inode size unit (== 4096 byte) is ok, but if I accessed
> > with block size unit, generic_direct_IO() returns error.  The reason
> > is that blocksize is designated as inode->i_blkbits, and its value is
> > not disk minimal block size (512), but inode's unit size (4096).
> 
> Actually, I now found the _real_ bug that explains both the "inode->i_dev"
> _and_ the block size problem.
> 
> We have the wrong inode.
> 
> We use the on-disk inode, which is NOT the same as the "mapping" inode for
> actually doing the IO.
> 
> This simple (and completely untested) patch should fix it.
> 
> This two-liner should also actually make the previous patch completely
> unnecessary, because now "inode->i_dev" should be automatically correct. I
> should have realized that inode->i_dev should always be right, and have
> thought more about the fact that it wasn't.

Hah! This is explainig well, why my private experiment
to make the ext3_inode_info ext3_i field in struct inode
a pointer is still failing maliciously some how during the
booting of the system (actually the init proces goes
really after some [ OK ] optics. And this despite the
fact that there are currently only two VFS entry points
where a fresh new filesystem specific inode can be allocated.
