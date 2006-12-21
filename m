Return-Path: <linux-kernel-owner+w=401wt.eu-S1161052AbWLUAXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWLUAXP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWLUAXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:23:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52409 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161052AbWLUAXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:23:12 -0500
Date: Wed, 20 Dec 2006 16:22:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
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
In-Reply-To: <20061220161158.acb77ce6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612201615590.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
 <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
 <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org>
 <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
 <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <20061220153207.b2a0a27f.akpm@osdl.org>
 <Pine.LNX.4.64.0612201548410.3576@woody.osdl.org> <20061220161158.acb77ce6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Andrew Morton wrote:
> > 
> > So with my change, afaik, we will just return EIO to the invalidate, and 
> > do the write.
> 
> The write's already been done by this stage.

Ok, but the end result is the same: you MUST NOT just "cancel" a write. It 
needs to be done, or the backing store must be actually de-allocated. You 
can't just say "get rid of it" and think that it can work. Exactly because 
of security issues, and just the simple fact that reading it back gets 
random contents.

So I repeat: clearing a dirty bit really only has two valid cases. Not 
three, like we used to have. And the "cancel" case cannot be conditional: 
either you can cancel it or you cannot. There's no

	if (cancel_dirty_page()) {
			..

sequence that makes sense that I can think of.

> > It really boils down to that same thing: if you remove the dirty bit, 
> > there is NO CONCEIVABLE GOOD THING YOU CAN DO EXCEPT FOR:
> >  - do the damn IO already ("clear_page_dirty_for_io()")
> >  - truncate the page (unmap and destroy it both from page cache AND from 
> >    any user-visible filesystem cases)
> 
> There's also redirty_page_for_writepage().

_dirtying_ a page makes sense in any situation. You can always dirty them. 
I'm just saying that you can't just mark them *clean*.

If your point was that the filesystem had better be able to take care of 
"redirty_page_for_writepage()", then yes, of course. But since it's the 
filesystem itself that does it, it had _better_ be able to take care of 
the situation it puts itself into.

			Linus
