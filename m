Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWAKEIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWAKEIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 23:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWAKEIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 23:08:42 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:9640 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751344AbWAKEIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 23:08:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=6Ywf/L230OyFvrkiP1BBMoMO0cVD8mNgAGcnIEKzSUZCV2fOcfgcr5F+aCDKzIj9CLcJ90rMvsgKyXc+n1eD1HZlmBIRF5clVVXNH0Fe39TK09CAnRJ5lSiu8+h2QKIKrrn7R/VD+ALzTcoteVroQ1D/qUlJ33GoBZrnrk4vSMg=  ;
Message-ID: <43C484BF.2030602@yahoo.com.au>
Date: Wed, 11 Jan 2006 15:08:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hugh@veritas.com
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
References: <20051213193735.GE3092@opteron.random> <20051213130227.2efac51e.akpm@osdl.org> <20051213211441.GH3092@opteron.random> <20051216135147.GV5270@opteron.random> <20060110062425.GA15897@opteron.random>
In-Reply-To: <20060110062425.GA15897@opteron.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Fri, Dec 16, 2005 at 02:51:47PM +0100, Andrea Arcangeli wrote:
> 
>>There was a minor buglet in the previous patch an update is here:
>>
>>	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.15-rc5/seqschedlock-2
> 
> 
> JFYI: I got a few hours ago positive confirmation of the fix from the
> customer that was capable of reproducing this. I guess this is good
> enough for production use (it's at the very least certainly better than
> the previous code and it's guaranteed not to hurt the scalability of the
> fast path in smp, so it's the least intrusive fix I could imagine).
> 
> So we can start to think if we should using this new primitive I
> created, and if to replace the yield() with a proper waitqueue (and
> how). Or if to take the risk of hitting a bit of scalability in the
> nopage page faults of processes, by rewriting the fix with a
> find_lock_page in the do_no_page handler, that would avoid the need of
> my new locking primitive.
> 
> Comments welcome thanks!

I'd be inclined to think a lock_page is not a big SMP scalability
problem because the struct page's cacheline(s) will be written to
several times in the process of refcounting anyway. Such a workload
would also be running into tree_lock as well.

Not that I have done any measurements.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
