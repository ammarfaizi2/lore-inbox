Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWHFO4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWHFO4q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 10:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWHFO4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 10:56:46 -0400
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:12487 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1750720AbWHFO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 10:56:45 -0400
Date: Sun, 6 Aug 2006 15:55:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mattia Dongili <malattia@linux.it>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <npiggin@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 [BUG at mm/vmscan.c:383!]
In-Reply-To: <20060806133306.GB4009@inferi.kami.home>
Message-ID: <Pine.LNX.4.64.0608061545080.16384@blonde.wat.veritas.com>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060806133306.GB4009@inferi.kami.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Aug 2006 14:56:25.0204 (UTC) FILETIME=[7D07D340:01C6B968]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006, Mattia Dongili wrote:
> [  781.988000] kernel BUG at mm/vmscan.c:383!
> [  781.988000] EIP is at remove_mapping+0xe8/0x120

You are so right: the minor fix below is needed.

> [  781.988000] DWARF2 unwinder stuck at kernel_thread_helper+0x5/0x10

Sorry, someone else will have to help with all that nuisance.


remove_mapping() must check against page_mapping(page):
&swapper_space is implicit, never actually stored in page->mapping.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.18-rc3-mm2/mm/vmscan.c	2006-08-06 12:25:40.000000000 +0100
+++ linux/mm/vmscan.c	2006-08-06 15:40:34.000000000 +0100
@@ -380,7 +380,7 @@ static pageout_t pageout(struct page *pa
 int remove_mapping(struct address_space *mapping, struct page *page)
 {
 	BUG_ON(!PageLocked(page));
-	BUG_ON(mapping != page->mapping);
+	BUG_ON(mapping != page_mapping(page));
 
 	write_lock_irq(&mapping->tree_lock);
 
