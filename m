Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUDDIQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 04:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUDDIQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 04:16:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:686 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262257AbUDDIQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 04:16:28 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
References: <20040402165440.GB24861@wohnheim.fh-wedel.de>
	<20040402180128.GA363@elf.ucw.cz>
	<20040402181707.GA28112@wohnheim.fh-wedel.de>
	<20040402182357.GB410@elf.ucw.cz>
	<20040402200921.GC653@mail.shareable.org>
	<20040402213933.GB246@elf.ucw.cz>
	<20040403010425.GJ653@mail.shareable.org>
	<m1n05soqh2.fsf@ebiederm.dsl.xmission.com>
	<20040403194344.GA5477@mail.shareable.org>
	<m1ekr4olcv.fsf@ebiederm.dsl.xmission.com>
	<20040403215941.GA6122@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Apr 2004 01:15:50 -0700
In-Reply-To: <20040403215941.GA6122@mail.shareable.org>
Message-ID: <m1vfkgma4p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > > We'd like cowlinks that are an invisible filesystem optimisation.
> > > That means you "copy" a file and it behaves the same as if you copy a file.
> > 
> > Exactly so they would not share the same pages in RAM.
> 
> That is one way to implement it.
> 
> > > Btw, I'm not suggesting sharing page cache entries.
> > 
> > It sounded like you assumed sharing of page cache entries above.  
> > How do you get to step 2 if the cow copies don't share the same page
> > cache entries?
> 
> Ah.  A misunderstanding on my part.
> 
> I mean not sharing page cache entries between different
> address_spaces, but sharing between different cowlinks which use the
> same underlying address_space.
> 
> I had in mind that since each cowlink is a separate inode, but both
> inodes point to a shared data structure in the filesystem, they would
> map pages out of a shared address_space representing that data
> structure.  You've pointed out that it isn't necessary to do that, and
> it's probably simpler not to.

Especially since the VM layer has no concept of COW except for private
anonymous pages.  Which does not map to a POSIX cow on files.
 
> Now I see your point.  Page sharing could be avoided completely, if
> when mapping a cowlink the page was _copied_ from the shared
> address_space to the cowlink's own address_space.  Copying also solves
> the mlock() problem.  (A shared address_space is still required, because
> you may cowlink a file which has dirty pages in RAM).

Either that your you call fsync(file) as part of generating the cow
copy.

> Copying raises a different problem: what to do when a non-cowlink file
> is mapped (PROT_READ), and then it's cowlinked while the mapping is in
> place.  The non-cowlink inode gets converted to a cowlink inode.  The
> pages are hashed in the original address_space, and you now have a
> mapping of a cowlink file where the mapped pages are _not copies_ of
> pages in the shared address_space.

If you don't flush things to disk first there are certainly some sharing
issues.  Flushing the data to the address_space of the shared inode
should work just as well though.

What you must have is a clear state change from caching a normal file
to cache a cow file.  Where certain parts of the behavior changes.

What this needs to do depends on the VFS at the time.  

If sharing is introduced past that state change things get tricky to
manage.  I just don't want to think about those issues just now...

Eric




