Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTDULWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTDULWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:22:33 -0400
Received: from mail-8.tiscali.it ([195.130.225.154]:33949 "EHLO
	mail-8.tiscali.it") by vger.kernel.org with ESMTP id S263811AbTDULWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:22:32 -0400
Date: Mon, 21 Apr 2003 13:33:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Neil Schemenauer <nas@arctrix.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, akpm@digeo.com,
       conman@kolivas.net
Subject: Re: [PATCH][CFT] new IO scheduler for 2.4.20
Message-ID: <20030421113346.GE21877@dualathlon.random>
References: <20030417172818.GA8848@glacier.arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030417172818.GA8848@glacier.arctrix.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 10:28:19AM -0700, Neil Schemenauer wrote:
> Hi all,
> 
> Recently I was bitten badly by bad IO scheduler behavior on an important
> Linux server.  An easy way to trigger this problem is to start a
> streaming write process:
> 
>     while :
>     do
>             dd if=/dev/zero of=foo bs=1M count=512 conv=notrunc
>     done
> 
> and then try doing a bunch of small reads:
> 
>     time (find kernel-tree -type f | xargs cat > /dev/null)

can you try the above on 2.4.21pre5aa2? I also spent effort to fix it
some month ago.

The interesting patch is this:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre5aa2/9981_elevator-lowlatency-4

the reason 2.4 mainline stalls so much is that the size of the queue is
overkill for no good reason, so no matter the elvtune numbers, you're
going to wait several dozen mbytes to be read or written before you can
read or write the next 1k from another task.

the above patch is fairly old and it basically fixes the showstopper
problem for me, contest looks fine now and throughput still is the best.

I don't like special "read hacks" for generic kernels that are critical
with O_SYNC and journaling responsiveness too.

So I recommend to apply the above 2.4 patch if you suffer any I/O
latency issue.

Andrea
