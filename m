Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269345AbUHZSSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269345AbUHZSSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269332AbUHZSPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:15:52 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:55999 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S269303AbUHZSHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:07:48 -0400
Date: Thu, 26 Aug 2004 14:07:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826180736.GE8959@delft.aura.cs.cmu.edu>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, reiser@namesys.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, reiserfs-list@namesys.com,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040803i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I trimmed/adjusted the CC list somewhat in the hope of getting a more
productive discussion going.

On Thu, Aug 26, 2004 at 09:48:04AM -0700, Linus Torvalds wrote:
> On Thu, 26 Aug 2004, Jan Harkes wrote:
> > 
> > (btw. the same could be implemented completely in userspace, for
> > instance in glibc. Whenever an open call gets an EISDIR error, simply
> > retry the open, but this time with /_contents appended).
> 
> Yes, and no - just to make it obvious before people jump on this, a lot of 
> things can be prototyped in user space with things like this, but once you 
> have to deal with races and mixed tool environments, user space suddenly 
> doesn't work so well any more.

Agreed.

> The same goes for something like a "container file". Whether you see it as
> "dir-as-file" or "file-as-dir" (and I agree with Jan that the two are
> totally equivalent), the point of having the capability in the kernel is

Only to some point. I was mostly trying to make the point that similar
functionality is already achievable within the current VFS framework.

However, files and directories still have some semantical differences,
and these are probably the points that we would have to address to get
Hans's efforts work well in cooperation with the Linux VFS.

We cannot atomically unlink a dir-as-file, but can unlink a file-as-dir.
In this case, the dcache seems to have no problems unlinking/unhashing a
non-empty directory, so I'm assuming that the unlink problem is mostly
enforced to avoid unreachable, but still allocated files in a file
system. (I'm sure that Viro can probably come up with other reasons why
unlinking a non-empty directory can be evil).

Also, we cannot create hardlinks to a directory (-as-file), but I guess
reiserfs4 allows hardlinks to files (-as-directory). Luckily as far as
hardlinked directories are concerned the file-as-dir implementation
should be a relatively benign subset. I assume that we are not allowed
to rename or link arbitrary objects from the regular fs into it, Coda
returns EXDEV in such situations. As a result there will be no cycles
and this simple premise should get rid of at least a couple of the
possible deadlock scenarios that I've seen mentioned.

Jan

