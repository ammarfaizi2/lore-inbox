Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWAJNz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWAJNz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWAJNz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:55:27 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:13287 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932097AbWAJNz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:55:26 -0500
Date: Tue, 10 Jan 2006 14:53:21 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Mike Galbraith <efault@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20060110145321.00aa7040@localhost>
In-Reply-To: <5.2.1.1.2.20060110135846.00bfd0a8@pop.gmx.net>
References: <5.2.1.1.2.20060110125942.00bef510@pop.gmx.net>
	<20060109210035.3f6adafc@localhost>
	<5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
	<5.2.1.1.2.20060102092903.00bde090@pop.gmx.net>
	<20060101123902.27a10798@localhost>
	<5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<200512281027.00252.kernel@kolivas.org>
	<20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
	<5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
	<5.2.1.1.2.20060110125942.00bef510@pop.gmx.net>
	<5.2.1.1.2.20060110135846.00bfd0a8@pop.gmx.net>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006 14:01:36 +0100
Mike Galbraith <efault@gmx.de> wrote:

> > > Can you please try this version?  It tries harder to correct any
> >
> >It seems that you have forgotten the to attach the patch...
> 
> Drat.  At least I'm not the first to ever do so :)

This version basically works like the the previous, except that it makes
the priority adjustment faster (that is fine).

However I can fool it the same way.

"./a.out 7000"
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5459 paolo     22   0  2392  288  228 S 71.3  0.1   0:09.47 a.out

"./a.out 3000"
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5493 paolo     19   0  2396  292  228 R 49.8  0.1   0:14.42 a.out

"./a.out 1500"
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5495 paolo     18   0  2396  288  228 S 33.4  0.1   0:09.60 a.out


Fooling it:

"./a.out 7000 & ./a.out 6537 & ./a.out 6347 & ./a.out 5873 &"
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5502 paolo     19   0  2392  288  228 R 27.0  0.1   0:05.64 a.out
 5503 paolo     19   0  2396  288  228 R 26.0  0.1   0:07.50 a.out
 5505 paolo     19   0  2396  292  228 R 25.6  0.1   0:07.24 a.out
 5504 paolo     18   0  2392  288  228 R 21.0  0.1   0:06.78 a.out

(priorities fluctuate between 18/19)


Again with more of them:

./a.out 7000 & ./a.out 6537 & ./a.out 6347 & ./a.out 5873& ./a.out 6245 & ./a.out 5467 &

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5525 paolo     18   0  2396  288  228 R 26.4  0.1   0:07.48 a.out
 5521 paolo     19   0  2396  288  228 R 22.0  0.1   0:09.00 a.out
 5524 paolo     19   0  2392  288  228 R 19.6  0.1   0:07.21 a.out
 5523 paolo     19   0  2392  288  228 R 13.0  0.1   0:10.60 a.out
 5520 paolo     19   0  2392  288  228 R 11.0  0.1   0:08.46 a.out
 5522 paolo     19   0  2396  288  228 R  7.8  0.1   0:07.14 a.out

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5528 paolo     18   0  2392  288  228 R 19.7  0.1   0:18.15 a.out
 5533 paolo     15   0  2396  288  228 S 19.3  0.1   0:19.12 a.out
 5531 paolo     18   0  2396  288  228 R 18.5  0.1   0:19.23 a.out
 5532 paolo     17   0  2392  288  228 R 15.1  0.1   0:18.55 a.out
 5529 paolo     18   0  2396  288  228 R 14.7  0.1   0:13.05 a.out
 5530 paolo     18   0  2392  288  228 R 12.5  0.1   0:20.42 a.out

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5530 paolo     18   0  2392  288  228 R 21.0  0.1   0:25.42 a.out
 5533 paolo     18   0  2396  288  228 R 20.2  0.1   0:24.75 a.out
 5529 paolo     18   0  2396  288  228 R 16.2  0.1   0:17.68 a.out
 5532 paolo     18   0  2392  288  228 R 14.8  0.1   0:23.33 a.out
 5531 paolo     18   0  2396  288  228 R 14.4  0.1   0:23.96 a.out
 5528 paolo     18   0  2392  288  228 R 13.6  0.1   0:23.03 a.out


-- 
	Paolo Ornati
	Linux 2.6.15-sched_trottle2 on x86_64
