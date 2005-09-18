Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVIRTHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVIRTHU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 15:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVIRTHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 15:07:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28544 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751311AbVIRTHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 15:07:19 -0400
Date: Sun, 18 Sep 2005 20:07:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Willy Tarreau <willy@w.ods.org>, Robert Love <rml@novell.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918190714.GO19626@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local> <20050918171845.GL19626@ftp.linux.org.uk> <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 10:31:36AM -0700, Linus Torvalds wrote:
> Last I looked, depending on what the initializer was, gcc would create a 
> temporary struct on the stack first, and then do a "memcpy()" of the 
> result. Not only does that obviously generate a lot of extra code, it also 
> blows your kernel stack to kingdom come.
> 
> So be careful out there, and check what code it generates first. With at 
> least a few versions of gcc.

BTW, one very useful thing we could do in sparse would be an attribute for
a struct that would generate a warning whenever sizeof is calculated - i.e.
catch the
	pointer arithmetics on pointers to these suckers
	sizeof(expression having such type)
	variable of such type (as opposed to pointers to such type)
	composite types containing elements of such type
with new primitive (#defined to sizeof if __CHECKER__ is not defined)
that would act as sizeof, but without a warning.  Optionally, we might
want assignments, passing as argument and conversion of pointers to
such beasts down to void * generate the same warnings.

It would be very useful when e.g. tracking down improper uses of
struct file, struct dentry, etc. - stuff that should always be
allocated by one helper function.  Same goes for e.g. net_device -
conversion to dynamic allocation involved doing what I've described
above manually (i.e. creative uses of grep).  If we had sparse
working on the entire tree back then and could do that sort of
checks, it would have saved a lot of PITA...

It shouldn't be hard to implement, AFAICS; I'll try to put together
something of that kind.
