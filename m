Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265228AbUFHPlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUFHPlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUFHPlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:41:51 -0400
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:23532 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S265232AbUFHPlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:41:35 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <510EDE3E-B962-11D8-B170-000A958E2366@mn.rr.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Chris Johns <cbjohns@mn.rr.com>
Subject: kswapd excessive CPU time
Date: Tue, 8 Jun 2004 10:41:32 -0500
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a 2.4.21 kernel (kernel.org + KDB patch + MITRE security patches),
I've seen bizarre (I think) behavior from kswapd.

My question boils down to this: given the (simple) scenario below,
am I missing critical VM/kswapd patches, or is this behavior
expected and OK, or is it wrong and possibly fixed in the 2.6 kernel?
Or is the kswapd behavior somehow tunable to avoid the apparent
thrashing that I saw?

I had a large source tree on an ext3 filesystem on machine A, and
did a 'make' from machine B via NFS. Then I did the equivalent of
'make clean' on machine A itself, and instead of taking maybe 30
seconds, the clean took 10  minutes. During all of that time, kswapd
ran at around 50% CPU, and kjournald was also extremely busy:

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
49161 root      12   0   616  616  488 D 46.5  0.0   3:41.43 find
     5 root      19   0     0    0    0 R 40.9  0.0 503:03.26 kswapd
   261 root      19   0     0    0    0 R 33.2  0.0  54:22.41 kjournald
51794 root      12   0   948  948  720 R  1.7  0.0   0:02.23 top

Meanwhile, memory was pretty constant. Here's a brief snapshot:

# vmstat 2 100000
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  3  0  30876 245536 630012 3865628    0    0    21    34   27     2  3 
14 83  0
  3  0  30876 245308 629968 3865628    0    0    50     0  119    77  0 
98  2  0
  4  1  30876 245284 629996 3865628    0    0   134     0  140   114  0 
98  1  0

Out of 5 GB of memory, only 1/4 GB was free, and 3.8 GB was used
by the page cache. I'm wondering if possibly the 'find/rm' that the
clean was doing freed pages in the cache and that the 5% of memory
that was free is somehow a significant number that caused kswapd
to work like crazy while the find/rm freed cached file data up.

I should say that some KDB backtrace samples from kswapd
showed that it was busy doing kswapd_balance_pgdat().

(I assume the kjournald activity is expected due to the amount of 
metadata
updates that the clean would be generating?)

Thanks,

Chris Johns 

