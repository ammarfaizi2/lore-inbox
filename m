Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVAHKgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVAHKgy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 05:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVAHKdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 05:33:12 -0500
Received: from gold.muskoka.com ([216.123.107.5]:45471 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id S261856AbVAHKcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 05:32:18 -0500
Message-ID: <41DF9AC1.2010609@muskoka.com>
Date: Sat, 08 Jan 2005 03:33:05 -0500
From: Paul Gortmaker <penguin@muskoka.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.6.9 Use skb_padto() in drivers/net/8390.c]
References: <41DED9FA.7080106@pobox.com>
In-Reply-To: <41DED9FA.7080106@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>
>
>This was done because it benchmarked materially faster than the
>skb_padto version you just reverted. Its only 64 bytes on the stack and
>its cached.
>
>ie the old 8390 code was quite intentional and done because it commonly
>occurs on very old machines where clock count matters. Because of its
>commonness I actually hand optimised this one when I did the original
>fixes to avoid doing extra memory allocations.
>
>Summary: Please revert.
>
>Alan
>
>

Is it possible that skb_padto has since got its act together?   Reason I
ask is that I just dusted off a crusty 386dx40 (doesn't get much older
than that) with a wd8013.  As a basic test, I did ttcp Tx tests with small
packets and they came out to all intents and purposes, identical.   Kernel 
was 2.6.10, with stack vs skb_padto, each size test ran 3 times, even tested
packets bigger than ETH_ZLEN as a (hopefully) invariant.  I've attached the
edited down results below.

Paul.

 --- Stock 2.6.10 kernel with 8390 doing the padding ---

ttcp-t: buflen=1, nbuf=32768, align=16384/0, port=5001  tcp  -> g
1: ttcp-t: 32768 bytes in 32.81 real seconds = 0.98 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 998.79
   ttcp-t: 3.5user 29.2sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
2: ttcp-t: 32768 bytes in 32.80 real seconds = 0.98 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 998.99
   ttcp-t: 3.7user 29.0sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
3: ttcp-t: 32768 bytes in 32.80 real seconds = 0.98 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.02, calls/sec = 999.10
   ttcp-t: 0.2user 32.5sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw

ttcp-t: buflen=10, nbuf=32768, align=16384/0, port=5001  tcp  -> g
1: ttcp-t: 327680 bytes in 32.80 real seconds = 9.76 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.02, calls/sec = 999.06
   ttcp-t: 1.3user 31.4sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
2: ttcp-t: 327680 bytes in 32.80 real seconds = 9.76 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 999.02
   ttcp-t: 1.5user 31.2sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
3: ttcp-t: 327680 bytes in 32.80 real seconds = 9.76 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.02, calls/sec = 999.07
   ttcp-t: 2.3user 30.3sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw

ttcp-t: buflen=40, nbuf=32768, align=16384/0, port=5001  tcp  -> g
1: ttcp-t: 1310720 bytes in 32.80 real seconds = 39.02 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 998.96
   ttcp-t: 14.2user 18.5sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
2: ttcp-t: 1310720 bytes in 32.82 real seconds = 39.00 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 998.37
   ttcp-t: 14.6user 18.1sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+24csw
3: ttcp-t: 1310720 bytes in 32.80 real seconds = 39.02 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 998.91
   ttcp-t: 15.1user 17.5sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw

ttcp-t: buflen=100, nbuf=32768, align=16384/0, port=5001  tcp  -> g
1: ttcp-t: 3276800 bytes in 32.86 real seconds = 97.37 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 997.05
   ttcp-t: 0.1user 32.7sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
2: ttcp-t: 3276800 bytes in 32.93 real seconds = 97.19 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 995.22
   ttcp-t: 0.1user 32.7sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+24csw
3: ttcp-t: 3276800 bytes in 32.83 real seconds = 97.47 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 998.12
   ttcp-t: 0.0user 32.7sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+22csw


--- 2.6.10 Kernel with 8390 calling kernel's skb_padto ---

ttcp-t: buflen=1, nbuf=32768, align=16384/0, port=5001  tcp  -> g
1: ttcp-t: 32768 bytes in 32.81 real seconds = 0.98 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 998.68
   ttcp-t: 1.5user 31.2sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
2: ttcp-t: 32768 bytes in 32.79 real seconds = 0.98 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.02, calls/sec = 999.36
   ttcp-t: 4.3user 28.3sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+24csw
3: ttcp-t: 32768 bytes in 32.80 real seconds = 0.98 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 998.99
   ttcp-t: 9.3user 23.3sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+24csw

ttcp-t: buflen=10, nbuf=32768, align=16384/0, port=5001  tcp  -> g
1: ttcp-t: 327680 bytes in 32.80 real seconds = 9.76 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.02, calls/sec = 999.14
   ttcp-t: 12.5user 20.2sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
2: ttcp-t: 327680 bytes in 32.78 real seconds = 9.76 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.02, calls/sec = 999.52
   ttcp-t: 1.2user 31.5sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
3: ttcp-t: 327680 bytes in 32.78 real seconds = 9.76 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.02, calls/sec = 999.60
   ttcp-t: 5.6user 27.1sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+24csw

ttcp-t: buflen=40, nbuf=32768, align=16384/0, port=5001  tcp  -> g
1: ttcp-t: 1310720 bytes in 32.80 real seconds = 39.03 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.02, calls/sec = 999.09
   ttcp-t: 17.3user 15.4sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+22csw
2: ttcp-t: 1310720 bytes in 32.80 real seconds = 39.02 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 999.00
   ttcp-t: 18.2user 14.5sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+24csw
3: ttcp-t: 1310720 bytes in 32.80 real seconds = 39.03 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.02, calls/sec = 999.06
   ttcp-t: 17.8user 14.9sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+22csw

ttcp-t: buflen=100, nbuf=32768, align=16384/0, port=5001  tcp  -> g
1: ttcp-t: 3276800 bytes in 32.81 real seconds = 97.54 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 998.77
   ttcp-t: 0.0user 32.7sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
2: ttcp-t: 3276800 bytes in 32.82 real seconds = 97.51 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 998.54
   ttcp-t: 0.0user 32.7sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw
3: ttcp-t: 3276800 bytes in 32.83 real seconds = 97.46 KB/sec +++
   ttcp-t: 32768 I/O calls, msec/call = 1.03, calls/sec = 997.99
   ttcp-t: 0.0user 32.7sys 0:32real 99% 0i+0d 0maxrss 0+0pf 0+23csw


