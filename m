Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVKDPdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVKDPdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVKDPdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:33:51 -0500
Received: from cantor2.suse.de ([195.135.220.15]:17058 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750816AbVKDPdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:33:50 -0500
Date: Fri, 4 Nov 2005 16:34:20 +0100
From: jblunck@suse.de
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: jblunck@suse.de, Miklos Szeredi <miklos@szeredi.hu>, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104153420.GA23962@hasse.suse.de>
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu> <20051104151104.GA22322@hasse.suse.de> <20051104151646.GB31827@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051104151646.GB31827@wohnheim.fh-wedel.de>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, Jörn Engel wrote:

> On Fri, 4 November 2005 16:11:04 +0100, jblunck@suse.de wrote:
> > 
> > True. Seeking to that offset should at least fail and shouldn't stop at the
> > new entry. But SuSV3 says that the offset given by telldir() is valid until
> > the next rewinddir().  This is no problem for directories that can only grow.
> > I tried to implement some kind of deferred dput'ing of the d_child's but that
> > was too hackish and was wasting memory. So the best thing I can do now is fail
> > if someone wants to seek to an offset of an already unlinked file.
> 
> Does that mean that, to satisfy the standard, you'd have to allow the
> seek, but return 0 bytes on further reads, as you're already at (or
> beyond, whatever) EOF?

No. To satisfy the standard, it would be necessary to let the seek succeed and
to return the already unlinked dentry or the next dentry (this is
unspecified). I think we should return the next dentry, therefore I let the
seek fail (seekdir() doesn't even have a return value) and the cursor/f_pos is
still at the old offset.

The real problem is this IMHO:
...
telldir() = a
...
telldir() = b
readdir() = foo.txt
unlink(foo.txt)
seekdir(a)
seekdir(b)
readdir() = ???

With my patch the seekdir(b) doesn't find the offset and is placing the cursor
at the end of the directory. In my understanding of the SuSV3 this should be
possible and should return either "foo.txt" or the next entry after
"foo.txt". I don't see any chance how I can implement that.

Regards,
	Jan Blunck

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
