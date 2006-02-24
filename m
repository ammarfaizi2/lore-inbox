Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWBXGWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWBXGWL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 01:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWBXGWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 01:22:11 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:50833 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750965AbWBXGWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 01:22:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=x8aolsSXCkhHOq0NWFYn/OUiqeQfV3r3sifC42NQPFxPzLl95evPVJKl7xYOIt7pZk7qEyWC4p/n4EQUHP7Dwwa+34TuOHIynIE56Jx+cJLJul/GYmRZYvfYuZAtIJ6hrM4Yltv0CrHx04LbjjJiS971/ynmx4TDgIL7X1htjVU=  ;
Message-ID: <43FEA60E.5040607@yahoo.com.au>
Date: Fri, 24 Feb 2006 17:22:06 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Gibson <dwg@au1.ibm.com>
CC: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: RFC: Block reservation for hugetlbfs
References: <20060221022124.GA18535@localhost.localdomain> <43FA94B3.4040904@yahoo.com.au> <20060221233950.GB20872@localhost.localdomain> <43FBB292.1000304@yahoo.com.au> <20060222021106.GB23574@localhost.localdomain> <43FBD5D5.5020706@yahoo.com.au> <20060224041154.GF28368@localhost.localdomain>
In-Reply-To: <20060224041154.GF28368@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> On Wed, Feb 22, 2006 at 02:09:09PM +1100, Nick Piggin wrote:

>>I mean a new core mm lock depenency (ie. lru_lock -> tree_lock).
>>
>>But I must have been smoking something last night: for the life
>>of me I can't see why I thought there was already a hugetlb_lock
>>-> lru_lock dependency in there...?!
>>
>>So I retract my statement. What you have there seems OK.
> 
> 
> Sadly, you weren't smoking something, and it's not OK.  As akpm
> pointed out later, the lru_lock dependecy is via __free_pages() which
> is called from update_and_free_page() with hugetlb_lock held.
> 

You're either thinking of zone->lock, or put_page/page_cache_release.
The former is happy to nest inside anything because it is confined to
page_alloc. The latter AFAIKS is not called from inside the hugepage
lock.

> 
>>>Also, any thoughts on whether I need i_lock or i_mutex or something
>>>else would be handy..
>>
>>I'm not much of an fs guy. How come you don't use i_size?
> 
> 
> i_size is already used for a hard limit on the file size - faulting a
> page beyond i_size will SIGBUS, whereas faulting a page beyond
> i_blocks just isn't guaranteed.  In particular, we always extend
> i_size when makiing a new mapping, whereas we only extend i_blocks
> (and thus reserve pages) on a SHARED mapping (because space is being
> guaranteed for things in the mapping, not for a random processes
> MAP_PRIVATE copy).
> 

Oh OK I misread how you're using it. I thought you wanted to be
able to guarantee the whole thing would be guaranteed.

The other thing you might be able to do is use hugetlbfs inode
private data so you don't have to overload vfs things?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
