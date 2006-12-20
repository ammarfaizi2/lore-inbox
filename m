Return-Path: <linux-kernel-owner+w=401wt.eu-S1161000AbWLTW72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWLTW72 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbWLTW72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:59:28 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39964 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161000AbWLTW70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:59:26 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
In-Reply-To: <Pine.LNX.4.64.0612201420140.3576@woody.osdl.org>
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
	 <1166651735.10211.9.camel@kleikamp.austin.ibm.com>
	 <Pine.LNX.4.64.0612201420140.3576@woody.osdl.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 16:59:13 -0600
Message-Id: <1166655553.9726.9.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 14:25 -0800, Linus Torvalds wrote:
> 
> On Wed, 20 Dec 2006, Dave Kleikamp wrote:
> >
> > This patch removes some questionable code that attempted to make a
> > no-longer-used page easier to reclaim.
> 
> If so, "cancel_dirty_page()" may actually be the right thing to use, but
> only if you can guarantee that the page isn't mapped anywhere (and from
> the name of the function I guess it's not something that you'll ever map?)

That's correct.  It can't be mapped.  It's a private mapping only used
for metadata.

I'm really not sure the code in question is having the intended effect.
Maybe one of the gurus on cc: can take a look at the code and tell me if
it's worth keeping.  I apologize in advance if it makes anyone lose
their lunch.

> So the JFS code _looks_ like you could just replace the
> 
> 	clear_page_dirty(page);
> 
> with
> 
> 	cancel_dirty_page(page, PAGE_CACHE_SIZE);
> 
> (where that second parameter is just used for statistics - it updates the
> "cancelled IO" byte-counts if CONFIG_TASK_IO_ACCOUNTING is set - so the
> number doesn't really matter, you could make it zero if you never want the
> thing to show up in the IO accounting).

I'm not sure whether zero or PAGE_CACHE_SIZE would be better.  The
situation is where some page of metadata is no longer used, say
shrinking a directory tree or truncating a file and throwing out the
extent tree.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

