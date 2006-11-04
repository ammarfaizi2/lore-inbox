Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965569AbWKDRl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965569AbWKDRl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 12:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965570AbWKDRl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 12:41:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965569AbWKDRl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 12:41:58 -0500
Date: Sat, 4 Nov 2006 09:41:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Falk Hueffner <falk@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: ipc/msg.c "cleanup" breaks fakeroot on Alpha
In-Reply-To: <20061104172954.GA3668@elte.hu>
Message-ID: <Pine.LNX.4.64.0611040938490.25218@g5.osdl.org>
References: <87d583f97t.fsf@debian.org> <20061104172954.GA3668@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Nov 2006, Ingo Molnar wrote:
> 
> * Falk Hueffner <falk@debian.org> wrote:
> 
> > -	struct msg_msg* volatile r_msg;
> > +	volatile struct msg_msg	*r_msg;
> >  };
> >  
> > breaks fakeroot on Alpha (variously hangs or oopses). Backing it out 
> > of 2.6.19-rc4 fixes the issue. Is it possible that this change (which 
> > clearly does change semantics) was made in error?
> 
> correct, it was an error, lets back it out.
> 
> Another interesting question is: what in the IPC code relies on the 
> volatility of this field, and shouldnt it be converted to explicit 
> barriers instead?

Absolutely. Anything that depends on "volatile" is broken by definition, 
since volatile does _not_ imply memory barriers, and while it may 
constrict the compiler in certain ways (and thus effectively make it work 
on things like x86 where the memory ordering is fairly easy to get to 
work), it is not going to do _anything_ on some other architectures, 
except just perhaps make a bug harder to trigger.

Falk - do you have a couple of the oopses (the more, the better: race 
conditions tend to have subtle oopses, and with more oopses it is easier 
to try to figure out the pattern) that you can point people at, so that we 
can get an idea of what's going on.

This looks like a classic case of "volatile is a sign of a bug".

		Linus
