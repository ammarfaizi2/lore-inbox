Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUJKHTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUJKHTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 03:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUJKHTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 03:19:21 -0400
Received: from support.codesourcery.com ([65.74.133.10]:50430 "EHLO
	mail.codesourcery.com") by vger.kernel.org with ESMTP
	id S267451AbUJKHTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 03:19:15 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ?
From: Zack Weinberg <zack@codesourcery.com>
Date: Mon, 11 Oct 2004 00:19:13 -0700
Message-ID: <878yadwwlq.fsf@codesourcery.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hacksaw writes:
>Zack Weinberg writes:
>>The very first thing init does is open /dev/console, and if it doesn't
>>exist the entire boot hangs.
>
>This raises a question: Would it be a useful thing to make a modified init
>that could run udev before it does anything else?

It wouldn't help.  The opening of /dev/console actually happens inside
the kernel, near the bottom of init/main.c:

        if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
                printk("Warning: unable to open an initial console.\n");

        (void) sys_dup(0);
        (void) sys_dup(0);

That's not a fatal error, but the userspace startup process does get
stuck not very long afterward.  (I'm not sure precisely where.  It
hadn't mounted filesystems read-write yet.)

Control reaches the above code after an initramfs is unpacked, so
including /dev/console in an initramfs will work.  I do not think it
will work to invoke udevstart from an initramfs or initrd *without*
also including a static /dev/console -- I'm pretty darn sure that
control reaches /init in an initramfs after the above code executes.
I'm not sure whether control reaches /linuxrc in an initrd before or
after the above code.

Being inside the kernel at this point, it seems to me there ought to
be some way to open device <5,1> without going through the filesystem,
but I could not find one.

[Tangentially, I thought kernel-side syscalls had been stamped out,
but there's still a __KERNEL_SYSCALLS__ #define at the top of the file
and a bare execve() in run_init_process()... which does in fact get
compiled to int $0x80 on my boring old x86...]

zw
