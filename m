Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267965AbTBVXyd>; Sat, 22 Feb 2003 18:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267980AbTBVXyd>; Sat, 22 Feb 2003 18:54:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5595 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267965AbTBVXyc>;
	Sat, 22 Feb 2003 18:54:32 -0500
Date: Sat, 22 Feb 2003 15:47:53 -0800 (PST)
Message-Id: <20030222.154753.133994666.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: kazunori@miyazawa.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org, kunihiro@ipinfusion.com
Subject: Re: [PATCH] IPv6 IPSEC support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030222.214935.134101784.yoshfuji@linux-ipv6.org>
References: <20030222202623.38d41d8a.kazunori@miyazawa.org>
	<20030222.031326.103246837.davem@redhat.com>
	<20030222.214935.134101784.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Sat, 22 Feb 2003 21:49:35 +0900 (JST)
   
   xfrm_policy.c:xfrm6_bundle_create() seems to depend on ip6_route_output()
   as xfrm_bundle_create() depends on __ip_route_output_key().
   How do we solve this dependency? inter-module?

Good question.

Maybe we can pass around a structure to xfrm_lookup() which contains
information on how to lookup routes for tunnels.  It can just be
a function pointer right now.

It may be possible to generalize this technique even more, making
more xfrm_*() routines address-family independant.

One example, xfrm_lookup() gets this xfrm_afinfo pointer, and it can
use it to learn how to compare addresses.  The xfrm_afinfo pointer
is also passed to xfrm_bundle_create() which uses it to learn how
to lookup tunnel routes.

A small net/ipv6/xfrm_ipv6.c module is created, which registers
a xfrm_afinfo structure to the generic xfrm engine, it teaches
how to do these operations for AF_INET6 xfrm objects.

Do you think this can work?

We have several conflicting desires, all of them arise from capability
to make many things as modules.  The only reliable aspect is that
ipv4 cannot be modular.  Because of this we can allow xfrm_user and
af_key to be either modular or non-modular.
