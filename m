Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265198AbUFMQJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbUFMQJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 12:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUFMQJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 12:09:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:10181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265198AbUFMQJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 12:09:26 -0400
Date: Sun, 13 Jun 2004 09:09:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated >
 MAX_ORDER size
In-Reply-To: <20040611161920.0a40e49d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0406130905410.2969@evo.osdl.org>
References: <20040611034809.41dc9205.akpm@osdl.org> <567.1086950642@redhat.com>
 <1056.1086952350@redhat.com> <20040611150419.11281555.akpm@osdl.org>
 <3066250000.1086995005@flay> <20040611161920.0a40e49d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Jun 2004, Andrew Morton wrote:
> 
> Confused.  Why do we have that test in there at all?  We should just toss
> the pages one at a time into the buddy list and let the normal coalescing
> work it out.  That way we'd end up with a single 16MB "page" followed by N
> 256MB "pages".

Doesn't work that way. We use the base of the memory area as the "zero
point", and while the buddy allocator itself shouldn't really care where
that zero-point is, anybody who expects physical alignment would be really
upset if it doesn't get it.

So the base address has to be as aligned as anybody could ever want. And
"anybody" wants quite a bit of alignment. Largepages usually want
alignment guarantees, and on most architectures that means a minimum
_physical_ address alignment of at least a few megabytes.

So the rule really should be: make sure that the buddy system base address 
is maximally aligned, and if your memory doesn't actually _start_ at that 
alignment point, just add the pages and let the buddy allocator build up 
all the bitmaps etc for you.

		Linus
