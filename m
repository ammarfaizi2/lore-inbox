Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWFHWsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWFHWsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 18:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWFHWsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 18:48:43 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:61485 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965032AbWFHWsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 18:48:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rGgpNhtSPx08zc/CzotKqOI0PU4R7Yb/R8OxK35kvx/6FKg5b1BZVE+dtNTrTK61NM0/vfQsbUfG/BeGcw1YBvRNJ9UiQpXxwWJTtdRmvTBiuKzcft/zIHMtc7Qqn0WazivJt6IAoVsUAg+vgxXO0hbCswKv18xaraQf1F4vmGU=
Message-ID: <305c16960606081548m316099awafa619bb5d0d14f0@mail.gmail.com>
Date: Thu, 8 Jun 2006 19:48:39 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Sascha Nitsch" <Sash_lkl@linuxhowtos.org>
Subject: Re: Idea about a disc backed ram filesystem
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <200606082233.13720.Sash_lkl@linuxhowtos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606082233.13720.Sash_lkl@linuxhowtos.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/06, Sascha Nitsch <Sash_lkl@linuxhowtos.org> wrote:
> Hi,
>
> this is (as of this writing) just an idea.
>
> === current state ===
> Currently we have ram filesystems (like tmpfs) and disc based file systems
> (ext2/3, xfs, <insert your fav. fs>).
>
> tmpfs is extremely fast but suffers from data losses from restarts, crashes
> and power outages. Disc access is slow against a ram based fs.
>
> === the idea ===
> My idea is to mix them to the following hybrid:
> - mount the new fs over an existing dir as an overlay
> - all files overlayed are still accessible
> - after the first read, the file stays in memory (like a file cache)
> - all writes are flushed out to the underlying fs (maybe done async)
> - all reads are always done from the memory cache unless they are not cached
>   yet
> - the cache stays until the partition is unmounted
> - the maximum size of the overlayed filesystem could be physical ram/2 (like tmpfs)
>
> === advantages ===
> once the files are read, no more "slow" disc reading is needed=> huge read
> speed improvements (like on tmpfs)
> if the writing is done asyncronous, write speeds would be as fast as a
> tmpfs => huge write speedup
> if done syncronous, write speed almost as fast as native disc fs
> the ram fs would be imune against data loss from reboots or controled shutdown
> if syncronous write is done, the fs would be imune to crashes/power
> outages (with the usual exceptions like on disc fs)
>
> === disadvantage ===
> possible higher memory usage (see implementation ideas below)
>
> === usages ===
> possible usage scenarios could be any storage where a
> smaller set of files get read/written a lot, like databases
> definition of smaller: lets say up to 50% of physical ram size.
> Depending on architecture and money spent, this can be a lot :)
>
> === implementation ideas ===
> One note first:
> I don't know the fs internals of the kernel (yet), so these ideas might not
> work, but you should get the idea.
>
> One idea is to build a complete virtual filesystem that connects to the VFS
> layer and hands the writes through to the "original" fs driver.
> The caching would be done in that layer. This might cause double caching
> (in the io cache) and might waste memory.
> But this idea would enable the possibility of async writes (when the disc has
> less to do) and gives write speed improves.
>
> The other idea would be to modify the existing filesystem cache algorithm to
> have a flag "always keep this file in memory".
>
> The second one may be easier to do and may cause less side effects, but
> might not enable async writes.
>
> Since this overlay is done in the kernel, no other process could change the
> files under the overlay.
> Remote FS must be excluded from the cache layer (for obvious reasons).
>
> Any kind of feedback is welcome.
>
> If this has been discussed earlier, sorry for double posting. I haven't found
> anything like this in the archives. Just point me in the right direction.
>
> Regards,
>
> Sascha Nitsch
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

I had a somewhat similar idea, once i have time to implement it ill
submit a patch.
My idea consisted of adding the capability to specify a device for
tmpfs mounting. if you dont specify any device, tmpfs continues to
behave the way it currently is. But if you do, once data doesnt fit on
ram (or some other limit) anymore, it will flush things to this
device. my intention was to reuse swap code for this, so you mount a
tmpfs passing the dev node of some unused swap device, and it works
just like tmpfs with a dedicated swap partition.
So i hope it would be damn fast because of the simple disk format, and
ofcourse all the data becomes lost if you umount it.
