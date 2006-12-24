Return-Path: <linux-kernel-owner+w=401wt.eu-S1752888AbWLXVfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbWLXVfe (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 16:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbWLXVfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 16:35:34 -0500
Received: from p02c11o145.mxlogic.net ([208.65.145.68]:46581 "EHLO
	p02c11o145.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbWLXVfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 16:35:33 -0500
X-Greylist: delayed 866 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 16:35:33 EST
Date: Sun, 24 Dec 2006 23:21:13 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrei Popa <andrei.popa@i-neo.ro>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061224212113.GA31813@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 24 Dec 2006 21:23:02.0609 (UTC) FILETIME=[B197EC10:01C727A1]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14890.000
X-TM-AS-Result: No--18.361200-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quoting Linus Torvalds <torvalds@osdl.org>:
> Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
>
> Peter, tell me I'm crazy, but with the new rules, the following condition 
> is a bug:
> 
>  - shared mapping
>  - writable
>  - not already marked dirty in the PTE
> 
> because that combination means that the hardware can mark the PTE dirty 
> without us even realizing (and thus not marking the "struct page *" 
> dirty).

Er.
Sorry about bumping in, and I'm not sure I understand all of the discussion,
but this reminded me of an old issue with COW that created what looks
like a vaguely similiar data corruption on infiniband. We solved this for
infiniband with MADV_DONTFORK, but I always wondered why does it not affect
other parts of kernel.  Small reminder from that discussion:

down mmap sem
get user pages
up mmap sem
page becomes shared, and COW (e.g. fork)
process writes to first byte of page <----- gets a copy
Now we had a problem: struct page that we got from get user pages
does not point to a correct page in our process.
For example: if at some point we map this page for DMA, and
hardware writes to last byte of page -----> process does not
see this data.

So for infiniband, what we do is a combination of
- prevent page from becoming COW while hardware might DMA to this page, and
- ask users not to write to page if hardware might DMA to same page
  (even if its using different bytes).

I just wandered - is there some chance something like this could be happening in
the fs code?

HTH,

-- 
MST
