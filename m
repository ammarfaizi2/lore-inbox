Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWD1XyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWD1XyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWD1XyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:54:04 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:48575 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751777AbWD1XyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:54:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux I/O scheduling - ionice & co
Date: Sat, 29 Apr 2006 09:53:57 +1000
User-Agent: KMail/1.9.1
Cc: devzero@web.de, ck list <ck@vds.kolivas.org>
References: <1092993727@web.de>
In-Reply-To: <1092993727@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604290953.58568.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 April 2006 06:45, devzero@web.de wrote:
> from this list i found, that in recent kernels we have cfq/ionice for this.
> is this rated "stable" and does it already work well?

cfq has builtin ionice support which is automatically linked to nice level 
unless you explicitly set ionice separately.

> if i start an I/O hog like "dd if=/dev/zero of=test.dat" the whole
> interactivity of a linux system is being influenced very negatively. i have
> found that working on a system running an I/O hog often becomes a real
> pain. if i start an CPU hog or syscall hog like "while true;do true;done"
> or "while /bin/true;do /bin/true;done" this never has such bad effects than
> starting an I/O hog.

This is the problem. The ionice support is for reads only. Due to the complex 
path writes take to get to the io scheduler there is no ionice support for 
writes yes so they are all treated equally. Some work is being done in that 
area but nothing is concrete yet. Watch this space.

> is it possible to adress this by some more "fine-tuning" or is this just
> because of the "nature" of I/O scheduling ?

You may be able to effectively throttle the writes by decreasing the amount of 
ram they can use up before writeout occurs but this is a complex process 
where throttling the writes may adversely affect the reads depending on what 
the task committing the writes is doing. The tunables are in /proc/sys/vm

dirty_background_ratio
is the percentage of ram that would be filled with write data before it starts 
committing writes to disk.

dirty_ratio
is the maximum percentage of ram filled and then all writes are throttled 
beyond that (the applications can't commit any more writes till the 
percentage drops enough again)

dirty_writeback_centisecs
how often it will check to see if data has been in ram too long and needs to 
be committed

dirty_expire_centisecs
how old the data can be maximum before being written

All of these have interdependencies and there are sanity checks in the kernel 
that ignore extreme values and rounds them back to other values.

Generally speaking, lowering these values tends to improve interactivity, but 
it is not an impressive improvement, and it happens at the expense of write 
throughput :)

-- 
-ck
