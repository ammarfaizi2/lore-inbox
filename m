Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbUJYSzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbUJYSzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbUJYSw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:52:59 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:56955 "EHLO
	ash.lnxi.com") by vger.kernel.org with ESMTP id S261201AbUJYSwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:52:05 -0400
Subject: chicken/egg between pipefs and initramfs/hotplug
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: klibc@zytor.com
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Content-Type: text/plain
Organization: Linux Networx
Date: Mon, 25 Oct 2004 12:30:08 -0600
Message-Id: <1098729008.19348.80.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a hotplug setup in initramfs.  Everytime that modprobe is called
I get a kernel oops: NULL pointer dereference:

Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c015db49
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    3
EIP:    0060:[<c015db49>]    Not tainted
EFLAGS: 00010296   (2.6.8)
EIP is at get_pipe_inode+0x9/0xb2
eax: 00000000   ebx: f74f4780   ecx: 00000000   edx: 00000000
esi: f7575580   edi: 0805cbdc   ebp: f767a000   esp: f767bf3c
ds: 007b   es: 007b   ss: 0068
Process default.hotplug (pid: 184, threadinfo=f767a000 task=f74d9110)
Stack: f74f4780 f74f4780 c015dc24 f74d9110 c0168225 f7963ef0 c0392e80 f74f4780
       ffffffe9 f74f4080 f767bfac 00000ff8 c014ff5f f7963cb0 00000001 00000ff8
       f767bfac c0162d17 00000000 f74f4080 fffffff7 bfffdeec f767bfb0 0805cbdc
Call Trace:
 [<c015dc24>] do_pipe+0x32/0x20e
 [<c0168225>] dput+0x9e/0x2b0
 [<c014ff5f>] vfs_read+0x94/0x103
 [<c0162d17>] do_fcntl+0x18c/0x21f
 [<c010a8ad>] sys_pipe+0x11/0x49
 [<c0103f2f>] syscall_call+0x7/0xb
Code: 8b 40 14 89 04 24 e8 4e d5 00 00 85 c0 89 c3 0f 84 8d 00 00


It appears that linux/init/main.c:init() has a chicken/egg problem.
Apparently modprobe and other programs need a pipe and pipefs isn't
mounted until later on in do_basic_setup()/do_initcalls().  That means
that linux/fs/pipe.c:static struct vfsmount *pipe_mnt;  isn't
initialized and blows up when it's derefernced in
linux/fs/pipe.c:get_pipe_inode().

Has this been discussed before?  Is there something that userspace can
wait on until pipefs is mounted or more of the kernel is initialized?  I
did some searching and I just can't turn up a previous discussion about
this - my apologies if it's already been covered.

-- 
Thayne Harbaugh
Linux Networx

