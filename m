Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbULJTyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbULJTyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 14:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbULJTyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 14:54:54 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:30926
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261175AbULJTyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 14:54:51 -0500
Date: Fri, 10 Dec 2004 11:48:29 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Robin Holt <holt@sgi.com>
Cc: yoshfuji@linux-ipv6.org, akpm@osdl.org, hirofumi@parknet.co.jp,
       torvalds@osdl.org, dipankar@ibm.com, laforge@gnumonks.org,
       bunk@stusta.de, herbert@apana.org.au, paulmck@ibm.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, gnb@sgi.com
Subject: Re: [RFC] Limit the size of the IPV4 route hash.
Message-Id: <20041210114829.034e02eb.davem@davemloft.net>
In-Reply-To: <20041210190025.GA21116@lnx-holt.americas.sgi.com>
References: <20041210190025.GA21116@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004 13:00:25 -0600
Robin Holt <holt@sgi.com> wrote:

> I then did some testing/experimenting with systems that are in production,
> determined the size calculation is definitely too large and then came
> to the following conclusion:
> 
> Limit the route hash size.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110260977405809&w=2
> 
> In the second, I included the patch, but did not intend this to be a
> patch submission.  Sorry for the Signed-off-by.
> 
> Where do I go from here?  I hate to just submit this as a patch without
> any other discussion.

Sometimes we have to just sit and be content with the fact that
nobody is inspired by our work enough to respond. :-)  It usually
means that people aren't too thrilled with your patch, but don't
feel any impetus to mention why.

I can definitely say that just forcing it to use 1 page is wrong.
Even ignoring your tests, your test was on a system that has 16K
PAGE_SIZE.  Other systems use 4K and 8K (and other) PAGE_SIZE
values.  This is why we make our calculations relative to PAGE_SHIFT.

Also, 1 page even in your case is (assuming you are on a 64-bit platform,
you didn't mention) going to give us 1024 hash chains.  A reasonably
busy web server will easily be talking to more than 1K unique hosts at
a given point in time.  This is especially true as slow long distance
connections bunch up.

Alexey Kuznetsov needed to use more than one page on his lowly
i386 router in Russia, and this was circa 7 or 8 years ago.

People are pretty happy with the current algorithm, and in fact
most people ask us to increase it's value not decrease it :-)
