Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbTGGPcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbTGGPcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:32:55 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:16181 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265032AbTGGPcw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:32:52 -0400
Message-ID: <001601c3449f$1e49d5b0$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: =?us-ascii?Q?Remi_Colinet?= <remi.colinet@wanadoo.fr>,
       <linux-kernel@vger.kernel.org>
References: <3F082BBB.6000705@wanadoo.fr>
Subject: Re: 2.5.74 / oops with ppp_synctty and local_bh_enable
Date: Mon, 7 Jul 2003 10:47:48 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm using the Alcatel SpeedTouch modem. It is working fine. :-)
> Meanwhile, when the pppd process is killed, the following oops appears.
> ...
> Jul  6 15:30:04 tigre01 kernel: Badness in local_bh_enable at
kernel/softirq.c:109
> Jul  6 15:30:04 tigre01 kernel: Call Trace:
> Jul  6 15:30:04 tigre01 kernel:  [<c0129265>] local_bh_enable+0x85/0xa0
> Jul  6 15:30:04 tigre01 kernel:  [<e982fe73>] ppp_sync_push+0xd3/0x280
[ppp_synctty]
> Jul  6 15:30:04 tigre01 kernel:  [<e982f768>] ppp_sync_wakeup+0x28/0x60
[ppp_synctty]
> Jul  6 15:30:04 tigre01 kernel:  [<c0226e32>] do_tty_hangup+0x492/0x560


The problem is that do_tty_hangup() in tty_io.h calls the
write wakeup callback with disabled interrupts. The
notes in this function question the validity of disabling
interrupts at that point. I'm not familiar enough with the
locking issues for this function to comment.

At some point ppp_synctty.c was changed to use
spin_lock_bh and spin_unlock_bh in the write wakeup callback.
These macros complain when called with interrupts disabled.

Perhaps changing ppp_synctty.c to use spin_lock_irqsave
and spin_lock_irqrestore is the best fix.

Paul Fulghum, paulkf@microgate.com
Microgate Corporation, www.microgate.com

