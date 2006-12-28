Return-Path: <linux-kernel-owner+w=401wt.eu-S1752778AbWL1P7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbWL1P7N (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbWL1P7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:59:12 -0500
Received: from mx2-2.mail.ru ([194.67.23.122]:32662 "EHLO mx2.mail.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753060AbWL1P7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:59:12 -0500
Date: Thu, 28 Dec 2006 19:04:05 +0300
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Tomasz Kvarsin <kvarsin@gmail.com>,
       Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [PATCH] [RFC] garbage instead of zeroes in UFS
Message-ID: <20061228160405.GA16344@rain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Tomasz Kvarsin <kvarsin@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <5157576d0612200302j556694bfsfdc6cb0c37b054c@mail.gmail.com> <5157576d0612200304n7123157vc47c3c7c1a645527@mail.gmail.com> <20061220030955.bd3acdbc.akpm@osdl.org> <20061220145412.GA11922@rain> <20061220213555.4a21dd08.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220213555.4a21dd08.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for delay with answer]

On Wed, Dec 20, 2006 at 09:35:55PM -0800, Andrew Morton wrote:
> I know nothing of UFS, but here goes..
> 
> > Looks like this is the problem, which point Al Viro some time ago:
> > when we allocate block(in this situation 16K) we mark as new
> > only one fragment(in this situation 2K), 
> 
> Do you mean:
> 
>  ufs's get_block callback allocates 16k of disk at a time, and links that
>  entire 16k into the file's metadata.  But because get_block is called for
>  only a single buffer_head (a 2k buffer_head in this case?) we are only
>  able to tell the VFS that this 2k is buffer_new().
> 
>  So when ufs_getfrag_block() is later called to map some more data in the
>  file, and when that data resides within the remaining 14k of this
>  fragment, ufs_getfrag_block() will incorrectly return a !buffer_new()
>  buffer_head.
> 
Yes.

> If that is correct, it seems like a fairly easy-to-trigger bug.  Perhaps
> it only happens when we're filling in file holes for some reason?
> 
when we filling file hole with size >=16K(in this case),
or extend big enough file(big - we use indirect, double indirect and so
on blocks).

> Or perhaps this bad data can be accessed simply by extending the file with
> ftruncate and then reading shortly beyond the previous end-of-file?
> 
> > I don't see _right_ way to do nullification of whole block,
> > if use inode page cache, some pages may be outside of inode limits
> > (inode size),
> > and will be lost;
> 
> Using the per-inode pagecache is certainly more efficient than perfroming
> synchronous writes via blockdev pagecache and then reading the blocks back
> into the inode pagecache!
> 
> It'd be fairly straightforward to do this for blocks which are inside
> i_size (ie: filling in file holes): populate pagecache, zero it, mark it
> dirty.
> 
> For pages which are presently outside i_size things are a bit more risky -
> they're not really legal and can't in theory be written out.  Or might not
> be written out.  Although from a quick look at the writeback code, it might
> all just work.
> 
> However a cleaner solution might be to remember, on a per-inode basis, what
> the filesystem's view is of the current file size.  Then implement
> inode_operations.setattr() and if someone extends the file, we know that
> this will expose the uninitialised blocks outside the old file-size to
> reads, so now is the time to instantiate that dirty, zero-filled pagecache
> to cover the tail of the last fragment.
> 
> Is all a bit tricky.
> 

I see the two places:
inode_ops.setattr and
address_space_operations.commit_write,
where inode size can be changed, and we should say
"hey, we have pages outside of inode lets fill them with zeroes".

But there is one problem, as can I see(may be I missed something?):
functions from ufs address_space_operations like prepare_write,
writepage are called with page in locked state,
and deadlock may appear, when for example msync will be called
for page "0" and another msync will be called for page "1",
and prepare_write for "0" will try nullify pages "0", "1", "2" and "3"
(The similar code[populate cache and modify pages],
used for reallocate fragments, but due to nature of ufs such situation
is impossible).

So it will be funny implement, debug and use such code.

> > if use blockdev page cache it is possible to zeroize real data,
> > if later inode page cache will be used.
> > 
> > The simpliest way, as can I see usage of block device page cache,
> > but not only mark dirty, but also sync it during "nullification".
> 
> That'll work.  How bad is this change from a performance point-of-view?

You suggest any particular benchmark?
I use my simple tests collection, which I used for check
that create,open,write,read,close works on ufs, and I see that
this patch makes ufs code 18% slower then before.

-- 
/Evgeniy

