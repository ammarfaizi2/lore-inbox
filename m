Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVIRRSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVIRRSs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 13:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVIRRSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 13:18:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42950 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932124AbVIRRSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 13:18:47 -0400
Date: Sun, 18 Sep 2005 18:18:45 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918171845.GL19626@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918165219.GA595@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 06:52:19PM +0200, Willy Tarreau wrote:
> know anybody who does kmalloc(sizeof(int)) nor kmalloc(sizeof(char)), but
> with memset, it's different. Doing memset(p, 0, sizeof(*p)) seems better
> to me than memset(p, 0, sizeof(short)), and represents a smaller risk
> when 'p' will silently evolve to a long int.

That's why you do
	*p = (struct foo){....};
instead of
	memset(p, 0, sizeof...);
	p->... =...;

Note that in a lot of cases your memset(p, 0, sizeof(*p)) is actually wrong -
e.g. when you've allocated a struct + some array just past it.

Oh, and in your case above...  *p = 0; is certainly saner than that memset(),
TYVM ;-)

I'm serious about compound literals instead of memset() - they give sane
typechecking for free and give compiler a chance for saner optimizations.
And no, it's not a gcc-ism - it's valid C99.
