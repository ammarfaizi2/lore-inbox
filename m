Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030584AbWHIImH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbWHIImH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbWHIImG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:42:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:1240 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030583AbWHIImD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:42:03 -0400
X-Authenticated: #271361
Date: Wed, 9 Aug 2006 10:41:55 +0200
From: Edgar Toernig <froese@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-Id: <20060809104155.48ad3c77.froese@gmx.de>
In-Reply-To: <1155040157.5729.34.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	<20060805122936.GC5417@ucw.cz>
	<20060807101745.61f21826.froese@gmx.de>
	<84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	<20060807224144.3bb64ac4.froese@gmx.de>
	<1155040157.5729.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> Ar Llu, 2006-08-07 am 22:41 +0200, ysgrifennodd Edgar Toernig:
> >
> > Your implementation is much cruder - it simply takes the fd
> > away from the app; any future use gives EBADF.  As a bonus,
> 
> It needs to give -ENXIO/0 as per BSD that much is clear.

Ah, OK.  And not to forget select/poll.  (What about SIGHUP?)
I'm not sure though, whether it's really necessary to allow the
owner of a file to revoke fds - I would feel better if only root
(or someone with the right caps) could revoke fds/mappings.

> To use revoke() I must own the file
> If I own the file I can make it a symlink to a pty/tty pair
> I can revoke a pty/tty pair

With the EIO/EOF behaviour that's not a problem - apps that deal
with ttys have to expect that condition.


> > A serious question: What do you need this feature of revoking
> > regular files (or block devices) for?  Maybe my imagination
> > is lacking, but I can't find a use where fuser(1) (or similar
> > tools) wouldn't be as good or even better than revoke(2).
> 
> On a typical non-SELinux system with a typical desktop configuration
> (SELinux can effectively replace revoke) you need revoke on block
> devices in order to guarantee security

Hmm... which apps have an open fd on block devices?  Usually a
filesystem is mounted on the device and then there are no fds
to the block-dev involved.  Or do you expect the "fuser -m"
behaviour from revoke?  Afaics, that's not the case at the moment.
Which users have perms to access a block-dev anyway?

> There are specific cases where being able to revoke access to one of
> your files is useful as well, particularly if you are moving it from
> open permissions to private permissions. That one is to be honest much
> less interesting and it is easy enough to make our revoke()
> implementation return -EINVAL.

Hmm... then use fuser and kill the process instead of silently taking
away fds and mappings.


My summary: revoke on chars devs with EIO/EOF behaviour is ok.
            revoke on blocks devs is questionable
            revoke on regular files is wrong.

Ciao, ET.
