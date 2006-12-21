Return-Path: <linux-kernel-owner+w=401wt.eu-S1422980AbWLURUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422980AbWLURUY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 12:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422984AbWLURUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 12:20:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52845 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422980AbWLURUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 12:20:22 -0500
Date: Thu, 21 Dec 2006 09:19:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Andrew Morton <akpm@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <1166669683.5909.52.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0612210915570.3394@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> 
 <1166571749.10372.178.camel@twins>  <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
  <1166605296.10372.191.camel@twins>  <1166607554.3365.1354.camel@laptopd505.fenrus.org>
  <1166614001.10372.205.camel@twins>  <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
  <1166622979.10372.224.camel@twins>  <20061220170323.GA12989@deprecation.cyrius.com>
  <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> 
 <20061220175309.GT30106@deprecation.cyrius.com>  <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
  <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>  <20061220153207.b2a0a27f.akpm@osdl.org>
  <Pine.LNX.4.64.0612201548410.3576@woody.osdl.org> <1166669683.5909.52.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Trond Myklebust wrote:
> 
> I can't see that it is the business of invalidate_inode_pages2() to
> resolve races between ->direct_IO() and pages that are redirtied by
> mmap(). All it needs to ensure is that pages that clean are discarded,
> since those are neither consistent with data that the ->directIO() call
> wrote to the disk nor are they scheduled to be written to disk.

Sure, we could happily just remove the -EIO. Alternatively, we could still 
do all the invalidates over the whole range, and return -EIO at the end of 
any of the pages weren't invalidated because they had to be written back. 

I don't personally care whether we should just return success or something 
to indicate that there were busy pages, but somebody who _uses_ direct-IO 
might want to know that the thing didn't throw away everything. If you 
know such users, can you ask them?

(Maybe "-EAGAIN" is better than "-EIO", since it's not really even a fatal 
error).

		Linus
