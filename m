Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272223AbTHRSjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272230AbTHRSjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:39:31 -0400
Received: from hera.cwi.nl ([192.16.191.8]:13769 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272223AbTHRSja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:39:30 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 18 Aug 2003 20:39:28 +0200 (MEST)
Message-Id: <UTC200308181839.h7IIdSG10173.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, levon@movementarian.org
Subject: Re: Maximum x86 swap partition size ?
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any reason you haven't responded ?

It is still in my inbox.
# received letters/day >> # answered letters/day

A careful answer requires inspection of the development of
the code involved. Let me give a rough answer from memory,
clarifying why mkswap contains severe restrictions.

Long ago:
Swap space started with a bit map of bad blocks. This is v0.
Later:
Swap space starts with a header that lists the bad blocks. This is v1.

V1 swap space was a disaster for several reasons.

The first problem is that nobody knows where the signature is,
because that is at the end of the page, and a "page" may be a
natural object for a kernel developer, it is not in user space.
Right now a large part of the source of mkswap consists of finding out
how large a page is, and in bad cases we can't, and need a user option.

The second problem is that old kernels will refuse the swapon
system call when the swapspace is too large (instead of only
using the part the kernel likes). That again means lots of
garbage code, trying to figure out what size swapspace the kernel
will accept.

The strange limitations documented in mkswap(8) are true limitations
for certain oldish kernels. If the assumption is that nobody uses
2.2 anymore then these can be removed. But lots of people still use 2.2.

I might send Alan a patch to remove this restriction in 2.2.

Alan: the bad fragment lives in swapfile.c and is

               if (p->max >= SWP_OFFSET(SWP_ENTRY(0,~0UL)))
                        goto bad_swap;

If it is still there (I have somewhat poor net and source access
right now) it could be changed to something like

               swaplimit = SWP_OFFSET(SWP_ENTRY(0,~0UL));
	       if (p->max >= swaplimit)
	                p->max = swaplimit-1;

	

Andries

Let me cc l-k.

