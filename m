Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266061AbTLIQov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266062AbTLIQou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:44:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:31689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266061AbTLIQot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:44:49 -0500
Date: Tue, 9 Dec 2003 08:44:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Arnd Bergmann <arnd@arndb.de>, Jamie Lokier <jamie@shareable.org>,
       Nikita Danilov <Nikita@Namesys.COM>, linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
In-Reply-To: <3FD5ED77.6070505@zytor.com>
Message-ID: <Pine.LNX.4.58.0312090837370.19936@home.osdl.org>
References: <200312081646.42191.arnd@arndb.de> <Pine.LNX.4.58.0312082321470.18255@home.osdl.org>
 <3FD57C77.4000403@zytor.com> <200312091256.47414.arnd@arndb.de>
 <3FD5ED77.6070505@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Dec 2003, H. Peter Anvin wrote:
>
> In some ways, this is rather unfortunate, too.  What it really means is
> that the gcc "m" constraint is overloaded; it would have been better if
> they would have created a new modifier (say "*") for "must be lvalue."

The thing is, most users of "m" (like 99%) actually mean "_THIS_ memory
location". So just fixing the "m" modifier was an easy way to make sure
that users get the behaviour they expect.

Also, I have this dim memory of there actually being a potential bug in
"m" handling inside gcc, and requiring the entry to be a lvalue was the
easiest way to fix it. Richard Henderson would have the details.  I think
it was the liveness analysis that got confused or something.

And the thing is, if you have a non-lvalue right now, you will (a) get a
nice warnign that tells you so, and (b) it will be trivial to fix. So
something like

	asm("xxxx" : :"m" (1+x));

can be trivially fixed to be

	{
		int tmp = 1+x;
		asm("xxxx" : : "m" (tmp));
	}

so it's not like it's a horribly undue burden on the programmer.

In the kernel, I don't think we had a _single_ case that needed this, but
I might remember that wrong. Anyway, it wasn't a problem - and the kernel
tends to be the single most active user of inline asm's of all
gcc-compiled projects.

			Linus
