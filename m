Return-Path: <linux-kernel-owner+w=401wt.eu-S1753087AbWLRFYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbWLRFYB (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 00:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbWLRFYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 00:24:00 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:30622 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753087AbWLRFYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 00:24:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1XRrFVKlbI8Rm49ASEzffZ9E55DYdxGIEm7yvd5eLhAm/8cHHjIJ7fKjiPpR/ct/2l6riv54Go3/ehn7GS9P6CSomWX4ozEL0Upn1blU4vZUIvUmnG1fbDScoFygdizTqpL00tKlGZCmY/oyjVJBb7zYialNiy3wrUaZuRTvHfw=  ;
X-YMail-OSG: HhHKtSgVM1n.qiPrOB166a.2Wh1GJ5.zPG1mTIeo1NLa2l1uKiY2kVmDqXXHT_0ooezxwmxAjloA0dP2IWT1bCe1r99Lopk1z8LQ6nai8OUKGGDrvvg9te0qIR72kSvQx3sge9.VOrxGDvw-
Message-ID: <45861E68.3060403@yahoo.com.au>
Date: Mon, 18 Dec 2006 15:51:52 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org> <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org> <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org> <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> [ Replying to myself - a sure sign that I don't get out enough ]
> 
> On Sun, 17 Dec 2006, Linus Torvalds wrote:
> 
>>So I don't actually see any serialization at all that would keep a random 
>>page from being paged back in.
> 
> 
> We do actually serialize, but we do it _after_ the page has already been 
> mapped back. Ie we do it for the dirty page case at rthe end of 
> do_wp_page() and do_no_page() when we do the "set_page_dirty_balance()", 
> but that's potentially too late - we've already mapped the page read-write 
> into the address space.

I can't see how that's exactly a problem -- so long as the page does not
get reclaimed (it won't, because we have a ref on it) then all that matters
is that the page eventually gets marked dirty.

> That said, this means that only threaded apps should ever trigger any 
> problems, which would seem to make it unlikely that this is the issue.
> 
> But Andrew: I don't think it's necessarily true that 
> "try_to_free_buffers()" callers have all unmapped the page.
> 
> That seems to be true for vmscan.c (ie the shrink_page_list -> 
> try_to_release_page -> try_to_release_buffers callchain), but what about 
> the other callchains (through filesystems, or through "pagevec_strip()" or 
> similar?) That pagevec_strip() is called from shrink_active_list(), I 
> don't see that unmapping the pages..

Right. But would it really matter whether they are currently mapped or
not, given that we agree it may become mapped at any point?

I think the problem Andrew identified is real.

The issue is the disconnect between the pte dirtiness and a filesystem
bringing buffers clean. But I disagree with his fix, because we don't
actually want to just throw out that pte dirtiness information: we're
just trying to get the PG_dirty bit into synch with what the buffers are
telling us, not actually clean or dirty anything, as such.

Can we clear the page dirty bit, then run set_page_dirty afterwards, if
any dirty ptes are found?

The other thing we might be able to do is to skip doing the
clear_page_dirty if the page is uptodate. This feels more hackish but it
might be faster?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
