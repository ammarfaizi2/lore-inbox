Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWCFCdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWCFCdH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 21:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWCFCdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 21:33:06 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:10847 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S932187AbWCFCdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 21:33:05 -0500
Date: Mon, 06 Mar 2006 11:32:53 +0900 (JST)
Message-Id: <20060306.113253.88700204.nemoto@toshiba-tops.co.jp>
To: paulus@samba.org
Cc: akpm@osdl.org, ak@muc.de, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, johnstul@us.ibm.com,
       rth@twiddle.net
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <17418.7988.409791.419494@cargo.ozlabs.ibm.com>
References: <20060304112010.GA94875@muc.de>
	<20060304034050.40f29251.akpm@osdl.org>
	<17418.7988.409791.419494@cargo.ozlabs.ibm.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 5 Mar 2006 10:13:56 +1100, Paul Mackerras <paulus@samba.org> said:
paul> I think the thing that makes most sense is:

paul> #define jiffies ((unsigned long) jiffies_64)

paul> and fix the few drivers that use `jiffies' as a local variable.
paul> No-one should be trying to write to jiffies, and the compiler
paul> will do the right thing for reads of jiffies on 32-bit platforms
paul> (it does on ppc32 at least).

I think making jiffies a non l-value is good, but this drops volatile
attribute from jiffies (since jiffies_64 is not volatile).  It might
break some codes which do polling on jiffies.

Something like this would be better?

#if defined(__BIG_ENDIAN) && BITS_PER_LONG == 32
#define jiffies (*((const volatile unsigned long *)&jiffies_64 + 1))
#else
#define jiffies (*(const volatile unsigned long *)&jiffies_64)
#endif

And if we do not want to depend on -fno-strict-aliasing, the union
would be The Only Neat Thing to Do.

---
Atsushi Nemoto
