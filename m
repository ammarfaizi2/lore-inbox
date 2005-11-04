Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVKDPjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVKDPjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVKDPjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:39:04 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:51206 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750816AbVKDPjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:39:02 -0500
To: joern@wohnheim.fh-wedel.de
CC: jblunck@suse.de, miklos@szeredi.hu, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org
In-reply-to: <20051104151646.GB31827@wohnheim.fh-wedel.de> (message from
	=?iso-8859-1?Q?J=F6rn?= Engel on Fri, 4 Nov 2005 16:16:46 +0100)
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu> <20051104151104.GA22322@hasse.suse.de> <20051104151646.GB31827@wohnheim.fh-wedel.de>
Message-Id: <E1EY3eK-0004Yb-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 04 Nov 2005 16:38:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > True. Seeking to that offset should at least fail and shouldn't
> > stop at the new entry. But SuSV3 says that the offset given by
> > telldir() is valid until the next rewinddir().  This is no problem
> > for directories that can only grow.  I tried to implement some
> > kind of deferred dput'ing of the d_child's but that was too
> > hackish and was wasting memory. So the best thing I can do now is
> > fail if someone wants to seek to an offset of an already unlinked
> > file.
> 
> Does that mean that, to satisfy the standard, you'd have to allow the
> seek, but return 0 bytes on further reads, as you're already at (or
> beyond, whatever) EOF?
> 
> Sounds quite ugly and it would be nice if this wasn't necessary.

The directory position not _on_ an entry, but _between_ two entries.
So it doesn't matter if the next entry is removed, the offset stays
perfectly valid.

If there doesn't remain any entries after the position, readdir should
return EOF.  Otherwise it should continue reading normally.

What SUS doesn't specify is what happens entries added between
opendir() and before rewinddir().

Miklos
