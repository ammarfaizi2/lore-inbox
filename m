Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263673AbUJ2X6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbUJ2X6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUJ2XqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:46:14 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:41582 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S263712AbUJ2Xmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:42:50 -0400
Subject: Re: 2.6.9 kernel oops with openais
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Mark Haverkamp <markh@osdl.org>
Cc: Openais List <openais@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1099091302.13961.42.camel@markh1.pdx.osdl.net>
References: <1099090282.14581.19.camel@persist.az.mvista.com>
	 <1099091302.13961.42.camel@markh1.pdx.osdl.net>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1099093365.1207.5.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 29 Oct 2004 16:42:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

I think I found the changes to 2.6.9 which cause mlockall to fail. 
mlockall can now be called by non privleged applications without root
priveleges..  But those processes are limited to 32kb of ram.  aisexec
starts as root, mlocks, then allocates several mb of ram, then drops
root priveleges.  This causes further memory allocations to fail since
sbrk cannot find new memory in the process space.

I think this can be fixed with setrlimit but I've not tested this.

I tried 2.6.8 with nfs root to see if the oops is gone when runnig
openais, but get a different oops on startup:

Unable to handle kernel NULL pointer dereference at virtual address
00000014
 printing eip:
c01eff35
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c01eff35>]    Not tainted
EFLAGS: 00010246   (2.6.8)
EIP is at nfs_request_init+0x1e/0x2d
eax: 00000000   ebx: f7b4b800   ecx: 00000000   edx: f7f4ed80
esi: 00000000   edi: f7b4b858   ebp: f7f92000   esp: f7f93a24
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7f92000 task=f7f916b0)
Stack: f7b59680 f7f4ed80 f7b4b800 c01ee3f1 f7b4b800 f7f4ed80 f7fb1c80
c1ffea00
       00001000 f7b59680 00000000 c01f1091 f7f4ed80 f7b59680 c1ffea00
00000000
       00001000 f7b59728 00000000 f7f93b10 c1ffea18 c1ffea00 f7f93bc4
00000000
Call Trace:
 [<c01ee3f1>] nfs_create_request+0xe5/0xe9
 [<c01f1091>] readpage_async_filler+0x70/0x147
 [<c013ea1e>] read_cache_pages+0xcc/0x154
 [<c01f11ca>] nfs_readpages+0x62/0xce
 [<c01f1021>] readpage_async_filler+0x0/0x147
 [<c013ebef>] read_pages+0x149/0x152
 [<c013bd36>] __alloc_pages+0x2ee/0x32d
 [<c013f0f8>] __do_page_cache_readahead+0x111/0x18f
 [<c013edac>] page_cache_readahead+0xb9/0x22e
 [<c0137b11>] do_generic_mapping_read+0x103/0x507
 [<c01381f0>] __generic_file_aio_read+0x1ef/0x22b
 [<c0137f15>] file_read_actor+0x0/0xec
 [<c0140212>] cache_grow+0x12a/0x1c6
 [<c0138286>] generic_file_aio_read+0x5a/0x74
 [<c01ea034>] nfs_file_read+0xb3/0xf5
 [<c01575c6>] do_sync_read+0x84/0xad
 [<c01576ab>] vfs_read+0xbc/0x127
 [<c0162a38>] kernel_read+0x50/0x5f
 [<c01637a5>] prepare_binprm+0xde/0xfc
 [<c0163cbf>] do_execve+0x1a8/0x28c
 [<c01048f5>] sys_execve+0x50/0x80
 [<c0105e47>] syscall_call+0x7/0xb
 [<c0100442>] run_init_process+0x1c/0x2a
 [<c01005c7>] init+0x177/0x1e7
 [<c0100450>] init+0x0/0x1e7
 [<c0103f49>] kernel_thread_helper+0x5/0xb
Code: f0 ff 40 14 89 43 18 8b 5c 24 08 83 c4 0c c3 8b 4c 24 04 8b
 <0>Kernel panic: Attempted to kill init!

I'll have to spend some time debugging some of these oops to see if I
can get a 2.6 kernel up and running that I can fix the defect-169 with..

Thanks
-steve

On Fri, 2004-10-29 at 16:08, Mark Haverkamp wrote:
> On Fri, 2004-10-29 at 15:51 -0700, Steven Dake wrote:
> > Mark,
> > 
> > Have you seen the following oops in 2.6.x?  I can generate it easily
> > with two nodes by letting openais run for 15-20 seconds on 2.6.9.
> > 
> > I had to turn mlockall off in order to get openais to run in the first
> > place, otherwise openais runs out of ram which causes a memset to a null
> > address in parse.c (we should fix that:).  Have you had problems with
> > mlock when working with a 2.6 kernel?
> 
> Funny that you should ask.  Just this afternoon I updated one of my
> machines from 2.6.8-rc4 to 2.6.10-rc1 and saw the memset problem.  (I
> got around it by commenting out the group.conf file). And then got a
> segfault later.  I didn't see a kernel panic though since I couldn't get
> it to run that long.  I don't know about any mlock problems.  Maybe the
> kernel mailing list archives has something.
> 
> 
> Mark.
> 
> > 
> >  <1>Unable to handle kernel NULL pointer dereference at virtual address
> > 0000000c
> >  printing eip:
> > c016dd7b
> > *pde = 00000000
> > Oops: 0000 [#2]
> > PREEMPT SMP
> > Modules linked in:
> > CPU:    2
> > EIP:    0060:[<c016dd7b>]    Not tainted VLI
> > EFLAGS: 00010286   (2.6.9)
> > EIP is at dnotify_flush+0x1e/0xad
> > eax: 00000000   ebx: f6cdfb80   ecx: 00000000   edx: f6cdfb80
> > esi: 00000000   edi: f7baf880   ebp: f6cdfb80   esp: f6cefd50
> > ds: 007b   es: 007b   ss: 0068
> > Process aisexec (pid: 929, threadinfo=f6cee000 task=f7cc2810)
> > Stack: c0154240 f7224a70 f7cdea80 f6cdfb80 00000000 f7baf880 f7baf880
> > c0152a6f
> >        f6cdfb80 f7baf880 00000005 00000007 0000000f c011e344 f6cdfb80
> > f7baf880
> >        00000020 00000001 f7baf880 f7cc2d38 f7cc2810 f7a9a0ac c011f11e
> > f7cc2810
> > Call Trace:
> >  [<c0154240>] __fput+0x86/0xd4
> >  [<c0152a6f>] filp_close+0x46/0x86
> >  [<c011e344>] put_files_struct+0x87/0xec
> >  [<c011f11e>] do_exit+0x1a8/0x360
> >  [<c01070fd>] do_divide_error+0x0/0x13e
> >  [<c0116640>] do_page_fault+0x251/0x5af
> >  [<c0108aa3>] do_IRQ+0xd2/0x139
> >  [<c033b760>] move_addr_to_user+0x5c/0x67
> >  [<c033d815>] sys_recvmsg+0x21d/0x226
> >  [<c033f3ec>] release_sock+0x1b/0x71
> >  [<c033f3a7>] lock_sock+0x17/0x41
> >  [<c01555d7>] invalidate_inode_buffers+0x1b/0x7e
> >  [<c01163ef>] do_page_fault+0x0/0x5af
> >  [<c01068e5>] error_code+0x2d/0x38
> >  [<c033c550>] sock_poll+0xe/0x31
> >  [<c01664c1>] do_pollfd+0x8c/0x90
> >  [<c016652b>] do_poll+0x66/0xc6
> >  [<c01666cb>] sys_poll+0x140/0x1fd
> >  [<c0165a45>] __pollwait+0x0/0xc5
> >  [<c0105e7b>] syscall_call+0x7/0xb
> > 

