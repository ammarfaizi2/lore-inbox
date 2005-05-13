Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVEMICP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVEMICP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVEMICP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:02:15 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:21409 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262289AbVEMIBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:01:38 -0400
Date: Fri, 13 May 2005 10:01:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Markus Klotzbuecher <mk@creamnet.de>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Message-ID: <20050513080137.GA9255@wohnheim.fh-wedel.de>
References: <20050509183135.GB27743@mary> <20050512121842.GA20388@wohnheim.fh-wedel.de> <20050512164413.GA14099@mary> <2F200E69-465D-46ED-9D3A-5ED5C9FEAC9A@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2F200E69-465D-46ED-9D3A-5ED5C9FEAC9A@mac.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It took me quite some time to understand what you're really after.
There are a bunch of problems I can imagine, but this approach may
actually work out.  If it does, it definitely solves the problem of
copy-up of insanely large files.

If it does...

On Thu, 12 May 2005 23:18:36 -0400, Kyle Moffett wrote:
> 
> I've been thinking about a "-o union" mount option for a while now, and
> I had a couple ideas on this topic.
> 
> 1) This system should be a first-class VFS element, IE: -o union should
> work on all filesystems, regardless of feature support. (As long as you
> can read/write from/to the unioned fs and read from the underlying fs)
> 
> 2) When forced to copy data, the copy should be done in the context of
> whatever process is doing the "write" operation, and be interruptible,
> etc.  The end result is that if you union an nfs mount over another one,
> it will just seem like a write to a big file takes a _really_ long time
> to complete.

Doesn't even have to be interruptable.  Your trick, if I understand it
correctly, is to copy data up on a block level, not on a file level.
Hence, even those nasty multi-gigabyte files will be copied in
granularities of a few bytes - definitely nothing you absolutely need
to be interruptable.

> 3) ext2/3 should get an extra flag for files and directories that
> indicates nonresidence.  This would be used by the VFS union layer to
> map existence/nonexistence to the unioned filesystem (If it's ext2/3).
> That way, if I later unmounted the unioned ext3 fs and remounted it
> elsewhere without the underlying storage, I would be able to access the
> parts of the directory structure and files that are resident, and the
> rest would fail with a new error code ENONRESIDENT or similar.

ENONRESIDENT bugs me somehow.  I guess EIO would be quite sufficient.
Maybe you also want a new incompatible fs flag, just to make sure old
kernels without proper understanding don't mess up the fs.

> For example, if I have two ext3 filesystems on /dev/hdb1 and /dev/hdb2,
> then I could do this:
> 
> mount -t ext3 -o ro /dev/hdb1 /mnt
> mount -t ext3 -o rw,union /dev/hdb2 /mnt
> 
> The on-disk structures might look like this:
> 
> /dev/hdb1:
>     foo/
>         bar => blocks(1-4)
>         baz => blocks(1-8)
>     oof/
>         xuuq => blocks(1-2)
> 
> /dev/hdb2:
>     foo/
>         bar => sparse,nonresident,blocks(2,4)
>         baz => sparse,nonresident,blocks(1-4,9-12)
>         quux => blocks(1-32)
>     oof/ => nonresident
>     mumble/
>         grumble => blocks(1-4)
> 
> The resultant view to the user:
> 
> /mnt
>     foo/
>         bar => blocks(1-4)
>         baz => blocks(1-12)
>         quux => blocks(1-32)
>     oof/
>         xuuq => blocks(1-2)
>     mumble/
>         grumble => blocks(1-4)
> 
> If they deleted /dev/hdb1, but still wanted whatever changes they had
> made on /dev/hdb2, they could always get at them by remounting /dev/hdb2
> somewhere _without_ "-o union", and use a modified tar to package up the
> resident portions of files the same way it does for sparse files.
> Naturally there would need to be a way to mark a sparse file's empty
> spaces as nonresident if so desired when untarring.

That's the old well-known (to some people) union-mount behaviour.

Really, your idea of a block (page, whatever) level granularity for
copying data is nice.  It solves the biggest concern I had left for
union mount.  Actually implementing it, though, depends on quite a bit
of infrastructure that just doesn't exist yet.  Still, a very
interesting idea.

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918
