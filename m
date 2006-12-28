Return-Path: <linux-kernel-owner+w=401wt.eu-S1753596AbWL1RRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbWL1RRJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 12:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbWL1RRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 12:17:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45157 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596AbWL1RRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 12:17:07 -0500
Date: Thu, 28 Dec 2006 09:15:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
cc: David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <1167297349.15989.171.camel@ymzhang>
Message-ID: <Pine.LNX.4.64.0612280912071.4473@woody.osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net> 
 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> 
 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> 
 <20061227.165246.112622837.davem@davemloft.net>  <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
 <1167297349.15989.171.camel@ymzhang>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2006, Zhang, Yanmin wrote:
> 
> The test program is a process to write/read data. pdflush might write data
> to disk asynchronously. After pdflush writes a page to disk, it will call (either by
> softirq) clear_page_dirty to clear the dirty bit after getting the interrupt
> notification.

That would indeed be a horrible bug. However, we don't do 
"clear_page_dirty()" _after_ the IO has completed, we do it _before_ the 
IO starts.

If you can actually find a place that does clear_page_dirty _after_ IO, 
then yes, you've just found the bug. But I haven't found it.

So the rule is _always_:

 - call "clear_page_dirty_for_io()" with the page lock held, and _before_ 
   the IO starts.
 - do "set_page_writeback()" before unlocking the page again
 - do a "end_page_writeback()" when the IO actually finishes.

and any code sequence that doesn't honor those rules would be buggy. A 
beer for anybody that finds it..

		Linus
