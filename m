Return-Path: <linux-kernel-owner+w=401wt.eu-S1754490AbWLRUOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbWLRUOv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754523AbWLRUOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:14:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42816 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754490AbWLRUOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:14:51 -0500
Date: Mon, 18 Dec 2006 12:14:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166471069.6940.4.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <1166466272.10372.96.camel@twins>  <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
  <1166468651.6983.6.camel@localhost>  <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
 <1166471069.6940.4.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Andrei Popa wrote:
> 
> I dropped that patch and added WARN_ON(1), the unified patch is
> attached.
> 
> I got corruption: "Hash check on download completion found bad chunks,
> consider using "safe_sync"."

Ok. That is actually _very_ interesting.

It's interesting because (a) the corruption obviously goes away with the 
one-liner that effectively disables "page_mkclean_one()".

So that tells us that yes, it's a PTE dirty bit that matters.

But at the same time, it's interesting that it still happens when we try 
to re-add the dirty bit. That would tell me that it's one of two cases:

 - there is another caller of page cleaning that should have done the same 
   thing (we could check that by just doing this all _inside_ the 
   page_mkclean() thing)

OR:

 - page_mkclean_one() is simply buggy.

And I'm starting to wonder about the second case. But it all LOOKS really 
fine - I can't see anything wrong there (it uses the extremely 
conservative "ptep_get_and_clear()", and seems to flush everything right 
too, through "ptep_establish()").

		Linus
