Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUHCJhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUHCJhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 05:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUHCJhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 05:37:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:8882 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265395AbUHCJhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 05:37:15 -0400
Date: Tue, 3 Aug 2004 15:05:55 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, dipankar@in.ibm.com
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Message-ID: <20040803093553.GF1753@vitalstatistix.in.ibm.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk> <20040803092316.GE1753@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803092316.GE1753@vitalstatistix.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 02:53:17PM +0530, Ravikiran G Thirumalai wrote:
> > ...
> > How about this for comparison?  That's just a dumb "convert to rwlock"
> > patch; we can be smarter in e.g. close_on_exec handling, but that's a
> > separate story.
> > 
> 
> I ran tiobench on this patch and here is the comparison:
> 
> 
> Kernel		Seqread		Randread	Seqwrite	Randwrite
> --------------------------------------------------------------------------
> 2.6.7		410.33		234.15		254.39		189.36
> rwlocks-viro	401.84		232.69		254.09		194.62
> refcount (kref)	455.72		281.75		272.87		230.10
> 
> All of this was 2.6.7 based.  Nos are througput rates in mega bytes per sec.
> Test was on ramfs, 48 threads doing 100 MB of io per thread averaged over
> 8 runs.  This was on a 4 way PIII xeon. 

Just adding. This was with premption off and here are the oprofile 
profiles for the above runs;

Thanks,
Kiran

1. Vanilla 2.6.7
=================
CPU: PIII, speed 699.726 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a unit mask of 0x00 (No unit mask) count 100000
samples  %        symbol name
31816    18.7302  __copy_to_user_ll
30421    17.9089  simple_prepare_write
13270     7.8121  __copy_from_user_ll
11514     6.7783  fget_light
8388      4.9380  mark_offset_tsc
5352      3.1507  sysenter_past_esp
5047      2.9712  default_idle
3723      2.1917  do_gettimeofday
2991      1.7608  increment_tail
2884      1.6978  generic_file_aio_write_nolock
2147      1.2639  do_generic_mapping_read
1922      1.1315  current_kernel_time
1800      1.0597  find_vma
1691      0.9955  get_offset_tsc
1683      0.9908  __pagevec_lru_add
1537      0.9048  add_event_entry
1511      0.8895  profile_hook
1413      0.8318  activate_page
1411      0.8307  find_lock_page
1342      0.7900  lookup_dcookie
1318      0.7759  sync_buffer
1289      0.7588  dnotify_parent
1248      0.7347  apic_timer_interrupt
1244      0.7323  find_get_page
1203      0.7082  .text.lock.file_table
1135      0.6682  release_pages
1067      0.6281  __set_page_dirty_buffers
1032      0.6075  scheduler_tick
1027      0.6046  radix_tree_lookup
920       0.5416  generic_file_write

2. rwlocks-2.6.7
=================
CPU: PIII, speed 699.717 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a unit mask of 0x00 (No unit mask) count 100000
samples  %        symbol name
32276    18.9282  __copy_to_user_ll
29917    17.5448  simple_prepare_write
13168     7.7224  fget_light
13167     7.7218  __copy_from_user_ll
8505      4.9877  mark_offset_tsc
5237      3.0712  sysenter_past_esp
5199      3.0489  default_idle
3697      2.1681  do_gettimeofday
3090      1.8121  generic_file_aio_write_nolock
2739      1.6063  increment_tail
1977      1.1594  current_kernel_time
1956      1.1471  do_generic_mapping_read
1845      1.0820  find_vma
1764      1.0345  get_offset_tsc
1717      1.0069  __pagevec_lru_add
1598      0.9371  add_event_entry
1511      0.8861  profile_hook
1478      0.8668  activate_page
1390      0.8152  sync_buffer
1350      0.7917  find_lock_page
1336      0.7835  lookup_dcookie
1307      0.7665  apic_timer_interrupt
1240      0.7272  release_pages
1239      0.7266  dnotify_parent
1223      0.7172  find_get_page
1173      0.6879  __set_page_dirty_buffers
999       0.5859  scheduler_tick

3. rcu refcounting -2.6.7
=========================
CPU: PIII, speed 699.717 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a unit mask of 0x00 (No unit mask) count 100000
samples  %        symbol name
31391    19.8978  __copy_to_user_ll
29672    18.8082  simple_prepare_write
13330     8.4495  __copy_from_user_ll
8076      5.1191  mark_offset_tsc
5323      3.3741  sysenter_past_esp
5071      3.2144  default_idle
3682      2.3339  do_gettimeofday
2890      1.8319  increment_tail
2789      1.7679  generic_file_aio_write_nolock
1997      1.2658  do_generic_mapping_read
1993      1.2633  fget_light
1873      1.1872  __pagevec_lru_add
1826      1.1574  find_vma
1808      1.1460  profile_hook
1797      1.1391  current_kernel_time
1738      1.1017  get_offset_tsc
1439      0.9121  add_event_entry
1354      0.8583  sync_buffer
1346      0.8532  lookup_dcookie
1285      0.8145  dnotify_parent
1267      0.8031  apic_timer_interrupt
1260      0.7987  activate_page
1178      0.7467  find_get_page
1173      0.7435  find_lock_page
1125      0.7131  release_pages
1034      0.6554  scheduler_tick
986       0.6250  __set_page_dirty_buffers
939       0.5952  sched_clock

