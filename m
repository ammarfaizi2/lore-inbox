Return-Path: <linux-kernel-owner+w=401wt.eu-S1752903AbWL2CyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbWL2CyG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 21:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbWL2CyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 21:54:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:58188 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbWL2CyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 21:54:05 -0500
In-Reply-To: <20061228.143815.41633302.davem@davemloft.net>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com, guichaz@yahoo.fr,
       hugh@veritas.com, linux-kernel@vger.kernel.org, ranma@tdiedrich.de,
       torvalds@osdl.org, gordonfarquharson@gmail.com, akpm@osdl.org,
       a.p.zijlstra@chello.nl, tbm@cyrius.com, arjan@infradead.org,
       andrei.popa@i-neo.ro
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Date: Fri, 29 Dec 2006 03:50:50 +0100
To: David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think what might be happening is that pdflush writes them out fine,
> however we don't trap writes by the application _during_ that writeout.

Yeah.  I believe that more exactly it happens if the very last
write to the page causes a writeback (due to dirty balancing)
while another writeback for the page is already happening.

As usual in these cases, I have zero proof.

> It's something that will only occur with writeback and MAP_SHARED
> writable access to the file pages.

It's the do_wp_page -> balance_dirty_pages -> generic_writepages
path for sure.  Maybe it's enough to change

                         if (wbc->sync_mode != WB_SYNC_NONE)
                                 wait_on_page_writeback(page);

                         if (PageWriteback(page) ||
                             !clear_page_dirty_for_io(page)) {
                                 unlock_page(page);
                                 continue;
                         }

to

                         if (wbc->sync_mode != WB_SYNC_NONE)
                                 wait_on_page_writeback(page);

                         if (PageWriteback(page)) {
                         	    redirty_page_for_writepage(wbc, page);
                                 unlock_page(page);
                                 continue;
                         }

                         if (!clear_page_dirty_for_io(page)) {
                                 unlock_page(page);
                                 continue;
                         }

or something along those lines.  Completely untested of course :-)


Segher

