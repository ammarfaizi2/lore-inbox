Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVDLFzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVDLFzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVDLFxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:53:15 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:33388 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262033AbVDLFvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:51:43 -0400
Message-ID: <425B61DD.60700@yahoo.com.au>
Date: Tue, 12 Apr 2005 15:51:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org> <20050411220013.23416d5f.akpm@osdl.org>
In-Reply-To: <20050411220013.23416d5f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>So it turns out that patch was broken.  I've fixed it locally and the
>results are good, but odd.
>
>The machine is a 4GB x86_64 with aic79xx controllers and MAXTOR
>ATLAS10K4_73WLS disks.  ext2 filesystem.
>
>The workload is continuous pagecache writeback versus
>read-lots-of-little-files:
>
>	while true
>	do
>		dd if=/dev/zero of=/mnt/sdb2/x bs=40M count=100 conv=notrunc
>	done
>
>versus
>
>	find /mnt/sdb2/linux-2.4.25 -type f | xargs cat > /dev/null
>
>we measure how long the find+cat takes.
>
>2.6.12-rc2, 	as,	tcq depth=2:		7.241 seconds
>2.6.12-rc2, 	as,	tcq depth=64:		12.172 seconds
>2.6.12-rc2+patch,as,	tcq depth=64:		7.199 seconds
>2.6.12-rc2, 	cfq2,	tcq depth=64:		much more than 5 minutes
>2.6.12-rc2, 	cfq3,	tcq depth=64:		much more than 5 minutes
>
>So
>
>- The effects of tcq on AS are much less disastrous than I thought they
>  were.  Do I have the wrong workload?  Memory fails me.  Or did we fix the
>  anticipatory scheduler?
>
>

Yes, we did fix it ;)
Quite a long time ago, so maybe you are thinking of something else
(I haven't been able to work it out).

AS basically does its own TCQ strangulation, which IIRC involves things
like completing all reads before issuing new writes, and completing all
reads from one process before reads from another. As well as the
fundamental way that waiting for a 'dependant read' throttles TCQ.

>- as-limit-queue-depth.patch fixes things right up anyway.  Seems to be
>  doing the right thing.  
>
>

Well it depends on what we want to do. If we hard limit the AS queue
like this, I can remove some of that TCQ throttling logic from AS.

OTOH, the throttling was intended to allow us to sanely use a large
TCQ depth without getting really bad behaviour. Theoretically a process
can make use of TCQ if it is doing a lot of writing, or if it is not
determined to be doing dependant reads.



