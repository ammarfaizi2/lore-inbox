Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVDAHnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVDAHnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVDAHnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:43:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:50099 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262659AbVDAHme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:42:34 -0500
Date: Thu, 31 Mar 2005 23:42:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: connector.c
Message-Id: <20050331234213.0c06ba71.akpm@osdl.org>
In-Reply-To: <1112339238.9334.66.camel@uganda>
References: <20050331173026.3de81a05.akpm@osdl.org>
	<1112339238.9334.66.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> > What happens if we expect a reply to our message but userspace never sends
> > one?  Does the kernel leak memory?  Do other processes hang?
> 
> It is only advice, one may easily skip seq/ack initialization.
> I could remove it totally from the header, but decided to 
> place it to force people to use more reliable protocols over netlink
> by introducing such overhead.

hm.  I don't know what that means.

> > > 	nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof(*nlh));
> > > 
> > > 	data = (struct cn_msg *)NLMSG_DATA(nlh);
> > 
> > Unneeded typecast.
> 
> Is it really an issue?

Well it adds clutter, but more significantly the cast defeats typechecking.
If someone was to change NLMSG_DATA() to return something other than
void*, the compiler wouldn't complain.

> > 
> > Why is spin_lock_bh() being used here?
> 
> skb may be delivered in soft irq context, and may race with sending.
> And actually it can be sent from irq context, like it is done in test
> module.

But spin_lock_bh() in irq context will deadlock if interruptible context is
also doing spin_lock_bh().

> > What's all the above code doing?  What do `a' and `b' mean?  Needs
> > commentary and better-chosen identifiers.
> 
> It searches for idx and val to match requested notification, 
> if "a" is true - idx is found, if b - val is found.

Let me rephrase: please comment the code and choose identifiers in a manner
which makes it clearer what's going on.

> > Please document all functions with comments.  Functions which constitute
> > part of the external API should be commented using the kernel-doc format.
> 
> There is Documentation/connector/connector.txt which describes all
> exported functions and structures.
> Should it be ported to docbook?

connector.txt is pitched at about the right level: an in-kernel and
userspace API description.  It's rather unclear with respect to mesage
directions though - whether the callback is invoked after kernel->user
messages, or for user->kernel or what, for example.  Some clarification
there would help.  

But an API description is a different thing from code commentary which
explains the internal design - the latter should be coupled to the code
itself. 


