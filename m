Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbUDQRPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 13:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbUDQRPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 13:15:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:24709 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263993AbUDQRPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 13:15:02 -0400
Date: Sat, 17 Apr 2004 10:14:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: linux-kernel@vger.kernel.org, arjanv@redhat.com,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       viro@parcelfarce.linux.theplanet.co.uk, bfennema@falcon.csc.calpoly.edu
Subject: Re: Fix UDF-FS potentially dereferencing null
In-Reply-To: <200404171313.02784.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.58.0404171009320.3947@ppc970.osdl.org>
References: <20040416214104.GT20937@redhat.com> <Pine.LNX.4.58.0404161720450.3947@ppc970.osdl.org>
 <1082195458.4691.1.camel@laptop.fenrus.com> <200404171313.02784.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Apr 2004, Ingo Oeser wrote:
> 
> Or even call the attribute "nonnull", because this is a very obvious
> naming, even to non-native English readers.

I did that at first, but decided that what I really wanted was "safe".

"nonnull" is nice for avoiding the NULL check, but it's useless for 
anything else.

"safe" to my mind means that not only is it not NULL, it's also safe to 
dereference early (ie "prefetchable"), which has a lot of meaning for the 
back-end.

> "safe" can mean anything from "safe to use under spinlock" to
> "you cannot get pregnant from using this variable".

That's pretty much _exactly_ what "safe" means.

Basically, a real C compiler is not allowed to dereference a pointer
speculatively, since that could have undefined side effects in the
machine. And "safe" means that there are no side effects, pregnancy- 
or otherwise.

> GCC will not only optimize out the check, but also ensure that the we
> will not pass NULL ptrs, if it can notice it. If this gets pushed high
> enough (up to the register-like functions, where it gets first
> assigned), we will never face this kind of problem anymore and document
> this fact per function. Sounds like C coder heaven ;-)

No. "nonnull" is useless. Even if it isn't NULL, the C standard does not 
allow the compiler to just dereference something willy-nilly.

In contrast, "safe" means that the compiler could do something like

	int * safe ptr;

	if (!a)
		a = *ptr;

and know that it is "safe" to transform this into

	tmp = *ptr;
	a = a ? : tmp;

which it otherwise can't necessarily determine.

		Linus
		
