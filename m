Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTEVEEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 00:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbTEVEEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 00:04:55 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:45048 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262482AbTEVEEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 00:04:53 -0400
Date: Wed, 21 May 2003 22:16:29 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [RFC] fast EA for ext3
Message-ID: <20030521221628.H4198@schatzie.adilger.int>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <87n0hkmbiw.fsf@gw.home.net> <20030518165718.B11651@schatzie.adilger.int> <Pine.LNX.4.53.0305220050250.17302@Chaos.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0305220050250.17302@Chaos.suse.de>; from agruen@suse.de on Thu, May 22, 2003 at 01:33:56AM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 22, 2003  01:33 +0200, Andreas Gruenbacher wrote:
> - What's the status of the other fixed fields in the large inodes? Is
>   there agreement on adding exactly the fields in the patch?

Not specifically - the "microsecond times" were pretty much a given (hmm,
which I guess are actually nanosecond times, so maybe should be renamed),
I think (especially since the VFS now supports that).  I have been considering
if we wanted to overload the on-disk fields so that the high bits of the
usecond timestamps also serve as bits 32+ of the seconds field, so we can
handle y2038 problems in advance.  All this would require now is either
masking the high bits and possibly shifting the low bits depending on how
many bits we wanted (nseconds are < 2^30, so we have 2 bits free right now
for ~600 years of time growth), but we could have more at some small expense
in time resolution).

> - A common operation is to change an attribute's value without changing
>   the value's length. The current code does not optimize this case, but
>   it should. The patch makes this optimization a little harder.

Sure.

> - struct ext3_xattr_entry makes little sense in an inode. The
>   e_value_block and e_hash fields should go away. The e_value_size
>   field could be shrunk from 4 to 2 bytes. This would save 10 bytes per
>   attribute. The code wouldn't become a lot more messy from that.

We did it this way specifically to avoid duplicating all of the code that
uses ext3_xattr_entry - we had originally wanted to have a smaller in-inode
"entry" struct.  I suppose we could convert from the in-inode short format
to the larger ext3_xattr_entry before calling the xattr code.

Still, having the same struct does have some advantages - e_value_block
could still be used to store larger EA data outside the inode but still
keep the entries in the inode for faster lookups.  It also facilitates
moving EAs from inside the inode to an external block and vice-versa if
that becomes desirable (e.g. keeping "system" attributes in the inode,
and "user" attributes outside if there are size issues).

> - In-inode EA support should be configurable. I would like to choose
>   whether I want this feature at compile time, with as few #ifdef's as
>   possible.

I suppose that might be marginally desirable, but if you don't have
large inodes you don't activate that code.

> >  Storing EAs in external blocks is slow, and if you
> > have a lot of inodes with external EAs it is fatal, as the EA blocks consume
> > so much RAM that they force all of the inode/directory data out of cache.
> 
> The current implementation is not suitable for applications which store
> unique EAs for very many inodes. Storing the EAs in the inodes is much
> better, but increasing the inode size also costs space.

That is exactly the situation we are in - each inode has unique EA data.
In a test we needed to pass for Lustre (10M files in a single directory),
we had ~1.25GB of inode table data, ~256MB of directory data, and a
whopping 40GB of EA blocks, of which we needed about 600MB.

> > Some benchmarks (from Alex):
> > > environment for  old EA: just mkfs'ed EXT3, inode size 128, 33000 files
> > > environment for fast EA: just mkfs'ed EXT3, inode size 256, 33000 files
> > >
> > >                      old EA       fast EA
> > > add attributes       2m35.241s    1m4.151s   (+142%)
> > > dump attributes      0m28.716s    0m13.466s  (+113%)
> > > change attributes    2m42.108s    1m4.413s   (+153%)
> > > remove attributes    1m15.373s    1m3.909s   (+19%)
> 
> Nice. That's probably with unique attributes per inode.

Yes.  The mbcache doesn't help us at all in this case.

> > Some minor improvements could be made, such as not storing user EAs inside
> > the inode if there are system EAs that could be stored there.
> 
> I don't know which strategy will be best here. We don't have to solve this
> problem now, though.

Definitely not.

> By the way, you will likely also need dynamically allocated inodes, right?
> What's the status here?

Yes, eventually.  We are in the midst of getting Lustre working on 2.5,
and our customers have very big storage needs (2TB just for the metadata
filesystem - only inodes, EAs, directories, no file data at all there),
so dynamic inode tables isn't #1 on our list of problems to fix.  However,
we will get there eventually I hope.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

