Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161551AbWAMKpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161551AbWAMKpk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161555AbWAMKpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:45:39 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:51437 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161551AbWAMKpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:45:38 -0500
Date: Fri, 13 Jan 2006 11:46:07 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20060113114607.54c83fc8@localhost>
In-Reply-To: <200601131213.14832.kernel@kolivas.org>
References: <20051227190918.65c2abac@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<20051230145221.301faa40@localhost>
	<200601131213.14832.kernel@kolivas.org>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006 12:13:11 +1100
Con Kolivas <kernel@kolivas.org> wrote:

> Can you try the following patch on 2.6.15 please? I'm interested in how
> adversely this affects interactive performance as well as whether it helps
> your test case.

"./a.out 5000 & ./a.out 5237 & ./a.out 5331 &"
"mount space/; sync; sleep 1; time dd if=space/bigfile of=/dev/null
bs=1M count=256; umount space/"

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5445 paolo     16   0  2396  288  228 R 34.8  0.1   0:05.84 a.out
 5446 paolo     15   0  2396  288  228 S 32.8  0.1   0:05.53 a.out
 5444 paolo     16   0  2392  288  228 R 31.3  0.1   0:05.99 a.out
 5443 paolo     16   0 10416 1104  848 R  0.2  0.2   0:00.01 top
 5451 paolo     15   0  4948 1468  372 D  0.2  0.3   0:00.01 dd

DD test takes ~20 s (instead of 8s).

As you can see DD priority is now very good (15) but it still suffers
because also my test programs get good priority (15/16).


Things are BETTER on the real test case (transcode): this is because
transcode usually gets priority 16 and "dd" gets 15... so dd is quite
happy.

BUT what is STRANGE is this: usually transcode is stuck to priority 16
using about 88% of the CPU, but sometimes (don't know how to reproduce
it) its priority grows up to 25 and then stay to 25.

When transcode priority is 25 the DD test is obviously happy: in
particular 2 things can happen (this is expected because I've observed
this thing before):

1) priority of transcode stay to 25 (when the file transcode is
reading from, through pipes, IS cached).

2) CPU usage and priority of transcode go down (the file transcode is
reading from ISN'T cached and DD massive disk usage interferes with
this reading). When DD finish trancode priority go back to 25.

-- 
	Paolo Ornati
	Linux 2.6.15-kolivasPatch on x86_64
