Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbTAJKju>; Fri, 10 Jan 2003 05:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTAJKju>; Fri, 10 Jan 2003 05:39:50 -0500
Received: from holomorphy.com ([66.224.33.161]:14488 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264859AbTAJKjs>;
	Fri, 10 Jan 2003 05:39:48 -0500
Date: Fri, 10 Jan 2003 02:48:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anthony Lau <anthony@greyweasel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops with HIMEM+VM in 2.4.19,20
Message-ID: <20030110104827.GM23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anthony Lau <anthony@greyweasel.com>, linux-kernel@vger.kernel.org
References: <20030110083714.GA702@kimagure>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110083714.GA702@kimagure>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 12:37:14AM -0800, Anthony Lau wrote:
> I am getting reproducible kernel oops and random segmentation
> faults whenever the kernel starts using VM. Without any VM pages
> being used, the system is stable.
> I have tested kernels compiled with and without HIMEM support
> (all other kernel config options identical). Without HIMEM 4GB
> support, the system is stable for weeks. With HIMEM 4GB support,
> the system starts oops'ing and seg. faulting when VM starts
> being used.
> My system info:
> 1.5GB physical RAM (MemTest86 run for 2 times, no errors)
> 2.0GB VM on a partition
> Aopen AX34u with Via Apollo Pro 133T chipset

Hmm, I'd call the "VM on a partition" something like "swap" myself.

This looks tiny, it's almost certainly not one of the "spin forever
hunting for a lowmem page intermixed with all the highmem pages" like
the big ones get burned by all the time on 2.4.x.


On Fri, Jan 10, 2003 at 12:37:14AM -0800, Anthony Lau wrote:
> Sample Oops from logs:
> Jan  8 08:53:59 kimagure kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000317
> Jan  8 08:53:59 kimagure kernel:  printing eip:
> Jan  8 08:53:59 kimagure kernel: c0146053
> Jan  8 08:53:59 kimagure kernel: *pde = 00000000
> Jan  8 08:53:59 kimagure kernel: Oops: 0000
> Jan  8 08:53:59 kimagure kernel: CPU:    0
> Jan  8 08:53:59 kimagure kernel: EIP:    0010:[free_kiovec+83/108]    Not tainted
> Jan  8 08:53:59 kimagure kernel: EFLAGS: 00010202
> Jan  8 08:53:59 kimagure kernel: eax: 00000000   ebx: df7dcc34   ecx: df7dcc44   edx: df7dcc44
> Jan  8 08:53:59 kimagure kernel: esi: f6784800   edi: 00000307   ebp: 00000c59   esp: c222df4c
> Jan  8 08:53:59 kimagure kernel: ds: 0018   es: 0018   ss: 0018
> Jan  8 08:53:59 kimagure kernel: Process kswapd (pid: 5, stackpage=c222d000)
> Jan  8 08:53:59 kimagure kernel: Stack: de765b48 de765b30 df7dcc34 c0144226 df7dcc34 00000011 000001d0 00000020 
> Jan  8 08:53:59 kimagure kernel:        00000006 c01444eb 000056a6 c012d760 00000006 000001d0 00000006 000001d0 
> Jan  8 08:53:59 kimagure kernel:        c03180c8 00000000 c03180c8 c012d7af 00000020 c03180c8 00000002 c222c000 
> Jan  8 08:53:59 kimagure kernel: Call Trace:    [destroy_inode+22/44] [sync_inodes_sb+159/468] [rw_swap_page_base+32/296]
> [rw_swap_p
> age_base+111/296] [rw_swap_page_base+259/296]
> Jan  8 08:53:59 kimagure kernel:   [rw_swap_page+54/72] [__free_pages_ok+109/612] [kernel_thread+40/56]
> Jan  8 08:53:59 kimagure kernel: 
> Jan  8 08:53:59 kimagure kernel: Code: 8b 47 10 85 c0 74 06 53 ff d0 83 c4 04 ff 4b 2c 0f 94 c0 84 

Looks like someone e.g. invalidate_inode_pages(), truncate_inode_pages(),
etc. etc., left pages hanging around. Borderline VM/vfs stuff. Or swap
code mangled something important. This oops either has buttloads of
stack noise or some other issue corrupting it. Can you find the first
oops? If this is not the first oops, then it's probably not useful.


On Fri, Jan 10, 2003 at 12:37:14AM -0800, Anthony Lau wrote:
> Because of the symptoms, I think that there could be some
> incompatibility between Himem and the VM subsystem. Of course
> I may have just configured my kernel incorrectly.
> Any help is appreciated and I will gladly supply more logs
> if I knew which ones would be useful.

No, it looks like VM/vfs interation-related stuff.


Bill
