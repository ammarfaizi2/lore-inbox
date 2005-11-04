Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbVKDPpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbVKDPpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbVKDPpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:45:14 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:34019 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751533AbVKDPpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:45:12 -0500
Date: Fri, 4 Nov 2005 16:45:11 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: jblunck@suse.de
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104154511.GC31827@wohnheim.fh-wedel.de>
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu> <20051104151104.GA22322@hasse.suse.de> <20051104151646.GB31827@wohnheim.fh-wedel.de> <20051104153420.GA23962@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051104153420.GA23962@hasse.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 November 2005 16:34:20 +0100, jblunck@suse.de wrote:
> On Fri, Nov 04, Jörn Engel wrote:
> > On Fri, 4 November 2005 16:11:04 +0100, jblunck@suse.de wrote:
> > > 
> > > True. Seeking to that offset should at least fail and shouldn't stop at the
> > > new entry. But SuSV3 says that the offset given by telldir() is valid until
> > > the next rewinddir().  This is no problem for directories that can only grow.
> > > I tried to implement some kind of deferred dput'ing of the d_child's but that
> > > was too hackish and was wasting memory. So the best thing I can do now is fail
> > > if someone wants to seek to an offset of an already unlinked file.
> > 
> > Does that mean that, to satisfy the standard, you'd have to allow the
> > seek, but return 0 bytes on further reads, as you're already at (or
> > beyond, whatever) EOF?
> 
> No. To satisfy the standard, it would be necessary to let the seek succeed and
> to return the already unlinked dentry or the next dentry (this is
> unspecified).

Do you have a link to the standard?  Iirc, it is explicitly
unspecified whether files created/deleted after opendir/rewinddir are
returned.  Why do you want to return one such unspecified file now?
Especially when the implementation is ugly and the whole concept
appears to be plain stupid.

> I think we should return the next dentry, therefore I let the
> seek fail (seekdir() doesn't even have a return value) and the cursor/f_pos is
> still at the old offset.
> 
> The real problem is this IMHO:
> ...
> telldir() = a
> ...
> telldir() = b
> readdir() = foo.txt
> unlink(foo.txt)
> seekdir(a)
> seekdir(b)
> readdir() = ???
> 
> With my patch the seekdir(b) doesn't find the offset and is placing the cursor
> at the end of the directory. In my understanding of the SuSV3 this should be
> possible and should return either "foo.txt" or the next entry after
> "foo.txt". I don't see any chance how I can implement that.

Does the above really happen, or is this just a theoretical case?  At
least it looks as if ext3 with dir_index will simply barf on it:
	/* Some one has messed with f_pos; reset the world */
	if (info->last_pos != filp->f_pos) {
		...

And imo, that is the correct behaviour.  Anything else would leave the
door wide open for trivial DOS attacks on kernel memory.

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown
