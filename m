Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbWHUPSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbWHUPSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 11:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbWHUPSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 11:18:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64933 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030536AbWHUPSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 11:18:09 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0608212112350.28902@raven.themaw.net> 
References: <Pine.LNX.4.64.0608212112350.28902@raven.themaw.net>  <Pine.LNX.4.64.0608211932300.27275@raven.themaw.net> <Pine.LNX.4.64.0608202223220.29268@raven.themaw.net> <20060819094840.083026fd.akpm@osdl.org> <13319.1155744959@warthog.cambridge.redhat.com> <1155743399.5683.13.camel@localhost> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <5910.1155741329@warthog.cambridge.redhat.com> <2138.1155893924@warthog.cambridge.redhat.com> <3976.1156079732@warthog.cambridge.redhat.com> <30856.1156153373@warthog.cambridge.redhat.com> <323.1156162567@warthog.cambridge.redhat.com> 
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 21 Aug 2006 16:17:52 +0100
Message-ID: <15387.1156173472@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> > But does it _matter_ that the thing is mounted or dismounted as a unit?  And
> > if so, why?
> 
> Yes with autofs version 4, because of the nesting of mounts which also 
> introduces issues with expiration.

The NFS client's automounting facilities handle automatic expiration and
implicit recursive unmounting of xdev submounts.

For example, on my test machine:

	[root@andromeda ~]# /root/mount warthog:/ /warthog -o fsc
	[root@andromeda ~]# ls /warthog/warthog
	[root@andromeda ~]# cat /proc/mounts 
	...
	warthog:/ /warthog nfs rw,vers=3,rsize=32768,wsize=32768,hard,fsc,proto=tcp,timeo=600,retrans=2,sec=sys,addr=warthog 0 0
	warthog:/warthog /warthog/warthog nfs rw,vers=3,rsize=32768,wsize=32768,hard,fsc,proto=tcp,timeo=600,retrans=2,sec=sys,addr=warthog 0 0
	[root@andromeda ~]# umount /warthog/
	[root@andromeda ~]# 

The "ls" command caused the client to mount warthog:/warthog off of the server
onto /warthog/warthog automatically.  I was then able to just unmount
/warthog, which took away /warthog/warthog also without me having to do
anything special.

> In version 5 they are mounted and umounted on demand.

This should now be left to the NFS client.

The NFS client now views each set of files with the same FSID as a separate
collection of files, and accords each set its own superblock.  The superblocks
thus created are automounted by the follow_link() op on the directory that's
at the point of FSID-change.

Note!  This works for NFS2, NFS3 and NFS4.  NFS4 has an extra facility by
which mounts can cross servers, but that uses more or less the same mechanism.

> > > In v4 that are mounted and umounted as a unit to deal with the nesting.
> > 
> > Why does the automounter daemon have to do the mounting of submounts?
> > What's wrong with having the kernel do it?  The one problem with having
> > the kernel do it that I can see, is that the kernel doesn't update
> > /etc/mtab.
> 
> v2 and v3 won't do the expire, will they?

Yes.  Automounting and auto-expiration both.

> Not updating the mtab will be a problem for me also and possibly for 
> users that expect to see mounts in it.

ln -sf /proc/mounts /etc/mtab

> The "/net" functionality is a standard, expected automounter function.

Whilst that may be true, it doesn't prohibit working with the NFS clients
automounting capabilities.

> > Note that rather than manually mounting the submounts, you could just open
> > and close those directories as that should cause them to automount -
> > though the xdev mountpoints will expire and become automatically unmounted
> > after a certain period.
> 
> The xdev (assume you mean NFSv4 submounts) mounts will be the area I need 
> to work on, for sure.

I mean NFSv2, NFSv3 and NFSv4 submounts that cross FSID, but remain on the
same server.

> I don't quite understand the "open will cause the automount" for NFS 
> version < 4.

Opening the directory will cause its follow_link() op to be invoked, which
will cause an automount if one hasn't already happened.  Obviously, if the
automount has taken place, the lower directory won't be seen for the follow to
take place.

> The automounter calls mount(8) when it gets a packet from the 
> autofs[4] kernel module due to an access.

The automounter must mount the root of any tree, yes; but xdev subtrees should
now be left to the NFS client to mount, which can be triggered by stat'ing the
mountpoint - admittedly, if you can reach it without a security error.

If you do get a security error, and attempt to build the directories anyway,
you run the risk of constructing a false image of the remote share as you
can't tell symlinks from directories, and run the risk of creating invalid
dentries locally because you can't determine the attributes of the remote
object.

> I expect that I won't have to do much at all for xdev mounts except to be 
> able to recoginize them and their owners so I can leave them alone. The 
> expire function might be a bit interesting.

They're self-expiring.  And, as I mentioned above, you only need to unmount
the root to dispose of the entire tree.

David
