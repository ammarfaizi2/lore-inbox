Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269156AbUHZQXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269156AbUHZQXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269128AbUHZQTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:19:46 -0400
Received: from mail.shareable.org ([81.29.64.88]:28870 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269156AbUHZQTV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:19:21 -0400
Date: Thu, 26 Aug 2004 17:19:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826161911.GK5733@mail.shareable.org>
References: <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <20040826144422.GD5733@mail.shareable.org> <20040826160306.GA4326@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826160306.GA4326@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> > Unfortunately, the problem is that reiser4 is the only filesystem
> > which is _technically capable_ of implementing that abstraction in a
> > practical way, apparently.  (I'm not sure if this is really true.
> > reiser4's object model is not the same as paths and inodes, but the
> > impedance mismatch doesn't seem huge.)
> 
> Umm, no.  In fact every filesystem does this.  There's not too many
> objects with different namespace semantic: regular files and special
> files vs directories vs symlinks basically, but as soon as you go to the
> data patch you can have hundrets of different file_operations on a
> single filesystems (for special files).

Remember that reiser4 allows you to operate on little pieces of data,
glueing and rearranging them inside files (something like that).

No other filesystem has that capability, and it's a data model which
the fancy features (when they exist) will use.

You can map those pieces to underlying directories and files and
renames and unlinks, so that the fancy stuff works on other
filesystems, but it would be a useless model because those other
filesystems wouldn't be recognisably "ordinary" files any more.

For reiser4 to expose that model through a VFS interface, and the
fancy stuff to use it through the VFS interface, and for the fancy
stuff to work (even imperfectly) on other filesystems which don't
offer those operations, some kind of fall-back "store metadata and
fragment rearrangements in auxiliary files with special names" layer
would be requied.  That's a big job.

I think it's a good job to do (funding, anyone? :), and the right
place for that (imperfect but useful) fall-back layer is userspace
with perhaps minimal VFS support.  Another reason to put the fall-back
layer in userspace is that applications which depend on the fancy
stuff can still be portable to other OSes, working, but a bit
smoother, faster and more "integrated" on reiser4.

-- Jamie
