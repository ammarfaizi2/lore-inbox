Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268751AbUIQNd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbUIQNd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268752AbUIQNd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:33:56 -0400
Received: from holomorphy.com ([207.189.100.168]:23468 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268751AbUIQNdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:33:39 -0400
Date: Fri, 17 Sep 2004 06:33:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Message-ID: <20040917133330.GR9106@holomorphy.com>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409171157.24943.vda@port.imtp.ilyichevsk.odessa.ua> <20040917110353.GM9106@holomorphy.com> <200409171532.58898.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171532.58898.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 September 2004 14:03, William Lee Irwin III wrote:
>> To address this in a meaningful way, we're going to have to get some
>> profiling data. The built-in kernel profiler should suffice, though you
>> may want to run the test for a longer, fixed period of time (I
>> recommend making the test run as long as 60s and recording the number
>> of operations completed). Also, please snapshot the profile state with
>> readprofile(1) immediately before and after the microbenchmark runs on
>> both kernels. This should only require booting into the kernels you've
>> already built with an additional commandline parameter, e.g. profile=2.

On Fri, Sep 17, 2004 at 03:34:59PM +0300, Denis Vlasenko wrote:
> I have profile=2. Profiles were collected with this script:
> ./openclose100000
> readprofile -m System.map -r
> ./openclose100000
> ./openclose100000
> ./openclose100000
> ./openclose100000
> readprofile -m System.map | sort -r

Excellent!


On Fri, Sep 17, 2004 at 03:34:59PM +0300, Denis Vlasenko wrote:
> 2.4:
>   2994 total                                      0.0013
>    620 link_path_walk                             0.2892
>    285 d_lookup                                   1.2076
>    156 dput                                       0.4815
>    118 kmem_cache_free                            0.7564
>    109 system_call                                1.9464
>    106 kmem_cache_alloc                           0.5096
>    103 strncpy_from_user                          1.2875
[...]
> 2.6:
>   3200 total                                      0.0013
>    790 link_path_walk                             0.2759
>    287 __d_lookup                                 1.2756
>    277 get_empty_filp                             1.4503
>    146 strncpy_from_user                          1.8250
>    110 dput                                       0.3254
>    109 system_call                                2.4773

Very odd that get_empty_filp() and strncpy_from_user() should be so
high on your profiles. They're not tremendously different between 2.4
and 2.6. It may be the case that 2.6 makes some inappropriate choice of
algorithms for usercopying on systems of your vintage. get_empty_filp()
is more mysterious still.

What was the relative performance of 2.4 vs. 2.6? e.g. 2.6 completed
some percentage of the number of operations as 2.4 in the given time?

Additive differential profile follows. I wonder if certain symbols'
hits should be folded together for a proper comparison.

 8.9688%	__d_lookup
 6.8526%	get_empty_filp
 3.9794%	link_path_walk
 2.8750%	do_lookup
 2.8621%	find_trylock_page
 1.8750%	may_open
 1.7188%	follow_mount
 1.6875%	__fput
 1.5216%	path_lookup
 1.2812%	find_next_zero_bit
 1.1223%	strncpy_from_user
 0.9117%	locks_remove_flock
 0.9042%	dentry_open
 0.8750%	file_ra_state_init
 0.8125%	page_put_link
 0.7188%	syscall_exit
 0.5271%	read_cache_page
 0.4310%	fs_may_remount_ro
 0.4279%	filp_close
 0.3794%	filp_open
 0.3750%	page_follow_link_light
 0.3125%	file_kill
 0.2812%	zap_pte_range
 0.2812%	eventpoll_init_file
 0.1875%	eventpoll_release_file
 0.1617%	locks_remove_posix
 0.1250%	syscall_call
 0.1250%	__copy_to_user_ll
 0.0938%	detach_mnt
 0.0873%	clear_user
 0.0625%	read_cache_pages
 0.0625%	page_remove_rmap
 0.0464%	file_move
 0.0312%	zap_pmd_range
 0.0312%	unmap_vmas
 0.0312%	pte_alloc_one
 0.0312%	process_backlog
 0.0312%	free_page_and_swap_cache
 0.0312%	free_hot_cold_page
 0.0312%	find_get_page
 0.0312%	dst_alloc
 0.0312%	do_no_page
 0.0312%	do_anonymous_page
 0.0312%	__up_write
 0.0140%	write_profile
 0.0000%	ret_from_sys_call
 0.0000%	path_walk
 0.0000%	path_init
 0.0000%	page_follow_link
 0.0000%	inet_rtm_newrule
 0.0000%	fib_lookup
 0.0000%	do_truncate
 0.0000%	d_lookup
 0.0000%	copy_page_range
 0.0000%	check_mnt
 0.0000%	cached_lookup
 0.0000%	__generic_copy_to_user
 0.0000%	__free_pages
 0.0000%	__find_get_page
 0.0000%	__constant_c_and_count_memset
-0.0065%	do_wp_page
-0.0334%	inet_rtm_newrule
-0.0334%	fib_lookup
-0.0334%	copy_page_range
-0.0829%	update_atime
-0.0958%	dnotify_flush
-0.1002%	check_mnt
-0.1065%	getname
-0.1336%	do_truncate
-0.2004%	path_walk
-0.2344%	system_call
-0.3674%	__generic_copy_to_user
-0.3759%	sys_open
-0.4008%	ret_from_sys_call
-0.5495%	mark_page_accessed
-0.5645%	path_release
-0.6280%	page_getlink
-0.8142%	get_unused_fd
-0.8350%	__find_get_page
-0.8684%	__free_pages
-0.9177%	sys_close
-0.9286%	fd_install
-1.5191%	lookup_mnt
-1.5890%	vfs_permission
-1.7729%	dput
-1.8336%	open_namei
-1.8842%	kmem_cache_alloc
-1.9361%	permission
-2.1376%	cached_lookup
-2.2850%	kmem_cache_free
-2.4048%	path_init
-2.6386%	page_follow_link
-2.6386%	__constant_c_and_count_memset
-2.8228%	fput
-9.5190%	d_lookup


-- wli
