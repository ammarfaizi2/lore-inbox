Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVHHVJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVHHVJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVHHVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:09:47 -0400
Received: from smtp.istop.com ([66.11.167.126]:19431 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932234AbVHHVJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:09:46 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Tue, 9 Aug 2005 07:09:59 +1000
User-Agent: KMail/1.7.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <42F57FCA.9040805@yahoo.com.au>
In-Reply-To: <42F57FCA.9040805@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508090710.00637.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 August 2005 13:28, Nick Piggin wrote:
> Hi,
>
> I'll be looking to send these off to Andrew after 2.6.14 opens,
> with the aim of having them merged by 2.6.15 hopefully.
>
> It doesn't look like they'll be able to easily free up a page
> flag for 2 reasons. First, PageReserved will probably be kept
> around for at least one release. Second, swsusp and some arch
> code (ioremap) wants to know about struct pages that don't point
> to valid RAM - currently they use PageReserved, but we'll probably
> just introduce a PageValidRAM or something when PageReserved goes.
>
> I believe this makes memory management cleaner and easier to
> understand.

Agreed, I've always looked askance at that particular page flag.  (Suggestion 
for your next act: 

> My other reason behind this is that the lockless 
> pagecache patches needs it for sane page refcounting.
>
> If anyone has an issue with the patches or my merge plan, let's
> get some discussion going.

You forgot to mention what replaces PageReserved: the VM_RESERVED vma flag, 
which is now added to the whole zap_pte call chain.  A slight efficiency win?  
Anyway, it looks like forward progress because some inner loops are a little 
straighter.  I've always wondered what PG_reserved was actually doing, and 
now I know: compensating for the missing vma parameter in the zap call 
chains.

Why don't you pass the vma in zap_details?  For that matter, why are addr and 
end still passed down the zap chain when zap_details appears to duplicate 
that information?  OK, it is because zap_details is NULL in about twice as 
many places as it carries data.  But since the details parameter is already 
there, would it not make sense to press it into service to slim down those 
parameter lists a little?

What stops swsusp from also using the vma flag?  Why does swsusp need both 
PG_reserved and PG_nosave?

Is there automated testing planned for this one?  It looks right as closely as 
I've read, but it tickles an awful lot of code.

Regards,

Daniel
