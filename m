Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265800AbSKFQjR>; Wed, 6 Nov 2002 11:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265805AbSKFQjR>; Wed, 6 Nov 2002 11:39:17 -0500
Received: from [202.88.171.30] ([202.88.171.30]:36776 "EHLO dikhow.hathway.com")
	by vger.kernel.org with ESMTP id <S265800AbSKFQjP>;
	Wed, 6 Nov 2002 11:39:15 -0500
Date: Wed, 6 Nov 2002 22:12:30 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46-mm1 3 uninitialized timers during boot, ipv6 related?
Message-ID: <20021106221230.A21209@dikhow>
Reply-To: dipankar@gamebox.net
References: <3DC8D423.DAD2BF1A@digeo.com> <3DC9192E.62600E21@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC9192E.62600E21@aitel.hist.no>; from helgehaf@aitel.hist.no on Wed, Nov 06, 2002 at 02:40:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 02:40:05PM +0100, Helge Hafting wrote:
> Uninitialised timer!
> This is just a warning.  Your computer is OK
> function=0xc02b53dc, data=0xc1293aec
> Call Trace:
>  [<c011ebc0>] check_timer_failed+0x40/0x4c
>  [<c02b53dc>] igmp6_timer_handler+0x0/0x50
>  [<c011eff1>] del_timer+0x15/0x74
>  [<c02b529e>] igmp6_join_group+0x8a/0x104
>  [<c02b455c>] igmp6_group_added+0xb0/0xbc
>  [<c02bcb99>] fl_create+0x1b9/0x1f8
>  [<c02b48a9>] ipv6_dev_mc_inc+0x281/0x294
>  [<c02a5a1e>] addrconf_join_solict+0x3a/0x44
>  [<c02a6e73>] addrconf_dad_start+0x13/0x12c
>  [<c02a6844>] addrconf_add_linklocal+0x28/0x40
>  [<c02a68f5>] addrconf_dev_config+0x99/0xa4
>  [<c02a69de>] addrconf_notify+0x52/0xc0
>  [<c0121d5a>] notifier_call_chain+0x1e/0x38
>  [<c024f976>] dev_open+0xa2/0xac
>  [<c0250a55>] dev_change_flags+0x51/0x104
>  [<c0281420>] devinet_ioctl+0x2bc/0x598
>  [<c0283827>] inet_ioctl+0x7b/0xb8
>  [<c02c3a9b>] packet_ioctl+0x173/0x190
>  [<c0249943>] sock_ioctl+0x1ef/0x218
>  [<c014bbf9>] sys_ioctl+0x21d/0x274
>  [<c0108943>] syscall_call+0x7/0xb

This patch should fix this up.

Thanks
Dipankar


--- linux-2.5.46-base/net/ipv6/mcast.c	Mon Oct 21 02:12:47 2002
+++ linux-2.5.46-mm/net/ipv6/mcast.c	Wed Nov  6 22:01:32 2002
@@ -296,6 +296,7 @@
 	}
 
 	memset(mc, 0, sizeof(struct ifmcaddr6));
+	init_timer(&mc->mca_timer);
 	mc->mca_timer.function = igmp6_timer_handler;
 	mc->mca_timer.data = (unsigned long) mc;
 
