Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268982AbUHZMws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268982AbUHZMws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268965AbUHZMvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:51:02 -0400
Received: from verein.lst.de ([213.95.11.210]:31190 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268858AbUHZMtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:49:36 -0400
Date: Thu, 26 Aug 2004 14:49:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826124929.GA542@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093522729.9004.40.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:18:49PM +0200, Christophe Saout wrote:
> The reiser4 core is just a big and fast storage layer using a single
> tree. It is bound to a mount point and uses the page cache to manage its
> memory. The only thing it can do on its own is to flush dirty data to
> the disk when the VM wants to (memory pressure) or the VFS wants to
> (unmount, sync) or some "plugin" wants to.
> Additionally it's completely atomic (with respect to crashes, no
> isolation like in databases), comparable to data=journal but without the
> overhead of using a journal for everything.
> 
> Up to this point there are no users of this "database" and it does not
> implement any of the VFS methods for a filesystem (except mount and
> unmount perhaps).

Now that part is interesting from the how to sell it to non-Linux users
POV, but not for the linux kernel.

> All the functionality is provided to the plugins. You can insert,
> remove, lookup or modify key:object pairs (with an index into the
> object). The object is a sequence of units. For files a unit would be 1
> byte and the index would be the byte offset. For directories the unit
> would be 1 entry and the index would be the filename.
> 
> Now there are some plugins that define how the storage layout on the
> disk is (some kind of "backend" plugins).
> 
> *And* there are plugins which are users of the "reiser4 client API" and
> implement the actual VFS methods.

Here comes the problem.  All the access checking/race avoidance/loop
creation avoiced, in short the posix+extension semantics are implemented
in the Linux VFS layer.  If you want to allow a second access method
(e.g. Hans' pet syscall) you'd have to duplicate all VFS functioanlity
inside reiser4.  But this is absolutely not what we want, because we
moved to this common as all previous version in the different
filesystems were buggy, and in fact there are problems that are simply
not solveable at the level at all (rename on directories comes to mind).

So if you want to provide an additional API you'll have to go through
the VFS to get it right - ergo a plugin architecture for upper plugins
is worthless.

Plugins for the disk-format level are an interesting and workable idea
on the other hand.

