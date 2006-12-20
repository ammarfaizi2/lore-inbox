Return-Path: <linux-kernel-owner+w=401wt.eu-S965043AbWLTNAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWLTNAn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWLTNAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:00:42 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:59365 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965043AbWLTNAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:00:41 -0500
X-AuditID: d80ac21c-a0b71bb0000050d2-eb-458933f87244 
Date: Wed, 20 Dec 2006 13:00:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <1166614001.10372.205.camel@twins>
Message-ID: <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <1166466272.10372.96.camel@twins>  <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
  <1166468651.6983.6.camel@localhost>  <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
  <1166471069.6940.4.camel@localhost>  <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
  <1166571749.10372.178.camel@twins>  <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
  <1166605296.10372.191.camel@twins>  <1166607554.3365.1354.camel@laptopd505.fenrus.org>
 <1166614001.10372.205.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Dec 2006 13:00:40.0423 (UTC) FILETIME=[D9CC5770:01C72436]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006, Peter Zijlstra wrote:
> 
> fix page_mkclean_one()

Congratulations on getting to the bottom of it, Peter (if you have:
I haven't digested enough of the thread to tell).  I'm mostly offline at
present, no time for dialogue, I'll throw out a few remarks and run...

> 
> it had several issues:
>  - it failed to flush the cache

It's unclear to me why it should need to flush the cache, but I don't
know much about that, and mprotect does flush the cache in advance -
I think others will tell you that if it does need to be flushed, it must
be flushed while there's still a valid pte (on some arches at least).

>  - it failed to flush the tlb

Eh?  It flushed the TLB inside ptep_establish, didn't it?
I guess you mean you've found a race before it flushed the TLB.

>  - it failed to do s390 (s390 guys, please verify this is now correct)

Hmm, I thought we cleared it with them back at the time.

> 
> Also, clear in a loop to ensure SMP safeness as suggested by Arjan.

Yikes.  Well, please compare with mprotect's change_pte_range.  I think
I took that as the relevant standard when checking your implementation,
and back then satisfied myself that what you were doing was equivalent.
If page_mkclean_one is now agreed to be significantly defective, then
I suspect change_pte_range is also; perhaps others too.

(But I haven't found time to do more than skim through the thread,
I've not thought through the issues at all: I am surprised that it's
now found defective, we looked at it long and hard back then.)

And trivial point: please undo those distracting "pte" to "ptep" mods:
if you want to call pte pointers ptep, throughout rmap.c and throughout
mm, that's another patch entirely (which I won't welcome, but others may).

Hugh
