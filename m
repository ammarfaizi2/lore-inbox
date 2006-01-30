Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWA3Iv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWA3Iv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 03:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWA3Iv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 03:51:26 -0500
Received: from mail.daysofwonder.com ([213.186.49.53]:49615 "EHLO
	mail.daysofwonder.com") by vger.kernel.org with ESMTP
	id S932135AbWA3IvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 03:51:25 -0500
Subject: 2.6.15.1: kernel BUG at drivers/ide/ide-io.c:63!
From: Brice Figureau <brice+lklm@daysofwonder.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 30 Jan 2006 09:50:22 +0100
Message-Id: <1138611022.32526.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm stumbling accross the following kernel bug (panic and reboot), this
is on a bi-Xeon server with 2 IDE drives in a raid 1 MD mirror, running
vanilla 2.6.15.1.

The oops seems very reproducible (at least it occured two times, at
exactly the same time) and it seems to be triggered while the disk is
doing a SMART extended self-test (which is scheduled every saturday at
3AM on this machine).

The previous kernel this server was running was 2.6.14 and it was
running fine, the server began to crash two weeks ago when I installed
the 2.6.15.1.

Jan 28 03:22:17 games hda: lost interrupt
Jan 28 03:22:17 games hda: failed barrier write: sector=e6126c4(good=0/bad=8)
Jan 28 03:22:17 games ------------[ cut here ]------------
Jan 28 03:22:17 games kernel BUG at drivers/ide/ide-io.c:63!
Jan 28 03:22:17 games invalid operand: 0000 [#1]
Jan 28 03:22:17 games SMP
Jan 28 03:22:17 games
Jan 28 03:22:17 games Modules linked in:
Jan 28 03:22:17 games  netconsole
Jan 28 03:22:17 games  i2c_i801
Jan 28 03:22:17 games  i2c_core
Jan 28 03:22:17 games  ipt_LOG
Jan 28 03:22:17 games  ipt_limit
Jan 28 03:22:17 games  ipt_REJECT
Jan 28 03:22:17 games  ipt_state
Jan 28 03:22:17 games  iptable_filter
Jan 28 03:22:17 games  ip_conntrack
Jan 28 03:22:17 games  ip_tables
Jan 28 03:22:17 games
Jan 28 03:22:17 games CPU:    0
Jan 28 03:22:17 games EIP:    0060:[<c02ae894>]    Not tainted VLI
Jan 28 03:22:17 games EFLAGS: 00010002   (2.6.15.1-zen)
Jan 28 03:22:17 games EIP is at __ide_end_request+0x10c/0x119
Jan 28 03:22:17 games eax: c04eb594   ebx: e7f26084   ecx: 00000008   edx: 00000086
Jan 28 03:22:17 games esi: 00000000   edi: c04eb594   ebp: c0483de8   esp: c0483dcc
Jan 28 03:22:17 games ds: 007b   es: 007b   ss: 0068
Jan 28 03:22:17 games Process swapper (pid: 0, threadinfo=c0482000 task=c0419b20)
Jan 28 03:22:17 games
Jan 28 03:22:17 games Stack:
Jan 28 03:22:17 games 00000000
Jan 28 03:22:17 games e7f26084
Jan 28 03:22:17 games f7db670c
Jan 28 03:22:17 games 00000001
Jan 28 03:22:17 games 00000000
Jan 28 03:22:17 games e7f26084
Jan 28 03:22:17 games 00000008
Jan 28 03:22:17 games c0483e1c
Jan 28 03:22:17 games
Jan 28 03:22:17 games
Jan 28 03:22:17 games c02ba1c5
Jan 28 03:22:17 games c04eb594
Jan 28 03:22:17 games e7f26084
Jan 28 03:22:17 games 00000000
Jan 28 03:22:17 games 00000008
Jan 28 03:22:17 games 00000000

This has been captured with the help of netconsole, unfortunately it
seems the oops is truncated (there is no stack traces as usual), maybe
because the machine rebooted because of the command-line argument
panic=60.

What's also interesting is that after rebooting it crashed again when
the second drive began its SMART extended self-test (scheduled one hour
later). I don't have this other trace because the machine doesn't load
netconsole at reboot, but I suspect it is the same one.

This sounds like what is described:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0512.2/1844.html
and is related to write barriers, it seems.
What I don't really understand is why doing a SMART self-test could
affect the kernel, since only the disk is doing work, the kernel is not
involved in the test.

I didn't had the opportunity to run with barrier=0 mount option, I
simply disabled the SMART test scheduling to be sure it won't crash
anymore.

As this is a production server, I can't reboot it whenever I want, so I
didn't want to perform a binary search on kernel version affected or
not.

If someone need more information, just let me know.

Please CC: me as I'm not subscribed to the list.

Regards,
--
Brice Figureau

