Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVEPN2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVEPN2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVEPN2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:28:11 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:59154 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261619AbVEPN2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:28:02 -0400
To: jamie@shareable.org
CC: linuxram@us.ibm.com, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20050516112648.GB21145@mail.shareable.org> (message from Jamie
	Lokier on Mon, 16 May 2005 12:26:48 +0100)
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
References: <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk> <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu> <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <E1DXbD5-0007UI-00@dorka.pomaz.szeredi.hu> <20050516112648.GB21145@mail.shareable.org>
Message-Id: <E1DXfZa-0007lS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 May 2005 15:23:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1) you need not recursively bind the whole tree of the private
> >    namespace.  In fact you can only do that by hand, since the kernel
> >    won't do it (!recurse || check_mnt(old_nd.mnt) in do_loopback).
> 
> That would be easy to change if it was desired though, by taking both
> namespace semaphores when two namespaces are involved.

Yes.

The other check_mnt() calls could be removed by taking
nd.mnt->mnt_namespace->sem instead of current->namespace->sem in the
relevant functions.

It does make sense IMO, even if it won't be used very often, since
only very little extra complexity is involved.

> > 4) in fact, the process in the originating namespace can single out a
> >    mount and just send a file descriptor refering to that mount
> >    (e.g. by binding it to a temporary directory, opening the root,
> >    detaching from the mountpoint, and then sending the file descriptor
> >    to the receiving process).  This way the receiving process will see
> >    no other mounts in the originating namespace, and can only bind
> >    from that single mount.
> 
> Nice.  The process in the originating namespace can also bind a small,
> carefully selected tree of mounts to a tree in that temporary
> directory before passing it, so the recipient can chroot/chdir into
> the set of mounts and get only those explicitly authorised by the
> originating process.

That won't work, since detach (umount -l) will break up the tree, and
the file descriptor will hold a reference to only one vfsmount/dentry.

Miklos
