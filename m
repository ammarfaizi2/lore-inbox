Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVIRUfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVIRUfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 16:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVIRUfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 16:35:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:34455 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932189AbVIRUfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 16:35:01 -0400
Date: Sun, 18 Sep 2005 22:34:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, Willy Tarreau <willy@w.ods.org>,
       Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
In-Reply-To: <20050918174549.GN19626@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0509182222030.3743@scrub.home>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
 <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local>
 <20050918171845.GL19626@ftp.linux.org.uk> <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org>
 <20050918174549.GN19626@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 18 Sep 2005, Al Viro wrote:

> > On Sun, 18 Sep 2005, Al Viro wrote:
> > > 
> > > That's why you do
> > > 	*p = (struct foo){....};
> > > instead of
> > > 	memset(p, 0, sizeof...);
> > > 	p->... =...;
> > 
> > Actually, some day that migth be a good idea, but at least historically, 
> > gcc has really really messed that kind of code up.
> > 
> > Last I looked, depending on what the initializer was, gcc would create a 
> > temporary struct on the stack first, and then do a "memcpy()" of the 
> > result. Not only does that obviously generate a lot of extra code, it also 
> > blows your kernel stack to kingdom come.
> 
> Ewwwww...  I'd say that it qualifies as one hell of a bug (and yes, at least
> 3.3 and 4.0.1 are still doing that).  What a mess...

It's not a bug, it's exactly what you're asking for, e.g. "*p1 = *p2" 
translates to memcpy. gcc also can't simply initialize that structure in 
place, e.g. you could do something like this (not necessarily useful but 
still valid): "*p = (struct foo){...,  bar(p),...};".
In the end it all depends on how good gcc can optimize away the memcpy, 
but initially there is always a memcpy.

bye, Roman
