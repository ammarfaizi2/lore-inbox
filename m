Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTEIPyd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 11:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTEIPyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 11:54:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9995 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263295AbTEIPyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 11:54:32 -0400
Date: Fri, 9 May 2003 09:06:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <jamie@shareable.org>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 uaccess to fixmap pages
In-Reply-To: <20030509124042.GB25569@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0305090856500.9705-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 May 2003, Jamie Lokier wrote:
>
> Why don't you change TASK_SIZE to 0xc0001000 (or so) and place the
> user-visible fixmaps at 0xc0000000?

I think I almost agree..

> That would have no cost at all.

It actually does have some cost in that form, namely the fact that the
kernel 1:1 mapping needs to be 4MB-aligned in order to take advantage of
large-pte support. So we'd have to move the kernel to something like
0xc0400000 (and preferably higher, to make sure there is a nice hole in
between - say 0xc1000000), which in turn has a cost of verifying that 
nothing assumes the current lay-out (we've had the 1/2/3GB TASK_SIZE 
patches floating around, but they've never had "odd sizes").

There's another cost, which is that right now we share the pgd with the 
kernel fixmaps, and this would mean that we'd have a new one. That's just 
a single page, though.

But it might "just work", and it would be interesting to see what the
patch would look like. Hint hint.

[ The current "TASK_SIZE comes up to start of kernel" is actually a bad 
  design, since it makes the boundary between user mapping a kernel 
  mapping a very abrupt one without any hole in between - opening us up
  for problems with overflows from user space addresses to kernel
  addresses on x86.

  In particular, if we use the wrong size to "access_ok()", a user program
  could fool the kernel to access low kernel memory. I don't know of any
  such bug, but having to be careful about it _did_ complicate
  "strcpy_from_user()" on x86. So from a security angle it would also be
  good to do this ]

		Linus

