Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUFSSzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUFSSzW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 14:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUFSSzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 14:55:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4302 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262114AbUFSSzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 14:55:15 -0400
Date: Sat, 19 Jun 2004 11:54:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mincore on anon mappings
Message-Id: <20040619115411.736cf787.davem@redhat.com>
In-Reply-To: <20040619162503.GC12019@dualathlon.random>
References: <20040619162503.GC12019@dualathlon.random>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004 18:25:03 +0200
Andrea Arcangeli <andrea@suse.de> wrote:

> here a first (untested) attempt to allow mincore on anon vmas too.
> 
> I heard you need this from gcc, right?

Sort of.  What I think we really need is a new MAP_FIXED that
doesn't wipe out existing mappings.

The issue is that architectures make decisions about passed in
"hint" addresses based upon cache aliasing concerns sometimes.

You can bypass that by using MAP_FIXED, but MAP_FIXED has the nasty
side effect of zapping existing mappings.  That's not what the user
wants in this case, the user here wants to tell the cache aliasing
virtual address hint changing logic to just go away.

mincore() is a really inefficient way to accomplish what GCC wants.
What gcc would do with this is basically:

	addr = mmap(request_address, ..., len, ...);
	if (addr == MMAP_FAIL) {
		use_mincore_to_see_if_area_free(request_address, len);
		if (really_is_free)
			addr = mmap( ... | MAP_FIXED );
	}

See?  That's terribly inefficient.

Basically what GCC is trying to do is mmap a file at a fixed location.
Per-architecture get_unmapped_area() implementations will change the
requested address, unless MAP_FIXED is set, in order to more efficiently
handle cache aliasing issues in data caches.  Using MAP_FIXED has the
unwanted side-effect of munmap()'ing any existing things in that range,
which is not what GCC wants.

Therefore I propose we add a MAP_FORCE which does exactly what GCC wants
which is:

1) The passed in 'hint' address is treated as mandatory, if exactly that
   address cannot be used, we fail.

2) Existing areas get in the way, and cause failure.

3) get_unmapped_area() implementations shut off any 'hint' address
   modification logic they may have.

I think the mincore() fix is important independant of how GCC eventually
deals with the thing it wants to accomplish.
