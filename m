Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265915AbUA1L7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 06:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUA1L7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 06:59:36 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:61145 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265915AbUA1L7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 06:59:16 -0500
Date: Wed, 28 Jan 2004 05:57:41 -0600
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4 VFS question.  File on free_list and in p->files->fd[1] at same time.
Message-ID: <20040128115741.GB23445@lnx-holt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a crash dump from a customer.  The problem occurred during a
machine shutdown.  All of the customer's tasks had cleanly exited
before the kernel oops occurred.

Here is the typical background info:

    <4>ps[518]: NaT consumption 17179869216
    <4>
    <4>Pid: 518, comm:                   ps
    <4>Registers: cpu 7, sapicid 0x2006, time 641738311
    <4>psr : 0000101008026018 ifs : 8000000000000791 ip  : [<e000000004578760>]    Tainted: PF
    <4>ip is at sys_newfstat+0x60/0x160 [kernel]
    <4>unat: 0000000000000000 pfs : 0000000000000791 rsc : 0000000000000003
    <4>rnat: e000003000000000 bsps: e0000030ffffffff pr  : 0000000000000199
    <4>ldrs: 0000000000000000 ccv : 00000000000001fb fpsr: 0009804c0270033f
    <4>b0  : e000000004578730 b6  : e000000004402f60 b7  : 0000000000000000
    <4>f6  : 1003e00000000008462a0 f7  : 1003e0000000000000ad0
    <4>f8  : 1003e0000000000000000 f9  : 1000fc22e800000000000
    <4>r1  : e0000000052f1d30 r2  : 0000000000000000 r3  : 00000000000000ff
    <4>r8  : e000003034782080 r9  : 2000000000462cc0 r10 : 0000000000000000
    <4>r11 : 6000000000011388 r12 : e0000130745f7e60 r13 : e0000130745f0000
    <4>r14 : 0000000000000001 r15 : 0000000000000040 r16 : e000003017aa5904
    <4>r17 : e000003017aa5918 r18 : 0000000000000008 r19 : 20000000003bbfd0
    <4>r20 : 0000000000000002 r21 : 0000000000444950 r22 : 0000000000000000
    <4>r23 : 60000000000166b0 r24 : 0000000000000010 r25 : 0000000000000180
    <4>r26 : 200000000030a9c0 r27 : 0000000000000000 r28 : 0000000000000040
    <4>r29 : 0000000000000000 r30 : 0000000000000001 r31 : 0000000000000000
    <4>
    <4>Call Trace:
    <4> [<e0000000044155d0>] show_stack+0x50/0xc0 [kernel]
    <4>                         sp=e0000130745f79d0 bsp=e0000130745f32f0
    <4> [<e000000004415ec0>] show_regs+0x800/0x840 [kernel]
    <4>                         sp=e0000130745f7ba0 bsp=e0000130745f3298
    <4> [<e000000004433960>] die+0x180/0x280 [kernel]
    <4>                         sp=e0000130745f7bc0 bsp=e0000130745f3268
    <4> [<e000000004433aa0>] die_if_kernel+0x40/0x60 [kernel]
    <4>                         sp=e0000130745f7bc0 bsp=e0000130745f3240
    <4> [<e0000000044353f0>] ia64_fault+0xa90/0xac0 [kernel]
    <4>                         sp=e0000130745f7bc0 bsp=e0000130745f3208
    <4> [<e00000000440e2c0>] ia64_leave_kernel+0x0/0x290 [kernel]
    <4>                         sp=e0000130745f7cc0 bsp=e0000130745f3208
    <4> [<e000000004578760>] sys_newfstat+0x60/0x160 [kernel]
    <4>                         sp=e0000130745f7e60 bsp=e0000130745f3178
    <4> [<e00000000440e2a0>] ia64_ret_from_syscall+0x0/0x20 [kernel]
    <4>                         sp=e0000130745f7e60 bsp=e0000130745f3178



The sys_newfstat+0x60 comes from stat.c in do_revalidate.  The first line is:
        struct inode * inode = dentry->d_inode;
and dentry is null.


Looking at the task_struct for the task that oops'd, I see the following:


>> px  *(task_struct *) 0xe0000130745f0000 | grep files
        files = 0xe000003017aa5900
>> px *(files_struct *) 0xe000003017aa5900
struct files_struct {
        count = atomic_t {
                counter = 0x1
        }
        file_lock = rwlock_t {
                read_counter = 0x0
                write_lock = 0x0
        }
        max_fds = 0x40
        max_fdset = 0x400
        next_fd = 0x9
        fd = 0xe000003017aa5a30
        close_on_exec = 0xe000003017aa5930
        open_fds = 0xe000003017aa59b0
<clipped>
        fd_array = {
                [0]         (null) = 0xe00000300cce6980
                [1]         (null) = 0xe000003034782080
                [2]         (null) = 0xe00000307802e680
                [3]         (null) = 0xe00000303651ce80
                [4]         (null) = 0xe00001b039007b80
                [5]         (null) = 0xe00001300fab0f80
                [6]         (null) = 0xe00000b021800480
                [7]         (null) = 0xe00000307802d380
                [8]         (null) = 0xe00000307802e280
<clipped>
        }
}

Then from above, looking at the open_fds value, I get:
>> dump 0xe000003017aa59b0
0xe000003017aa59b0: 00000000000001ff                  : ........


If I understand what I am reading, file descriptor 1 is pointing
to struct file at 0xe000003034782080.  open_fds indicates the file
is open.

Now, if I look at that structure, I see:

>> px *(struct file*) 0xe000003034782080
struct file {
        f_list = struct list_head {
                next = 0xe000003017f0e480
                prev = 0xe00000307a5e9c80
        }
        f_dentry = (nil)
        f_vfsmnt = (nil)
        f_op = 0xe000000004eaa568
        f_count = atomic_t {
                counter = 0x1
        }
        f_flags = 0x1
        f_mode = 0x2
        f_pos = 0x0
        f_reada = 0x0
        f_ramax = 0x0
        f_raend = 0x0
        f_ralen = 0x0
        f_rawin = 0x0
        f_owner = struct fown_struct {
                pid = 0x0
                uid = 0x0
                euid = 0x0
                signum = 0x0
        }
        f_uid = 0x0
        f_gid = 0x0
        f_error = 0x0
        f_version = 0x0
        private_data = (nil)
        f_iobuf = (nil)
        f_iobuf_lock = 0x0
}

This looks to me like the file has gone through an fput() where count
went to zero, fields got cleared, it got put on the free_list, and then
a later pass bumped f_count back up to one.

If I walk the free_list, I do find this struct file *.

Does anybody have any idea how this could happen.  I have looked through
the code and am drawing a blank.  The case is not very reproducible.
In seven months of repeating this test, this is the only failure with
this signature ever recorded.  As I said, I do have a crash dump and
can glean additional information as requested.

Looking at the register dump from the crash, I do see 0xe000003034782080
in the register for the struct file *.  The first param to the
sys_newfstat() call was 1 which corresponds.

Thanks for you attention,
Robin Holt
