Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263879AbUFFRzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbUFFRzq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUFFRzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:55:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:27091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263879AbUFFRzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:55:39 -0400
Date: Sun, 6 Jun 2004 10:55:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Kalin KOZHUHAROV <kalin@ThinRope.net>,
       Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@ximian.com>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <200406062022.54320.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0406061028050.7010@ppc970.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com> <40C2A6E4.7020103@ThinRope.net>
 <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org>
 <200406062022.54320.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jun 2004, Denis Vlasenko wrote:
> >
> > 	if (now() - when < ((60 + (getpid() & 31)) << 6))
> 
> timeout randomization across several qmail-send processes, to prevent
> stampede effect?
> 
> > And don't you find
> > the above (totally uncommented) line just a thing of beauty and clarity?
> 
> Yes, a comment would be in place. :(

The problem is not so much what it does, but how it's coded.

For example, if it really wanted to do this, then how about having a nice 
variable that is initialized at run-time (preferably just once at 
startup), and has a nice name and a comment on what it's all about? Or 
even a macro, to make it more readable? Or even _just_ the comment?

You could write the above incomprehensible one-liner as

	/* Timeout in seconds: 64 - 97 minutes, depending on pid */
	#define ERROR_FAILURE_TIMEOUT ((60 + (getpid() & 31)) << 6)

	...

	/*
	 * If this IP address had a SMTP connection timeout last
	 * time, don't let it try to connect again immediately
	 */
	if (now() - when < ERROR_FAILURE_TIMEOUT)

and it would at least have made some sense.

As it is, you CANNOT read "tcpto.c" and make any sense of it. It's not 
sensible code. You have to know what the hell the whole thing is all 
about, and you have to actually try to figure out what the expression is 
to even understand the code.

Trust me. Try sometime. The code is horrible.

It wouldn't irritate me so much, but then the person who wrote that 
abomination has the galls to complain about sendmail, NFS, System V etc.

And it's not like qmail is so big and has such a long history that it 
would be a huge deal to comment it and write it more readably. But since 
the license doesn't allow for anything but patches, and patches would be 
totally unmaintainable if they tried to fix these kinds of things, it will 
never be done.

Which is a pity, since I actually _agree_ with you that qmail has some
good sides: it's small, it's efficient, and it's pretty modular. It has 
the _potential_ to be great code.

			Linus
