Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269760AbUHZW6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269760AbUHZW6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbUHZW5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:57:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55936 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269760AbUHZWxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:53:09 -0400
Date: Thu, 26 Aug 2004 23:53:08 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: [some sanity for a change] possible design issues for hybrids
Message-ID: <20040826225308.GC21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org> <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk> <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org> <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org> <20040826223625.GB21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261538030.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261538030.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 03:45:09PM -0700, Linus Torvalds wrote:
> No, lookup would just return the dentry, but the dentry would already be 
> filled in with the mount-point information.
> 
> And you can do that with a simple vfs helper function, ie the filesystem 
> itself would just need to do
> 
> 	pseudo_mount(dentry, inode);
> 
> thing - which just fills in dentry->d_mountpoint with a new vfsmount
> thing. It would allocate a new root dentry (for the pseudo-mount) and a
> new vfsmount, and make dentry->d_mountpoint point to it.

What dentry->d_mountpoint?  No such thing...

Note that we can't get vfsmount by dentry - that's the point of having these
guys in the first place.  So I'm not sure what you are trying to do here -
dentry + inode is definitely not enough to attach any vfsmounts anywhere.

That's not about namespaces - same fs mounted in several places will give
the same problem - one dentry, many vfsmounts.  And we obviously *can't*
have one vfsmount for all of them - if the same fs is mounted on /foo and
/bar, we will have the same dentry for /foo/splat and /bar/splat.  So
what should we get for /foo/splat/. and /bar/splat/.?  Same dentry *and*
same vfsmount?  I'd expect .. from the former to give /foo and from the
latter - /bar...
