Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269827AbUH0AGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269827AbUH0AGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269823AbUH0AGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:06:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:43710 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269705AbUHZX7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:59:30 -0400
Date: Thu, 26 Aug 2004 16:57:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: [some sanity for a change] possible design issues for hybrids
In-Reply-To: <20040826234048.GD21964@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408261652240.2304@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org>
 <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk>
 <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org>
 <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org>
 <20040826223625.GB21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408261538030.2304@ppc970.osdl.org>
 <20040826225308.GC21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408261619230.2304@ppc970.osdl.org>
 <20040826234048.GD21964@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Thu, Aug 26, 2004 at 04:24:51PM -0700, Linus Torvalds wrote:
> > So basically: the "d_mounted++" just makes sure we get into
> > "lookup_mnt()". That's where we will usually find the actual mount thing.
> > 
> > And that's also where the special case comes in: if we _don't_ find the 
> > mount thing there, that's where we need to create it. That will only 
> > happen if somebody looks it up using another namespace, though, so it 
> > should be rare.
> 
> No.  Trivial example:
> 
> mount --bind /foo /bar
> mount /dev/sda1 /bar/baz
> 
> do lookup for /foo/baz.  No namespaces involved, no vfsmounts found, d_mounted
> positive and we certainly do *not* want anything to be created at that point.

Right. We obviously need to mark the dentry somehow, and only do the 
"create vfsmount" special case in this special case. If we didn't do that, 
then it wouldn't be a special case, now would it?

So clearly lookup_mnt() needs to check the dentry in the failure case. The 
marking could be in any of three places
 - mark the dentry itself by just using a dentry flag ("DCACHE_AUTOVFSMNT")
   or by having a dentry operation for this.
 - mark the inode itself (same logic as dentry)
 - look up the first vfsmount (on the inode list), and look if that one is 
   of the automatic type.

Clearly we should not _always_ create a vfsmount, that would just break 
the existign logic.

		Linus
