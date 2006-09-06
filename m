Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965280AbWIFXIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbWIFXIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWIFXDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:03:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:51916 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964975AbWIFXCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:05 -0400
Date: Wed, 6 Sep 2006 15:56:48 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>
Subject: [patch 18/37] SPARC64: Fix X server crashes on sparc64
Message-ID: <20060906225648.GS15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sparc64-fix-x-server-crashes-on-sparc64.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David S. Miller <davem@davemloft.net>

[SPARC64]: Fix X server hangs due to large pages.

This problem was introduced by changeset
14778d9072e53d2171f66ffd9657daff41acfaed

Unlike the hugetlb code paths, the normal fault code is not setup to
propagate PTE changes for large page sizes correctly like the ones we
make for I/O mappings in io_remap_pfn_range().

It is absolutely necessary to update all sub-ptes of a largepage
mapping on a fault.  Adding special handling for this would add
considerably complexity to tlb_batch_add().  So let's just side-step
the issue and forcefully dirty any writable PTEs created by
io_remap_pfn_range().

The only other real option would be to disable to large PTE code of
io_remap_pfn_range() and we really don't want to do that.

Much thanks to Mikael Pettersson for tracking down this problem and
testing debug patches.

Signed-off-by: David S. Miller <davem@davemloft.net>

---
 arch/sparc64/mm/generic.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.17.11.orig/arch/sparc64/mm/generic.c
+++ linux-2.6.17.11/arch/sparc64/mm/generic.c
@@ -69,6 +69,8 @@ static inline void io_remap_pte_range(st
 		} else
 			offset += PAGE_SIZE;
 
+		if (pte_write(entry))
+			entry = pte_mkdirty(entry);
 		do {
 			BUG_ON(!pte_none(*pte));
 			set_pte_at(mm, address, pte, entry);

--
