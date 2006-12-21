Return-Path: <linux-kernel-owner+w=401wt.eu-S1161054AbWLUAoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWLUAoT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbWLUAoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:44:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53838 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161054AbWLUAoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:44:18 -0500
Date: Wed, 20 Dec 2006 16:43:31 -0800 (PST)
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
In-Reply-To: <Pine.LNX.4.64.0612201615590.3576@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612201633300.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
 <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
 <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org>
 <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
 <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <20061220153207.b2a0a27f.akpm@osdl.org>
 <Pine.LNX.4.64.0612201548410.3576@woody.osdl.org> <20061220161158.acb77ce6.akpm@osdl.org>
 <Pine.LNX.4.64.0612201615590.3576@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Linus Torvalds wrote:
> > 
> > There's also redirty_page_for_writepage().
> 
> _dirtying_ a page makes sense in any situation. You can always dirty them. 
> I'm just saying that you can't just mark them *clean*.
> 
> If your point was that the filesystem had better be able to take care of 
> "redirty_page_for_writepage()", then yes, of course. But since it's the 
> filesystem itself that does it, it had _better_ be able to take care of 
> the situation it puts itself into.

Btw, as an example of something where this may NOT be ok, look at 
migrate_page_copy().

I'm not at all convinced that "migrate_page_copy()" can work at all. It 
does:

	...
        if (PageDirty(page)) {
                clear_page_dirty_for_io(page);
                set_page_dirty(newpage);
        }
	...

which is an example of what NOT to do, because it claims to clear the page 
for IO, but doesn't actually _do_ any IO.

And this is wrong, for many reasons. 

For example, it's very possible that the old page is not actually 
up-to-date, and is only partially dirty using some FS-specific dirty data 
queues (like NFS does with its dirty data, or buffer-heads can do for 
local filesystems). When you do

	if (clear_dirty(page))
		set_page_dirty(page);

in generic VM code, that is a BUG. It's an insane operation. It cannot 
work. It's exactly what I'm trying to avoid.

So page migration is probably broken, but it's no less broken than it 
always has been. And I don't think many people use it anyway. It might 
work "by accident" in a lot of situations, but to actually be solid, it 
really would need to do something fundamentally different, like:

 - have a per-mapping "migrate()" function that actually knows HOW to 
   migrate the dirty state from one page to another.

 - or, preferably, by just not migrating dirty pages, and just actually 
   doing the writeback on them first.

Again, this is an example of just _incorrect_ code, that thinks that it 
can "just clear the dirty bit". You can't do that. It's wrong. And it is 
not wrong just because I say so, but because the operations itself simply 
is FUNDAMENTALLY not a sensible one.

This is why I keep harping on this issue: there are two cases, and two 
cases only, when you can clear a page. And no, "migrating the data to 
another page" was not one of those two cases. The cases are, and will 
_always_ be: (a) full writeback IO of _all_ the dirty data on the page 
(and that can only be done by the low-level filesystem, since it's the 
only one that knows what rules it has followed for marking things dirty) 
and (b) cancelling dirty data that got truncated and literally removed 
from the filesystem.

So I don't claim that I fixed all the cases. mm/migrate.c is still broken. 
Maybe somebody else also uses "clear_page_dirty_for_io()" even though the 
name very clearly says FOR IO. I didn't check, but I think they're mostly 
right now.

		Linus
