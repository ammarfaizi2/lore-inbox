Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWHVCFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWHVCFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 22:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWHVCFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 22:05:19 -0400
Received: from mail.dotsterhost.com ([72.5.54.21]:58021 "HELO
	mail.dotsterhost.com") by vger.kernel.org with SMTP
	id S1751119AbWHVCFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 22:05:17 -0400
Date: Tue, 22 Aug 2006 10:04:03 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list
 [try #2]
In-Reply-To: <15387.1156173472@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0608220953090.3315@raven.themaw.net>
References: <Pine.LNX.4.64.0608212112350.28902@raven.themaw.net> 
 <Pine.LNX.4.64.0608211932300.27275@raven.themaw.net>
 <Pine.LNX.4.64.0608202223220.29268@raven.themaw.net> <20060819094840.083026fd.akpm@osdl.org>
 <13319.1155744959@warthog.cambridge.redhat.com> <1155743399.5683.13.camel@localhost>
 <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org>
 <5910.1155741329@warthog.cambridge.redhat.com> <2138.1155893924@warthog.cambridge.redhat.com>
 <3976.1156079732@warthog.cambridge.redhat.com> <30856.1156153373@warthog.cambridge.redhat.com>
 <323.1156162567@warthog.cambridge.redhat.com>  <15387.1156173472@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006, David Howells wrote:

OK. I think I get it now.
Thanks for your patience.

> Ian Kent <raven@themaw.net> wrote:
> 
> > > But does it _matter_ that the thing is mounted or dismounted as a unit?  And
> > > if so, why?
> > 
> > Yes with autofs version 4, because of the nesting of mounts which also 
> > introduces issues with expiration.
> 
> The NFS client's automounting facilities handle automatic expiration and
> implicit recursive unmounting of xdev submounts.

Very cool.

I guess I'm not concerned about what the expire timeout is for such trees 
either as it's not my problem.

I'll have to play around with these a bit to work out how I can recognize 
them in the export list. Hopefully it will be straight forward.

> 
> This should now be left to the NFS client.

Yep.

> 
> > Not updating the mtab will be a problem for me also and possibly for 
> > users that expect to see mounts in it.
> 
> ln -sf /proc/mounts /etc/mtab
> 
> > The "/net" functionality is a standard, expected automounter function.
> 
> Whilst that may be true, it doesn't prohibit working with the NFS clients
> automounting capabilities.

Yep.

Again, not my problem if I treat fsid filesets as the automount unit.

> 
> > > Note that rather than manually mounting the submounts, you could just open
> > > and close those directories as that should cause them to automount -
> > > though the xdev mountpoints will expire and become automatically unmounted
> > > after a certain period.
> > 
> > The xdev (assume you mean NFSv4 submounts) mounts will be the area I need 
> > to work on, for sure.
> 
> I mean NFSv2, NFSv3 and NFSv4 submounts that cross FSID, but remain on the
> same server.
> 
> > I don't quite understand the "open will cause the automount" for NFS 
> > version < 4.
> 
> Opening the directory will cause its follow_link() op to be invoked, which
> will cause an automount if one hasn't already happened.  Obviously, if the
> automount has taken place, the lower directory won't be seen for the follow to
> take place.

Yep. But also not my problem as user activity will make this happen 
automagically.

> 
> > The automounter calls mount(8) when it gets a packet from the 
> > autofs[4] kernel module due to an access.
> 
> The automounter must mount the root of any tree, yes; but xdev subtrees should
> now be left to the NFS client to mount, which can be triggered by stat'ing the
> mountpoint - admittedly, if you can reach it without a security error.
> 
> If you do get a security error, and attempt to build the directories anyway,
> you run the risk of constructing a false image of the remote share as you
> can't tell symlinks from directories, and run the risk of creating invalid
> dentries locally because you can't determine the attributes of the remote
> object.

Yep. No use in stepping on NFSs toes when he just wants to make my life 
easier for me.

Ian

