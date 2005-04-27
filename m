Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVD0SJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVD0SJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVD0SJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:09:30 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:38821 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261892AbVD0SFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:05:34 -0400
To: mj@ucw.cz
CC: lmb@suse.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <20050427175425.GA4241@ucw.cz> (message from Martin Mares on Wed,
	27 Apr 2005 19:54:25 +0200)
Subject: Re: [PATCH] private mounts
References: <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de> <20050427164652.GA3129@ucw.cz> <E1DQqUi-0002Pt-00@dorka.pomaz.szeredi.hu> <20050427175425.GA4241@ucw.cz>
Message-Id: <E1DQquc-0002W6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 20:05:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is it possible to limit all these from kernelspace?  Probably yes,
> > although a timeout for operations is something that cuts either way.
> > And the compexity of these checks would probably be orders of
> > magnitude higher then the check we are currently discussing.
> 
> Yes ... but does the check we are discussing really solve the
> problem?
> 
> Let's say that you attempt to export home directories of users by a
> user-space NFS daemon. This daemon probably changes its fsuid to
> match the remote user, so the check happily accepts the access and
> the user is able to lock up the daemon.

Valid point.  The only defense is that when a program set's fsuid,
it's performing the operation "on behalf of the user".  So the user is
actually doing DoS against himself.

Of course this is not strictly true.  E.g. in the userspace NFS case
it's probably a DoS against all users of the mount.

> It doesn't seem that there is any simple and universal cure -- root
> programs or setuid programs altering their fsuid are just too
> similar to the real user programs to separate them cleanly.

Root programs setting fsuid are relatively rare, most are suid
programs originally started from the user (nfsd is an exception).

So yes the check fsuid is not the perfect solution.  However let me
remind you that neither is the one with private namespace.

> I see a lot of similarities with symlinks -- many programs also need
> to take extra care of symlinks to be safe. However, symlinks are
> already senior citizens of Unix systems and programs know how to
> cope with them since ages.
> 
> Maybe this could be taken advantage of by keeping all user mounts in
> a separate directory like /mnt/usr (and /mnt is very likely to be
> avoided by all programs traversing directory structure
> automatically) and symlinking from the requested mount points there
> (with symlinks naturally not followed by automatic traversals).

Maybe.  It would be trivial to add a config option to fuse.conf to
limit user mounts to some directory.

Thanks,
Miklos



