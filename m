Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUCII3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 03:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUCII3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 03:29:51 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37044 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261779AbUCII3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 03:29:49 -0500
Date: Tue, 9 Mar 2004 09:31:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309083103.GB8021@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org> <20040308132305.3c35e90a.akpm@osdl.org> <20040308230247.GC12612@dualathlon.random> <20040308152126.54f4f681.akpm@osdl.org> <20040308234014.GG12612@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308234014.GG12612@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> btw (for completeness), about the cpu consumption concerns about
> objrmap w.r.t. security (that was Ingo's only argument against
> objrmap),

ugh? This is not my main argument against 'objrmap'. My main (and pretty
much only) argument against it is the linear searching it reintroduces.
I.e. in your patch you do this, in 3 key areas:

 +int page_convert_anon(struct page *page)
 ...
 +       list_for_each_entry(vma, &mapping->i_mmap, shared) {
 ...
 +       list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
 ...

 +static int
 +page_referenced_obj(struct page *page)
 ...
 +       list_for_each_entry(vma, &mapping->i_mmap, shared)
 ...
 +       list_for_each_entry(vma, &mapping->i_mmap_shared, shared)
 ...

 +static int
 +try_to_unmap_obj(struct page *page)
 ...
 +       list_for_each_entry(vma, &mapping->i_mmap, shared) {
 ...
 +       list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
 ...

the length of these lists ~equals to the number of processes mapping
said inode (the 'sharing factor'). I.e. the more processes, the bigger
box, the longer lists. The more advanced computers get, the longer the
lists get too. A scalability nightmare in the making.

with rmap we do have the ability to make it truly O(1) all across, by
making the pte chains a double linked list. Moreover, we can freely
reduce the rmap overhead (both the memory, algorithmic and locking
overhead) by increasing the page size - a natural thing to do on big
boxes anyway. The increasing of the page size also linearly _reduces_
the RAM footprint of rmap. So rmap and pgcl are a natural fit and the
thing of the future.

now, the linear searching of vmas does not reduce with increased
page-size. In fact, it will increase in time as the sharing factor
increases.

do you see what i'm worried about?

	Ingo
