Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318768AbSIDBRa>; Tue, 3 Sep 2002 21:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318779AbSIDBRa>; Tue, 3 Sep 2002 21:17:30 -0400
Received: from holomorphy.com ([66.224.33.161]:36770 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318768AbSIDBRa>;
	Tue, 3 Sep 2002 21:17:30 -0400
Date: Tue, 3 Sep 2002 18:15:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm1
Message-ID: <20020904011503.GT888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D7437AC.74EAE22B@zip.com.au> <20020904004028.GS888@holomorphy.com> <3D755E2D.7A6D55C6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D755E2D.7A6D55C6@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> It also looks like there's either a bit of internal fragmentation or a
>> missing kmem_cache_reap() somewhere:
>>   ext3_inode_cache:    20001KB    51317KB   38.97
>>       dentry_cache:     4734KB    18551KB   25.52
>>    radix_tree_node:     1811KB     1923KB   94.20
>>        buffer_head:     1132KB     1378KB   82.12

On Tue, Sep 03, 2002 at 06:13:17PM -0700, Andrew Morton wrote:
> That's really outside the control of slablru.  It's determined
> by the cache-specific LRU algorithms, and the allocation order.
> You'll need to look at the second-last and third-last columns in
> /proc/slabinfo (boy I wish that thing had a heading line, or a nice
> program to interpret it):
> ext3_inode_cache     959   2430    448  264  270    1
> That's 264 pages in use, 270 total.  If there's a persistent gap between
> these then there is a problem - could well be that slablru is not locating
> the pages which were liberated by the pruning sufficiently quickly.
> Calling kmem_cache_reap() after running the pruners will fix that up.

# grep ext3_inode_cache /proc/slabinfo 
ext3_inode_cache   18917  87012    448 7686 9668    1
...
ext3_inode_cache:     8098KB    38052KB   21.28

Looks like a persistent gap from here.


Cheers,
Bill
