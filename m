Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTIIU3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTIIU1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:27:24 -0400
Received: from mail.gmx.de ([213.165.64.20]:15584 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264466AbTIIUZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:25:22 -0400
Subject: Re: [2.6.0-test-x] Kernel Oops and pppd segfault
From: Florian Zimmermann <florian.zimmermann@gmx.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1062743688.3383.3.camel@mindfsck>
References: <1062711059.8011.4.camel@mindfsck>
	 <20030904143850.461467c6.akpm@osdl.org>  <1062743688.3383.3.camel@mindfsck>
Content-Type: text/plain
Message-Id: <1063139836.3336.8.camel@mindfsck>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 09 Sep 2003 22:37:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.6.0-test5: exactly same error path
ppp does _not_ work... :((

On Fri, 2003-09-05 at 08:34, Florian Zimmermann wrote:
> On Thu, 2003-09-04 at 23:38, Andrew Morton wrote:
> > Florian Zimmermann <florian.zimmermann@gmx.net> wrote:
> > > and here comes the Oops when i want to start 'pppd':
> > > 
> > > PPP generic driver version 2.4.2
> > > devfs_mk_cdev: could not append to parent for ppp
> > > failed to register PPP device (-17)
> > 
> > _devfs_append_entry("ppp") returns -EEXIST.
> > 
> > > Unable to handle kernel paging request at virtual address d1964580
> > > EIP is at cdev_get+0x29/0xc0
> > 
> > Then it looks like someone didn't handle the error right.
> > 
> > Please:
> > 
> > a) send your full .config
> > 
> > b) describe the exact sequence of steps which is required to make this
> >    happen, starting from a machine reboot.
> > 
> > Does a simple "modprobe ppp" fail?
> 
> .config file attached. this is linux-2.6.0-test4:
> 
> after boot devfs got registered, no ppp module is loaded yet.
> then i can do this:
> 
> # modprobe ppp_generic
> FATAL: Error inserting ppp_generic
> (/lib/modules/2.6.0-test4/kernel/drivers/net/ppp_generic.ko): Device or
> resource busy
> 
> kernel > PPP generic driver version 2.4.2
> kernel > devfs_mk_cdev: could not append to parent for ppp
> kernel > failed to register PPP device (-17)
> 
> # modprobe ppp_async
> WARNING: Error inserting ppp_generic
> (/lib/modules/2.6.0-test4/kernel/drivers/net/ppp_generic.ko): Device or
> resource busy
> FATAL: Error inserting ppp_async
> (/lib/modules/2.6.0-test4/kernel/drivers/net/ppp_async.ko): Unknown
> symbol in module, or unknown parameter (see dmesg)
> 
> kernel > PPP generic driver version 2.4.2
> kernel > failed to register PPP device (-16)
> kernel > ppp_async: Unknown symbol ppp_channel_index
> kernel > ppp_async: Unknown symbol ppp_register_channel
> kernel > ppp_async: Unknown symbol ppp_input
> kernel > ppp_async: Unknown symbol ppp_input_error
> kernel > ppp_async: Unknown symbol ppp_output_wakeup
> kernel > ppp_async: Unknown symbol ppp_unregister_channel
> kernel > ppp_async: Unknown symbol ppp_unit_number
> 
> # pppd
> Unable to handle kernel paging request at virtual address d19fa300
>  printing eip:
> c01853b8
> *pde = 0f956067
> *pte = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c01853b8>]    Not tainted
> EFLAGS: 00010202
> EIP is at cdev_get+0x28/0xb0
> eax: c5b20000   ebx: d19fa300   ecx: 0000006c   edx: c01852a0
> esi: 00000001   edi: cce31c4c   ebp: c5b21e78   esp: c5b21e68
> ds: 007b   es: 007b   ss: 0068
> Process pppd (pid: 3155, threadinfo=c5b20000 task=c6150000)
> Stack: c0197033 ccb78864 00006c00 00000000 c5b21e84 c01852b1 cce31c4c
> c5b21ebc
>        c02d6038 00006c00 cce31c4c 00000282 c5b20000 c5b20000 cce31c4c
> c0185290
>        000000ff 6c006040 c5b20000 00000000 ffffffed c5b21ef8 c0184cd6
> cffcb004
> Call Trace:
>  [<c0197033>] dput+0x23/0x680
>  [<c01852b1>] exact_lock+0x11/0x20
>  [<c02d6038>] kobj_lookup+0x128/0x220
>  [<c0185290>] exact_match+0x0/0x10
>  [<c0184cd6>] chrdev_open+0x446/0x610
>  [<c01573bc>] kmem_cache_alloc+0x14c/0x1c0
>  [<c01f9e1f>] devfs_open+0x24f/0x270
>  [<c0174f11>] dentry_open+0x151/0x220
>  [<c0174db6>] filp_open+0x66/0x70
>  [<c01755d3>] sys_open+0x53/0x90
>  [<c010a3ab>] syscall_call+0x7/0xb
> 
> Code: 83 3b 02 74 7a ff 83 00 01 00 00 b8 00 e0 ff ff 21 e0 ff 48
>  <6>note: pppd[3155] exited with preempt_count 1
> bad: scheduling while atomic!
> Call Trace:
>  [<c0120304>] schedule+0x6e4/0x6f0
>  [<c015f8d1>] unmap_page_range+0x41/0x70
>  [<c015fb1e>] unmap_vmas+0x21e/0x350
>  [<c016562b>] exit_mmap+0xcb/0x2c0
>  [<c0123896>] mmput+0xb6/0x140
>  [<c0129dc2>] do_exit+0x282/0x900
>  [<c010b57c>] die+0x21c/0x220
>  [<c011dbcc>] do_page_fault+0x15c/0x4ca
>  [<c01519a9>] buffered_rmqueue+0xc9/0x280
>  [<c011ef88>] kernel_map_pages+0x28/0x60
>  [<c0151e5f>] __alloc_pages+0x2ff/0x360
>  [<c011da70>] do_page_fault+0x0/0x4ca
>  [<c010add5>] error_code+0x2d/0x38
>  [<c01852a0>] exact_lock+0x0/0x20
>  [<c01853b8>] cdev_get+0x28/0xb0
>  [<c0197033>] dput+0x23/0x680
>  [<c01852b1>] exact_lock+0x11/0x20
>  [<c02d6038>] kobj_lookup+0x128/0x220
>  [<c0185290>] exact_match+0x0/0x10
>  [<c0184cd6>] chrdev_open+0x446/0x610
>  [<c01573bc>] kmem_cache_alloc+0x14c/0x1c0
>  [<c01f9e1f>] devfs_open+0x24f/0x270
>  [<c0174f11>] dentry_open+0x151/0x220
>  [<c0174db6>] filp_open+0x66/0x70
>  [<c01755d3>] sys_open+0x53/0x90
>  [<c010a3ab>] syscall_call+0x7/0xb
> 
> Unable to handle kernel paging request at virtual address d19fa300
>  printing eip:
> c01853b8
> *pde = 0f956067
> *pte = 00000000
> Oops: 0000 [#2]
> CPU:    0
> EIP:    0060:[<c01853b8>]    Not tainted
> EFLAGS: 00010202
> EIP is at cdev_get+0x28/0xb0
> eax: c6186000   ebx: d19fa300   ecx: 0000006c   edx: c01852a0
> esi: 00000001   edi: cce31c4c   ebp: c6187e78   esp: c6187e68
> ds: 007b   es: 007b   ss: 0068
> Process pppd (pid: 3158, threadinfo=c6186000 task=c615e000)
> Stack: c0197033 ccb78864 00006c00 00000000 c6187e84 c01852b1 cce31c4c
> c6187ebc
>        c02d6038 00006c00 cce31c4c 00000282 c6186000 c6186000 cce31c4c
> c0185290 
>        000000ff 6c006040 c6186000 00000000 ffffffed c6187ef8 c0184cd6
> cffcb004
> Call Trace:
>  [<c0197033>] dput+0x23/0x680
>  [<c01852b1>] exact_lock+0x11/0x20
>  [<c02d6038>] kobj_lookup+0x128/0x220
>  [<c0185290>] exact_match+0x0/0x10
>  [<c0184cd6>] chrdev_open+0x446/0x610
>  [<c01573bc>] kmem_cache_alloc+0x14c/0x1c0
>  [<c01f9e1f>] devfs_open+0x24f/0x270
>  [<c0174f11>] dentry_open+0x151/0x220
>  [<c0174db6>] filp_open+0x66/0x70
>  [<c01755d3>] sys_open+0x53/0x90
>  [<c010a3ab>] syscall_call+0x7/0xb
> 
> Code: 83 3b 02 74 7a ff 83 00 01 00 00 b8 00 e0 ff ff 21 e0 ff 48
>  <6>note: pppd[3158] exited with preempt_count 1
> bad: scheduling while atomic!
> Call Trace:
>  [<c0120304>] schedule+0x6e4/0x6f0
>  [<c015f8d1>] unmap_page_range+0x41/0x70
>  [<c015fb1e>] unmap_vmas+0x21e/0x350
>  [<c016562b>] exit_mmap+0xcb/0x2c0
>  [<c0123896>] mmput+0xb6/0x140
>  [<c0129dc2>] do_exit+0x282/0x900
>  [<c010b57c>] die+0x21c/0x220
>  [<c011dbcc>] do_page_fault+0x15c/0x4ca
>  [<c01519a9>] buffered_rmqueue+0xc9/0x280
>  [<c01ba7ae>] proc_alloc_inode+0x1e/0x80
>  [<c011ef88>] kernel_map_pages+0x28/0x60
>  [<c0151e5f>] __alloc_pages+0x2ff/0x360
>  [<c011da70>] do_page_fault+0x0/0x4ca
>  [<c010add5>] error_code+0x2d/0x38
>  [<c01852a0>] exact_lock+0x0/0x20
>  [<c01853b8>] cdev_get+0x28/0xb0
>  [<c0197033>] dput+0x23/0x680
>  [<c01852b1>] exact_lock+0x11/0x20
>  [<c02d6038>] kobj_lookup+0x128/0x220
>  [<c0185290>] exact_match+0x0/0x10
>  [<c0184cd6>] chrdev_open+0x446/0x610
>  [<c01573bc>] kmem_cache_alloc+0x14c/0x1c0
>  [<c01f9e1f>] devfs_open+0x24f/0x270
>  [<c0174f11>] dentry_open+0x151/0x220
>  [<c0174db6>] filp_open+0x66/0x70
>  [<c01755d3>] sys_open+0x53/0x90
>  [<c010a3ab>] syscall_call+0x7/0xb
-- 
Florian Zimmermann <florian.zimmermann@gmx.net>

