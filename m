Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUBDGF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 01:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266260AbUBDGF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 01:05:56 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:52202 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266256AbUBDGFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 01:05:54 -0500
Date: Tue, 03 Feb 2004 22:05:36 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>, Alok Mooley <rangdi@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
Message-ID: <35380000.1075874735@[10.10.2.4]>
In-Reply-To: <1075874074.14153.159.camel@nighthawk>
References: <20040204050915.59866.qmail@web9704.mail.yahoo.com> <1075874074.14153.159.camel@nighthawk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In order to move such pages, we will have to patch macros like
>> "virt_to_phys" & other related macros, so that the address 
>> translation for pages moved by us will take place vmalloc style, i.e.,
>> via page tables, instead of direct +-3GB. Is it worth introducing such
>> an overhead for address translation (vmalloc does it!)? If no, then is
>> there another way out, or is it better to stick to our current
>> definition of a movable page? 
> 
> Low memory kernel pages are a much bigger deal to defrag.  I've started
> to think about these for hotplug memory and it just makes my head hurt. 
> If you want to do this, you are right, you'll have to alter virt_to_phys
> and company.  The best way I've seen this is with CONFIG_NONLINEAR:
> http://lwn.net/2002/0411/a/discontig.php3
> Those lookup tables are pretty fast, and have benefits to many areas
> beyond defragmentation like NUMA and the memory hotplug projects.  

I don't think that helps you really - the mappings are usually done on
chunks signficantly larger than one page, and we don't want to break
away from using large pages for the kernel mappings.
 
> Rather than try to defrag kernel memory now, it's probably better to
> work on schemes that keep from fragmenting memory in the first place. 

Absolutely. Kernel pages are really hard (not any lowmem page is a 
kernel page, of course). 

>> Identifying pages moved by us may involve introducing a new page-flag. 
>> A new page-flag for per-cpu pages would be great, since we have to 
>> traverse the per-cpu hot & cold lists in order to identify if a page 
>> is on the pcp lists. 

Careful not to introduce new cacheline touches, etc whilst doing this.
The whole point of hot & cold pages is to be efficient.

If you don't need N kilobyte alignment on your N kilobyte page groups,
there's probably much more effective schemes that buddy allocator, but
that assumption may be too embedded to change.

> If the per-cpu allocator caches are your only problem, I don't see why
> we can't just flush them out when you're doing your operation.  Plus,
> they aren't *that* big, so you could pretty easily go scanning them. 
> Martin, can we just flush out and turn off the per-cpu hot/cold lists
> for the defrag period?

Yup, should be fairly easy to do. Just free them back with the standard
mechanisms.
 
>> As of now, we have adopted a failure based approach, i.e, we
>> defragment only when a higher order allocation failure has taken place
>> (just before kswapd starts swapping).  We now want to defragment based
>> on thresholds kept for each allocation order.  Instead of a daemon
>> kicking in on a threshold  violation (as proposed by Mr. Daniel
>> Phillips), we intend to capture idle cpu cycles by inserting a new
>> process just above the idle process.  
> 
> I think I'd agree with Dan on that one.  When kswapd is going, it's
> pretty much too late.  The daemon approach would be more flexible, allow
> you to start earlier, and more easily have various levels of
> aggressiveness.

I think the policy we've taken so far is that you can't *urgently* request
large contig areas. If you need that, you should be keeping your own cache.

M.
