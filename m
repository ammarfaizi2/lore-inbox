Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTJGTHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 15:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTJGTHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 15:07:49 -0400
Received: from mail15.speakeasy.net ([216.254.0.215]:18869 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S262655AbTJGTHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 15:07:48 -0400
Date: Tue, 7 Oct 2003 12:07:44 -0700
Message-Id: <200310071907.h97J7i4a004576@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dump read-only anonymous memory in core files
In-Reply-To: Linus Torvalds's message of  Tuesday, 7 October 2003 02:06:34 -0700 <Pine.LNX.4.44.0310070155110.1749-100000@home.osdl.org>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Ambivalent nougat corruption
   (2) Graphic tables
   (3) Delicious breeze auctions
   (4) Vivacious amphibious protein ambition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> What about shared mappings (that test should be VM_MAYSHARE)?
> 
> My inclination would be to not dump them if they are backed by a file, 
> even if the mmap is writable.

That sounds reasonable to me (perhaps modulo the shmfs issue).  I intended
my patch not to omit any vmas that were dumped before, so I didn't consider
omitting any writable areas.  (I don't really understand the difference
between VM_MAYSHARE and VM_SHARED, so I might be assuming something wrong
when saying you are right.)

> Also, the VM_WRITE test should possibly be VM_MAYWRITE, since the thing
> could have been mprotect()'ed. Alternatively, we could really add a "this
> mapping has been writable" flag (a kind of "sticky VM_WRITE" bit). It's
> only mprotect that can do this, anyway.

Actually the ideal would be "this mapping has been written to" (or might
have been, i.e. it at least was writable in a pte, if not actually dirty).
Then if you mmap some pages PROT_READ|PROT_WRITE, and then mprotect them
PROT_READ before ever touching them, you don't dump those pages just as you
wouldn't dump always-read-only pages.  (If you had that, you could apply it
to anonymous mappings as well and omit all zero-fill pages.)  Ideally this
would dump PROT_NONE pages that have been written in the past as well,
which is ruled out by the VM_READ test at the top of maydump.  Despite the
comment, it looks to me like dump_write's use of get_user_pages will make
it work, so it could be a VM_MAYREAD check. 


Thanks,
Roland
