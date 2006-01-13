Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161554AbWAMKhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161554AbWAMKhx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWAMKhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:37:53 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:19135 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030338AbWAMKhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:37:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=nhh93HcsOcVzFoE2sG/1MwrC+++p28/nXFOckoqVtIjOfUvJRdWjFM8trfS5M107KaKEJt10cQlGNAtoYGc5tHXUF1DhqHkjYCA4ZSJAyAUCQaBxRMJ52OxGgdgCjFjc3lmybCFpWyMQB3JpMdJU03JZvjNiIQjolikvx/x3Vlw=  ;
Message-ID: <43C782F3.1090803@yahoo.com.au>
Date: Fri, 13 Jan 2006 21:37:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hugh@veritas.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
References: <20051213193735.GE3092@opteron.random>	<20051213130227.2efac51e.akpm@osdl.org>	<20051213211441.GH3092@opteron.random>	<20051216135147.GV5270@opteron.random>	<20060110062425.GA15897@opteron.random>	<43C484BF.2030602@yahoo.com.au>	<20060111082359.GV15897@opteron.random>	<20060111005134.3306b69a.akpm@osdl.org>	<20060111090225.GY15897@opteron.random>	<20060111010638.0eb0f783.akpm@osdl.org>	<20060111091327.GZ15897@opteron.random>	<Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com>	<43C75834.3040007@yahoo.com.au> <20060112234726.676c3873.akpm@osdl.org>
In-Reply-To: <20060112234726.676c3873.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>(I guess reclaim might be one, but quite rare -- any other significant
>> lock_page users that we might hit?)
> 
> 
> The only time 2.6 holds lock_page() for a significant duration is when
> bringing the page uptodate with readpage or memset.
> 

Yes that's what I thought. And we don't really need to worry about this
case because filemap_nopage has to deal with it anyway (ie. we shouldn't
see a locked !uptodate page in do_no_page).

> The scalability risk here is 100 CPUs all faulting in the same file in the
> same pattern.  Like the workload which caused the page_table_lock splitup
> (that was with anon pages).  All the CPUs could pretty easily get into sync
> and start arguing over every single page's lock.
> 

Yes, but in that case they're still going to hit the tree_lock anyway, and
if they do have a chance of synching up, the cacheline bouncing from count
and mapcount accounting is almost as likely to cause it as the lock_page
itself.

I did a nopage microbenchmark like you describe a while back. IIRC single
threaded is 2.5 times *more* throughput than 64 CPUs, even when those 64 are
faulting their own NUMA memory (and obviously different pages). Thanks to
tree_lock.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
