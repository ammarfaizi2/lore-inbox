Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVFUIrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVFUIrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVFUIo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:44:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41874 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262078AbVFUIeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 04:34:36 -0400
Date: Tue, 21 Jun 2005 10:34:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: 2.6.12-mm1: BUG() in fd_install, RCU related?
Message-ID: <20050621083424.GA2076@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got 

Jun 21 10:30:20 amd kernel: ------------[ cut here ]------------
Jun 21 10:30:20 amd kernel: kernel BUG at fs/open.c:935!
Jun 21 10:30:20 amd kernel: invalid operand: 0000 [#1]
Jun 21 10:30:20 amd kernel: Modules linked in: ipw2100
Jun 21 10:30:20 amd kernel: CPU:    0
Jun 21 10:30:20 amd kernel: EIP:    0060:[page_referenced+39/160]    Not tainted VLI
Jun 21 10:30:20 amd kernel: EFLAGS: 00010286   (2.6.12-mm1)
Jun 21 10:30:20 amd kernel: EIP is at fd_install+0x27/0x40
Jun 21 10:30:20 amd kernel: eax: f7268e00   ebx: 00000080   ecx: f61a9800   edx: f6106400
Jun 21 10:30:20 amd kernel: esi: f6106400   edi: f61a9800   ebp: 0000000c   esp: f66d9f7c
Jun 21 10:30:20 amd kernel: ds: 007b   es: 007b   ss: 0068
Jun 21 10:30:20 amd kernel: Process kded (pid: 2056, threadinfo=f66d8000 task=f672ca80)
Jun 21 10:30:20 amd kernel: Stack: 00000080 c0165fd6 00000080 ffffffea 0000000c c0166300 00000000 f6106400
Jun 21 10:30:20 amd kernel:        fffffff7 c01664b0 f6106400 0000000c 00000080 b6e84b7c f66d8000 c0102ea9
Jun 21 10:30:20 amd kernel:        0000000c 00000000 00000080 00000080 b6e84b7c bf9361f8 000000dd 0000007b
Jun 21 10:30:20 amd kernel: Call Trace:
Jun 21 10:30:20 amd kernel:  [blkdev_get+38/160] dupfd+0x46/0x60
Jun 21 10:30:20 amd kernel:  [lookup_bdev+48/144] do_fcntl+0x80/0x150
Jun 21 10:30:20 amd kernel:  [.text.lock.block_dev+153/185] sys_fcntl64+0x80/0x90
Jun 21 10:30:20 amd kernel:  [do_signal+57/288] syscall_call+0x7/0xb
Jun 21 10:30:20 amd kernel: Code: 00 00 00 00 53 89 c3 b8 00 e0 ff ff 21 e0 8b 00 8b 80 54 04 00 00 8b 48 04 8b 41 0c 8b 04 98 85 c0 75 08 8b 41 0c 89 14 98 5b c3 <0f> 0b a7 03 3c be 52 c0 eb ee eb 0d 90 90 90 90 90 90 90 90 90
Jun 21 10:31:54 amd pam_limits[1559]: wrong limit value 'unlimited'

..while doing nothing particulary interesting. Its:

void fastcall fd_install(unsigned int fd, struct file * file)
{
        struct files_struct *files = current->files;
        struct fdtable *fdt;
        spin_lock(&files->file_lock);
        fdt = files_fdtable(files);
        if (unlikely(fdt->fd[fd] != NULL))
                BUG();
~~~~~~~~~~~~~~~~~~~~~~
        rcu_assign_pointer(fdt->fd[fd], file);
        spin_unlock(&files->file_lock);
}

This bug. (Is there any particular reason why the code does not use
BUG_ON())?

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
