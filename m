Return-Path: <linux-kernel-owner+w=401wt.eu-S964810AbWL1AAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWL1AAQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWL1AAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:00:16 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:24997 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964810AbWL1AAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:00:13 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Martin Michlmayr <tbm@cyrius.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
In-Reply-To: <Pine.LNX.4.64.0612211134370.3536@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	 <1166622979.10372.224.camel@twins>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <1166652901.30008.1.camel@twins>
	 <Pine.LNX.4.64.0612201441030.3576@woody.osdl.org>
	 <1166655805.30008.18.camel@twins>  <1166692586.27750.4.camel@localhost>
	 <1166692812.32117.2.camel@twins>
	 <Pine.LNX.4.64.0612211134370.3536@woody.osdl.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 28 Dec 2006 01:00:00 +0100
Message-Id: <1167264000.5200.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-21 at 12:01 -0800, Linus Torvalds wrote:
> What do you guys think? Does something like this work out for S/390 too? I
> tried to make that "ptep_flush_dirty()" concept work for architectures
> that hide the dirty bit somewhere else too, but..

For s390 there are two aspects to consider:
1) the pte values are 100% software controlled. They only change because
a cpu stored a value to it or issued one of the specialized instructions
(csp, ipte and idte). The ptep_flush_dirty would be a nop for s390.
2) ptep_exchange is a bit dangerous. For s390 we need a lock that
protects the software controlled updates of the ptes. The reason is the
ipte instruction. It is implemented by the machine microcode in a
non-atomic way in regard to the memory. It reads the byte of the pte
that contains the invalid bit, flushes the tlb entries for it and then
writes back the byte with the invalid bit set. The microcode makes sure
that this pte cannot be used for form a new tlb on any cpu while the
ipte is in progress.
That means a compare-and-swap semantics on ptes won't work together with
the ipte optimization. As long as there is the pte lock that protects
all software accesses to the pte we are fine. But if any code expects
that ptep_exchange does something like an xchg things break.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


