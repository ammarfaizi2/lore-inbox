Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUDBXpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 18:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUDBXp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 18:45:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:45781 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261410AbUDBXpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 18:45:08 -0500
Date: Fri, 2 Apr 2004 15:47:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Consistently slower 3ware RAID performance under 2.6.4
Message-Id: <20040402154718.43f16ea9.akpm@osdl.org>
In-Reply-To: <406D89B8.4090308@techsource.com>
References: <406D89B8.4090308@techsource.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> wrote:
>
> ## Performance with "2.4.25-gentoo":
> 
> The read test here takes 21.6 seconds which is about 47MB/sec.  This is 
> a correct number, because I have measured the maximum read throughput 
> from each drive to be 47MB/sec.
> 
> The write test here takes 2 minutes, 2.5 seconds.  This translates to 
> 8.35MB/sec.  This is what I'm working with 3ware to correct, but let's 
> call this the baseline write performance.
> 
> 
> ## Performance with "2.6.4-gentoo-r1":
> 
> The read test here takes 33.9 seconds.  That's down to about 30MB/sec.
> 
> The write test here takes 2 minutes, 44.2 seconds.  That is down to 
> 6.2MB/sec.
> 

You cannot compare 2.4 and 2.6 kernel write performance with `dd', because
the kernels are tuned differently.  2.6 kernels are tuned to leave less
dirty pages in memory than a 2.4 kernel.  Hence when your dd has finished,
40% of memory will be dirty (needing writeout) under 2.6, but this figure
is 60% on 2.4.

So the 2.6 kernel does more writeout during the dd run and less writeout
after dd has finished.  The 2.4 kernel does less writeout during the dd run
and more writeout after dd has finished.

To compare IO performance you'll need to set 2.6's /proc/sys/vm/dirty_ratio
to 60 and /proc/sys/vm/dirty_async_ratio to 30.  Or use write-and-fsync
from http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz with
the `-f' option.

I don't know why the read bandwidth appears to be lower.  Try increasing
the readahead with `blockdev --setra'?
