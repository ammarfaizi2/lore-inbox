Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264432AbRGWXRE>; Mon, 23 Jul 2001 19:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264461AbRGWXQy>; Mon, 23 Jul 2001 19:16:54 -0400
Received: from zeus.kernel.org ([209.10.41.242]:42717 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264432AbRGWXQq>;
	Mon, 23 Jul 2001 19:16:46 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15196.45004.237634.928656@pizda.ninka.net>
Date: Mon, 23 Jul 2001 16:14:20 -0700 (PDT)
To: Chris Evans <chris@scary.beasts.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Minor net/core/sock.c security issue?
In-Reply-To: <Pine.LNX.4.33.0107232321120.19755-100000@ferret.lmh.ox.ac.uk>
In-Reply-To: <Pine.LNX.4.33.0107232321120.19755-100000@ferret.lmh.ox.ac.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Chris Evans writes:
 >     int val;
 > ...
 >     case SO_SNDBUF:
 >       if (val > sysctl_wmem_max)
 >         val = sysctl_wmem_max;
 >       sk->sndbuf = max(val*2,2048);
 > 
 > If val is negative, then sk->sndbuf ends up negative. This is because the
 > arguments to max are passed as _unsigned_ ints. SO_RCVBUF has similar
 > issues. Maybe a nasty local user could use this to chew up memory?

Indeed, you have only hit the tip of the iceberg on the larger
problems lurking in this area.

In short, min/max usage is pretty broken.  And it is broken for
several reasons:

1) Signedness, what you have discovered.

2) Arg evaluation.

3) Multiple definitions

#3 is what really makes this look gross.  Watch this:

include/net/sock.h declares two inline functions, min and
max

net/core/sock.c defines "min" as a macro, overriding the
function in sock.h

egrep "define max" include/linux/*.h shows at least three
other headers which want to define their own max macro.

There is even commentary about this in include/linux/netfilter.h along
with Rusty's attempt to make reasonable macros.  I personally disagree
with keeping them as macros because of the arg multiple evaluation
issues.

I think the way to fix this is to either:

1) have standard inline functions with names that suggest the
   signedness, much like Rusty's netfilter macros.

2) Just open code all instances of min/max, there will be no
   mistaking what the code does in such a case.

In both cases, min/max simply die and nobody can therefore misuse them
anymore.

Later,
David S. Miller
davem@redhat.com
