Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTLLMS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 07:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTLLMS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 07:18:29 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:22439 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264546AbTLLMS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 07:18:27 -0500
Date: Fri, 12 Dec 2003 13:18:24 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031212121824.GA6112@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com> <20031211194815.GA10029@wohnheim.fh-wedel.de> <20031211135854.A29359@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031211135854.A29359@hexapodia.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 December 2003 13:58:54 -0600, Andy Isaacson wrote:
> On Thu, Dec 11, 2003 at 08:48:15PM +0100, Jörn Engel wrote:
> > 
> > If you really do it, please don't add a syscall for it.  Simply check
> > each written page if it is completely filled with zero.  (This will be
> > a very quick check for most pages, as they will contain something
> > nonzero in the first couple of words)
> 
> Um, no.
> 
> That is a very bad idea.  Your suggestion would make it impossible to
> actually write a block of all-zeros to the disk.  That makes it
> impossible to pre-allocate disk space.

How about implementing it inside the individual filesystems?  Then
each filesystem can figure out a logic that suits it's special needs.

What I would sometimes like to have goes even beyond this.  Create a
simple hash for each size-x chunk of a file, and check against those
hashes whenever writing.  If hashes are identical, compare the chunks
and if those are identical as well, just create another link to that
chunk.  Kinda like rsync on a filesystem level, only without the
rolling checksum thing.

Yes, you can do a lot of this from userspace, but hard links don't
have a copy-on-write semantic, so this often breaks things, unless
*all* userspace programs break hard links before modifying files.

Also, this effectively compresses your data, so you need less
bandwidth to the cache and less cache size.  Whatever applies to code
size and L1 cache should apply here as well.  Sure, the disk access
pattern may be worse, but who cares, if data sets suddenly fit into
memory?

Oh yes, this would also give you my proposed zero-block detection for
free.

> Another syscall is precisely the correct thing to do.  (I don't think
> make_hole() is a special case of any extant syscall.)

Depends.  My proposal has a bunch of problems.  We won't have it
implemented by next year.  I buy all that.  Maybe we can do it with
10% kernel code and 90% userspace, maybe not.  Most likely the first
couple of implementations create more problems than they solve, yes.

But we should get there some day.  Having 15 nearly identical copies
of the kernel on my notebook is a pain and hard links simply have the
wrong semantics.

Jörn

-- 
Anything that can go wrong, will.
-- Finagle's Law
