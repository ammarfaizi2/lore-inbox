Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbUKQDNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbUKQDNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbUKQDNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:13:34 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:65379 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262179AbUKQDNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:13:16 -0500
Message-ID: <419AC1C6.4050403@yahoo.com.au>
Date: Wed, 17 Nov 2004 14:13:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, dhowells@redhat.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Making compound pages mandatory
References: <2315.1100630906@redhat.com>	<Pine.LNX.4.58.0411161746110.2222@ppc970.osdl.org> <20041116182841.4ff7f2e5.akpm@osdl.org>
In-Reply-To: <20041116182841.4ff7f2e5.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080607060207090307060607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080607060207090307060607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>
>>
>>On Tue, 16 Nov 2004, David Howells wrote:
>>
>>>Do you have any objection to compound pages being made mandatory, even without
>>>HUGETLB support?
>>
>>I haven't really looked into it, so I cannot make an informed decision.  
>>How big is the overhead? And what's the _point_, since we don't seem to 
>>need them normally, but the code is there for people who _do_ need them? 
> 
> 
> Yes, it's just the single pointer chase.  Probably that's the common case
> now, because everyone will be enabling hugepages on lots of architectures.
> 
> But still, the non-compound code is well tested too, and leaving it in
> place does make a little microoptimisation available to those who want it,
> so I don't see a reason yet to make compound pages compulsory.
> 
> So I'd suggest that we make compound pages conditional on a new
> CONFIG_COMPOUND_PAGE and make that equal to HUGETLB_PAGE || !MMU.

Good idea. BTW, any reason why the following (very)micro optimisation
shouldn't go in?

It currently only picks up a couple of things under fs/, but might help
reduce other ifdefery around the place. For example mm.h: page_count and
get_page.

--------------080607060207090307060607
Content-Type: text/x-patch;
 name="mm-page_compound-microopt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-page_compound-microopt.patch"




---

 linux-2.6-npiggin/include/linux/page-flags.h |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN include/linux/page-flags.h~mm-page_compound-microopt include/linux/page-flags.h
--- linux-2.6/include/linux/page-flags.h~mm-page_compound-microopt	2004-11-17 14:02:44.000000000 +1100
+++ linux-2.6-npiggin/include/linux/page-flags.h	2004-11-17 14:09:07.000000000 +1100
@@ -286,7 +286,11 @@ extern unsigned long __read_page_state(u
 #define ClearPageReclaim(page)	clear_bit(PG_reclaim, &(page)->flags)
 #define TestClearPageReclaim(page) test_and_clear_bit(PG_reclaim, &(page)->flags)
 
+#ifdef CONFIG_HUGETLB_PAGE
 #define PageCompound(page)	test_bit(PG_compound, &(page)->flags)
+#else
+#define PageCompound(page)	0
+#endif
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 

_

--------------080607060207090307060607--
