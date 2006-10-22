Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWJVBfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWJVBfA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 21:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWJVBe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 21:34:59 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:15497 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1030396AbWJVBe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 21:34:58 -0400
Date: Sun, 22 Oct 2006 02:34:54 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
       linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
       James.Bottomley@SteelEye.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061022013454.GA4418@linux-mips.org>
References: <Pine.LNX.4.64.0610201625190.3962@g5.osdl.org> <20061021000609.GA32701@linux-mips.org> <Pine.LNX.4.64.0610201733490.3962@g5.osdl.org> <20061020.191134.63996591.davem@davemloft.net> <Pine.LNX.4.64.0610201934170.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201934170.3962@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 07:37:24PM -0700, Linus Torvalds wrote:

> Well, if you can re-create the performance numbers (Ralf - can you send 
> the full series with the final "remove the now unnecessary flush" to 
> Davem?), that will make deciding things easier, I think.

Blwo are numbers and comments from Atsushi Nemoto on two Toshiba TY49
cores with 16K rsp. 32K per primary cache.  Each lmbench run was repeated
twice.  The numbers taken without the flush_cache_mm hack to dup_mmap(),
so there are those 12% on fork which can easily be obtained in addition
on PIVT caches such as the TX49.

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
TX49-16K  without-patch  197 0.72 2.40 17.7 34.3 82.9 2.84 26.2 2500 9364 39.K
TX49-16K  without-patch  197 0.73 2.40 17.7 34.4 82.9 2.85 26.1 2495 9337 39.K
TX49-16K  without-patch  197 0.72 2.40 17.8 34.3 82.9 2.85 26.1 2501 9341 39.K
TX49-16K  with-patch     197 0.72 2.39 20.1 31.9 82.9 2.85 20.2 2491 9101 38.K
TX49-16K  with-patch     197 0.72 2.39 20.1 32.8 82.9 2.86 20.2 2496 9058 38.K
TX49-16K  with-patch     197 0.72 2.39 20.1 32.8 82.9 2.85 20.3 2501 9074 38.K
TX49-32K  without-patch  396 0.36 1.19 6.78 11.3 41.0 1.41 8.15 1246 4674 19.K
TX49-32K  without-patch  396 0.36 1.19 6.78 11.3 41.0 1.41 8.17 1251 4680 19.K
TX49-32K  without-patch  396 0.36 1.19 6.79 11.3 41.0 1.41 8.15 1250 4682 19.K
TX49-32K  with-patch     396 0.36 1.19 6.79 10.2 41.0 1.41 8.14 1230 4638 19.K
TX49-32K  with-patch     396 0.36 1.19 6.78 10.2 40.9 1.41 8.14 1241 4628 19.K
TX49-32K  with-patch     396 0.36 1.19 6.79 10.2 40.9 1.41 8.14 1238 4627 19.K

A little bit faster on exec/proc and open/close (why?).  Strange
results on sig/hndl and stat on TX49-16K again.


Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
TX49-16K  without-patch 4.7800   87.1   36.5   97.2   47.8   101.1    40.8
TX49-16K  without-patch 5.4000   88.4   28.9   96.2   39.6   101.2    40.8
TX49-16K  without-patch 4.6800   84.5   32.7   96.8   46.5   100.2    42.9
TX49-16K  with-patch    2.4600   82.7   34.0   93.5   50.5    97.2    43.3
TX49-16K  with-patch    1.5200   87.7   33.6   95.1   42.4    99.7    43.6
TX49-16K  with-patch    1.7700   86.2   34.1   95.8   49.0    99.2    41.7
TX49-32K  without-patch          31.4   11.3   72.1   15.2    72.3    16.9
TX49-32K  without-patch          30.4   11.6   72.2   16.1    73.2    15.1
TX49-32K  without-patch          33.5   12.1   71.2   15.5    73.0    17.0
TX49-32K  with-patch             30.9   11.5   72.3   17.4    73.1    17.5
TX49-32K  with-patch             31.5   11.9   71.8   15.8    73.0    16.7
TX49-32K  with-patch             32.5   10.4   71.7   16.0    72.5    16.6

No noticeable differences.


File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
TX49-16K  without-patch  251.8  192.5 1212.1  397.6   500.0 4.388 7.32710  50.5
TX49-16K  without-patch  254.7  193.9 1197.6  394.9   505.0 4.412 7.34230  50.5
TX49-16K  without-patch  252.6  193.6 1212.1  399.4   499.0 4.758 7.33790  50.5
TX49-16K  with-patch     251.8  192.2 1207.7  391.7   502.0 0.143 7.32320  50.5
TX49-16K  with-patch     252.7  194.0 1200.5  393.7   505.0 0.108 7.32030  50.5
TX49-16K  with-patch     252.0  191.8 1199.0  392.3   508.0 0.011 7.33150  50.5
TX49-32K  without-patch   86.0   54.8  461.3  146.3   378.0 1.818 5.45460  25.0
TX49-32K  without-patch   86.5   54.1  454.3  148.1   378.0 1.816 5.47120  25.0
TX49-32K  without-patch   86.7   53.8  458.1  148.0   378.0 2.130 5.48540  25.0
TX49-32K  with-patch      90.4   52.5  460.8  148.7   377.0 0.471 5.46340  25.0
TX49-32K  with-patch      88.8   52.6  462.5  148.6   380.0 0.476 5.44630  25.0
TX49-32K  with-patch      88.7   52.9  466.4  147.8   378.0 0.477 5.49560  25.0

Major improvements on Prot/Fault.

  Ralf
