Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316571AbSGAWnP>; Mon, 1 Jul 2002 18:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSGAWnO>; Mon, 1 Jul 2002 18:43:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60422 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316571AbSGAWnO>;
	Mon, 1 Jul 2002 18:43:14 -0400
Message-ID: <3D20DB20.7B526686@zip.com.au>
Date: Mon, 01 Jul 2002 15:43:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: bio_append patch
References: <200206221504.IAA00919@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
>         Here is a first draft of my bio_append patch.  It includes
> a rewrite of most of mpage.c.
> 

I basically gave up on trying to get the mpage code to
go 100% BIO.  Impressed.

Some random thoughtlets:

Removing the buffer-layer fallback is a cleanliness/architectural
thing rather than a performance thing.  The number of pages which
fall back to the buffer functions is utterly tiny.

Really, I don't think it's a desirable thing to do - those
buffers were added by the buffer layer, they're owned by the
buffer layer and it should be up to the buffer layer to handle
the I/O, without making mpage peer into buffer state internals
any more than necessary.

I don't think your implementation correctly handles the case
where a page has some dirty buffers and some non-uptodate
buffers.  Looks like the readpage function will read old data
on top of the dirty buffers?


wrt integrating the readpages and writepages code: now is not the
time - mpage_writepages() and mpage_readpages() are very simple
functions which really only support the simplest of filesytems: ext2.
Changes have been identified on both the read and write side for
reiserfs, and on the write side for XFS.  Could be that integrating
the read and write paths will make those changes more painful.  It
would be best to wait until the mpage code has been fleshed out to
support other filesystems and then take a look.  read and write are
rather different things...


Pointing all the BIOs at a common completion structure is cunning.
But we really don't want to have to perform another memory allocation
on that path.  Frankly, given that this is the most important and
the most frequent bio-assembly code in the kernel, I'd be inclined
to just stick an extra field in struct bio for it.

-
