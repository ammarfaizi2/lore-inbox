Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUDAQ4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbUDAQ4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:56:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16848 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262954AbUDAQ4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:56:31 -0500
Subject: s390 storage key inconsistency?  [was Re: msync() behaviour broken
	for MS_ASYNC, revert patch?]
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jamie Lokier <jamie@shareable.org>,
       Linux on 390 Port <linux-390@vm.marist.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040401161949.GC25502@mail.shareable.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0403311433240.1116@ppc970.osdl.org>
	 <1080776487.1991.113.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0403311550040.1116@ppc970.osdl.org>
	 <1080834032.2626.94.camel@sisko.scot.redhat.com>
	 <20040401161949.GC25502@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1080838581.2626.136.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Apr 2004 17:56:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-04-01 at 17:19, Jamie Lokier wrote:

> Some documentation I'm looking at says MS_INVALIDATE updates the
> mapped page to contain the current contents of the file.  2.6.4 seems
> to do the reverse: update the file to contain the current content of
> the mapped page.  "man msync" agrees with the the latter.  (I can't
> look at SUS right now).

btw, just looking at the filemap_sync_pte() code for MS_INVALIDATE, I
noticed

	if (!PageReserved(page) &&
	    (ptep_clear_flush_dirty(vma, address, ptep) ||
	     page_test_and_clear_dirty(page)))
		set_page_dirty(page);

I just happened to follow the function and noticed that on s390,
page_test_and_clear_dirty() has the comment:

* Test and clear dirty bit in storage key.
* We can't clear the changed bit atomically. This is a potential
* race against modification of the referenced bit. This function
* should therefore only be called if it is not mapped in any
* address space.

but in this case the page is clearly mapped in the caller's address
space, else we wouldn't have reached this.

Is this a problem?

--Stephen



