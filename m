Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTFIPjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTFIPjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:39:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15368 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264478AbTFIPjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:39:46 -0400
Date: Mon, 9 Jun 2003 08:53:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Frank Cusack <fcusack@fcusack.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number
 mismatch)
In-Reply-To: <20030609065141.A9781@google.com>
Message-ID: <Pine.LNX.4.44.0306090848080.12683-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good job.

On Mon, 9 Jun 2003, Frank Cusack wrote:
> 
> 1) Don't unhash the dentry after silly-renaming.  In 2.2, each fs is
>    responsible for doing a d_delete(), in 2.4 it happens in the VFS and
>    I think it was just an oversight that the 2.4 VFS doesn't consider
>    sillyrename (considering the code and comments that are cruft).
> 
>    This preserves the unlinked-but-open semantic, but breaks rmdir.  So
>    it's not a clear winner from a semantics POV.  dentry->d_count is
>    always correct, which sounds like a plus.
> 
>    The patch to make this work is utterly simple, which is a big plus.

I think your #1 is "obviously correct", but the fact that it breaks rmdir 
sounds like a bummer. However, since it only breaks rmdir when 
silly-renames exist - and since silly-renames should only happen when you 
have a file descriptor still open - I'd be inclined to say that this is 
the right behaviour.

> 2b) Since this is really only a problem when the parent dir goes away,
>     do the same as above but only scan the queue in nfs_rmdir(), and
>     mark any entries whose d_parent is "us".
> 
>     I've included this in favor of (2a) because it's simpler and should
>     give better performance in the common case.

This sounds like a hack, even if it happens to work.

I dunno. I'm personally inclined to prefer (1), since that seems to just
fix a bug in the VFS layer and doesn't introduce any conceptual
complexity. But I think I'd let Trond make the final decision, I don't 
hate (2b) enough to say "over my dead body!".

Trond?

		Linus

