Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTECStu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTECStu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 14:49:50 -0400
Received: from rth.ninka.net ([216.101.162.244]:25065 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263375AbTECSts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 14:49:48 -0400
Subject: Re: [PATCH] net/ipv4/route.c, kernel 2.4.20
From: "David S. Miller" <davem@redhat.com>
To: Arcady Stepanov <penguin@mol.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0304181500140.7345-100000@penguin-hole.mol.ru>
References: <Pine.LNX.4.33.0304181500140.7345-100000@penguin-hole.mol.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051946941.14276.9.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2003 00:29:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-18 at 04:22, Arcady Stepanov wrote:
> The patch is trivial:

This patch is wrong.

>  /* IP route accounting ptr for this logical cpu number. */
> -#define IP_RT_ACCT_CPU(i) (ip_rt_acct + cpu_logical_map(i) * 256)
> +#define IP_RT_ACCT_CPU(i) ((u8*)ip_rt_acct + cpu_logical_map(i) * 256)

There is no way this can be correct.  Look at the formula used
by ip_input.c, which is:

  struct ip_rt_acct *st = ip_rt_acct + 256*smp_processor_id();

So there is only two possibilities, either your patch is wrong
or this code in ip_input.c is wrong.

You probably want to keep IP_RT_ACCT_CPU() how it is, cast _THAT_
to "u8 *" then add in the offset.

Also, you'd get a response more quickly if you had sent this to
the networking development lists (linux-net and netdev@oss.sgi.com)
CC:'ing the networking maintainers (myself and Alexey Kuznetsov).
I came across this posting by pure luck.

linux-kernel is effectively /dev/null for some of us on many days.
Just like ipv4 and ipv6, linux kernel is an unreliable transport.

-- 
David S. Miller <davem@redhat.com>
