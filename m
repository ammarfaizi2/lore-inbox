Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263529AbUFREhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUFREhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 00:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbUFREhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 00:37:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:30105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263529AbUFREhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 00:37:22 -0400
Date: Thu, 17 Jun 2004 21:36:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.7
Message-Id: <20040617213619.7f0b5b89.akpm@osdl.org>
In-Reply-To: <6uisdqryyt.fsf@zork.zork.net>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
	<6uisdqryyt.fsf@zork.zork.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> wrote:
>
> The 2.6.7 I built seems kind of swap-happy, apparently triggered by an
>  overnight updatedb run.  I think this also happened with
>  2.6.7-rc3-mm2.

There were corrections to logic errors in the vm scanner which will cause
increased pageout.

>  I can't seem to find anything particularly out of the
>  ordinary in the information below.  I started off with swappiness set
>  to 50 as I have for a while and dropped it twice by ten each time
>  after a swapoff/swapon.  It starts paging stuff out again pretty fast
>  after it gets the swap back.  Swap is is a dm-crypt device map.

swapoff/swapon doesn't do what you think it does.  The pages are read from
the swap device, have the ptes reattached but the pages are placed on the
inactive list, from where they will be swapped out again very easily after
a swapon.

Which is really the correct behaviour: if these pages were earlier swapped
out then clearly they are the right ones to swap out when swap again
becomes available.

But that doesn't seem very important, and the old swapoff/swapon trick is
useful, so...

--- 25/mm/swapfile.c~swapoff-activate-pages	2004-06-17 21:27:41.704568280 -0700
+++ 25-akpm/mm/swapfile.c	2004-06-17 21:28:35.417402688 -0700
@@ -467,6 +467,13 @@ static unsigned long unuse_pmd(struct vm
 		if (unlikely(pte_same(*pte, swp_pte))) {
 			unuse_pte(vma, offset + address, pte, entry, page);
 			pte_unmap(pte);
+
+			/*
+			 * Move the page to the active list so it is not
+			 * immediately swapped out again after swapon.
+			 */
+			activate_page(page);
+
 			/* add 1 since address may be 0 */
 			return 1 + offset + address;
 		}
_

