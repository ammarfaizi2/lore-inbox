Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUBJRka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbUBJRkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:40:24 -0500
Received: from mail.shareable.org ([81.29.64.88]:55168 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265974AbUBJRiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:38:02 -0500
Date: Tue, 10 Feb 2004 17:37:38 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-ID: <20040210173738.GA9894@mail.shareable.org>
References: <1076384799.893.5.camel@gaston> <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> What I find strange is that bash passed in something else than NULL as the 
> argument in the first place. Doing a quick trace of my bash executable 
> shows non-NULL hints only for MAP_FIXED mmap's. So what triggered this? 

Run the "prelink" program on your system.

It's not bash which is using non-NULL hints, it's ld.so.  Prelinked
libraries have relocations already resolved on the assumption that
they are mapped at a known address.  (Prelink chooses a different
address for each library).  ld.so calls mmap() with that address.

If the library cannot be mapped at the requested address, then ld.so
has to do dynamic linking as usual, dirtying some pages and looking up
symbols.

The real question is - why does malloc() break?  I'd expect malloc()
to use MAP_ANON these days, when brk() fails.  But it seems not.

-- Jamie
