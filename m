Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWHRTcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWHRTcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWHRTcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:32:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:9642 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932243AbWHRTcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:32:13 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kirill Korotaev <dev@sw.ru>, rohitseth@google.com,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>, Andi Kleen <ak@suse.de>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1155913165.28764.6.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
	 <1155835003.14617.45.camel@galaxy.corp.google.com> <44E57FB4.8090905@sw.ru>
	 <1155913165.28764.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 12:32:03 -0700
Message-Id: <1155929523.12204.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 15:59 +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-18 am 12:52 +0400, ysgrifennodd Kirill Korotaev:
> > > hmm, not sure why it is simpler.
> > because introducing additonal lookups/hashes etc. is harder and
> > adds another source for possible mistakes.
> > we can always optimize it out if people insist (by cost of slower accounting).
> 
> It ought to be cheap. Given each set of page structs is an array its a
> simple subtract and divide (or with care and people try to pack them
> nicely for cache lines - shift) to get to the parallel accounting array.

I wish page structs were just a simple array. ;)

It will just be a bit more code, but we'll need this for the two other
memory models: sparsemem and discontigmem.  For discontig, we'll just
need pointers in the pg_data_ts and, for sparsemem, we'll likely need
another pointer in the 'struct mem_section'.

This will effectively double the memory we need for sparsemem (because
we only use one pointer per SECTION_SIZE bytes of memory) but, that
should be just fine.

Is there ever any need to go from the accounting structure *back* to the
page?  I guess that might be the hard part with keeping parallel arrays,
if we even need it.

The reverse lookups might introduce a bit more pain with sparsemem and
discontig because, right now, we use bits in page->flags to help us go
find the containing node or the correct mem_section for the page.  

-- Dave

