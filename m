Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWFJCy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWFJCy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 22:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWFJCy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 22:54:56 -0400
Received: from thunk.org ([69.25.196.29]:15324 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932385AbWFJCyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 22:54:55 -0400
Date: Fri, 9 Jun 2006 22:54:24 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610025424.GA8536@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
	linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
References: <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org> <20060610004727.GC7749@thunk.org> <448A1BBA.1030103@garzik.org> <20060610013048.GS5964@schatzie.adilger.int> <448A23B2.5080004@garzik.org> <20060610020306.GA449@thunk.org> <448A2A6F.8020301@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448A2A6F.8020301@garzik.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 10:11:59PM -0400, Jeff Garzik wrote:
> Trivial to prove false, by your statement above if nothing else.  But 
> anyway:
> Run mke2fs on a blkdev of size 500MB, and one of 500GB.  Note values.
> Now resize blkdev formatted for size 500MB to 500GB, and note differences.

OK, so *that's* what you were trying to get at.  I wish you had said
that from the first, since most people who are creating filesystems to
resize (i.e., on LVM or RAID systems), don't start them as small as
500MB.

Yes, the default inode ratio and blocksize is different for
filesystems under 512MB.  But that's largely irrelevant for the use
cases of online resizing, where people will generally be starting with
a filesystem *far* larger than 512megs.  They might starting with an
LVM sized to be 2 gigs and resize it to 5 gigs.  Or 100 gigs and
resizing it 200 gigs; or 500gigs; or a terrabyte.  In all of those
cases, the results are identical.

It also by the way has nothing to do with the "inode allocation
algorithm", as you caleimd.  The biggest difference will come from the
use of a 1k blocksize instead of 4k blocksize, but that's a matter of
the defaults that were selected for "small" filesystems.  If someone
was creating a file system that they knew they were likely to resize
to 500GB, they could always create it with an explicitly specified
blocksize of 4k, and also specify a different inode ratio.

And this is your argument that on-line resizing is a horrible hack,
and ext3 should be thrown out and rewritten from scratch?  That's
weak.   


One other thought --- people do *care* about backwards compatibility
from a filesystem format level, and they do appreciate being able to
easily upgrade and take advantage of new filesystem features without
needing to do a dump/restore.  

If you don't care about compatibility, but want a scalable filesystem,
take a look at JFS.  It's very, very, good at what it does (and has
support for extents and large block numbers) --- and it's smaller than
XFS and doesn't have the VNODE and System V/IRIX API compatibility
crud of XFS.  The only downside with it is that you do have to do a
backup, reformat, and restore, and of course, the lack of support from
pretty much all of the major distributions.

						- Ted
