Return-Path: <linux-kernel-owner+w=401wt.eu-S965089AbWLTO1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWLTO1b (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWLTO1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:27:31 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:48450 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965089AbWLTO13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:27:29 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrei Popa <andrei.popa@i-neo.ro>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <1166605296.10372.191.camel@twins>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 20 Dec 2006 15:27:13 +0100
Message-Id: <1166624834.4221.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 10:01 +0100, Peter Zijlstra wrote:
> Also, what is this page_test_and_clear_dirty() business, that seems to
> be exclusively s390 btw. However they do seem to need this.
> 
> > But the "ptep_get_and_clear() + flush_tlb_page()" sequence should
> > hopefully also work.
> 
> Yeah, probably, not optimally so on some archs that don't actually need
> the flush though. And as above, I wonder about s390.

Simple, the s390 architecture does not keep the dirty bit in the pte but
in something called the storage key. For each physical page there is one
associated storage key. It is accessed with special instructions like
"iske", "sske" or "rrbe". To clear the dirty bit the storage key of a
page is read with iske, the bit is cleared and the storage key is stored
back with sske. That means that clearing the dirty bit is not an atomic
operation. rrbe is used to test and clear the referenced bit (young/old
infomation) and is atomic in regard to other storage key operations. If
you think about it, the storage keys are quite nice for the operating
system, page_referenced() can be implemented with a single test
"page_test_and_clear_young()". No need to read all the ptes pointing to
the page. The downside is that the storage keys have a cost on the
hardware side.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


