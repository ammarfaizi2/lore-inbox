Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVCWKeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVCWKeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVCWKeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:34:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261517AbVCWKeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:34:12 -0500
Date: Wed, 23 Mar 2005 02:33:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unable to handle paging request in worker_thread on apm resume
Message-Id: <20050323023344.62ba883b.akpm@osdl.org>
In-Reply-To: <20050322040657.GA28404@fieldses.org>
References: <20050322040657.GA28404@fieldses.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> wrote:
>
> I got the following after an apm resume on a thinkpad X31, with
>  2.6.12-rc1 plus some (hopefully unrelated) NFS patches.  Any ideas?
> 
>  --Bruce Fields
> 
> 
>  Mar 21 18:22:44 puzzle apmd[1815]: Suspending now
>  Mar 21 22:37:36 puzzle kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
>  Mar 21 22:37:36 puzzle kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
>  Mar 21 22:37:36 puzzle kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
>  Mar 21 22:37:39 puzzle kernel: Unable to handle kernel paging request at virtual address d28c9dbc
>  Mar 21 22:37:39 puzzle kernel:  printing eip:
>  Mar 21 22:37:39 puzzle kernel: c01331a6
>  Mar 21 22:37:39 puzzle kernel: *pde = 00048067
>  Mar 21 22:37:39 puzzle kernel: *pte = 128c9000
>  Mar 21 22:37:39 puzzle kernel: Oops: 0002 [#1]
>  Mar 21 22:37:39 puzzle kernel: PREEMPT DEBUG_PAGEALLOC
>  Mar 21 22:37:39 puzzle kernel: Modules linked in:
>  Mar 21 22:37:39 puzzle kernel: CPU:    0
>  Mar 21 22:37:39 puzzle kernel: EIP:    0060:[<c01331a6>]    Not tainted VLI
>  Mar 21 22:37:39 puzzle kernel: EFLAGS: 00010093   (2.6.12-rc1-CITI_NFS4_ALL-1) 
>  Mar 21 22:37:39 puzzle kernel: EIP is at worker_thread+0x1a6/0x400
>  Mar 21 22:37:39 puzzle kernel: eax: d28c9db8   ebx: 00000246   ecx: c0680ea4   edx: dff19f58
>  Mar 21 22:37:39 puzzle kernel: esi: dff19f38   edi: c0680ea0   ebp: dff0ffc4   esp: dff0ff5c
>  Mar 21 22:37:39 puzzle kernel: ds: 007b   es: 007b   ss: 0068
>  Mar 21 22:37:39 puzzle kernel: Process events/0 (pid: 3, threadinfo=dff0f000 task=dff1aa90)
>  Mar 21 22:37:39 puzzle kernel: Stack: dff19f80 00000000 c05643e0 dff0f000 dff19f58 ffffffff ffffffff 00000001 
>  Mar 21 22:37:39 puzzle kernel:        00000000 c0115ec0 00010000 00000000 dff07e44 c0571eff dff0ffc8 00000000 
>  Mar 21 22:37:39 puzzle kernel:        dff1aa90 c0115ec0 00100100 00200200 e1b0835a 00000000 dff1aa90 dff0f000 
>  Mar 21 22:37:39 puzzle kernel: Call Trace:
>  Mar 21 22:37:39 puzzle kernel:  [<c0103a75>] show_stack+0x75/0x90
>  Mar 21 22:37:39 puzzle kernel:  [<c0103bcb>] show_registers+0x11b/0x180
>  Mar 21 22:37:39 puzzle kernel:  [<c0103dfd>] die+0x13d/0x290
>  Mar 21 22:37:39 puzzle kernel:  [<c011375f>] do_page_fault+0x30f/0x68e
>  Mar 21 22:37:39 puzzle kernel:  [<c01035cb>] error_code+0x2b/0x30
>  Mar 21 22:37:39 puzzle kernel:  [<c01399e8>] kthread+0x98/0xa0
>  Mar 21 22:37:39 puzzle kernel:  [<c0100c49>] kernel_thread_helper+0x5/0xc

Seems that there's a `struct work_struct' which is still registered but its
memory has been freed.  It's likely that CONFIG_DEBUG_PAGEALLOC caught this.

Either that, or some module got unloaded without flushing its workqueue.

Are you using any modules which do schedule_work()?

Have you added any code which does schedule_work()?

