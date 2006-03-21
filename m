Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWCUUk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWCUUk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWCUUk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:40:57 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:64897 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932318AbWCUUk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:40:56 -0500
Date: Tue, 21 Mar 2006 13:40:50 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Takashi Sato <sho@bsd.tnes.nec.co.jp>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org,
       cascardo@minaslivre.org
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060321204050.GU6199@schatzie.adilger.int>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, Takashi Sato <sho@bsd.tnes.nec.co.jp>,
	cmm@us.ibm.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org,
	cascardo@minaslivre.org
References: <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com> <20060320234829.GJ6199@schatzie.adilger.int> <1142960722.3443.24.camel@orbit.scot.redhat.com> <20060321183822.GC11447@thunk.org> <1142970467.3443.50.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142970467.3443.50.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 21, 2006  14:47 -0500, Stephen C. Tweedie wrote:
> On Tue, 2006-03-21 at 13:38 -0500, Theodore Ts'o wrote:
> > Hurd is definitely using the translator field, and I only recently
> > discovered they are using it to point at a disk block where the name
> > of the translator program (I'm not 100% sure, but I think it's a
> > generic, out-of-band, #! sort of functionality).  

Argh, sounds fragile in any case.

> I'm not proposing breaking any compatibility.  The idea was simply that
> if we wanted to add new fields to that space in the inode struct, it
> would be an incompat change on *all* platforms, not just hurd; and that
> on hurd, an extra side-effect of that incompat flag would be that we now
> look for translation etc. in an xattr.

I would rather propose that we maintain as much compatibility as possible,
given that we don't even know what those extra fields might be, and would
likely need to have yet another compatibility flag on the feature itself.
Remember that large inodes themselves are incompatible with older kernels
(maybe predating 2.6.9) so we don't need to worry about 2.4 kernels at all.

> The timestamps are about the only things I can think of that would be
> safe to ignore.  Everything else --- i_nlinks, i_blocks, checksums,
> highwatermarking --- has consistency implications and e2fsck would need
> to be aware of it.

Which would get their own superblock flags if needed.

> Hmm, that should work.  It certainly works nicely for overflow fields.
> It might complicate things like highwatermarking: a simple HWM
> implementation would record the amount of the file that is actually
> initialised in the HWM field, so "0" would actually be an unusual,
> important special case.

The HWM feature would fall under an INCOMPAT flag then, and possibly
also set a flag in the inode to indicate validity (similar to my
proposal for the i_blocks change).

> And "0" would be a potentially valid checksum if we use CRC32, too.

Hmm, is that true?  I thought that 0 was impossible for CRC32, since
even for a zero-length file the initial value should be 0xffffffff,
though I'm not 100% sure of that.  

> Using the per-sb field for reserved space, and
> the in-inode one to determine which fields are actively in use, would
> avoid such ambiguous cases.

But, doesn't help if i_hwm comes before some other field that is put into
use, so it has to be handled anyways.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

