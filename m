Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbTEEOoW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTEEOoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:44:22 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262287AbTEEOoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:44:20 -0400
Date: Mon, 5 May 2003 07:53:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christian Hammers <ch@westend.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: icmp_ratelimit seems to be too low (related to NAT?)
Message-Id: <20030505075358.7555f137.rddunlap@osdl.org>
In-Reply-To: <20030505093523.GE15625@westend.com>
References: <20030505093523.GE15625@westend.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003 11:35:23 +0200 Christian Hammers <ch@westend.com> wrote:

| Hello
| 
| icmp_ratelimit has, as of kernel 2.4.20, a default of 100 (which unit
| btw?). This seems to be too low as I have packet loss when doing two
| "mtr" to the same 4 hops away host simultaneously. As this suggerates
| packet loss on the network to the administrator, a too low limit will 
| certainly annoy network admins as it gives wrong information.

icmp_ratelimit is init to 1 * HZ (where HZ == 100 most likely),
so I'll guess that unit is jiffies (100ths of a second).

| My tests gave the following results:
| 
| src. linux --> SNAT'ing linux router --> cisco1 --> cisco2 --> dst. linux
| 
| On the src linux host I opened _two_ mtr at the same time and watched
| the packet loss at the first host after 30 rounds (seconds).
| 
| 	icmp_ratelimit | loss at hop1 for both mtr
| 	0		 0
| 	10		 0
| 	20		 0
| 	40		 0
| 	80		 34% and 37%
| 	100		 44% and 57%	(default)
| 	160		 64% and 75%
| 	320		 87% and 83%
| 	999		 100% and 100%
| 
| For 2*(4*icmp_request + 4*icmp_timeexceeded/reply) = 16 packets per 
| second the loss seems to be a bit high at the default value of 100.
| 
| Is this related to any other setting? Maybe NAT?
| My /proc/net/ip_conntrack only has 1200 lines and the max in 
| /proc/sys/net/ipv4/ip_conntrack_max is 32767.

Only other value that I see related to it is
icmp_ratemask, which has a default value of 0x1818.
>From net/ipv4/icmp.c:

/* 
 * 	Configurable global rate limit.
 *
 *	ratelimit defines tokens/packet consumed for dst->rate_token bucket
 *	ratemask defines which icmp types are ratelimited by setting
 * 	it's bit position.
 *
 *	default: [for ratemask -RDD]
 *	dest unreachable (3), source quench (4),
 *	time exceeded (11), parameter problem (12)
 */

--
~Randy
