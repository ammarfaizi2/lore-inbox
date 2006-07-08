Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWGHRVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWGHRVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWGHRVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:21:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34223 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964909AbWGHRVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:21:24 -0400
Date: Sat, 8 Jul 2006 18:21:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Quigley <dpquigl@tycho.nsa.gov>
Cc: Christoph Hellwig <hch@infradead.org>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Message-ID: <20060708172120.GB27058@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Quigley <dpquigl@tycho.nsa.gov>,
	Phillip Hellewell <phillip@hellewell.homeip.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060513033742.GA18598@hellewell.homeip.net> <20060520095740.GA12237@infradead.org> <20060707115422.GA4705@infradead.org> <1152292929.3727.23.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152292929.3727.23.camel@moss-terrapins.epoch.ncsc.mil>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 01:22:09PM -0400, David Quigley wrote:
> This is actually an interesting thing. Due to certain issues, stackable
> file systems normally do not allow people to modify the lower level
> files from under the mounted stackable filesystem. Ideally you want to
> be able to view a stack and make changes at each level. This is possible
> but not without some changes to the kernel. If we go with the statement
> that you should not modify lower level files except through eCryptfs
> (which seams reasonable since its an encryption file system) then this
> is not needed. We do not need to pass the lock down to the lower file
> system since locking the upper level file is more than adequate. If we
> decide to make the changes to the kernel to allow for modifications at
> each layer of a stack then we do need this.

Getting locking right if you want to allow access from above and below
the stackable filesystems will be a pain.  Note that I can't see any
way to exclude direct access to the underlying filesystem in ecryptfs.

> > And a more general issue with implementing stackable filesystems:
> > 
> >   I think it's probably much better to not stack ontop of a part of the
> >   existing namespace but rather let ecryptfs mount the underlying filesystem
> >   internally using vfs_kern_mount.  This gets out of the way of possible
> >   lock order problems when doing namespace operation involving both the
> >   stacked and underlying filesystem aswell as allowing using a stackable
> >   filesystem as the root filesystem.
> > 
> 
> Could you actually explain this with an example? If it is what I think
> you mean then we did look into this and we had some concerns with it
> however I'll make sure its the same before we delve into it.

I don't think there's too much of example for the behaviour I want.

But lets explain it a little better:

 - The idea is to avoid having the underlying filesystem mounted in any
   public namespace.

 - Linux has the concept of mount points that only the kernel can use and
   that aren't visible to any public namespace.  They can be created using
   the *kern_mount family of APIs.

 - I suggest to use this API to mount the underlying filesystems from
   ecryptfs.  It will have a reference to the vfsmount * and thus all
   important data for the underlying filesystem.  Because it is the only
   user of that filesystem locking and other operations get a lot simpler.
