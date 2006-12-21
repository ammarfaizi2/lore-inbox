Return-Path: <linux-kernel-owner+w=401wt.eu-S1422731AbWLUFgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWLUFgG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 00:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWLUFgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 00:36:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40042 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422731AbWLUFgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 00:36:04 -0500
Date: Wed, 20 Dec 2006 21:35:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: Tomasz Kvarsin <kvarsin@gmail.com>,
       Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [PATCH] [RFC] garbage instead of zeroes in UFS
Message-Id: <20061220213555.4a21dd08.akpm@osdl.org>
In-Reply-To: <20061220145412.GA11922@rain>
References: <5157576d0612200302j556694bfsfdc6cb0c37b054c@mail.gmail.com>
	<5157576d0612200304n7123157vc47c3c7c1a645527@mail.gmail.com>
	<20061220030955.bd3acdbc.akpm@osdl.org>
	<20061220145412.GA11922@rain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 17:54:12 +0300
Evgeniy Dushistov <dushistov@mail.ru> wrote:

> On Wed, Dec 20, 2006 at 03:09:55AM -0800, Andrew Morton wrote:
> > On Wed, 20 Dec 2006 14:04:06 +0300
> > "Tomasz Kvarsin" <kvarsin@gmail.com> wrote:
> > 
> > > Forgot to say I use linux-2.6.20-rc1-mm1
> > > 
> > > On 12/20/06, Tomasz Kvarsin <kvarsin@gmail.com> wrote:
> > > > I have some problems with write support of UFS.
> > > > Here is script which demonstrate problem:
> > > >
> > > > #create image
> > > > mkdir /tmp/ufs-expirements && cd /tmp/ufs-expirements/
> > > > for ((i=0; i<1024*1024*2; ++i)); do printf "z"; done > image
> > > >
> > > > #build ufs tools
> > > > wget 'http://heanet.dl.sourceforge.net/sourceforge/ufs-linux/ufs-tools-0.1.tar.bz2'
> > > > && tar xjf ufs-tools-0.1.tar.bz2 && cd ufs-tools-0.1
> > > > wget http://lkml.org/lkml/diff/2006/5/20/48/1 -O build.patch
> > > > patch -p1 < build.patch && make
> > > >
> > > > #create UFS file system on image
> > > > ./mkufs -O 1 -b 16384 -f 2048 ../image
> > > > cd .. && mkdir root
> > > > mount -t ufs image root -o loop,ufstype=44bsd
> > > > cd root/
> > > > touch a.txt
> > > > echo "END" > end.txt
> > > > dd if=./end.txt of=./a.txt bs=16384 seek=1
> > > >
> > > > and at the end content of "a.txt" not only  "END" and zeroes,
> > > > "a.txt" also contains "z".
> > > >
> > > > The real situation happened when I deleted big file,
> > > > and create new one with holes. This script just easy way to reproduce bug.
> > > >
> > 
> > Does 2.6.20-rc1 have the same problem?

I know nothing of UFS, but here goes..

> Looks like this is the problem, which point Al Viro some time ago:
> when we allocate block(in this situation 16K) we mark as new
> only one fragment(in this situation 2K), 

Do you mean:

 ufs's get_block callback allocates 16k of disk at a time, and links that
 entire 16k into the file's metadata.  But because get_block is called for
 only a single buffer_head (a 2k buffer_head in this case?) we are only
 able to tell the VFS that this 2k is buffer_new().

 So when ufs_getfrag_block() is later called to map some more data in the
 file, and when that data resides within the remaining 14k of this
 fragment, ufs_getfrag_block() will incorrectly return a !buffer_new()
 buffer_head.

If that is correct, it seems like a fairly easy-to-trigger bug.  Perhaps
it only happens when we're filling in file holes for some reason?

Or perhaps this bad data can be accessed simply by extending the file with
ftruncate and then reading shortly beyond the previous end-of-file?

> I don't see _right_ way to do nullification of whole block,
> if use inode page cache, some pages may be outside of inode limits
> (inode size),
> and will be lost;

Using the per-inode pagecache is certainly more efficient than perfroming
synchronous writes via blockdev pagecache and then reading the blocks back
into the inode pagecache!

It'd be fairly straightforward to do this for blocks which are inside
i_size (ie: filling in file holes): populate pagecache, zero it, mark it
dirty.

For pages which are presently outside i_size things are a bit more risky -
they're not really legal and can't in theory be written out.  Or might not
be written out.  Although from a quick look at the writeback code, it might
all just work.

However a cleaner solution might be to remember, on a per-inode basis, what
the filesystem's view is of the current file size.  Then implement
inode_operations.setattr() and if someone extends the file, we know that
this will expose the uninitialised blocks outside the old file-size to
reads, so now is the time to instantiate that dirty, zero-filled pagecache
to cover the tail of the last fragment.

Is all a bit tricky.

> if use blockdev page cache it is possible to zeroize real data,
> if later inode page cache will be used.
> 
> The simpliest way, as can I see usage of block device page cache,
> but not only mark dirty, but also sync it during "nullification".

That'll work.  How bad is this change from a performance point-of-view?

