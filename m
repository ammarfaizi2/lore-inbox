Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWDEUXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWDEUXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 16:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWDEUXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 16:23:08 -0400
Received: from [67.40.69.52] ([67.40.69.52]:40176 "EHLO morpheus")
	by vger.kernel.org with ESMTP id S1751165AbWDEUXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 16:23:07 -0400
Subject: Issues with symbol names
From: Kristis Makris <kristis.makris@asu.edu>
To: linux-kernel@vger.kernel.org
Date: Wed, 05 Apr 2006 13:27:17 -0700
Message-Id: <1144268838.8306.16.camel@syd.mkgnu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'd like to bring to attention two issues with symbol names.



1) Duplicate symbol names in vmlinux in 2.4

I've come across cases where the kernel object file vmlinux may have
multiple symbols with the same name. For example, in kernel 2.4.2:

# nm /usr/src/linux-2.4.2-kpm/vmlinux |grep -i free_list 
c0130704 t __remove_from_free_list
c01bbc78 t aic7xxx_add_curscb_to_free_list
c015cfdc t blk_init_free_list
c02b4c74 d free_list
c031c8a0 b free_list

There are two "free_list" symbols, both in lowercase (meaning they are
both local to their respective files that declared them). They are
coming from:

fs/buffer.c:96:static struct bh_free_head free_list[NR_SIZES];
fs/file_table.c:21:static LIST_HEAD(free_list);

Running the linker with the argument "--warn-common" could warn about
such symbols. It'd be swell if the kernel was linked with --warn-common, and
duplicate symbols were renamed in the future.


The motivation behind this is one may build tools that consult the kernel object
file to determine while the kernel is live and running the memory addresses
of non-exported symbols. Then the kernel could be dynamically updated if those addresses
are known. If one is building a tool that automates this determination, duplicate
symbols bring this process to a halt and require manual resolution.



2) Unremoved symbol names in /proc/kallsyms for __init functions in 2.6

It appears that in 2.6.10 some symbol names that correspond to functions that
were declared as __init (thus were removed from the kernel) did not
get removed from the kernel's internal symbol table. e.g.

$ cat /proc/kallsyms |sort

We see:

e09141e0 t pipe_readv_v2        [final_benchmark_pipe]
e0914270 t ac6_proc_init        [ipv6]
e09142b0 t if6_proc_init        [ipv6]
e09142e8 t addrconf_init        [ipv6]
e0914360 t ipip6_fb_tunnel_init [ipv6]
e09143d0 t sit_init     [ipv6]
e0914480 t ip6_route_init       [ipv6]
e0914510 t fib6_init    [ipv6]
e0914544 t ipv6_packet_init     [ipv6]
e0914560 t ndisc_init   [ipv6]
e0914608 t udp6_proc_init       [ipv6]
e0914610 t pipe_readv_v2_endlabel       [final_benchmark_pipe]

The declaration for example of ac6_proc_init is:

int __init ac6_proc_init(void)

My goal here is to use /proc/kallsyms to determine the size of a function
image at runtime. For example, the size of pipe_readv_v2 should be
pipe_readv_v2_endlabel - pipe_readv_v2 + 1.

My approach in computing this value right now for symbols that were not
exported is to find the memory address of the symbol and then the
address of the next symbol and subtract one. So for example the size of
kmem_cache_create is 0xc0129f78 - 0xc0129bcc + 1, because /proc/kallsyms
(well /proc/ksyms -- I took this example from a 2.4)

c0129bcc kmem_cache_create_Rd1c0b4e6
c0129f78 kmem_cache_shrink_R12f7cf04

The problem here is that this approach is no longer sound if __init functions
remain listed somewhere in between symbols. So something like the following
would throw the logic off:

c0129bcc kmem_cache_create_Rd1c0b4e6
c0129dea some_module_function_init
c0129f78 kmem_cache_shrink_R12f7cf04

Again, the motivation is to automate the determination of the size of functions
during runtime.


So in summary:

 - Can the kernel from now on start being linked with --warn-common ?
 - Is the code that unloads __init functions lacking the logic to remove
   the symbols of the unloaded functions ? And if so, can this be fixed ?

Please CC me; I'm not on the list.

Thanks,
Kristis


