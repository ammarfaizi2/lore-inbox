Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbUJ0Glx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbUJ0Glx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbUJ0Ghh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:37:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:40172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262306AbUJ0GfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:35:13 -0400
Date: Tue, 26 Oct 2004 23:33:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.10-rc1-mm1
Message-Id: <20041026233307.53f37a6c.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0410270206140.7627-100000@thoron.boston.redhat.com>
References: <20041026213156.682f35ca.akpm@osdl.org>
	<Xine.LNX.4.44.0410270206140.7627-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> I think this was the new ACPI video module being loaded, during boot:
> 

It works OK here.

My guess would be that you died here:

	list_add_tail(&driver->node, &acpi_bus_drivers);

in acpi_bus_register_driver().  Which means that some _other_ acpi driver
structure on that list is scrogged.  Perhaps it was marked __init or
something.

Can you debug it a bit?  Maybe print the addresses and names of the drivers
as they get registered in acpi_bus_register_driver() and also print out
acpi_bus_drivers.prev.  If we can get the name of the offending driver
we'll be able to find the bug.


> Unable to handle kernel paging request at virtual address f881e9c0
>  printing eip:
> *pde = 1ff81067
> *pte = 00000000
> Oops: 0002 [#1]
> PREEMPT SMP 
> Modules linked in: video ac e1000 3c59x mii
> CPU:    2
> EIP:    0060:[<c026337b>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.10-rc1-mm1) 
> EIP is at acpi_bus_register_driver+0x35/0x50
> eax: f881e9c0   ebx: f8835e20   ecx: 00000001   edx: f79e6000
> esi: f8836380   edi: c03a820c   ebp: f79e6f98   esp: f79e6f94
> ds: 007b   es: 007b   ss: 0068
> Process insmod (pid: 2776, threadinfo=f79e6000 task=f79e0550)
> Stack: c03a8230 f79e6fa0 f881502b f79e6fbc c013409b bffffeb7 00000004 0807a018 
>        00000000 00000000 f79e6000 c0105c9d 0807a018 00004861 0807a008 00000000 
>        00000000 bfffc2b8 00000080 0000007b 0000007b 00000080 ffffe410 00000073 
> Call Trace:
>  [<c0106add>] show_stack+0x7a/0x90
>  [<c0106c62>] show_registers+0x156/0x1ce
>  [<c0106e64>] die+0xfb/0x181
>  [<c0114f80>] do_page_fault+0x303/0x62b
>  [<c0106779>] error_code+0x2d/0x38
>  [<f881502b>] acpi_video_init+0x2b/0x4a [video]
>  [<c013409b>] sys_init_module+0x19e/0x295
>  [<c0105c9d>] sysenter_past_esp+0x52/0x71
> Code: 53 89 c3 b8 ed ff ff ff 75 39 85 db b0 ea 74 33 b8 08 b5 3e c0 e8 6d ee 0e 00 a1 8c b5 3e c0 c7 03 88 b5 3e c0 89 
> 1d 8c b5 3e c0 <89> 18 89 43 04 b8 08 b5 3e c0 e8 0b f1 0e 00 89 d8 5b 5d e9 af
> 
> 
> 
> -- 
> James Morris
> <jmorris@redhat.com>
