Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271174AbTHCMpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 08:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271177AbTHCMpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 08:45:25 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:10513 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271174AbTHCMpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 08:45:23 -0400
Date: Sun, 3 Aug 2003 14:45:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel@vger.kernel.org, janfrode@parallab.uib.no
Subject: Re: Badness in local_bh_enable at kernel/softirq.c:113
Message-ID: <20030803124521.GA4054@win.tue.nl>
References: <20030803115131.GA28454@ii.uib.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803115131.GA28454@ii.uib.no>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 01:51:31PM +0200, Jan-Frode Myklebust wrote:

> Kernel: 2.6.0-test2
> ppp-2.4.1-r14
> pptpclient-1.2.0
> 
> Problem Description:
> 
> My pptp client connections keeps dying, syslogging:

> Aug  3 13:35:36 [pppd] Using interface ppp0
> Aug  3 13:35:36 [pppd] Connect: ppp0 <--> /dev/pts/4
> Aug  3 13:35:36 [/etc/hotplug/net.agent] NET add event not supported
> Aug  3 13:35:38 [pptp] anon log[decaps_hdlc:pptp_gre.c:198]: PPP mode seems to be Asynchronous._
> Aug  3 13:35:39 [pppd] Remote message: Welcome^M^J
> Aug  3 13:35:41 [pppd] local  IP address 129.177.43.23
> Aug  3 13:35:41 [pppd] remote IP address 129.177.43.1
> Aug  3 13:36:07 [pppd] Unsupported protocol 0xd44a received
> Aug  3 13:36:57 [pppd] Unsupported protocol 0xcc4a received
> aug  3 13:38:20 [su(pam_unix)] session opened for user root by (uid=1001)
> Aug  3 13:39:21 [anacron] Job `cron.daily' started
> Aug  3 13:39:29 [crontab] (root) LIST (root)_
> Aug  3 13:39:37 [pptp] anon warn[decaps_gre:pptp_gre.c:300]: short read (-1): Message too long
> Aug  3 13:39:37 [pptp] anon log[callmgr_main:pptp_callmgr.c:234]: Closing connection
> Aug  3 13:39:37 [pptp] anon log[pptp_conn_close:pptp_ctrl.c:308]: Closing PPTP connection
> Aug  3 13:39:39 [pptp] anon log[call_callback:pptp_callmgr.c:74]: Closing connection
> Aug  3 13:39:39 [pppd] Hangup (SIGHUP)
> Aug  3 13:39:39 [kernel] Badness in local_bh_enable at kernel/softirq.c:113
> 
> And giving this call trace in the kernel log:
> 
> Badness in local_bh_enable at kernel/softirq.c:113
> Call Trace:
>  [<c0120b88>] local_bh_enable+0x88/0x90
>  [<c037bd54>] ppp_async_push+0xa4/0x1b0
>  [<c015dd04>] __lookup_hash+0x64/0xd0
>  [<c037b621>] ppp_asynctty_wakeup+0x31/0x60
>  [<c032bff6>] pty_unthrottle+0x56/0x60
>  [<c032898a>] check_unthrottle+0x3a/0x40
>  [<c0328a34>] n_tty_flush_buffer+0x14/0x50
>  [<c032c3ae>] pty_flush_buffer+0x5e/0x60
>  [<c03253ac>] do_tty_hangup+0x3ac/0x420

The badness in local_bh_enable part is well-known (but I don't know
whether anybody fixed it in -mm already). It was (is?) must-fix bug
#1 on Andrew's list.

(What happens is that do_tty_hangup() does
	local_irq_save(flags); // FIXME: is this safe?
	*flush_buffer(tty);
where the flush buffer ends up calling ppp_async_push(), which does
	spin_lock_bh ... spin_unlock_bh
and spin_unlock_bh() calls local_bh_enable() which does
	WARN_ON(irqs_disabled());

So, we know that it happens, and why it happens, and can trivially
remove the symptom with an ostrich head-in-sand patch.)

This happens when pppd dies. I don't know why your pppd has problems.

