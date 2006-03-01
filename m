Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbWCAKEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWCAKEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWCAKEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:04:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932655AbWCAKEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:04:20 -0500
Date: Wed, 1 Mar 2006 02:02:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301020255.39fcc6a8.akpm@osdl.org>
In-Reply-To: <20060301015338.b296b7ad.pj@sgi.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Ok - down to the patch:
> 
>  1) gregkh-driver-empty_release_functions_are_broken.patch         - good
>  2) gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch - special case
>  3) gregkh-driver-fix-up-the-sysfs-pollable-patch.patch            - bad
> 
>  Up through and including (1), it all seems fine.

OK, thanks.  So
gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch is the
problem.   Odd.

<looks at sysfs_poll()>

If that gets called on a top-level file in /sys, won't
filp->f_dentry->d_parent be pointing at a non-sysfs dentry?

>  With (3) or more loaded, it fails to boot, with the crash
>  given before (and appended below for completeness).
> 
>  With patchs up through (2) loaded, it boots, but complains 27
>  times during the boot
> 
>  One of the 27 complaints for special case (2):
>  ================================= begin =================================
>  Debug: sleeping function called from invalid context at drivers/base/core.c:343^M
>  in_atomic():1, irqs_disabled():0^M
>  ^M
>  Call Trace:^M
>   [<a0000001000132c0>] show_stack+0x40/0xa0^M
>                                  sp=e00002bc3a49f9b0 bsp=e00002bc3a499558^M
>   [<a000000100013b50>] dump_stack+0x30/0x60^M
>                                  sp=e00002bc3a49fb80 bsp=e00002bc3a499540^M
>   [<a00000010008ff80>] __might_sleep+0x200/0x220^M
>                                  sp=e00002bc3a49fb80 bsp=e00002bc3a499510^M
>   [<a0000001004b58b0>] put_device+0x30/0x60^M
>                                  sp=e00002bc3a49fb90 bsp=e00002bc3a4994f0^M
>   [<a00000010051e470>] scsi_put_command+0x170/0x1a0^M
>                                  sp=e00002bc3a49fb90 bsp=e00002bc3a499498^M
>   [<a000000100528c80>] scsi_next_command+0x40/0x80^M
>                                  sp=e00002bc3a49fb90 bsp=e00002bc3a499468^M
>   [<a0000001005296a0>] scsi_end_request+0x1a0/0x1e0^M
>                                  sp=e00002bc3a49fb90 bsp=e00002bc3a499420^M
>   [<a000000100529a50>] scsi_io_completion+0x370/0x820^M
>                                  sp=e00002bc3a49fb90 bsp=e00002bc3a499388^M

Yeah, known problem - big messiness in scsi.  That's why -mm includes
revert-gregkh-driver-put_device-might_sleep.patch.  Looks like I need to
add revert-gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch too ;)
