Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265005AbUELDmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265005AbUELDmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUELDmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:42:09 -0400
Received: from thunk.org ([140.239.227.29]:53158 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265005AbUELDmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:42:04 -0400
Date: Tue, 11 May 2004 23:41:23 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Valdis.Kletnieks@vt.edu
Cc: root@chaos.analogic.com, Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU,
       madan@cs.Stanford.EDU, "David L. Dill" <dill@cs.Stanford.EDU>
Subject: Re: [Ext2-devel] Re: [CHECKER] e2fsck writes out blocks out of order, causing root dir to be corrupted (ext3, linux 2.4.19, e2fsprogs 1.34)
Message-ID: <20040512034123.GA6469@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Valdis.Kletnieks@vt.edu,
	root@chaos.analogic.com, Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU,
	madan@cs.Stanford.EDU, "David L. Dill" <dill@cs.Stanford.EDU>
References: <Pine.GSO.4.44.0405111749290.2448-100000@elaine24.Stanford.EDU> <Pine.LNX.4.53.0405112238140.3269@chaos> <200405120309.i4C39jUZ017062@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405120309.i4C39jUZ017062@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 11:09:45PM -0400, Valdis.Kletnieks@vt.edu wrote:
> 
> I suspect this bug is merely a special case of "your filesystem can
> get scrogged if something's doing caching behind your back" - the
> same sort of issues that prompted recent "flush the IDE cache on
> shutdown" fixes, and the well-known issues with using journalling
> file systems on a file-backed loopback device.

No, not really.  This is the case of "we moved code that was original
kernel-space to user space", and we failed to simulate certain
functions, such as sync_blockdev().

> Having said that, I admit being surprised that their demonstration
> test case is *that* simple - that's a truly small number of I/Os to
> get it into a repeatably corruptible state.  I'm sure many of us
> have a mental image of these class of failures as being heisenbugs,
> dependent on the cache contents.

Well, the demonstration test case *wasn't* that simple.  It required
the system crashing twice at very specific points.  Once to create the
filesystem requiring a journal replay, and then a second crash at
exactly the right time in the middle of e2fsck's journal replaying
code.  This failure would be fairly hard to replicate in real-life
conditions, since it would require to crashes in quick succession, at
very carefully chosen points, although if you had really flaky AC
mains, I suppose it might be considered a more likely failure case.

> Hardly - the class of errors is one that does (or should) concern
> the kernel community - and I don't consider identifying a "your
> filesystem *will* be toast if you get into this repeatable scenario"
> a troll.  At the very least, we can consider what additional
> hardening we can do to either the kernel or userspace to make sure
> that we don't re-order the blocks - note the key phrase here:
> 
> "Neither of these pay attention to the journaling constraints of
> EXT3 and JBD."

Well, actually it was the e2fsprogs user space code that wasn't paying
attention t the journalling constraints, mainly because we had been we
weren't faithfully implementing sync_blockdev()/fsync_no_super().  The
patch to fix this in e2fsprogs was fairly simple.

						- Ted
