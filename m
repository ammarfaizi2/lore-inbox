Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbWHDHxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWHDHxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWHDHxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:53:15 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:36731 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161096AbWHDHxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:53:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sr5X/UlUkRQwUJJu/zvRuAG77TYTw+nL1rGCaEkHieAuc5U1lGBKZfR4iay8dCHicvhW7JX0Bij+2il5GHqkKJDQYKjxeUagZ5owwJWuy2ASeHo3MJUR3MwEi7O1j7oF4G4nCnOPKmah4NTLk6ih1wAvfO5ylTx3FQZLOd6IB8g=
Message-ID: <6d4bc9fc0608040053x4d7a9e14xe9de793cd0787736@mail.gmail.com>
Date: Fri, 4 Aug 2006 09:53:14 +0200
From: "Maarten Maathuis" <madman2003@gmail.com>
To: "Dave Kleikamp" <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: heavy file i/o on ext3 filesystem leads to huge ext3_inode_cache and dentry_cache that doesn't return to normal for hours
In-Reply-To: <1154661560.17180.31.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d4bc9fc0608030927t175f16c0kfef6a21cc521e368@mail.gmail.com>
	 <1154661560.17180.31.camel@kleikamp.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/06, Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> On Thu, 2006-08-03 at 18:27 +0200, Maarten Maathuis wrote:
> > I have a kernel specific problem and this seemed like a suitable place to ask.
> >
> > I would like responces to be CC'ed to me if possible.
> >
> > I use a 2.6.17-ck1 kernel on an amd64 system. I have observed this
> > problem on other/older kernels.
> >
> > Whenever there is serious hard drive activity (such as doing "slocate
> > -u") ext3_inode_cache and dentry_cache grow to a combined 400-500 MiB.
>
> The behavior of slocate (updatedb) is pretty well-known, but nobody has
> come up with a real solution.
>
> > The amount of objects is more than half a million.
> >
> > This will slowly decrease to normal, but will take many hours. It does
> > not result in any OOM, because i have 1 GiB of memory.
> >
> > As far as i understand hard drive cache should not be in the slab. Are
> > these just the inode's, because the amount of memory consumption seems
> > large for that?
>
> inodes and directory cache entries (dentries).  In general, it's a good
> idea to cache inodes and dentries that have recently been read.  slocate
> is a special case since it will traverse all of the directories and
> never look at them again (until the next time it runs).  The kernel
> doesn't have any idea that it may be a good idea to free those objects.
>

Wasn't there something like a possible read only flag to prevent that?

> >
> > I have found a way to clear the memory (and unfortunately most of the cache):
> >
> > echo 100 > /proc/sys/vm/nr_hugepages
> > echo 0 > /proc/sys/vm/nr_hugepages
>
> A better way to clear just the inodes and dentries (that aren't in use)
> is:
>
> echo 2 > /proc/sys/vm/drop_caches
>
> This feature is relatively new.
>

Thank you, i tried echo'ing a 1 into that and it had no effect iirc.
Documentation on /proc/sys/vm seems pretty scarce.

> > This suggest the kernel can free this memory. It's not the caching
> > that bothers me, what bothers me is that it seems to reside in the
> > slab.
>
> I'm not sure why that bothers you.  A more common complaint is that all
> the inodes and dentries being cached push out other pages to swap.
>

The reason i asked was because i expected cache related things to be
seperated from "normal" memory usage. Since free already seperates
normal and buffers/cache, it was very strange seeing 400 or 500 MiB
memory usage.

> Completely free memory doesn't do the system any good.  The kernel
> attempts to keep as much as possible in cache in case something is
> needed again.  These objects are easily reclaimable, so when more memory
> is needed, they can be freed with very little overhead.
>
> > I am not a developer, so please keep that in mind when replying.
> >
> > I hope someone can be of help.
> >
> > Sincerely,
> >
> > Maarten Maathuis.
>
> Shaggy
> --
> David Kleikamp
> IBM Linux Technology Center
>
>
