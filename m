Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbSI0QUI>; Fri, 27 Sep 2002 12:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSI0QUI>; Fri, 27 Sep 2002 12:20:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46090 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261911AbSI0QUH>; Fri, 27 Sep 2002 12:20:07 -0400
Date: Fri, 27 Sep 2002 09:26:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <Pine.LNX.4.44.0209271812450.15069-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209270922340.2013-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Ingo Molnar wrote:
> 
> the attached patch implements the virtual => physical cache. Right now
> only the COW code calls the invalidation function, because futexes do not
> need notification on unmap.

Ok, looks good. Except you make get_user_page() do a write fault on the 
page, and one of the points of this approach was that that shouldn't even 
be needed. Or did I miss some case that does need it?

> I have fixed a new futex bug as well: pin_page() alone does not guarantee
> that the mapping does not change magically, only taking the MM semaphore
> in write-mode does.

And this makes no sense to me.

A read lock on the semaphore should give you all the same protection as a
write lock does.

To protect against the swapper etc, you really need to get the mm
spinlock, not the semaphore. And once you have the spinlock, you should be
totally safe.  Please explain what you saw?

		Linus

