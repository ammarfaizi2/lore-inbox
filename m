Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbSLOMKi>; Sun, 15 Dec 2002 07:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266433AbSLOMKi>; Sun, 15 Dec 2002 07:10:38 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:11904 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S266417AbSLOMKe>;
	Sun, 15 Dec 2002 07:10:34 -0500
Message-ID: <3DFC72E4.30400@walrond.org>
Date: Sun, 15 Dec 2002 12:17:40 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: junkio@cox.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <fa.eib7vkv.1tju08k@ifi.uio.no> <fa.cnblikv.qjmuqd@ifi.uio.no> <7v65tvn3s0.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

junkio@cox.net wrote:
> "AW" == Andrew Walrond <andrew@walrond.org> gives an example of
> a/{x,y,z}, b/{y,z}, c/z mounted on d/. in that order, later
> mounts covering the earlier ones.
> 
> AW> echo "d/w" > d/w would create a new file in directory a.
> 
> Personally I'd rather expect this to happen in c/.  Imagine a/
> being on read-only medium like CD-ROM containing bunch of source
> files, b/ to hold patched source, and c/ to hold binaries
> resulting from compilation.  That is,
> 
>     rm -fr a b c d
>     mkdir a b c d
>     mount /cdrom a
>     mount --bind a d
>     mount --bind --overlay b d
>     (cd b && bzip2 -d <../patch-2.9.91.bz2 | patch -p1)
>     mount --bind --overlay c d
>     (cd c && make mrproper && cat ../.config >.config &&
>     make oldconfig && make dep && make bzImage)

A nice example.

Lets ditch --overlay and replace it with:

--transparent
	just like --overlay
--read-transparent
	a bit like a pane of glass. You can see stuff behind it (read) but 
throw a tomato at it and it sticks to the glass (write)

Then, simplifying your example a bit, we can mount the source cd then 
mount a directory --read-transparent over the top to hold both our 
patched source and compiled binaries.

Or if you want to keep patched-source and binaries seperate,

mount /cdrom stuff
mount --bind --read-transparent patched-src stuff

cd stuff
patch the src

mount --bind --read-transparent binaries stuff

compile your code

> 
> Back to your example; what do you wish to happen when we do
> this?
> 
>     $ mv d/z d/zz && test -f d/z && cat d/z
> 
> Here we rename d/z (which is really c/z) to zz.  Does this
> reveal z that used to be hidden by that, namely b/z, and "cat
> d/z" now shows "b/z"?

Yes - exactly

> 
> Or just like the case of creating a new file, does the union
> "remember" the fact that the directory "d" should not contain
> "z" anymore, and "test -f d/z" fails?
> 

No. Thats not necessary.

