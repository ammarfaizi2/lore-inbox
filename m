Return-Path: <linux-kernel-owner+w=401wt.eu-S965005AbWL1Wul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWL1Wul (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWL1Wul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:50:41 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:3985
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965005AbWL1Wuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:50:40 -0500
Date: Thu, 28 Dec 2006 14:50:38 -0800 (PST)
Message-Id: <20061228.145038.71089607.davem@davemloft.net>
To: torvalds@osdl.org
Cc: akpm@osdl.org, guichaz@yahoo.fr, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, mh+linux-kernel@zugschlus.de,
       nickpiggin@yahoo.com.au, andrei.popa@i-neo.ro,
       linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, hugh@veritas.com,
       fw@deneb.enyo.de, tbm@cyrius.com, arjan@infradead.org,
       kenneth.w.chen@intel.com
Subject: Re: 2.6.19 file content corruption on ext3
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0612281325290.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612281318480.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612281325290.4473@woody.osdl.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 28 Dec 2006 14:37:37 -0800 (PST)

> So if we're not losing any dirty bits, what's going on?

What happens when we writeback, to the PTEs?

page_mkclean_file() iterates the VMAs and when it finds a shared
one it goes:

		entry = ptep_clear_flush(vma, address, pte);
		entry = pte_wrprotect(entry);
		entry = pte_mkclean(entry);

and that's fine, but that PTE is still marked writable, and
I think that's key.

What does the fault path do in this situation?

	if (write_access) {
		if (!pte_write(entry))
			return do_wp_page(mm, vma, address,
					pte, pmd, ptl, entry);
		entry = pte_mkdirty(entry);
	}

It does nothing to update the page dirty state, because it's
writable, it just sets the PTE dirty bit and that's it.  Should
it be setting the page dirty here for SHARED cases?

So until vmscan actually unmaps the PTE completely, we have this
window in which the application can write to the PTE and the
page dirty state doesn't get updated.

Perhaps something later cleans up after this, f.e. by rechecking the
PTE dirty bit at the end of I/O or when vmscan unmaps the page.
I guess that should handle things, but the above logic definitely
stood out to me.
