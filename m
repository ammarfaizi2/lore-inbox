Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270647AbTG0BvY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 21:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270648AbTG0BvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 21:51:24 -0400
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:14079 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S270647AbTG0BvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 21:51:23 -0400
Message-Id: <200307270206.LAA21133@toshiba.co.jp>
From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
To: linux-kernel@vger.kernel.org
Subject: A shutdown is impossible in 2.4.18-27.
Date: Sun, 27 Jul 2003 11:06:02 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The problem whose shutdown is impossible in 2.4.18-27 has occurred.
2.4.18-27 is  Kernel upgrade of Red Hat 8.0.
The ttyS1 is used as the serial console in my environment.
If a shutdown is performed, it will stop at mgetty.
The stack trace extracted by sysrq is as follows.

mgetty        S 00000003     0 25524      1               20598 (L-TLB)
Call Trace: [<c0123c9d>] schedule_timeout [kernel] 0xad (0xc2415e28))
[<e0800ef5>] journal_get_write_access_R2b76932b [jbd] 0x55 (0xc2415e48))
[<c017b4de>] tty_wait_until_sent [kernel] 0x9e (0xc2415e60))
[<e08151f5>] ext3_reserve_inode_write [ext3] 0x75 (0xc2415e68))
[<c018d012>] rs_close [kernel] 0x152 (0xc2415e9c))
[<c01771ef>] release_dev [kernel] 0x57f (0xc2415ebc))
[<c012c9d0>] zap_pte_range [kernel] 0xf0 (0xc2415ee4))
[<c012ad8b>] do_zap_page_range [kernel] 0x8b (0xc2415f0c))
[<c017762f>] tty_release [kernel] 0xf (0xc2415f30))
[<c014121c>] fput [kernel] 0xfc (0xc2415f38))
[<c013f84d>] filp_close [kernel] 0x4d (0xc2415f54))
[<c011e8ec>] close_files [kernel] 0x7c (0xc2415f6c))
[<c011da78>] put_files_struct [kernel] 0x28 (0xc2415f8c))
[<c011e0e5>] do_exit [kernel] 0xc5 (0xc2415f9c))
[<c012ddda>] sys_munmap [kernel] 0x4a (0xc2415fa4))
[<c011e2a3>] sys_exit [kernel] 0x13 (0xc2415fb8))
[<c0109147>] system_call [kernel] 0x33 (0xc2415fc0))

When tty_wait_until_sent() is investigated,
I think that it does not escape from the following loops.

       do {
#ifdef TTY_DEBUG_WAIT_UNTIL_SENT
                printk(KERN_DEBUG "waiting %s...(%d)\n", tty_name(tty, buf),
                       tty->driver.chars_in_buffer(tty));
#endif
                set_current_state(TASK_INTERRUPTIBLE);
                if (signal_pending(current))
                        goto stop_waiting;
                if (!tty->driver.chars_in_buffer(tty))
                        break;
                timeout = schedule_timeout(timeout);
        } while (timeout);

I want to hear everybody's opinion. Please let me know your idea.

Regards,
Haruo
