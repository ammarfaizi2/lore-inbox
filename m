Return-Path: <linux-kernel-owner+w=401wt.eu-S932704AbWLSJBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWLSJBW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbWLSJBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:01:22 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:56119 "EHLO
	amsfep11-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932700AbWLSJBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:01:21 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <45876C65.7010301@yahoo.com.au>
	 <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	 <45878BE8.8010700@yahoo.com.au>
	 <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 10:00:10 +0100
Message-Id: <1166518810.10372.127.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 00:04 -0800, Linus Torvalds wrote:

> Nobody has actually ever explained why "test_clear_page_dirty()" is good 
> at all.
> 
>  - Why is it ever used instead of "clear_page_dirty_for_io()"?
> 
>  - What is the difference?
> 
>  - Why would you EVER want to clear bits just in the "struct page *" or 
>    just in the PTE's?
> 
>  - Why is it EVER correct to clear dirty bits except JUST BEFORE THE IO?
> 
> In other words, I have a theory:
> 
>  "A lot of this is actually historical cruft. Some of it may even be code 
>   that was never supposed to work, but because we maintained _other_ dirty 
>   bits in the PTE's, and never touched them before, we never even realized 
>   that the code that played with PG_dirty was totally insane"
> 
> Now, that's just a theory. And yeah, it may be stated a bit provocatively. 
> It may not be entirely correct. I'm just saying.. maybe it is?

On Sun, 2006-12-17 at 15:40 -0800, Andrew Morton wrote:

> try_to_free_buffers() clears the page's dirty state if it successfully removed
> the page's buffers.
> 
>   Background for this:
> 
>   - a process does a one-byte-write to a file on a 64k pagesize, 4k
>     blocksize ext3 filesystem.  The page is now PageDirty, !PgeUptodate and
>     has one dirty buffer and 15 not uptodate buffers.
> 
>   - kjournald writes the dirty buffer.  The page is now PageDirty,
>     !PageUptodate and has a mix of clean and not uptodate buffers.
> 
>   - try_to_free_buffers() removes the page's buffers.  It MUST now clear
>     PageDirty.  If we were to leave the page dirty then we'd have a dirty, not
>     uptodate page with no buffer_heads.
> 
>     We're screwed: we cannot write the page because we don't know which
>     sections of it contain garbage.  We cannot read the page because we don't
>     know which sections of it contain modified data.  We cannot free the page
>     because it is dirty.

However!! this is not true for mapped pages because mapped pages must
have the whole (16k in akpm's example) page loaded. Hence I suspect that
what Andrei did by accident - remove the if (mapping) case in
test_clean_dirty_pages() - is actually totally correct.



