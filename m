Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVGDKLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVGDKLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVGDKLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:11:25 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:41145 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261613AbVGDJ7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 05:59:17 -0400
Date: Mon, 4 Jul 2005 11:59:14 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging? (2)
Message-ID: <20050704095914.GA6949@janus>
References: <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu> <20050703112541.GA32288@janus> <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu> <20050703141028.GB1298@janus> <E1Dp6hK-00056d-00@dorka.pomaz.szeredi.hu> <20050703193619.GA2928@janus> <E1DpMkg-00064O-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DpMkg-00064O-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 10:56:30AM +0200, Miklos Szeredi wrote:
> > It is important because on UNIX, "root" rules on local filesystems.
> > I dont't like the idea of root not being able to run "find -xdev"
> > anymore for administrative tasks, just because something got hidden
> > by accident or just for fun by a user.  It's not about malicious
> > users who want to hide data: they can do that in tons of ways.
> 
> That's a sort of security by obscurity: if the user is dumb enough he
> cannot do any harm.  But I'm not interested in that sort of thing.  If
> this issue important, then it should be solved properly, and not just
> by "preventing accidents".

"solving it properly" refers to hardening the leaf node constraint
against circumvention I assume. Suppose there's a script for doing simple
on-line backups using "find". Now explain to the user why he lost his
data due to a backup script geting EACCES on a non-leaf FUSE mount. I
don't think that's acceptable. On the other hand, when the user stored
something _deliberately_ under a mountpoint, circumventing the leaf node
constraint by some trickery then it is clearly his own fault when the data
is lost. Anyway, a leaf node constraint can be hardened against misuse
later on, should it become necessary. Your bind-mount case to circumvent
this restriction is slightly flawed because it requires root interaction.

> 
> There's a nice solution to this (discussed at length earlier): private
> namespaces.

I thought that's rejected because a process doesn't automatically get the
right namespace after rsh into such a machine? And fixing it by adjusting
the name-space of a process (by whatever means) is not transparent.

> I think we are still confusing these two issues, which are in fact
> separate.
> 
>   1) polluting global namespace is bad (find -xdev issue)
> 
>   2) not ptraceable (or not killable) processes should not be able to
>      access an unprivileged mount
> 
> For 1) private namespaces are the proper solution.  For 2) the
> fuse_allow_task() in it's current or modified form (to check
> killability) should be OK.
> 
> 1) is completely orthogonal to FUSE.  2) is currently provably secure,
> and doesn't seem cause problems in practice.  Do you have a concrete
> example, where it would cause problems?

See above backup scenario.

Issues (1) and (2) are tied together I'm afraid:

When using a private name-space and thus assuming an unrelated process
needs to do something very special to get that name-space then (2)
would not be needed at all.

On the other hand, Name-space inheritance by setuid processes suddenly
becomes an issue: issue (2) is re-appearing but at another place.

-- 
Frank
