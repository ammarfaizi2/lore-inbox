Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbTFSPyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265829AbTFSPyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:54:04 -0400
Received: from ps0.linanet.is ([62.145.128.3]:17897 "EHLO ps0.linanet.is")
	by vger.kernel.org with ESMTP id S265828AbTFSPxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:53:52 -0400
Posted-Date: Thu, 19 Jun 2003 15:47:39 GMT
Message-ID: <3EF1DEFC.8080906@hi.is>
Date: Thu, 19 Jun 2003 16:04:12 +0000
From: Petur Thors <peturth@hi.is>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Badness in softirq.c 109, possible fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Got badness in local_bh_enable because Im still in irq_disabled.
This is caused by local_irq_save() in do_tty_hangup (drivers/char/tty_io.c)
He calls local_irq_save(flags) and then goes to flush_buffer and down
to local_bh_enable.
Do we really need local_irq_save/restore in do_tty_hangup() line 447 ?
Its not safe.
Thanks

Badness in local_bh_enable at kernel/softirq.c:109
Jun 19 13:21:01 spiderman kernel: Call Trace:
Jun 19 13:21:01 spiderman kernel:  [<c0128e63>] local_bh_enable+0x93/0xa0
Jun 19 13:21:01 spiderman kernel:  [<e08ebed1>] 
ppp_async_push+0xe1/0x250 [ppp_async]
Jun 19 13:21:01 spiderman kernel:  [<c0173023>] cached_lookup+0x23/0x90
Jun 19 13:21:01 spiderman kernel:  [<e08eb712>] 
ppp_asynctty_wakeup+0x32/0x70 [ppp_async]
Jun 19 13:21:01 spiderman kernel:  [<c022297a>] pty_unthrottle+0x5a/0x60
Jun 19 13:21:01 spiderman kernel:  [<c021e2bb>] check_unthrottle+0x3b/0x40
Jun 19 13:21:01 spiderman kernel:  [<c021e370>] 
reset_buffer_flags+0xb0/0x100
Jun 19 13:21:01 spiderman kernel:  [<c021e3d3>] n_tty_flush_buffer+0x13/0x60
Jun 19 13:21:01 spiderman kernel:  [<c0222d46>] pty_flush_buffer+0x66/0x70
Jun 19 13:21:01 spiderman pppd[1366]: Modem hangup
Jun 19 13:21:01 spiderman kernel:  [<c021a105>] do_tty_hangup+0x4f5/0x5d0

Jun 19 13:21:01 spiderman pppd[1366]: Connection terminated.
Jun 19 13:21:01 spiderman kernel:  [<c021bbaf>] release_dev+0x6df/0x730
Jun 19 13:21:01 spiderman pppd[1366]: Connect time 9.8 minutes.
Jun 19 13:21:01 spiderman kernel:  [<c014bd8c>] release_pages+0x1dc/0x280
Jun 19 13:21:01 spiderman pppd[1366]: Sent 84 bytes, received 50 bytes.
Jun 19 13:21:01 spiderman kernel:  [<c0150dbb>] zap_pmd_range+0x4b/0x70
Jun 19 13:21:01 spiderman kernel:  [<c017dce2>] dput+0x22/0x380
Jun 19 13:21:01 spiderman kernel:  [<c021bffb>] tty_release+0x3b/0xc0
Jun 19 13:21:01 spiderman kernel:  [<c01640f8>] __fput+0x118/0x120
Jun 19 13:21:01 spiderman kernel:  [<c01624d0>] filp_close+0xd0/0x130
Jun 19 13:21:01 spiderman kernel:  [<c0125f68>] put_files_struct+0x58/0xc0
Jun 19 13:21:01 spiderman kernel:  [<c0126dfe>] do_exit+0x1fe/0x690
Jun 19 13:21:02 spiderman kernel:  [<c01624d0>] filp_close+0xd0/0x130
Jun 19 13:21:02 spiderman kernel:  [<c0127419>] do_group_exit+0xf9/0x180
Jun 19 13:21:02 spiderman kernel:  [<c01625bb>] sys_close+0x8b/0x110
Jun 19 13:21:02 spiderman kernel:  [<c010b1fb>] syscall_call+0x7/0xb

Petur Thors





