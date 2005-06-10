Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVFJEyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVFJEyF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 00:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVFJEyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 00:54:04 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:55032 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261450AbVFJEx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 00:53:59 -0400
Message-ID: <42A91D36.8090506@lab.ntt.co.jp>
Date: Fri, 10 Jun 2005 13:55:18 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de, andrea@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Real-time problem due to IO congestion.
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have been encountering big real-time problem due to IO congestion, and
I want some advices.

-The problem description-
There are 2 type processes in test environment.
1. The real-time needed process (run on with high static priority)
    The process wake up every 10ms, and wake up, write some log (the
test case is current CPU clock via tsc) to the file.

2. The process which make IO load
    The process have large memory size, and kill the process with dumping.
    The process's memory area exceeds 70% of whole physical
RAM.(Actually 1.5GB memory area while whole RAM is 2GB)

Whenever during dumping, the real-time needed process sometimes stop for
long time during write system call. (sometimes exceeds 1000ms)
I tested every IO scheduler but the same problem occurs.
I also seek this problem into the code, and find that the stops are
mainly occurring on blk_congestion_wait/get_request/get_request_wait
functions located on drivers/block/ll_rw_blk.c.

-My assumption-
The design of IO(read/write) queue and queuing is not well match to
real-time needed processes.
If there are many IO requests by low priority processes already, then
the IO request by high priority process should wait until queue goes
clean, and this cause some kind of priority inversions.

-My suggestion-
Add the new IO scheduler or change current IO scheduler to reflect
process's priority on queuing.

I don't know my assumption and suggestion are correct and you like,
would you give me some advices?

Thank you.
-- 
Takashi Ikebe

