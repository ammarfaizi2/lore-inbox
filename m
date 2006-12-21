Return-Path: <linux-kernel-owner+w=401wt.eu-S1422838AbWLUIMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbWLUIMS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbWLUIMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:12:18 -0500
Received: from amsfep15-int.chello.nl ([62.179.120.10]:63676 "EHLO
	amsfep15-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1422838AbWLUIMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:12:17 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
In-Reply-To: <1166668598.5909.38.camel@lade.trondhjem.org>
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
	 <1166668598.5909.38.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 09:10:38 +0100
Message-Id: <1166688638.30008.22.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 21:36 -0500, Trond Myklebust wrote:
> On Wed, 2006-12-20 at 23:15 +0100, Peter Zijlstra wrote:
> > I think this is also needed:
> 
> NAK
> 
> invalidate_inode_pages2() should _not_ be pretending that dirty pages
> are clean. This patch is incorrect both for the NFS usage and for the
> directIO usage.
> 
> In the latter case, if someone has the page mmapped, resulting in the
> page getting marked as dirty _after_ a directIO write, then it would be
> wrong to discard that data. Only dirty data from _before_ the directIO
> write should needs to be discarded (and that is achieved by unmapping,
> then cleaning the page prior to the directIO call)...
> 
> For the NFS case, the race is a bit more tricky, since you have the
> "unstable write" case which means that the page is neither marked as
> dirty, nor is entirely clean ('cos we don't know that the server has
> committed the data to permanent storage yet).

Then this patch:
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/broken-out/nfs-fix-nr_file_dirty-underflow.patch

is equally wrong, right?

