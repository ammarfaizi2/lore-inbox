Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVAYT5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVAYT5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVAYT5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:57:36 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:63392 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262089AbVAYTta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:49:30 -0500
Subject: Re: [patch 1/13] Qsort
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, Andi Kleen <ak@muc.de>,
       Nathan Scott <nathans@sgi.com>,
       Mike Waychison <Michael.Waychison@sun.com>,
       Jesper Juhl <juhl-lkml@dif.dk>, Felipe Alfaro Solana <lkml@mac.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Buck Huppmann <buchk@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Tim Hockin <thockin@hockin.org>
In-Reply-To: <1106681637.11449.101.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <41F570F3.3020306@sun.com> <20050125065157.GA8297@muc.de>
	 <200501251112.46476.agruen@suse.de> <20050125120023.GA8067@muc.de>
	 <20050125120507.GH19199@suse.de>
	 <1106671920.11449.11.camel@lade.trondhjem.org>
	 <1106672028.9607.33.camel@winden.suse.de>
	 <1106672637.11449.24.camel@lade.trondhjem.org>
	 <1106673415.9607.36.camel@winden.suse.de>
	 <1106674620.11449.43.camel@lade.trondhjem.org>
	 <1106676722.9607.61.camel@winden.suse.de>
	 <1106681637.11449.101.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106682566.9607.73.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 Jan 2005 20:49:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 20:33, Trond Myklebust wrote:
> ty den 25.01.2005 Klokka 19:12 (+0100) skreiv Andreas Gruenbacher:
> 
> > Ah, I see now what you mean. The setxattr syscall only accepts
> > well-formed acls (that is, sorted plus a few other restrictions), and
> > user-space is expected to take care of that. In turn, getxattr returns
> > only well-formed acls. We could lift that guarantee specifically for
> > nfs, but I don't think it would be a good idea.
> 
> Note that if you really want to add a qsort to the kernel you might as
> well drop the setxattr sorting requirement too. If the kernel can qsort
> for getxattr, then might as well do it for the case of setxattr too.

There is no need to sort anything in the kernel for acls except for the
NFSACL case, so that's where we need it, and nowhere else. What would be
the point in making setxattr accept unsorted acls? It's just not
necessary; userspace can do it just as well.

> > Entry order in POSIX acls doesn't convey a meaning by the way.
> 
> Precisely. Are there really any existing programs out there that are
> using the raw xattr output and making assumptions about entry order?

I don't know. Anyway, it's a nice feature to have a unique canonical
form.

> > The server must have sorted lists.
> 
> So, I realize that the on-disk format is already defined, but looking at
> routines like posix_acl_permission(), it looks like the only order the
> kernel (at least) actually cares about is that of the "e_tag" field.
> Unless I missed something, nothing there cares about the order of the
> "e_id" fields.

Correct. But posix_acl_valid() does care about the i_id order as well.

> Given that you only have 6 possible values there, it seems a shame in
> hindsight that we didn't choose to just use a 6 bucket hashtable (the
> value of e_id being the hash value), and leave the order of the e_id
> fields undefined. 8-(

Checking for duplicate e_id fields would become expensive. I really
don't see any benefit.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

