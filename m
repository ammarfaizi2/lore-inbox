Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUIFLi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUIFLi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 07:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267740AbUIFLi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 07:38:28 -0400
Received: from ozlabs.org ([203.10.76.45]:52450 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267748AbUIFLi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 07:38:26 -0400
Date: Mon, 6 Sep 2004 21:35:41 +1000
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allocate correct amount of memory for pid hash
Message-ID: <20040906113541.GR7716@krispykreme>
References: <412824BE.4040801@yahoo.com.au> <4128252E.1080002@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4128252E.1080002@yahoo.com.au>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nick,

> Use hlists for the PID hashes. This halves the memory footprint of these
> hashes. No benchmarks, but I think this is a worthy improvement because
> the hashes are something that would be likely to have significant portions
> loaded into the cache of every CPU on some workloads.
> 
> This comes at the "expense" of
> 	1. reintroducing the memory  prefetch into the hash traversal loop;
> 	2. adding new pids to the head of the list instead of the tail. I
> 	   suspect that if this was a big problem then the hash isn't sized
> 	   well or could benefit from moving hot entries to the head.
> 
> Also, account for all the pid hashes when reporting hash memory usage.

It looks like we are now allocating twice as much memory as required.
How does this look?

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN kernel/pid.c~fix_freemem_reporting kernel/pid.c
--- foobar2/kernel/pid.c~fix_freemem_reporting	2004-09-06 21:17:34.185012321 +1000
+++ foobar2-anton/kernel/pid.c	2004-09-06 21:25:29.494818586 +1000
@@ -278,7 +278,7 @@ void __init pidhash_init(void)
 
 	for (i = 0; i < PIDTYPE_MAX; i++) {
 		pid_hash[i] = alloc_bootmem(pidhash_size *
-					sizeof(struct list_head));
+					sizeof(struct hlist_head));
 		if (!pid_hash[i])
 			panic("Could not alloc pidhash!\n");
 		for (j = 0; j < pidhash_size; j++)
_
