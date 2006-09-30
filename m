Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWI3PGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWI3PGH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 11:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWI3PGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 11:06:07 -0400
Received: from pat.uio.no ([129.240.10.4]:34203 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751052AbWI3PGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 11:06:04 -0400
Subject: Re: Postal 56% waits for flock_lock_file_wait
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC3AD921@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC3AD921@mssmsx411>
Content-Type: text/plain
Date: Sat, 30 Sep 2006 11:05:52 -0400
Message-Id: <1159628752.5425.31.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.222, required 12,
	autolearn=disabled, AWL 1.64, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 09:25 +0400, Ananiev, Leonid I wrote:
> A benchmark
>              'postal -p 16 localhost list_of_1000_users'
> 56% of run time waits for flock_lock_file_wait;
> Vmstat reports that 66% cpu is idle and  vmstat bi+bo=3600 (far from
> max).
> Postfix server with FD_SETSIZE=2048 was used.
> Similar results got for sendmail. 
> Wchan is counted by
>             while :; do
>                         ps -o user,wchan=WIDE-WCHAN-COLUMN,comm;
> sleep 1;
>            done | awk '/ postfix /{a[$2]++}END{for (i in a) print
> a[i]"\t"i}'
> If ext2 fs is used the Postal throughput is twice more and bi+bo by 50%
> less while  flock_lock_file_wait 60% still.

On which filesystem were the above results obtained if it was not ext2?

> Is flock_lock_file_wait considered as a performance limiting waiting for
> similar applications in smp?

All the above results are telling you is that your test involves several
processes contending for the same lock, and so all of them barring the
one process that actually holds the lock are idle.

As for the throughput issue, that really depends on the filesystem you
are measuring. For remote filesystems like NFS, locks can _really_ slow
down performance because they are often required to flush all dirty data
to disk prior to releasing the lock (so that it becomes visible to
processes on other clients that might subsequently obtain the lock).

Cheers,
  Trond

