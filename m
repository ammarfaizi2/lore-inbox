Return-Path: <linux-kernel-owner+w=401wt.eu-S1161049AbWLTX4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWLTX4g (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWLTX4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:56:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50047 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161038AbWLTX43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:56:29 -0500
Date: Wed, 20 Dec 2006 15:55:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Chinner <dgc@sgi.com>
cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
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
In-Reply-To: <20061220232401.GB44411608@melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0612201543540.3576@woody.osdl.org>
References: <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org>
 <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
 <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <20061220232401.GB44411608@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Dec 2006, David Chinner wrote:
> 
> XFS appears to call clear_page_dirty to get the mapping tree dirty
> tag set correctly at the same time the page dirty flag is cleared. I
> note that this can be done by set_page_writeback() if we clear the
> dirty flag on the page first when we are writing back the entire page.

Yes. I think the XFS routine should just use "clear_page_dirty_fir_io()", 
since that matches what it actually wants to do (surprise surprise, it's 
going to write it out).

HOWEVER. Why is it conditional? Can somebody who understands XFS tell me 
why "clear_dirty" would ever be 0? I can grep the sources, and I see that 
it's an unconditional 1 in one call-site, but then in the other one it 
does

	xfs_start_page_writeback(page, wbc, !page_dirty, count);

and that part just blows my mind. Why would you do a 
xfs_start_page_writeback() and _not_ write the page out? Is this for a 
partial-page-only case?

Anyway, your patch looks fine. It seems to be the right thing to do. I'm 
just wondering why we're not always cleaning the whole page, and why we'd 
not set it unconditionally dirty?

			Linus
