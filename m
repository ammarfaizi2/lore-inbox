Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVBAXi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVBAXi4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVBAXip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:38:45 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:16563 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262172AbVBAXhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:37:55 -0500
Date: Tue, 1 Feb 2005 18:37:54 -0500
To: Ram <linuxram@us.ibm.com>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050201233753.GB22118@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <20050116160213.GB13624@fieldses.org> <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050116184209.GD13624@fieldses.org> <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk> <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost> <41F6BE58.50208@sun.com> <1106690563.3298.43.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106690563.3298.43.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:02:43PM -0800, Ram wrote:
> oops. I had the following in mind.
> 
> 	mount <device1> /tmp/mnt1
>       **  mount --make-shared /tmp/mnt1  **
>         mkdir -p /tmp/mnt1/a/b
>         mount --rbind /tmp/mnt1 /tmp/mnt2
>         mount --make-slave /tmp/mnt2
> 
> In this case it cannot be EINVAL, because /tmp/mnt1 and /tmp/mnt2 will
> both be part of a pnode and hence /tmp/mnt2 can be demoted to be a
> slave. 
> > 
> > >         mount <device2> /tmp/mnt2/a
> > >         rm -f /tmp/mnt2/a/*
> > > 
> > >         what happens when a mount is attempted on /tmp/mnt1/a/b?
> > >         will that be reflected in /tmp/mnt2/a ?
> > > 
> > >         I believe the answer is 'no', because that part of the subtree 
> > >         in /tmp/mnt2 no more mirrors its parent subtree.

shared subtrees aside, it is the nature of --bind mounts that they share
all the same dentries; so the "rm -f" above will immediately be
reflected in all copies (with or without subtree sharing) and no mounts
will be possible on the (now absent) path a/b.

I think the question you meant to ask was what would happen if you
mounted something on /tmp/mnt2/a/b (the slave copy) and then mounted
something else on /tmp/mnt1/a/b.  In that case there's two places where
the propagated mount might go:
	1. On top of the dentry a/b in /tmp/mnt2, underneath the
	   preexisting mount.
	2. On top of the root dentry of the thing mounted in
	   /tmp/mnt2/a/b, thus covering the preexisting mount.

Wouldn't option 1 require changing the mnt_parent of the preexisting
mount on /tmp/mnt2/a/b?  That seems like an odd thing to do, so I assume
option 2 is the only possible solution, but perhaps I'm missing
something.

--b.
