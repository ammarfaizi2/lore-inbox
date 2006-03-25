Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWCYAOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWCYAOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWCYAOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:14:00 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:5052 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750733AbWCYAN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:13:59 -0500
Date: Fri, 24 Mar 2006 18:13:45 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com, daw@cs.berkeley.edu
Subject: Re: eCryptfs Design Document
Message-ID: <20060325001345.GC13688@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060324222517.GA13688@us.ibm.com> <20060324154920.11561533.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324154920.11561533.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 03:49:20PM -0800, Andrew Morton wrote:
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> > On a page read, the eCryptfs page index is interpolated into the
> > corresponding lower page index, taking into account the header page in
> > the file.
> 
> I trust that PAGE_CACHE_SIZE is not implicitly encoded into the file
> layout?

For release 0.1, it is. Managing differing page sizes is one of the
not-so-trivial changes to eCryptfs that we have planned for the 0.2
release. For this release, we can easily include a flag setting in the
header that indicates the page size, so that at least eCryptfs will
return a -EIO when the file is moved between hosts with different page
sizes. We will make sure that this is in the code before it is
submitted.

Do you think that this is an acceptable approach for the initial
release of eCryptfs?

> hm.  The above write() description doesn't sound right.  The
> read+decrypt from the underlying fs should happen at
> ->prepare_write(), not at ->writepage().  And it can be elided if
> ->prepare_write() is about to write the whole page, and if the
> underlying fs's blocksize is less than or equal to the ecryptfs's
> blocksize.

Yes, the design document is unclear; what you describe here is what
the code actually does.

> Anyway, I'll stop trying to review the code without the code.

I would say that this design document is largely only good for
evaluating the security of the design. At this point, it looks like
the code is ready to go out for evaluation, so we will get to work on
cleaning it up and getting it into patches.

Speaking of which, is there any particular way of breaking the code
into patches that you would prefer for delivery of a new filesystem?
In the past, we have been breaking the code into one patch for
inode.c, another for dentry.c, and so forth.

> One dutifully wonders whether all this functionality could be
> provided via FUSE...

My main concern with FUSE has to do with shared memory mappings. My
next concern is with regard to performance impact of constant context
switching during page reads and writes.

Whether to implement in the kernel or in userspace was a fundamental
design decision that was the subject of debate early in the
development of eCryptfs. Given the in-kernel support for something
like a cryptographic filesystem, such as the kernel crypto API and the
keyring support, and given performance and shared memory mapping
concerns, it seemed rational to implement it directly in the kernel.

More heavy-weight cryptographic operations in later versions of
eCryptfs, such as policy evaluation and public key operations, will be
done mostly in userspace and only on file open/close events.

Thanks,
Mike
