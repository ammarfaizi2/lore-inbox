Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422630AbWJRQGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWJRQGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422628AbWJRQGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:06:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:10926 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161225AbWJRQGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:06:10 -0400
Date: Wed, 18 Oct 2006 17:06:09 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061018160609.GO29920@ftp.linux.org.uk>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 08:04:24AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 18 Oct 2006, Al Viro wrote:
> >
> > +#define lock_super(x) do {		\
> > +	struct super_block *sb = x;	\
> > +	get_fs_excl();			\
> > +	mutex_lock(&sb->s_lock);	\
> > +} while(0)
> 
> Don't do this. The "x" passed in may be "sb", and then you end up with 
> bogus code.

*duh*
 
> I think the solution to these kinds of things is either
>  - just bite the bullet, and make it out-of-line. A function call isn't 
>    that expensive, and is sometimes actually cheaper due to I$ issues.
>  - have a separate trivial header file, and only include it for people who 
>    actually need these things (very few files, actually - it's usually 
>    just one file per filesystem)
> 
> In this case, since it's _so_ simple, and since it's _so_ specialized, I 
> think #2 is the right one. Normally, uninlining would be.

Actually, after reading that code I suspect that get_fs_excl() in there
is the wrong thing to do.  Why?  Because the logics is all wrong.

Look what we do under lock_super().  There are two things: ->remount_fs()
and ->write_super().  Plus whatever low-level filesystems are using
lock_super() for.

I would argue that we want to move get_fs_excl() down to the places in
->write_super() that actually want to do something deserving it.  And
to be honest, I'm not at all sure that lock_super() should survive
at upper layers, but that's a longer story...
