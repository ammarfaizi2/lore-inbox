Return-Path: <linux-kernel-owner+w=401wt.eu-S1030414AbWLTWta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWLTWta (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWLTWta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:49:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46350 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030414AbWLTWt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:49:29 -0500
Date: Wed, 20 Dec 2006 14:49:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Martin Michlmayr <tbm@cyrius.com>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <1166652901.30008.1.camel@twins>
Message-ID: <Pine.LNX.4.64.0612201441030.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> 
 <1166571749.10372.178.camel@twins>  <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
  <1166605296.10372.191.camel@twins>  <1166607554.3365.1354.camel@laptopd505.fenrus.org>
  <1166614001.10372.205.camel@twins>  <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
  <1166622979.10372.224.camel@twins>  <20061220170323.GA12989@deprecation.cyrius.com>
  <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> 
 <20061220175309.GT30106@deprecation.cyrius.com>  <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
  <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <1166652901.30008.1.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Peter Zijlstra wrote:
>
> I think this is also needed:

Yeah, that looks about right. Although I think it should go above the 
"try_to_release_page()", because right now we do that "ttrp()" with the 
dirty bit set, and we should let the low-level filesystem just know that 
it's simply not interesting any more (and, indeed, "try_to_free_buffers()" 
too, for that matter).

Anyway, I think that's a detail. I'd rather know whether this all actually 
makes any difference what-so-ever to the corruption behaviour of Andrei 
&co. 

Maybe the UP ARM case is some strange dcache alias issue with PIO IDE, and 
the only reason that started showing up at the same time is the different 
IO loads. Who knows.

[ Although I think you may have been on the right track with that dcache 
  flushing stuff in "page_mkclean()".. It might not have been quite 
  all there, but I think we should go back and look very closely at 
  page_mkclean() regardless of any other issues! ]

So far, my whole "cancel_dirty_page/clean_page_dirty_for_io" patch has 
really been just a "try to make the code _look_ sane. I don't think we 
have a single report that the patch actually makes any difference yet.

		Linus
