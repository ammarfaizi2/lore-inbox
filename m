Return-Path: <linux-kernel-owner+w=401wt.eu-S932655AbWLTAEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWLTAEf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWLTAEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:04:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47442 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932655AbWLTAEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:04:34 -0500
Date: Tue, 19 Dec 2006 16:03:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166569582.10372.165.camel@twins>
Message-ID: <Pine.LNX.4.64.0612191553140.6766@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <45876C65.7010301@yahoo.com.au>  <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
  <45878BE8.8010700@yahoo.com.au>  <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
  <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>  <4587B762.2030603@yahoo.com.au>
  <Pine.LNX.4.64.0612190847270.3479@woody.osdl.org> 
 <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org> 
 <Pine.LNX.4.64.0612191037291.3483@woody.osdl.org>  <1166563828.10372.162.camel@twins>
  <Pine.LNX.4.64.0612191451410.3483@woody.osdl.org>  <20061219145818.5b36381c.akpm@osdl.org>
 <1166569582.10372.165.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Peter Zijlstra wrote:

> On Tue, 2006-12-19 at 14:58 -0800, Andrew Morton wrote:
> 
> > Well... we'd need to see (corruption && this-not-triggering) to be sure.
> > 
> > Peter, have you been able to trigger the corruption?
> 
> Yes; however the mail I send describing that seems to be lost in space.

Btw, can somebody actually explain the mess that is ext3 "dirtying".

Ext3 does NOT use __set_page_dirty_buffers. It does

	static int ext3_journalled_set_page_dirty(struct page *page)
	{
	        SetPageChecked(page);
	        return __set_page_dirty_nobuffers(page);
	}

and uses that "Checked" bit as a "whole page is dirty" bit (which it tests 
in "writepage()".

You realize what this all means? It means that ANYTHING that actually 
clears the _real_ dirty bit won't actually be doing anything at all for 
ext3, because the Checked bit will still stay set, and any IO down the 
line on that page would totally ignore the dirty bits on the buffer heads 
and just write out everything.

That is "The Mess(tm)".

It also basically means that anything that clears the dirty bit without 
just calling "writepage()" had _better_ call "invalidatepage()" for the 
whole page, because otherwise the PageChecked bit will never be cleared as 
far as I can see. Happily, at least ext3 seems to _test_ for that case in 
the release_page() function, so it appears that we do do this.

But this seems to just strengthen my argument: you can NEVER clean a page, 
unless you (a) do IO on it immediately afterwards (writeback) or (b) 
invalidate it entirely (truncate).

I'd really like to see just those two functions exist. Preferably in a 
form where you can see easily that we actually follow those rules. Rather 
than having a confusing set of "clear_page_dirty()" and
"test_and_clear_page_dirty()" functions that are called from random 
places.

IOW, I think the "clear_page_dirty_for_io()" is fine (it's case (a)) 
above, and then we should probably have a "cancel_dirty_page()" function 
that does all the current clear_page_dirty() but also makes sure that we 
actually call the invalidate_page() function itself. 

Hmm?

			Linus
