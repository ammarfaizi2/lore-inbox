Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUBUBoa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUBUBoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:44:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:34754 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261474AbUBUBoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:44:24 -0500
Date: Fri, 20 Feb 2004 17:46:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: John Levin <levin@gamebox.net>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: 2.6.2-rc3 messages  BUG
Message-Id: <20040220174616.30d73718.akpm@osdl.org>
In-Reply-To: <20040221075308.161992c7.levin@gamebox.net>
References: <20040221075308.161992c7.levin@gamebox.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levin <levin@gamebox.net> wrote:
>
> Hi,
> 	My guess atleast in this case is that  suspend/resume cyle looses track
> of the fact that a module is use.I have file corruption. All those
> files which have been created after resume is corrupted. I copied dmesg
> into a backup file and saved it. When i boot 2.4 and look into it , it
> is corrputed.
> 	After booting I connect to the internet through wvdial. So i have to
> load up usbcore,cdc_acm,uhci. i am connected to the net and searching on
> google.	Now i do echo 4 > /proc/acpi/sleep . It suspends. Then i resume
> it from command line.
>  So now wvdial looks as if connected but really isn't. So i close it and
> try running it again. It doesn't detect /dev/usb/acm/0. So i remove the
> modules and try inserting it (uhci) which gives me the error.
> 
> Here is something which i could copy after resume.
> 
> --> WvDial: Internet dialer version 1.53
> --> Initializing modem.
> --> Sending: ATZ
> --> Sending: ATQ0
> --> Re-Sending: ATZ
> --> Modem not responding.
> lsmod
> [root@mdk9 root]# lsmod
> Module                  Size  Used by
> uhci_hcd               31752  0
> cdc_acm                10784  3
> usbcore               111828  4 uhci_hcd,cdc_acm
> [root@mdk9 root]# rmmod uhci_hcd
> [root@mdk9 root]# insmod
> /lib/modules/2.6.3-rc2/kernel/drivers/usb/host/uhci-hcd.ko

You missed out an important piece of info.  The kernel should have printed
out "kmem_cache_create: duplicate cache <name>" before going BUG.

What was "<name>"?  uhci_urb_priv?

I suggest you go into drivers/usb/host/uhci-hcd.c:uhci_hcd_cleanup() and
replace

	warn("not all urb_priv's were freed!");

with

	BUG();

because failure to destroy that slab cache is fatal, and it points at a bug
in this driver.


> ------------[cut here ]------------ 
> kernel BUG at mm/slab.c:1269!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0143a29>]    Not tainted
> EFLAGS: 00010202
> EIP is at kmem_cache_create+0x509/0x670
> eax: 00000031   ebx: c130277c   ecx: c04a50e8   edx: c03cc3f8
> esi: cf935fa7   edi: cf935fa7   ebp: cbdedf74   esp: cbdedf44
> ds: 007b   es: 007b   ss: 0068
> Process insmod (pid: 2234, threadinfo=cbdec000 task=cc1fa6a0)
> Stack: c036e980 cf935f99 00010c00 cbdedf64 c13026a4 c0000000 c1302668
> fffffffc       00000020 00000000 fffffff4 cf938980 cbdedf9c cf91d0d4
> cf935f99 00000044       00000080 00010c00 00000000 00000000 c03ceb70
> c03ceb58 cbdedfbc c0137aeb Call Trace:
>  [<cf91d0d4>] uhci_hcd_init+0xd4/0x12e [uhci_hcd]
>  [<c0137aeb>] sys_init_module+0xeb/0x1c0
>  [<c010b1df>] syscall_call+0x7/0xb

