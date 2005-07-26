Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVGZSoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVGZSoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVGZSl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:41:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51144 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262035AbVGZSjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:39:33 -0400
Subject: Re: Memory pressure handling with iSCSI
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20050726111110.6b9db241.akpm@osdl.org>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726111110.6b9db241.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 11:39:11 -0700
Message-Id: <1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 11:11 -0700, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > After KS & OLS discussions about memory pressure, I wanted to re-do
> >  iSCSI testing with "dd"s to see if we are throttling writes.  
> > 
> >  I created 50 10-GB ext3 filesystems on iSCSI luns. Test is simple
> >  50 dds (one per filesystem). System seems to throttle memory properly
> >  and making progress. (Machine doesn't respond very well for anything
> >  else, but my vmstat keeps running - 100% sys time).
> 
> It's important to monitor /proc/meminfo too - the amount of dirty/writeback
> pages, etc.
> 
> btw, 100% system time is quite appalling.  Are you sure vmstat is telling
> the truth?  If so, where's it all being spent?
> 
> 

Well, profile doesn't show any time in "default_idle". So
I believe, vmstat is telling the truth.

# cat /proc/meminfo
MemTotal:      7143628 kB
MemFree:         43252 kB
Buffers:         16736 kB
Cached:        6683348 kB
SwapCached:       5336 kB
Active:          14460 kB
Inactive:      6686928 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      7143628 kB
LowFree:         43252 kB
SwapTotal:     1048784 kB
SwapFree:      1017920 kB
Dirty:         6225664 kB
Writeback:      447272 kB
Mapped:          10460 kB
Slab:           362136 kB
CommitLimit:   4620596 kB
Committed_AS:   168616 kB
PageTables:       2452 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      9888 kB
VmallocChunk: 34359728447 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB



# echo 2 > /proc/profile; sleep 5;  readprofile -
m /usr/src/*12.3/System.map | sort -nr
1634737 total                                      0.5464
1468569 shrink_zone                              390.5769
 21203 unlock_page                              331.2969
 19497 release_pages                             46.8678
 19061 __wake_up_bit                            397.1042
 17936 page_referenced                           53.3810
 10679 lru_add_drain                            133.4875
  7348 page_waitqueue                            76.5417
  5877 tg3_poll                                   2.4007
  4650 cond_resched                              41.5179
  4476 copy_user_generic                         15.0201
  1973 do_get_write_access                        1.2583
  1858 __mod_page_state                          38.7083
  1754 tg3_start_xmit                             0.9876
  1348 journal_dirty_metadata                     2.1063
  1250 __find_get_block                           2.7902
  1224 journal_add_journal_head                   2.6379
  1082 kmem_cache_free                           11.2708
  1077 tcp_sendpage                               0.3580
  1076 tcp_ack                                    0.1431
  1075 __make_request                             0.7999
  1035 tg3_interrupt_tagged                       2.5875
  1022 __pagevec_lru_add                          4.5625
   928 tcp_transmit_skb                           0.4677
   924 kmem_cache_alloc                          14.4375
   900 thread_return                              3.5294
   819 __ext3_get_inode_loc                       0.9307
   754 established_get_next                       2.2440
   711 journal_cancel_revoke                      1.4335
   684 file_send_actor                            7.1250


Thanks,
Badari

