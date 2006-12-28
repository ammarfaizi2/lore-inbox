Return-Path: <linux-kernel-owner+w=401wt.eu-S964837AbWL1AnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWL1AnG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWL1AnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:43:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46679 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964837AbWL1AnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:43:04 -0500
Date: Wed, 27 Dec 2006 16:42:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Martin Michlmayr <tbm@cyrius.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <1167264000.5200.21.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612271639510.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> 
 <1166571749.10372.178.camel@twins>  <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
  <1166605296.10372.191.camel@twins>  <1166607554.3365.1354.camel@laptopd505.fenrus.org>
  <1166614001.10372.205.camel@twins>  <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
  <1166622979.10372.224.camel@twins>  <20061220170323.GA12989@deprecation.cyrius.com>
  <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> 
 <20061220175309.GT30106@deprecation.cyrius.com>  <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
  <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>  <1166652901.30008.1.camel@twins>
  <Pine.LNX.4.64.0612201441030.3576@woody.osdl.org>  <1166655805.30008.18.camel@twins>
  <1166692586.27750.4.camel@localhost>  <1166692812.32117.2.camel@twins> 
 <Pine.LNX.4.64.0612211134370.3536@woody.osdl.org> <1167264000.5200.21.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2006, Martin Schwidefsky wrote:
> 
> For s390 there are two aspects to consider:
> 1) the pte values are 100% software controlled.

That's fine. In that situation, you shouldn't need any atomic ops at all, 
I think all our sw page-table operations are already done under the pte 
lock. 

The reason x86 needs to be careful is exactly the fact that the hardware 
will obviously do a lot on its own, and the hardware is _not_ going to 
honor our page table locking ;)

In an all-sw situation, a lot of this should be easier. S390 has _other_ 
things that are inconvenient (the strange "dirty bit is not in the page 
tables" thing that makes it look different from everybody else), but hey, 
it's a balance..

So for s390, ptep_exchange() in my example should be able to be a simple 
"load old value and store new one", assuming everybody honors the pte lock 
(and they _should_).

		Linus
