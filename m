Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUG2Dbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUG2Dbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 23:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUG2Dbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 23:31:46 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:18030 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263971AbUG2Dbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 23:31:44 -0400
Message-ID: <41086F9D.2000801@yahoo.com.au>
Date: Thu, 29 Jul 2004 13:31:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Klaus Dittrich <kladit@t-online.de>
CC: Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
References: <20040726150615.GA1119@xeon2.local.here> <20040726123702.222ae654.akpm@osdl.org> <4105633C.3080204@xeon2.local.here> <20040726133846.604cef91.akpm@osdl.org> <41057A16.60801@xeon2.local.here> <20040726221420.GA8789@ii.uib.no> <4106BE6C.1030701@xeon2.local.here> <4106C3B7.10603@xeon2.local.here> <4106FF9F.5060609@yahoo.com.au> <4107C109.2070600@xeon2.local.here>
In-Reply-To: <4107C109.2070600@xeon2.local.here>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Dittrich wrote:

> Nick Piggin wrote:
>
>>
>> Your vfs_cache_pressure probably wants to be higher than 500. Make it 
>> 10000.
>
>
> *No problems when using 10000.
> But I think of this as workaround only.
>

Yes it is just a workaround.

> I have read the "Scaling dcache with RCU" article from linuxjournal.com
> to get some insight how things should work. Pretty complicated.
>

Yes, prune_dcache is the only one called in response to memory pressure.
Basically you wouldn't have to worry about dcache internals for your sort
of machine. For example, RCU delayed freeing would not cause any problem.

The problem has probably been triggered either by a small change in the
page scanner, however the underlying problem is that the slab pressure
calculation isn't ideal on highmem systems, so in vfs intensive workloads
(lots of files), it is easy for ZONE_NORMAL allocations to OOM without
actually scanning much slab.

