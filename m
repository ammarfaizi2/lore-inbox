Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263922AbUD1BAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbUD1BAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUD1BAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:00:34 -0400
Received: from [209.195.52.120] ([209.195.52.120]:49885 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S263922AbUD1BAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:00:22 -0400
Date: Tue, 27 Apr 2004 18:00:11 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Timothy Miller <miller@techsource.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system compression, not at the block layer
In-Reply-To: <408951CE.3080908@techsource.com>
Message-ID: <Pine.LNX.4.58.0404271753380.20613@dlang.diginsite.com>
References: <408951CE.3080908@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to answer the fundamental question that was asked in this thread but not
answered.

the reason why we want to compress at the block level instead of over the
entire file is that sometimes we want to do random seeks into the middle
of the file or replace a chunk in the middle of a file (edits, inserts,
etc). by doing the compression in a block the worst that you have to do is
to read that one block, decompress it and get your data out (or modify the
block, compress it and put it back on disk). if your unit of compression
is the entire file each of these options will require manipulating basicly
the entire file (Ok, reads you can possibly stop after you found your
data)

as for those who say that compression isn't useful becouse CPU's are so
much faster then disks, I will argue that that's exactly when the
compression becomes most useful, if your CPU would otherwise be idle
waiting for the data to move to/from disk then the compression is
essentially free and you save time overall by transfering less data
through your IO bottleneck. however the right way to do this may be to put
a compression engine on the drive and allow the OS to request/send either
compressed or uncompressed data, that way if it's CPU bound or the data is
already compressed it won't spend CPU time on it, but if it will compress
the CPU and drive interface compress it to ease the bandwidth load between
them.

David Lang

 On Fri, 23 Apr 2004, Timothy Miller wrote:

> Date: Fri, 23 Apr 2004 13:26:38 -0400
> From: Timothy Miller <miller@techsource.com>
> To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: File system compression, not at the block layer
>
> This is probably just another of my silly "they already thought of that
> and someone is doing exactly this" ideas.
>
> I get the impression that a lot of people interested in doing FS
> compression want to do it at the block layer.  This gets complicated,
> because you need to allocate partial physical blocks.
>
> Well, why not do the compression at the highest layer?
>
> The idea is something akin to changing this (syntax variation intentional):
>
>     tar cf - somefiles* > file
>
> To this:
>
>     tar cf - somefiles* | gzip > file
>
> Except doing it transparently and for all files.
>
> This way, the disk cache is all compressed data, and only decompressed
> as it's read or written by a process.
>
> For files below a certain size, this is obviously pointless, since you
> can't save any space.  But in many cases, this could speed up the I/O
> for large files that are compressable.  (Space is cheap.  The only
> reason to compress is for speed.)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
