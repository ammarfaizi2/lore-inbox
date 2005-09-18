Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVIRQwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVIRQwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 12:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVIRQwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 12:52:37 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:15108 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751231AbVIRQwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 12:52:36 -0400
Date: Sun, 18 Sep 2005 18:52:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Robert Love <rml@novell.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918165219.GA595@alpha.home.local>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127061146.6939.6.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127061146.6939.6.camel@phantasy>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 12:32:26PM -0400, Robert Love wrote:
> On Sun, 2005-09-18 at 11:06 +0100, Russell King wrote:
> 
> > +The preferred form for passing a size of a struct is the following:
> > +
> > +       p = kmalloc(sizeof(*p), ...);
> > +
> > +The alternative form where struct name is spelled out hurts readability and
> > +introduces an opportunity for a bug when the pointer variable type is changed
> > +but the corresponding sizeof that is passed to a memory allocator is not.
> 
> Agreed.
> 
> Also, after Alan's #4:
> 
> 5.  Contrary to the above statement, such coding style does not help,
>     but in fact hurts, readability.  How on Earth is sizeof(*p) more
>     readable and information-rich than sizeof(struct foo)?  It looks
>     like the remains of a 5,000 year old wolverine's spleen and
>     conveys no information about the type of the object that is being
>     created.
> 
> 	Robert Love

To be honnest, before reading this thread, I would have voted for the
sizeof(*p). However, I completely agree that there is a high risk of
messing up the initialization, and that structures don't change often.
The situations where I think that sizeof(*p) is better than
sizeof(struct foo) is more on functions such as memset() than {,k}malloc() :
forgetting to initialize a struct member is always a high risk, but if the
object is not a struct (eg, a scalar), then it could be tolerated. I don't
know anybody who does kmalloc(sizeof(int)) nor kmalloc(sizeof(char)), but
with memset, it's different. Doing memset(p, 0, sizeof(*p)) seems better
to me than memset(p, 0, sizeof(short)), and represents a smaller risk
when 'p' will silently evolve to a long int.

Last, there's little probability that a scalar will evolve into a struct
without code modifications, while it has happened often that a __u8 or
__u16 was changed to __u32. So perhaps we could accept use of sizeof(*p)
when (*p) is a scalar to protect against silent type changes, and reject
it when (*p) is a structure to avoid incomplete initialization ?

Alan, I like your proposal BTW ;-)

Regards,
Willy

