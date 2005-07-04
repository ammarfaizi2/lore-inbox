Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVGDK3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVGDK3S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVGDK3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:29:17 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:7178 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261612AbVGDK2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:28:08 -0400
To: frankvm@frankvm.com
CC: miklos@szeredi.hu, frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk,
       arjan@infradead.org, linux-kernel@vger.kernel.org
In-reply-to: <20050704095914.GA6949@janus> (message from Frank van Maarseveen
	on Mon, 4 Jul 2005 11:59:14 +0200)
Subject: Re: FUSE merging? (2)
References: <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu> <20050703112541.GA32288@janus> <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu> <20050703141028.GB1298@janus> <E1Dp6hK-00056d-00@dorka.pomaz.szeredi.hu> <20050703193619.GA2928@janus> <E1DpMkg-00064O-00@dorka.pomaz.szeredi.hu> <20050704095914.GA6949@janus>
Message-Id: <E1DpOAT-00069p-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 04 Jul 2005 12:27:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "solving it properly" refers to hardening the leaf node constraint
> against circumvention I assume. Suppose there's a script for doing simple
> on-line backups using "find". Now explain to the user why he lost his
> data due to a backup script geting EACCES on a non-leaf FUSE mount.

I see your point.  But then this is really not a security issue, but
an "are you sure you want to format C:" style protection for the
user's own sake.  Adding a mount option (checked by the library) for
this would be fine.  E.g. with "mount_nonempty" it would not refuse to
mount on a non-leaf dir, and README would document, that using this
option might cause trouble.  Otherwise the mount would be refused with
a reference to the above option.

Is that what you were thinking?

> > There's a nice solution to this (discussed at length earlier): private
> > namespaces.
> 
> I thought that's rejected because a process doesn't automatically get the
> right namespace after rsh into such a machine? And fixing it by adjusting
> the name-space of a process (by whatever means) is not transparent.

Private namespaces in their current form are not really useful.  But
that's irrelevant to the current discussion.  If somebody needs
private namespaces they will have to add the missing features (Ram Pai
is working on shared subtrees, the biggest chunk).

> > I think we are still confusing these two issues, which are in fact
> > separate.
> > 
> >   1) polluting global namespace is bad (find -xdev issue)
> > 
> >   2) not ptraceable (or not killable) processes should not be able to
> >      access an unprivileged mount
> > 
> > For 1) private namespaces are the proper solution.  For 2) the
> > fuse_allow_task() in it's current or modified form (to check
> > killability) should be OK.
> > 
> > 1) is completely orthogonal to FUSE.  2) is currently provably secure,
> > and doesn't seem cause problems in practice.  Do you have a concrete
> > example, where it would cause problems?
> 
> See above backup scenario.

The backup problem is a consequence of 1).  It has absolutely zero to
do with 2).  If the fuse_allow_task() security check didn't exist the
backup script would still not work.

> Issues (1) and (2) are tied together I'm afraid:
> 
> When using a private name-space and thus assuming an unrelated process
> needs to do something very special to get that name-space then (2)
> would not be needed at all.

Wrong.  It's still needed, because suid/sgid programs can

  - run under the private namespace without doing anything special

  - run with extra privileges, not possesed by the user executing the
    program

> On the other hand, Name-space inheritance by setuid processes suddenly
> becomes an issue: issue (2) is re-appearing but at another place.

I don't think you could change the rules of namespace inheritence,
without causing trouble.

Miklos
