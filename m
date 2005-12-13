Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVLMXFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVLMXFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVLMXFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:05:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53954 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932392AbVLMXFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:05:47 -0500
Date: Tue, 13 Dec 2005 23:05:36 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, dhowells@redhat.com, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       rth@redhat.com
Subject: Re: Using C99 in the kernel was Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213230536.GQ27946@ftp.linux.org.uk>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <Pine.LNX.4.64.0512130812020.15597@g5.osdl.org> <20051213215610.GX23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213215610.GX23384@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 10:56:10PM +0100, Andi Kleen wrote:
> It looks like casts in constant initializers for global structures are not 
> allowed anymore: struct foo x = (struct foo) { ... }; warns.  That's
> not good because when the (struct foo){} is generated in a macro
> then it's the only easy way to allow initialization outside a declaration.
> 
> Common case is SPIN_LOCK_UNLOCKED() / DEFINE_SPINLOCK().

There are two similar things - struct initializers and compound literals.
They are *not* the same, though; compound literal defines an unnamed
object, so
{
	struct foo x = (struct foo){...};

is equivalent to
	struct foo unnamed_variable = {....};
	struct foo x = unnamed_variable;

For auto variables it's fine; there initializer doesn't have to be
constant.  For globals it's _not_.

Note that it's really a definition of object - e.. you can say
	f(&(struct foo){....});
and have it work just fine.

IOW, DEFINE_SPINLOCK() should be spinlock_t x = __SPIN_LOCK_UNLOCKED()
and SPIN_LOCK_UNLOCKED - (spinlock_t) __SPIN_LOCK_UNLOCKED.  That's
enough to make it valid C99...
