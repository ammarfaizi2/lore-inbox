Return-Path: <linux-kernel-owner+w=401wt.eu-S1753763AbWLRKoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbWLRKoK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753775AbWLRKoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:44:10 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:20705 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753763AbWLRKoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:44:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Cifm6Y/xQLELgRdiqhZXey94/FtuqvSyIgxHswycP4/RcxSzNuYrB90Qm1NCfl4aPokfN/jbpMJ6SfirxBxzaAB4Kn/lwMLBNbQhEEWVk1N4ZDIYsHKy9x4EbNMqIST9woiZ7lBKKH1xZSbgz7dRSrmjkAAWwpYRK+5dVysWFk0=  ;
X-YMail-OSG: V2pz2qEVM1l0PPP6yFF6jFGldzwMpe9nz9QhHkBDuaXgLf_.uKZ_gB0IJBSAigYP2.3RYENXhz.FSvRAO6v82JhKBv81iPHcKwCVECtIstzC9E7wvQn8dSHGsDmY.6G89WIPepupfsSsDRw-
Message-ID: <4586626C.9020300@yahoo.com.au>
Date: Mon, 18 Dec 2006 20:42:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost>	<20061217040620.91dac272.akpm@osdl.org>	<1166362772.8593.2.camel@localhost>	<20061217154026.219b294f.akpm@osdl.org>	<Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>	<Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>	<Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>	<45861E68.3060403@yahoo.com.au>	<20061217214308.62b9021a.akpm@osdl.org>	<458641C2.5010807@yahoo.com.au> <20061218011801.04ec66be.akpm@osdl.org>
In-Reply-To: <20061218011801.04ec66be.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 18 Dec 2006 18:22:42 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

 >>Yes I could believe it the corruption is caused by something else
 >>completely.
 >
 >
 > Think so.  We do have a problem here, but only on threaded apps, I believe.
 > rtorrent doesn't appear to be threaded, and the bug is hit on non-preempt
 > UP.

I think (see below) that it does not apply only to threaded apps. But
it would need one of SMP or PREEMPT to trigger.


>>After try_to_free_buffers detaches the buffers from the page, a
>>pagefault can come in, and mark the pte writeable, then set_page_dirty
>>(which finds no buffers, so only sets PG_dirty).
>>
>>The page can now get dirtied through this mapping.
>>
>>try_to_free_buffers then goes on to clean the page and ptes.
> 
> 
> try_to_free_buffers() isn't called against a page which doesn't have
> buffers.  It'll oops.

Sure. But I think the race exists... I'll try spelling it out in
the conventional way:

try_to_free_buffers()
   drop_buffers() (succeeds)

** preempt here or run right-hand thread on 2nd CPU in SMP **

                                do_no_page()
                                  set_page_dirty()

                                [now modify the page via this mapping
                                (from this process or a concurrent thread)]


   clear_page_dirty() (clears PG_dirty + pte dirty, oops)


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
