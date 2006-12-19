Return-Path: <linux-kernel-owner+w=401wt.eu-S932572AbWLSA5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWLSA5t (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWLSA5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:57:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37353 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932572AbWLSA5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:57:48 -0500
Date: Mon, 18 Dec 2006 16:57:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166488199.6950.2.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612181648490.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <1166466272.10372.96.camel@twins>  <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
  <1166468651.6983.6.camel@localhost>  <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
  <1166471069.6940.4.camel@localhost>  <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
  <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>  <1166476297.6862.1.camel@localhost>
  <Pine.LNX.4.64.0612181426390.3479@woody.osdl.org>  <1166485691.6977.6.camel@localhost>
  <Pine.LNX.4.64.0612181559230.3479@woody.osdl.org> <1166488199.6950.2.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Andrei Popa wrote:
> > > 
> > > nope, no file corruption at all.
> > 
> > Ok. That's interesting, but I think you actually #ifdef'ed out too 
> > much:
> > 
> > It was really just the _inner_ "if (mapping_cap_account_dirty(.." 
> > statement that I meant you should remove.
> > 
> > Can you try that too?
> 
> I have file corruption: "Hash check on download completion found bad
> chunks, consider using "safe_sync"."

Ok, that's interesting.

So it doesn't seem to be the call to page_mkclean() itself that causes 
corruption. It looks like Peter's hunch that maybe there's some bug in 
PG_dirty handling _itself_ might be an idea..

And the reason it only started happening now is that it may just have been 
_hidden_ by the fact that while we kept the dirty bits in the page tables, 
we'd end up writing the dirty page _despite_ having lost the PG_dirty bit. 
So if it's some bad interaction between writable mappings and some other 
part of the system, we just didn't see it earlier, exactly because we had 
_lots_ of dirty bits, and it was enough that _one_ of them was right.

If you didn't see corruption when you #ifdef'ed out too much of the 
"test_clean_page_dirty() function (the _whole_ TestClearPageDirty() 
if-statement), but you get it when you just comment out the stuff that 
does the page_mkclean(), that's interesting.

I'm left lookin gat the "radix_tree_tag_clear()" in 
test_clear_page_dirty().

What happens if you only ifdef out that single thing? 

The actual page-cleaning functions make sure to only clear the TAG_DIRTY 
bit _after_ the page has been marked for writeback. Is there some ordering 
constraint there, perhaps?

I'm really reaching here. I'm trying to see the pattern, and I'm not 
seeing it. I'm asking you to test things just to get more of a feel for 
what triggers the failure, than because I actually have any kind of idea 
of what the heck is going on.

Andrew, Nick, Hugh - any ideas?

			Linus
