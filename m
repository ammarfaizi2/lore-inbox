Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUHZAcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUHZAcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUHZAcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:32:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6294 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266917AbUHZAa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:30:56 -0400
Date: Thu, 26 Aug 2004 01:30:55 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826001152.GB23423@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:11:52AM +0100, Jamie Lokier wrote:
> Is this a problem if we treat entering a file-as-directory as crossing
> a mount point (i.e. like auto-mounting)?

Yes - mountpoints can't be e.g. unlinked.  Moreover, having directory
mounted on non-directory is also an interesting situation.

> Simply doing a path walk would lock the file and then cross the mount
> point to a directory.

*Ugh*

What would happen if you open that directory or chdir there?  If it's
"underlying file stays locked" - we are in even more obvious deadlocks.

> A way to ensure that preserves the lock order is to require that the
> metadata is in a different filesystem to its file (i.e. not crossing a
> bind mount to the same filesystem).
> 
> That has the side effect of preventing hard links between metadata
> files and non-metadata, which in my opinion is fine.

We don't actually need a different fs - different vfsmount will do just fine.

> The strict order is ensured by preventing bind mounts which create a
> path cycle containing a file->metadata edge.  One way to ensure that
> is to prevent mounts on the metadata filesystems, but the rule doesn't
> have to be that strict.  This condition only needs to be checked in
> the mount() syscall.

You really don't want to lock mountpoint on path lookup, so I don't see
how that would be relevant - it's a hell to clean up, for one thing
(I've crossed ten mountpoints on the way, when do I unlock them and
how do I prevent deadlocks from that?)  Besides, different namespaces
can have completely different mount trees, so tracking down all that
stuff would be hell in its own right.

The main issue I see with all schemes in that direction (and something
like that could be made workable) is the semantics of unlink() on
mountpoints.  *Especially* with users being able to see attributes of
files they do not own (e.g. reiser4 mode/uid/gid stuff).  Ability to
pin down any damn file on the system and make it impossible to replace
is not something you want to give to any user.
