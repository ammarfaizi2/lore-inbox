Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbTJQBeb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTJQBeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:34:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56434 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263272AbTJQBe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:34:29 -0400
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Josh Litherland <josh@temp123.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove>
	<20031015133305.GF24799@bitwizard.nl>
	<16269.20654.201680.390284@laputa.namesys.com>
	<20031015142738.GG24799@bitwizard.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Oct 2003 19:32:57 -0600
In-Reply-To: <20031015142738.GG24799@bitwizard.nl>
Message-ID: <m1ekxcejhy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> writes:

> On Wed, Oct 15, 2003 at 05:50:38PM +0400, Nikita Danilov wrote:
> > Erik Mouw writes:
> >  > Nowadays disks are so incredibly cheap, that transparent compression
> >  > support is not realy worth it anymore (IMHO).
> > 
> > But disk bandwidth is so incredibly expensive that compression becoming
> > more and more useful: on compressed file system bandwidth of user-data
> > transfers can be larger than raw disk bandwidth. It is the same
> > situation as with allocation of disk space for files: disks are cheap,
> > but storing several files in the same block becomes more advantageous
> > over time.
> 
> You have a point, but remember that modern IDE drives can do about
> 50MB/s from medium. I don't think you'll find a CPU that is able to
> handle transparent decompression on the fly at 50MB/s, even not with a
> simple compression scheme as used in NTFS (see the NTFS docs on
> SourceForge for details).

You don't need to do 50MB/s decompression to for compression to be
a win though.  At 16MB/s with an average of 3:1 compression you have
achieved the same speed off of the disk.  So you only need > 16MB/s
for it to be a speed win.  The double buffering and cpu resources
may give rise to other throughput issues though.

Beyond that modern disks cannot do 50MB/s random I/O seeks are too
expensive.  So by compressing data you can fit it into a smaller
space and with care reduce your seek overhead.

Looking for some real world examples I picked one of my log files that
I generate from my daily development activities.  It was archived
with logrotate and already compressed.  And I just picked the largest 
one.  The file is a text log file, it is not full of zeros and
run length encoding it would not be useful.

Compressed it is 5.5M decompressed it is 128M.  
At home on my athlon 700Mhz I can decompress it in roughly 3 seconds.
At work on my xeon 1.7Ghz  I can decompress it in 1 second.
On my test opteron at 1.4 Ghz I can decompress it in 0.9 seconds.

So I would get effective 42MB/s at home and 128MB/s at work, and 142MB/s on my
test box.  So for some loads there is certainly a performance win to
be had.

The way to incorporate this into the write path of a filesystem
is to use delayed allocation, and put off the write as long as possible.
Then compress the file, allocate the blocks for it and write it in one
big piece.   This allows very big compressed blocks.  e2compr I think stopped
development before compression was implemented in the right place.

And then there are other cases where compression is worthwhile like zisofs.
You can't make a CD bigger so to stuff more data on it you must compress it.
And then you have more files you can use immediately.

I suspect other things like a transparently compressed glibc would also be a win.
You always have it in ram so it might as well be compressed on disk
and save space..

And there are enough embedded cases out there where people are
squeezing the hardware budgets to bring prices down as far as they can 
living on less hardware is a good thing is you can do so easily.

Eric
