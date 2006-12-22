Return-Path: <linux-kernel-owner+w=401wt.eu-S1946020AbWLVKR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946020AbWLVKR5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946021AbWLVKR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:17:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34688 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946020AbWLVKR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:17:56 -0500
Date: Fri, 22 Dec 2006 02:17:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
Message-Id: <20061222021714.6a83fcac.akpm@osdl.org>
In-Reply-To: <20061222100004.GC10273@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	<20061220175309.GT30106@deprecation.cyrius.com>
	<Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	<Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	<97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
	<Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
	<97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	<20061221012721.68f3934b.akpm@osdl.org>
	<97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	<Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
	<20061222100004.GC10273@deprecation.cyrius.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 11:00:04 +0100
Martin Michlmayr <tbm@cyrius.com> wrote:

> > -	if (TestClearPageDirty(page) && account_size)
> > +	if (TestClearPageDirty(page) && account_size) {
> > +		dec_zone_page_state(page, NR_FILE_DIRTY);
> >  		task_io_account_cancelled_write(account_size);
> > +	}
> 
> This hunk (on top of git from about 2 days ago and your latest patch)
> results in the installer hanging right at the start. 

You'll need this also:

From: Andrew Morton <akpm@osdl.org>

Only (un)account for IO and page-dirtying for devices which have real backing
store (ie: not tmpfs or ramdisks).

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/truncate.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN mm/truncate.c~truncate-dirty-memory-accounting-fix mm/truncate.c
--- a/mm/truncate.c~truncate-dirty-memory-accounting-fix
+++ a/mm/truncate.c
@@ -60,7 +60,8 @@ void cancel_dirty_page(struct page *page
 		WARN_ON(++warncount < 5);
 	}
 		
-	if (TestClearPageDirty(page) && account_size) {
+	if (TestClearPageDirty(page) && account_size &&
+			mapping_cap_account_dirty(page->mapping)) {
 		dec_zone_page_state(page, NR_FILE_DIRTY);
 		task_io_account_cancelled_write(account_size);
 	}
_

