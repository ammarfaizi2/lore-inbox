Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSHPAGs>; Thu, 15 Aug 2002 20:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSHPAGs>; Thu, 15 Aug 2002 20:06:48 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:12548 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S317694AbSHPAGr>; Thu, 15 Aug 2002 20:06:47 -0400
Date: Fri, 16 Aug 2002 10:10:18 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Matthew Wilcox <willy@debian.org>
cc: "David S. Miller" <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>,
       Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
In-Reply-To: <20020815200436.E29958@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Mutt.LNX.4.44.0208161004310.30494-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002, Matthew Wilcox wrote:

> In general, this is good... I think it could be better:
> 
> > +	lock_kernel();
> > +	error = f_setown(filp, current->pid);
> > +	unlock_kernel();
> 
> There are a lot of these, and you even batch it up as sock_setown()
> later.  May I suggest renaming f_setown to __setown and sock_setown
> to f_setown?

Sounds like a good idea.

> this one's particularly silly -- now you've done the good job of wrapping
> the security_ops up inside f_setown this can simply be:
> 
> 			lock_kernel();
> 			err = f_setown(filp, arg);
> 			unlock_kernel();
> 			break;

Yep.

> Might make more sense to refactor as:
> 
> void sk_send_sigurg(struct sock *sk)
> {
> 	if (!sk->socket || !sk->socket->file)
> 		return;
> 	if (send_sigurg(&sk->socket->file->f_owner))
> 		sk_wake_async(sk, 3, POLL_PRI);
> }
> 

Possibly.  I guess it's up to the networking guys -- is there any point in 
keeping these separate?  I can't see any with the current code.

Thanks for the feedback.


- James
-- 
James Morris
<jmorris@intercode.com.au>


