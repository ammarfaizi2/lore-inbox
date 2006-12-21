Return-Path: <linux-kernel-owner+w=401wt.eu-S1161102AbWLUBUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWLUBUg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWLUBUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:20:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55801 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161102AbWLUBUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:20:35 -0500
Date: Wed, 20 Dec 2006 17:20:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
Message-Id: <20061220172009.b0e4246b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612201633300.3576@woody.osdl.org>
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
	<20061220153207.b2a0a27f.akpm@osdl.org>
	<Pine.LNX.4.64.0612201548410.3576@woody.osdl.org>
	<20061220161158.acb77ce6.akpm@osdl.org>
	<Pine.LNX.4.64.0612201615590.3576@woody.osdl.org>
	<Pine.LNX.4.64.0612201633300.3576@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 16:43:31 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Wed, 20 Dec 2006, Linus Torvalds wrote:
> > > 
> > > There's also redirty_page_for_writepage().
> > 
> > _dirtying_ a page makes sense in any situation. You can always dirty them. 
> > I'm just saying that you can't just mark them *clean*.
> > 
> > If your point was that the filesystem had better be able to take care of 
> > "redirty_page_for_writepage()", then yes, of course. But since it's the 
> > filesystem itself that does it, it had _better_ be able to take care of 
> > the situation it puts itself into.
> 
> Btw, as an example of something where this may NOT be ok, look at 
> migrate_page_copy().
> 
> I'm not at all convinced that "migrate_page_copy()" can work at all. It 
> does:
> 
> 	...
>         if (PageDirty(page)) {
>                 clear_page_dirty_for_io(page);
>                 set_page_dirty(newpage);

Note that this is referring to different pages.

>         }
> 	...
> 
> which is an example of what NOT to do, because it claims to clear the page 
> for IO, but doesn't actually _do_ any IO.
> 
> And this is wrong, for many reasons. 
>
> For example, it's very possible that the old page is not actually 
> up-to-date, and is only partially dirty using some FS-specific dirty data 
> queues (like NFS does with its dirty data, or buffer-heads can do for 
> local filesystems).

afaict the code copes with those things.

> When you do
> 
> 	if (clear_dirty(page))
> 		set_page_dirty(page);
> 
> in generic VM code, that is a BUG. It's an insane operation. It cannot 
> work. It's exactly what I'm trying to avoid.

These are different pages.

We could view the copy_highpage() in migrate_page_copy() as an "io"
operation, only the backing store is a new pagecache page.

It'd be more logical if that copy_highpage() was occurring after the
clear_page_dirty_for_io().

I'm not sure why migrate_page_copy() is playing with
PageWriteback(newpage).  Surely newpage is locked, in which case nobody
will be starting writeback on it.

> So page migration is probably broken, but it's no less broken than it 
> always has been. And I don't think many people use it anyway. It might 
> work "by accident" in a lot of situations, but to actually be solid, it 
> really would need to do something fundamentally different, like:
> 
>  - have a per-mapping "migrate()" function that actually knows HOW to 
>    migrate the dirty state from one page to another.

That is how it's presently implemented.  You're looking at helper functions
which fileystems may point their address_space_operations.migratepage at.

>  - or, preferably, by just not migrating dirty pages, and just actually 
>    doing the writeback on them first.
> 
> Again, this is an example of just _incorrect_ code, that thinks that it 
> can "just clear the dirty bit". You can't do that. It's wrong. And it is 
> not wrong just because I say so, but because the operations itself simply 
> is FUNDAMENTALLY not a sensible one.

The dirty state is being transferred to the new page.  The tricky part is
handling the cases where these pages are mapped into pagetables.  That's
what the special migration ptes are there for.  I'll let Christoph explain
that lot ;)

