Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266966AbTGKWRi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266982AbTGKWRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:17:38 -0400
Received: from [63.205.85.133] ([63.205.85.133]:54990 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S266966AbTGKWRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:17:36 -0400
Date: Fri, 11 Jul 2003 15:37:54 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sound updating, security of strlcpy and a question on pci v unload
Message-ID: <20030711223754.GC73897@gaz.sfgoth.com>
References: <1057943137.20637.27.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0307112100240.843-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307112100240.843-100000@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
> What's the difference there? strlcpy always creates null-terminated
> string, strncpy doesn't. strncpy in kernel (unlike user strncpy) does not
> pad the whole destination buffer with zeros (see comment and
> implementation in lib/string.c), so I don't see any point why strncpy
> should be more secure.

Not only that, I think the point is usually moot anyway.  If you're
filling in a structure to pass to userspace like:

	struct whatever foo;
	strncpy(foo.name, "My Driver", sizeof(foo.name));
	foo.count = 1;
	[...]

then you're STILL probably at risk of data leakage if "struct whatever"
requires padding on any architecture.  The real fix is to make sure
that "foo" is explicitly zero'ed out first.  Then strlcpy-vs-strncpy
becomes a non-issue.

I wonder if strncpy() should just be removed from the kernel since it
doesn't seem to behave consistently across architectures anyway.  There's
probably only a couple places that actually ever would WANT to generate
a maybe-NUL-terminated byte array and they could just open code it.
For 95%+ of cases strlcpy() is the better API.

-Mitch
