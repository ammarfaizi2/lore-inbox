Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVAYSML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVAYSML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVAYSML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:12:11 -0500
Received: from ns.suse.de ([195.135.220.2]:13235 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262042AbVAYSME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:12:04 -0500
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
In-Reply-To: <1106674620.11449.43.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <41F570F3.3020306@sun.com> <20050125065157.GA8297@muc.de>
	 <200501251112.46476.agruen@suse.de> <20050125120023.GA8067@muc.de>
	 <20050125120507.GH19199@suse.de>
	 <1106671920.11449.11.camel@lade.trondhjem.org>
	 <1106672028.9607.33.camel@winden.suse.de>
	 <1106672637.11449.24.camel@lade.trondhjem.org>
	 <1106673415.9607.36.camel@winden.suse.de>
	 <1106674620.11449.43.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106676722.9607.61.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 Jan 2005 19:12:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 18:37, Trond Myklebust wrote:
> ty den 25.01.2005 Klokka 18:16 (+0100) skreiv Andreas Gruenbacher:
> 
> > > Whatever Sun chooses to do or not do changes nothing to the question of
> > > why our client would want to do a quicksort in the kernel.
> > 
> > Well, it determines what we must accept, both on the server side and the
> > client side.
> 
> I can see why you might want it on the server side, but I repeat: why
> does the client need to do this in the kernel? The client code should
> not be overriding the server when it comes to what is acceptable or not
> acceptable. That's just wrong...

Ah, I see now what you mean. The setxattr syscall only accepts
well-formed acls (that is, sorted plus a few other restrictions), and
user-space is expected to take care of that. In turn, getxattr returns
only well-formed acls. We could lift that guarantee specifically for
nfs, but I don't think it would be a good idea. Entry order in POSIX
acls doesn't convey a meaning by the way, and the nfs client never
rejects what the server sends.

> I can also see that if the server _must_ have a sorted list, then doing
> a sort on the client is a good thing since it will cut down on the work
> that said server will need to do, and so it will scale better with the
> number of clients (though note that, conversely, this server will scale
> poorly with the Sun clients or others if they do not sort the lists).

The server must have sorted lists. Linux clients send well-formed acls
except when they fake up a mask entry; they insert the mask entry at the
end instead of in the right position (this is the three-entry acl
problem I described in [patch 0/13]). We could insert the mask in the
right position, but the protocol doesn't require it. We must sort on the
server anyway, and the server can as easily swap the two entries.

> I'm asking 'cos if the client doesn't need this code, then it seems to
> me you can move helper routines like the quicksort and posix checking
> routines into the nfsd module rather than having to keeping it in the
> VFS (unless you foresee that other modules will want to use the same
> routines???).

That would cause getxattr to return an "invalid" result. libacl doesn't
care, but other users might exist that rely on the current format. In
addition, comparing acls becomes non-trivial: currently xattr values are
equal iff acls are equal.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

