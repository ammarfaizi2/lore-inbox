Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282814AbRLOQ7N>; Sat, 15 Dec 2001 11:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282815AbRLOQ7E>; Sat, 15 Dec 2001 11:59:04 -0500
Received: from waste.org ([209.173.204.2]:31435 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282814AbRLOQ7B>;
	Sat, 15 Dec 2001 11:59:01 -0500
Date: Sat, 15 Dec 2001 10:58:44 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <kaos@ocs.com.au>
Subject: Re: [PATCH] 2.5.1-pre10 #ifdef CONFIG_KMOD Cleanup Part II. 
In-Reply-To: <E16F3av-0003TC-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.40.0112151029450.1324-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001, Rusty Russell wrote:

> In message <Pine.LNX.4.40.0112141019100.11489-100000@waste.org> you write:
> > On Thu, 13 Dec 2001, Rusty Russell wrote:
> >
> > > 2) Adds request_module_start()/request_module_end() macros, eg.
> > >
> > > 	struct protocol protoptr;
> > >
> > > 	request_module_start("proto-%u", protonum) {
> > > 		/* search for protocol, set protoptr. */
> > >
> > > 	} request_module_end(protoptr != NULL);
> > >
> > >    This loops once if !CONFIG_KMOD or protoptr != NULL after first
> > >    iteration, otherwise calls request_module and loops a second time.
> >
> > Clever, but very un-C-like. Perhaps something like this:
> >
> > do {
> >   /* search for protocol, set protoptr. */
> > } while (protoptr != NULL || request_module("proto-%u",protonum)==0);
> >
> > ..with request_module returning -EBUSY if the module is already loaded.
>
> This can spin forever 8(.

Well there is a thinko or two above, but provided we have a variant of
request_module that only returns zero when it actually loads a module,
this should only loop once or twice:

 do {
   /* search for protocol, set protoptr. */
 } while (protoptr == NULL && request_module("proto-%u",protonum)==0);

> > > 3) Adds a request_module_unless() macro, eg:
> > >
> > > 	protoptr = request_module_unless(protoptrs[proto],
> > > 					 "proto-%u", protonum);
> >
> > Also weird.
>
> Ack.  However, I was looking for positive suggestions 8)

I think the deeper problem is that request_module is expensive. If, say,
it had a fast path on the order of an inline hash lookup on a cookie
corresponding to the module identifier, we could just unconditionally
request_module(cookie).

Cookie here might be also something like a dentry, which can be positive
or negative, and has some of the reference counting and locking semantics
we need for modules anyway.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

