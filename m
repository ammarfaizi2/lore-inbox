Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUAWHR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUAWHR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:17:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:1157 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265315AbUAWHRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:17:24 -0500
Date: Thu, 22 Jan 2004 23:18:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: glennpj@charter.net (Glenn Johnson)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm1 oops with X
Message-Id: <20040122231814.149c8e8d.akpm@osdl.org>
In-Reply-To: <20040123061927.GA7025@gforce.johnson.home>
References: <20040123061927.GA7025@gforce.johnson.home>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

glennpj@charter.net (Glenn Johnson) wrote:
>
>  I am getting the oops pasted below.  It only happens when the X server
>  is restarting.  I do not see it all of the time but frequently enough
>  that I can call it reproducible.  I started seeing it with 2.6.1-mm4 and
>  can trigger it fairly regularly with 2.6.2-rc1-mm1.  However, I do not
>  see it with 2.6.1-mm3 nor with 2.6.2-rc1.  Hopefully, that narrows the
>  field as to what may be the culprit.
> 
>  Some relevant hardware and kernel configuration information: 
> 
>  - 2.4GHz P4c with HyperThreading (I do have CONFIG_SMT set)
>  - Radeon 9100 graphics card (DRI enabled)
> 
>  ---begin oops---
>  Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   printing eip:
>  c02a2c56
>  *pde = 00000000
>  Oops: 0000 [#1]
>  PREEMPT SMP 
>  CPU:    0
>  EIP:    0060:[<c02a2c56>]    Not tainted VLI
>  EFLAGS: 00010286
>  EIP is at vt_ioctl+0x1e/0x1f4b
>  eax: 00000000   ebx: daf10000   ecx: 00000007   edx: 00000007
>  esi: 00005607   edi: daf10000   ebp: daf48080   esp: dc6d7ea0
>  ds: 007b   es: 007b   ss: 0068
>  Process X (pid: 6100, threadinfo=dc6d6000 task=dbe56d00)
>  Stack: 00000006 df8e6005 00000003 df8e6005 dc6d7f70 dffd8f00 00000000 dfda1480 
>         df963b00 c01746e1 dfda1480 c0526e80 00000000 dfbaf780 df963b00 c016b982 
>         00021480 00000000 00000000 00000001 df4f9200 c01668e6 c0579800 daf48280 
>  Call Trace:
>   [<c01746e1>] dput+0x22/0x2b1
>   [<c016b982>] link_path_walk+0x690/0x9ea
>   [<c01668e6>] cdev_put+0x17/0x69
>   [<c0166503>] chrdev_open+0x160/0x291
>   [<c011dfaa>] recalc_task_prio+0x90/0x1aa
>   [<c012082d>] schedule+0x39b/0x6d7
>   [<c02a2c38>] vt_ioctl+0x0/0x1f4b
>   [<c029d8dd>] tty_ioctl+0x472/0x570
>   [<c016fb3a>] sys_ioctl+0x119/0x2a3
>   [<c041b3da>] sysenter_past_esp+0x43/0x65

Sorry, this is the mysterious tty close race.  We end up setting
tty->driver_data to zero somewhere, somehow, when someone else is still
using the tty.

If you revert

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1-rc1/2.6.1-rc1-mm1/broken-out/sysfs-add-vc-class.patch

does it go away?

It is maddeningly hard to debug even when you can reproduce it, which I can
no longer do.

