Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVIKLt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVIKLt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 07:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVIKLt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 07:49:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932456AbVIKLt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 07:49:27 -0400
Date: Sun, 11 Sep 2005 04:49:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paolo Ornati <ornati@fastwebnet.it>
cc: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 7/7] uml: retry host close() on EINTR
In-Reply-To: <20050911092802.1ab931ac@localhost>
Message-ID: <Pine.LNX.4.58.0509110437120.4912@g5.osdl.org>
References: <20050910174452.907256000@zion.home.lan> <20050910174630.063774000@zion.home.lan>
 <Pine.LNX.4.58.0509101157170.30958@g5.osdl.org> <20050911092802.1ab931ac@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Paolo Ornati wrote:
> 
> So glibc doc is wrong here:

Yes.

> SUSV3:
> -------------------------------------------------------------
> If close() is interrupted by a signal that is to be caught, it shall
> return -1 with errno set to [EINTR] and the state of fildes is
> unspecified
> -------------------------------------------------------------
> 
> Unspecified! ;-)

I don't know of any system where re-trying the close() is the right thing
to do, but I guess they exist. I think the Linux behaviour of "hey, it's
closed, live with it" is pretty universal - almost nobody ever tests the
return value of close().

Even the "careful" users that want to hear about IO errors have to really 
do an fsync(), so any IO errors should show up there. Of course, checking 
the return value of "close()" in addition to the fsync() is always a good 
idea anyway, and I suspect they do.

In Linux, another thread may return with the same fd in open() even _long_
before the close() that released it has even finished. The kernel releases
the fd itself early, and then the rest (anything that could return EINTR -
things like TCP linger stuff etc) is all done with just the "struct file".

So retrying is really really wrong. And not just on Linux. I think this is 
true on _most_  if not all unix implementations out there.

		Linus
