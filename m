Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281215AbRKHBKE>; Wed, 7 Nov 2001 20:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281221AbRKHBJz>; Wed, 7 Nov 2001 20:09:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18316 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281215AbRKHBJu>;
	Wed, 7 Nov 2001 20:09:50 -0500
Date: Wed, 07 Nov 2001 17:09:40 -0800 (PST)
Message-Id: <20011107.170940.10246156.davem@redhat.com>
To: tim@physik3.uni-rostock.de
Cc: adilger@turbolabs.com, jgarzik@mandrakesoft.com, andrewm@uow.edu.au,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        netdev@oss.sgi.com, ak@muc.de, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0111080157180.29908-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <20011107.164426.35502643.davem@redhat.com>
	<Pine.LNX.4.30.0111080157180.29908-100000@gans.physik3.uni-rostock.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tim Schmielau <tim@physik3.uni-rostock.de>
   Date: Thu, 8 Nov 2001 01:58:45 +0100 (CET)

   Please consider to change the appended ones.
   
   --- linux-2.4.14/net/ipv4/route.c	Wed Oct 31 00:08:12 2001
   +++ linux-2.4.14-jiffies64/net/ipv4/route.c	Wed Nov  7 22:51:23 2001
   @@ -395,7 +395,7 @@
    		write_unlock(&rt_hash_table[i].lock);
   
    		/* Fallback loop breaker. */
   -		if ((jiffies - now) > 0)
   +		if ((long)(jiffies - now) > 0)
    			break;
    	}
    	rover = i;

Nothing is wrong with this case.  Jiffies is guarenteed to be greater
than or equal to "now".  There is no need to cast it to a signed type.

Let me say this again, in another way :-)

	SOME_WRAPPED_AROUND_SMALL_VALUE

	MINUS

	SOME_HUGE_ABOUT_TO_WRAP_AROUND_VALUE

will have the same result, signed or not.  Check this out!

(gdb) p (long)0x2 - (long)0xfffffff8
$1 = 10
(gdb) p (unsigned long)0x2 - (unsigned long)0xfffffff8
$2 = 10

It's math and the computer comfirms it! :-)))

Please show me a failure case for this statement if you disagree
with me.

   --- linux-2.4.14/net/ipv4/ipconfig.c	Wed Oct 31 00:08:12 2001
   +++ linux-2.4.14-jiffies64/net/ipv4/ipconfig.c	Wed Nov  7 23:28:47 2001

These cases are indeed buggy.  I'd rather fix these ones with
time_{after,before}() though.  And again, your "signed" casts
are totally superfluous.

Franks a lot,
David S. Miller
davem@redhat.com
