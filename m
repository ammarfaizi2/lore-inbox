Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbTLLPkn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265259AbTLLPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:40:43 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:24132 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265258AbTLLPkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:40:33 -0500
Date: Fri, 12 Dec 2003 09:40:31 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031212094031.B1303@hexapodia.org>
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com> <20031211194815.GA10029@wohnheim.fh-wedel.de> <20031211135854.A29359@hexapodia.org> <20031212121824.GA6112@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031212121824.GA6112@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Fri, Dec 12, 2003 at 01:18:24PM +0100
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 01:18:24PM +0100, Jörn Engel wrote:
> On Thu, 11 December 2003 13:58:54 -0600, Andy Isaacson wrote:
> > On Thu, Dec 11, 2003 at 08:48:15PM +0100, Jörn Engel wrote:
> > > If you really do it, please don't add a syscall for it.  Simply check
> > > each written page if it is completely filled with zero.  (This will be
> > > a very quick check for most pages, as they will contain something
> > > nonzero in the first couple of words)
> > 
> > Um, no.
> > 
> > That is a very bad idea.  Your suggestion would make it impossible to
> > actually write a block of all-zeros to the disk.  That makes it
> > impossible to pre-allocate disk space.
> 
> How about implementing it inside the individual filesystems?  Then
> each filesystem can figure out a logic that suits it's special needs.
> 
> What I would sometimes like to have goes even beyond this.  Create a
> simple hash for each size-x chunk of a file, and check against those
> hashes whenever writing.  If hashes are identical, compare the chunks
> and if those are identical as well, just create another link to that
> chunk.  Kinda like rsync on a filesystem level, only without the
> rolling checksum thing.

A related idea was reportedly used in the Venti filesystem, which was
discussed on linux-kernel back in October; look for the thread
"Transparent compression in the FS".

The downsides are pretty substantial (but the upsides are too).  You
don't know how many blocks are available on the filesystem for you to
write, because when you write you might not allocate blocks.  And you
lose disk-streaming-perfomance, because you're going to be seeking all
over the disk picking up the blocks for your files.

> > Another syscall is precisely the correct thing to do.  (I don't think
> > make_hole() is a special case of any extant syscall.)
> 
> Depends.  My proposal has a bunch of problems.  We won't have it
> implemented by next year.  I buy all that.  Maybe we can do it with
> 10% kernel code and 90% userspace, maybe not.  Most likely the first
> couple of implementations create more problems than they solve, yes.
> 
> But we should get there some day.  Having 15 nearly identical copies
> of the kernel on my notebook is a pain and hard links simply have the
> wrong semantics.

I don't know about you, but I don't have 15 nearly identical copies of
the kernel; I have 30 copies that have almost no text in common, and
certainly have no blocks in common -- they result from independent
compilations, and the resulting bzImage files are not duplicates.

-andy
