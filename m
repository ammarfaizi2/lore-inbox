Return-Path: <linux-kernel-owner+w=401wt.eu-S1030400AbWLTWa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWLTWa5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWLTWa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:30:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45125 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030400AbWLTWa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:30:56 -0500
Date: Wed, 20 Dec 2006 14:25:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
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
In-Reply-To: <1166651735.10211.9.camel@kleikamp.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0612201420140.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> 
 <1166571749.10372.178.camel@twins>  <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
  <1166605296.10372.191.camel@twins>  <1166607554.3365.1354.camel@laptopd505.fenrus.org>
  <1166614001.10372.205.camel@twins>  <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
  <1166622979.10372.224.camel@twins>  <20061220170323.GA12989@deprecation.cyrius.com>
  <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> 
 <20061220175309.GT30106@deprecation.cyrius.com>  <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
  <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
 <1166651735.10211.9.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Dave Kleikamp wrote:
> 
> This patch removes some questionable code that attempted to make a
> no-longer-used page easier to reclaim.

If so, "cancel_dirty_page()" may actually be the right thing to use, but 
only if you can guarantee that the page isn't mapped anywhere (and from 
the name of the function I guess it's not something that you'll ever map?)

So the JFS code _looks_ like you could just replace the

	clear_page_dirty(page);

with

	cancel_dirty_page(page, PAGE_CACHE_SIZE);

(where that second parameter is just used for statistics - it updates the 
"cancelled IO" byte-counts if CONFIG_TASK_IO_ACCOUNTING is set - so the 
number doesn't really matter, you could make it zero if you never want the 
thing to show up in the IO accounting).

			Linus
