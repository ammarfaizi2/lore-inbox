Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSKREER>; Sun, 17 Nov 2002 23:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSKREER>; Sun, 17 Nov 2002 23:04:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15375 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261427AbSKREEQ>; Sun, 17 Nov 2002 23:04:16 -0500
Date: Sun, 17 Nov 2002 20:11:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <3DD8657E.7020203@redhat.com>
Message-ID: <Pine.LNX.4.44.0211172003050.1206-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Ulrich Drepper wrote:
> 
> They don't have to be as such.  It's a simple list operation (move all
> active threads except the active one on the free list).  That's it.  No
> more work especially no resetting of the TID fields.

Ok. So you _do_ do more than just the clone(), but you depend on the clone 
to at least set up the local thread descriptor for you.

Fair enough, and it sounds like a good implementation.

I'm convinced. However, I still want som elargely cosmetic changes to the 
patch, Ingo:

 - the existing CLONE_SETTID should be called CLONE_PARENT_SETTID, because 
   that is how it already works since it is done after the VM copy (this
   is what your patch already does)
 - the existing CLONE_CLEARTID should then be CLONE_CHILD_CLEARTID (your 
   existing patch re-numbers this) and using existing semantics
 - the new flag should be CLONE_CHILD_SETTID, and should _not_ renumber 
   old existing bits (your existing patch renumbers everything, including 
   totally unrelated bits like CLONE_DETATCHED)
 - please don't introduce a new pointer, just use the old one. There 
   appears to be no cases where you want to have different pointers
   anyway.

With those changes, no actual behavioural changes should take place, and
the patch is _purely_ adding a new flag (CLONE_CHILD_SETTID) without
changing existing behaviour (yeah, it renames a few old flags too, but
that's purely syntactic).

Plus the patch should be smaller.

		Linus

