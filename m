Return-Path: <linux-kernel-owner+w=401wt.eu-S965050AbWL1XCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWL1XCQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWL1XCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:02:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39937 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965050AbWL1XCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:02:15 -0500
Date: Thu, 28 Dec 2006 15:01:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: akpm@osdl.org, guichaz@yahoo.fr, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, mh+linux-kernel@zugschlus.de,
       nickpiggin@yahoo.com.au, andrei.popa@i-neo.ro,
       linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, hugh@veritas.com,
       fw@deneb.enyo.de, tbm@cyrius.com, arjan@infradead.org,
       kenneth.w.chen@intel.com
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <20061228.145038.71089607.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0612281459090.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612281318480.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612281325290.4473@woody.osdl.org> <20061228.145038.71089607.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2006, David Miller wrote:
> 
> What happens when we writeback, to the PTEs?

Not a damn thing.

We clear the PTE's _before_ we even start the write. The writeback does 
nothing to them. If the user dirties the page while writeback is in 
progress, we'll take the page fault and re-dirty it _again_.

> page_mkclean_file() iterates the VMAs and when it finds a shared
> one it goes:
> 
> 		entry = ptep_clear_flush(vma, address, pte);
> 		entry = pte_wrprotect(entry);
> 		entry = pte_mkclean(entry);
> 
> and that's fine, but that PTE is still marked writable, and
> I think that's key.

No it's not. It's right there. "pte_wrprotect(entry)". You even copied it 
yourself.

> What does the fault path do in this situation?
> 
> 	if (write_access) {
> 		if (!pte_write(entry))
> 			return do_wp_page(mm, vma, address,
> 					pte, pmd, ptl, entry);

So we call "do_wp_page()", and that does everythign right.

		Linus
