Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTLXRvx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTLXRvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:51:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:55701 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263584AbTLXRvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:51:39 -0500
Date: Wed, 24 Dec 2003 09:51:30 -0800
From: Greg KH <greg@kroah.com>
To: joshk@triplehelix.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-mm1 oops from khubd
Message-ID: <20031224175130.GA30182@kroah.com>
References: <20031223071327.GG7522@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223071327.GG7522@triplehelix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 11:13:27PM -0800, Joshua Kwan wrote:
> After deciding to try out udev from Greg KH, I started inserting and
> removing my USB memory stick (a Lexar JumpDrive) while tweaking my
> /etc/udev/udev.rules to make it map the device to /udev/usbstick all the
> time.
> 
> After a while, I noticed that nothing new was occuring in my system log.
> So I checked dmesg:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000002c
>  printing eip:
> c0172b2e
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT 
> CPU:    0
> EIP:    0060:[<c0172b2e>]    Not tainted VLI
> EFLAGS: 00010292
> EIP is at simple_unlink+0xa/0x1c
> eax: 00000000   ebx: c42d2280   ecx: 00000000   edx: c42d2280
> esi: c13f9a80   edi: cfdcc800   ebp: 00000003   esp: c13d9eec
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 5, threadinfo=c13d8000 task=c129c080)
> Stack: c42d2280 c01860e5 c13f8c80 c42d2280 cc0c42cc c039c0a0 c021e746 c13f9a80 
>        cc0c42f8 cc0c42cc cfdcc8cc c021e8a6 cc0c42cc cc0c4328 cc0c42cc cfdcc8cc 
>        c021d968 cc0c42cc cc0c42cc 0000000a c021d9b9 cc0c42cc 00000100 c026dd28 
> Call Trace:
>  [<c01860e5>] sysfs_hash_and_remove+0x7b/0x7d
>  [<c021e746>] device_release_driver+0x28/0x66
>  [<c021e8a6>] bus_remove_device+0x55/0x96
>  [<c021d968>] device_del+0x5d/0x9b
>  [<c021d9b9>] device_unregister+0x13/0x23
>  [<c026dd28>] hub_port_connect_change+0x30f/0x314
>  [<c026d679>] hub_port_status+0x45/0xb0
>  [<c026e000>] hub_events+0x2d3/0x346
>  [<c026e0a0>] hub_thread+0x2d/0xe4
>  [<c03001c6>] ret_from_fork+0x6/0x14
>  [<c011ca48>] default_wake_function+0x0/0x12
>  [<c026e073>] hub_thread+0x0/0xe4
>  [<c0109255>] kernel_thread_helper+0x5/0xb

Ick, I thought we had fixed this...

Can you try the patch below?  It should apply on top of the -mm1 tree
you are using.  Let me know if this fixes the problem or not.

thanks,

greg k-h


--- a/fs/sysfs/dir.c	Fri Dec  5 17:36:20 2003
+++ b/fs/sysfs/dir.c	Wed Dec 24 09:49:05 2003
@@ -82,9 +82,10 @@
 {
 	struct dentry * parent = dget(d->d_parent);
 	down(&parent->d_inode->i_sem);
-	d_delete(d);
-	if (d->d_inode)
+	if (!d_unhashed(d)) {
+		d_delete(d);
 		simple_rmdir(parent->d_inode,d);
+	}
 
 	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
 		 atomic_read(&d->d_count));
