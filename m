Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSH0Xzj>; Tue, 27 Aug 2002 19:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSH0Xzj>; Tue, 27 Aug 2002 19:55:39 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:17928 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317400AbSH0Xzi>; Tue, 27 Aug 2002 19:55:38 -0400
Date: Wed, 28 Aug 2002 00:59:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: aia21@cantab.net, kernel@bonin.ca, linux-kernel@vger.kernel.org
Subject: Re: Loop devices under NTFS
Message-ID: <20020828005955.A10892@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>, aia21@cantab.net,
	kernel@bonin.ca, linux-kernel@vger.kernel.org
References: <200208272342.QAA05414@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208272342.QAA05414@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Aug 27, 2002 at 04:42:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 04:42:56PM -0700, Adam J. Richter wrote:
> >On Tue, Aug 27, 2002 at 06:53:19AM -0700, Adam J. Richter wrote:
> >> 	Why?
> >> 
> >> 	According to linux-2.5.31/Documentation/Locking,
> >> "->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
> >> may be called from the request handler (/dev/loop)."
> 
> >Just because it's present in current code it doesn't mean it's right.
> >Calling aops directly from generic code is a layering violation and
> >it will not survive 2.5.
> 
> 	Only according your own proclamation.  You are arguing
> circular logic, and I am aruging a concrete benefit: we can avoid an
> extra copying of all data in the input and output paths going through
> an encrypted device.

I tell you that the address_spaces are an _optional_ abstraction.  Thus
using the directly from generic code is a layering violation.  This layer
of indirection was added intentionally in 2.3, and if you want to get rid
of it again please submit a patch to Al to merge the aops back into the
inode_operations vector.  Otherwise I will cleanup the last remaining
violation of that layering rule in 2.5.

> While I don't have a benchmark to show you (and
> the burden of proof is upon you since you want a change), an extra
> copying of all data going through a potentially high throughput
> service (like, say, all of your file systems if you're running an
> encryptd disk), is likely to have a substantial performance impact.
> There is a real world benefit at stake here of making strong
> encryption as "cheap" to use as as possible.

I am currently reviewing a patch from Jari Ruusu that does not only
get rid of the layering violation but also provides certain advantags
for the loop-AES crypto addon he wrote/maintains.  I doubt he would do
so it it kills performance for his application.  Neverless I must say
I don't care at all for performace of encrypted loop:  It's not merged,
and mainline correctness has a _much_ higher priority for me than
performance of external code.

You argue for performace at the cost of correctness.

> >Separating a stackalbe encryption block device from the loop driver is
> >a good idea.  The current loop code is a horrible mess because it tries
> >to do the job of three drivers in one.
> 
> 	Just saying "good idea" is no substitute for an argument about
> real world benefits, like performance, code footprint, etc.

Correctness and cleanness.

> >No, tmpfs also does not use generic_file_read but a sligh variation,
> >calling do_generic_file_read on tmpfs inodes will not always works as
> >expected.  Don't do it.
> 
> 	Your first sentence is not a clear reason why tmpfs cannot
> provide {prepare,commit}_write, and your second sentence ("Don't do
> it.") is not a reason.

It could provide them just for the sake of loop.c's layering violation
to exist for a longer time.  Due to it's abuse of do_generic_file read
it would continue to have another problem.

> 	I have to say I haven't see much documentation of
> address_space_operations aside from the code, and a few pages about
> the page cache in _Understanding The Linux Kernel_.  However, if you
> believe that loop.c is relying on some guarantee that aops does not
> officially provide but all of its implementations currently abide by,
> then simply documenting that guarantee as "official" would result in a
> kerenl that is lives within its guarantees and yet has faster performance
> for software encrypted block devices.

If you think that the guarantee that every filesystem should be pagecache
backed is worth documenting (and adopting everything to it), feel free to
submit a patch for review.  I have stated above why it's not a good idea.

