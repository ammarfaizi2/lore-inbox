Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSH1Qh2>; Wed, 28 Aug 2002 12:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSH1Qh2>; Wed, 28 Aug 2002 12:37:28 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:21005 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313898AbSH1Qh1>; Wed, 28 Aug 2002 12:37:27 -0400
Date: Wed, 28 Aug 2002 17:41:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: aia21@cantab.net, kernel@bonin.ca, linux-kernel@vger.kernel.org
Subject: Re: Loop devices under NTFS
Message-ID: <20020828174138.A2935@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>, aia21@cantab.net,
	kernel@bonin.ca, linux-kernel@vger.kernel.org
References: <200208280106.SAA05492@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208280106.SAA05492@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Aug 27, 2002 at 06:06:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 06:06:32PM -0700, Adam J. Richter wrote:
> >I tell you that the address_spaces are an _optional_ abstraction.
> >Thus using the directly from generic code is a layering violation.
> 
> 	That does not follow from your previous sentence.  It is
> perfectly legitimate to check for the existence of an optional feature
> and use it if it is there, which is what the stock 2.5.31 loop.c and
> my version do.

I didn't say an optional feature.  The filesystem may choose to use that
abstraction in a totally different way than the generic code.  An example
for such an filesystem is GFS.  Thus OpenGFS doesn't support loop devices
at all and sistina has tp provide workaround patches for their propritary
product.

> >This layer
> >of indirection was added intentionally in 2.3, and if you want to get rid
> >of it again please submit a patch to Al to merge the aops back into the
> >inode_operations vector.
> 
> 	Regardless of whether aops and inode_operations are merged,
> you haven't shown a problem with using aops when they are present.  It
> is not necessary to remerge these data structures in order to use an
> optional feature if it is present.

See above.  Execpt of ->writepage which must be callable by the VM writeout
code filesystems may have totally different assumptions.  For a worst case
example look at the (Open-)GFS cluster filesystem.  For a not so bad example
look at XFS which does in theory require additional locking although this
doesn't seem exploitable in practice.

> 	You've failed to show real end user benefits against the
> disadvantage of slower encrypted devices and you're going to go ahead
> anyway?

The end-user benefict is that a user can use the loop device omtop
of any filesystem without the danger of those races actually beeing exposed
for some random reason.  

> I looked at his changes, they created a much bigger loop.c.

Yes, loop.c does grow.

> In
> comparison, my version fixes the serious bug of loop.c allocating
> n*(n+1)/2 pages for an n page bio, cleans up the locking dramatically,
> eliminats the need to preallocate a fixed number of loop devices,
> exports the DMA parameters of each underlying loop devices to enable
> handling of bigger bio's, eliminates unnecessary data copying (via
> bio_copy, not just the aops stuff we have been talkign about), a
> generally makes it a lot more readable.  Before I put in the
> file_ops->{read,write} stuff, my changes actually shrunk loop.c.

I don't complain about your other changes.  These bugs were in before and
after your changes so I certainly do not blaim you.

> 	There is a difference between killing performance and making
> enough of a difference to warrant an engineering decision.
> Differences that warrant such changes can be small enough that you
> need to do benchmarks to be sure of them.  People present lots of
> papers on measurement results in Linux at conferences because of this.
> In general, and extra copy of all data on the input and output data
> paths is a big deal.

Blarg.  If you care for performance encrypted loop is the last thing you want.

> If you care that little about a major use of loop.c, then
> Linux will be better off if you stay out of the patch approval path
> for it.

I don't care about loop.c, really.  And I don't plan to approve or reject
loop-specific patches.  I care about it's interaction with the VFS and
lowlevel filesystems.

