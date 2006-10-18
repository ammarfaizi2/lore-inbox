Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWJRPNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWJRPNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWJRPNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:13:23 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:7401 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1161162AbWJRPNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:13:20 -0400
Date: Wed, 18 Oct 2006 09:13:19 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061018151319.GQ22289@parisc-linux.org>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 08:04:24AM -0700, Linus Torvalds wrote:
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

For this one, I see a third way:

#define lock_super(sb) do {		\
	get_fs_excl();			\
	mutex_lock(&(sb)->s_lock);	\
} while (0)

It does have the disadvantage that you can pass *anything* that has
an s_lock field in ... but I don't think that's a very likely thing
to happen.

Or you could use _sb as the local variable, since it's a reserved
identifier.
