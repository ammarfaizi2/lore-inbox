Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966532AbWKOAbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966532AbWKOAbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 19:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966521AbWKOAbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 19:31:05 -0500
Received: from mail.station1.mxsweep.com ([212.147.136.149]:63757 "EHLO
	blue.mxsweep.com") by vger.kernel.org with ESMTP id S966532AbWKOAbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 19:31:01 -0500
Message-ID: <455A5F97.1070509@draigBrady.com>
Date: Wed, 15 Nov 2006 00:30:15 +0000
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Lauri Lubi <lauri@lubi.se>
Subject: negative anon_rss?
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mlf-Version: 5.0.0.8233
X-Mlf-UniqueId: o200611150032140002387
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not sending this to linux-mm,
but I can't subscribe at present? Anyway...

I wrote the following script to try and accurately determine
how much RAM a particular program uses:
http://www.pixelbeat.org/scripts/ps_mem.py

A user reported an issue on debian with kernel 2.6.8-2-386
where many processes were being reported as using
a negative amount of memory.

I asked him to run the following:

  (
    echo total rss shared trs - drs -
    for pid in `pidof apache2`; do
        cat /proc/$pid/statm
    done
  ) | column -t

the output of which was:

  total  rss   shared  trs  -  drs   -
  6580   2306  5273    95   0  6485  0
  6580   2313  5273    95   0  6485  0
  6119   1717  5269    95   0  6024  0
  6630   2371  5273    95   0  6535  0
  6735   2503  5273    95   0  6640  0
  6773   2546  5273    95   0  6678  0
  5845   1146  5198    95   0  5750  0

Notice the large values for the shared column.
Also notice that the shared column is larger than rss!?
I had assumed that shared was a subset of rss from
the following (pseudo) code from fs/proc/task_mmu.c::task_statm()

  *total  = mm->total_em
  *shared = get_mm_counter(mm, file_rss)
  *rss    = *shared + get_mm_counter(mm, anon_rss)
  *trs    = mm->end_code - mm->start_code
  *drs    = mm->total_vm - mm->shared_vm

Therefore anon_rss must be negative in the kernel?
So there is a mismatch between pages being marked
as anonymous and anon_rss being updated appropriately?

cheers,
Pádraig.
