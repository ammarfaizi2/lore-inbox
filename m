Return-Path: <linux-kernel-owner+w=401wt.eu-S1753559AbWLRJBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbWLRJBs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbWLRJBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:01:47 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:29778 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753559AbWLRJBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:01:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=O5hsg8pQcFMHIvOz7iQS/6iqZ4wPv1ai8/DOZLZn8l7WPwR1LX6AF/5o7q3xem+w+lPdzIptgqjgJe/V5IBruY00D8f1R09H01r4a61MPy9Z4bdMnfSWdsCJabPJFV1Lbq3PAlHWWcn1RMIOQ3CDS3+RYEMjn2S+34teLZ+XTpU=  ;
X-YMail-OSG: csh00NAVM1lub.ueeRiqSvmSdi9bWBpqyRjjxCS5uw8RdYXlP7.qZMNTv9UAPo1TxVcgfy.a9t3HNRplzQMyQdiHDN0lggFMFm6AB9B1HwSC4o0MukEf1lIpTlOwVJtW1tryEU_YvqeG4dU-
Message-ID: <458641C2.5010807@yahoo.com.au>
Date: Mon, 18 Dec 2006 18:22:42 +1100
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
References: <1166314399.7018.6.camel@localhost>	<20061217040620.91dac272.akpm@osdl.org>	<1166362772.8593.2.camel@localhost>	<20061217154026.219b294f.akpm@osdl.org>	<Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>	<Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>	<Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>	<45861E68.3060403@yahoo.com.au> <20061217214308.62b9021a.akpm@osdl.org>
In-Reply-To: <20061217214308.62b9021a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 18 Dec 2006 15:51:52 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>I think the problem Andrew identified is real.
> 
> 
> I don't.  In fact I don't think I described any problem (well, I tried to,
> but then I contradicted myself).

By saying that there shouldn't be any dirty ptes if there are no
dirty buffers? But in that case the _page_ shouldn't be dirty either,
so that clear_page_dirty would be redundant. But presumably it isn't.

> Six hours here of fsx-linux plus high memory pressure on SMP on 1k
> blocksize ext3, mainline.  Zero failures.  It's unlikely that this testing
> would pass, yet people running normal workloads are able to easily trigger
> failures.  I suspect we're looking in the wrong place.

Yes I could believe it the corruption is caused by something else
completely.

>>The issue is the disconnect between the pte dirtiness and a filesystem
>>bringing buffers clean.
> 
> 
> Really?  The dirtying direction goes pte_dirty->PG_dirty->BH_Dirty and the
> cleaning direction goes !BH_Dirty->!PG_dirty->!pte_dirty.  That's pretty
> simple, setting aside races.
> 
> In the try_to_free_buffers case there's a large time inverval between
> !BH_Dirty and !PG_dirty, but that shouldn't affect anything.

After try_to_free_buffers detaches the buffers from the page, a
pagefault can come in, and mark the pte writeable, then set_page_dirty
(which finds no buffers, so only sets PG_dirty).

The page can now get dirtied through this mapping.

try_to_free_buffers then goes on to clean the page and ptes.

I really thought you were the one who identified this race, and I didn't
see where you showed it is safe.

It may be very unlikely with small SMPs, but less so with preempt. All
we have to do is preempt at spin_unlock in try_to_free_buffers AFAIKS.
Were you testing with preempt?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
