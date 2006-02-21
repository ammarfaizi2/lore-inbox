Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWBUHvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWBUHvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 02:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWBUHvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 02:51:21 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:40068 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751099AbWBUHvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 02:51:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jQPlnaCoJPz4DCWKDYcKLU5BQXlnjtbrU+/PGPWRX4+MRKUXArR7gUo9bpcgzG0UAruTcgmzOIhvesVg7xzdm3G3qsTUX1cJQaopuJn8Li3Bbyf4mDeMlFsMiWNNbGI7YBntOU1SJ7KvxFagexbM2r4B5uTYPdmv53TE2VliPuQ=  ;
Message-ID: <43FA94B3.4040904@yahoo.com.au>
Date: Tue, 21 Feb 2006 15:18:59 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Gibson <dwg@au1.ibm.com>
CC: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Block reservation for hugetlbfs
References: <20060221022124.GA18535@localhost.localdomain>
In-Reply-To: <20060221022124.GA18535@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> These days, hugepages are demand-allocated at first fault time.
> There's a somewhat dubious (and racy) heuristic when making a new
> mmap() to check if there are enough available hugepages to fully
> satisfy that mapping.
> 
> A particularly obvious case where the heuristic breaks down is where a
> process maps its hugepages not as a single chunk, but as a bunch of
> individually mmap()ed (or shmat()ed) blocks without touching and
> instantiating the blocks in between allocations.  In this case the
> size of each block is compared against the total number of available
> hugepages.  It's thus easy for the process to become overcommitted,
> because each block mapping will succeed, although the total number of
> hugepages required by all blocks exceeds the number available.  In
> particular, this defeats such a program which will detect a mapping
> failure and adjust its hugepage usage downward accordingly.
> 
> The patch below is a draft attempt to address this problem, by
> strictly reserving a number of physical hugepages for hugepages inodes
> which have been mapped, but not instatiated.  MAP_SHARED mappings are
> thus "safe" - they will fail on mmap(), not later with a SIGBUS.
> MAP_PRIVATE mappings can still SIGBUS.
> 
> This patch appears to address the problem at hand - it allows DB2 to
> start correctly, for instance, which previously suffered the failure
> described above.  I'm almost certain I'm missing some locking or other
> synchronization - I am entirely bewildered as to what I need to hold
> to safely update i_blocks as below.  Corrections for my ignorance
> solicited...
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> 

This introduces
tree_lock(r) -> hugetlb_lock

And we already have
hugetlb_lock -> lru_lock

So we now have tree_lock(r) -> lru_lock, which would deadlock
against lru_lock -> tree_lock(w), right?

 From a quick glance it looks safe, but I'd _really_ rather not
introduce something like this.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
