Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVJGOlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVJGOlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbVJGOlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:41:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:138 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S1030219AbVJGOlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:41:49 -0400
Date: Fri, 7 Oct 2005 15:41:47 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't invalidate non-directory mountpoints
Message-ID: <20051007144147.GE7992@ftp.linux.org.uk>
References: <E1ENqAg-0004bJ-00@dorka.pomaz.szeredi.hu> <20051007143012.GC7992@ftp.linux.org.uk> <E1ENtKD-0005Dw-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ENtKD-0005Dw-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 04:35:53PM +0200, Miklos Szeredi wrote:
> > > d_invalidate allowed a non-directory mountpoint to be invalidated,
> > > which is bad, since the mountpoint becomes unreachable.
> > > 
> > > I know it's racy wrt attaching/detaching mount, but AFAICS so is
> > > everything else that unhashes the dentry.  This seems to be an
> > > oversight when splitting out vfsmount_lock from dcache_lock.  To be
> > > fixed.
> > 
> > NAK.  That's a wrong way to deal with the problem and it's much older
> > than vfsmount_lock or dcache_lock (and affects directories too).
> 
> Sorry?
> 
> Directories are not invalidated if they have any other reference (like
> a mount, or any subdirectories which may have mounts).
> 
> So how does it affect directories?

The underlying problem is still there - parts of mount tree _can_ go
unreachable when remote object dies; trying to pin them down is hopeless
and the only sane way to deal with that is to dissolve the subtrees
of mount when that happens.
