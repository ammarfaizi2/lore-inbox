Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbTCEXtQ>; Wed, 5 Mar 2003 18:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTCEXtQ>; Wed, 5 Mar 2003 18:49:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45501 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267008AbTCEXtP>;
	Wed, 5 Mar 2003 18:49:15 -0500
Date: Wed, 05 Mar 2003 15:41:00 -0800 (PST)
Message-Id: <20030305.154100.28816301.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: kazunori@miyazawa.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: (usagi-core 12294) Re: [PATCH] IPv6 IPsec support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030306.004820.41101302.yoshfuji@linux-ipv6.org>
References: <20030305233025.784feb00.kazunori@miyazawa.org>
	<20030305.072149.121185037.davem@redhat.com>
	<20030306.004820.41101302.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Thu, 06 Mar 2003 00:48:20 +0900 (JST)
   
   > The next large task will be to abstract out more common
   > pieces of code.  There is still quite a bit of code duplication
   > between v4 and v6 xfrm methods,
   
   Yes, we will do that.  That patch is first step for reducing 
   duplicate codes between IPv4 and IPv6.

Great.  I believe it should be possible, in the end, to make the XFRM
engine %100 address-family (v4, v6 etc.) and protocol (ah, esp)
independant.  If that goal is achieved, we may move generic parts from
net/ipv4/xfrm_*.c to net/xfrm_*.c

Note that this coincides with the idea to eventually have
an address-family independant flow cache.

Most of the address-family specific areas are:

1) DST lookup (xfrm_dst_lookup_t)

2) selector key comparisons and state lookup
   (xfrm$(AF)_selector_match, xfrm$(AF)_state_find)

3) receive processing (xfrm${AF}_rcv)

#1 is made for ipv6 by Miyazawa-san's patch.  This could logically
be extended to handle issues #2 and #3 above.

All protocol specific (ESP, AH) and address-family specific references
should go away from places like include/net/xfrm.h

I think you understand all of this, and therefore I cannot wait for the
next ipsec cleanup patch from you :)

Finally, note that eventually we will need some reference counting scheme
for to allow xfrm address-family modules to be unloaded safely.

Currently, ipv4 cannot be a module and ipv6 as a module is not able
to unload :-)  So the module unload problem does not exist right
at this moment.  So ignore this issue for now.
