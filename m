Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269017AbUIHDVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269017AbUIHDVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUIHDVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:21:03 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:39255 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269017AbUIHDU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:20:58 -0400
Message-ID: <413E779D.4050608@yahoo.com.au>
Date: Wed, 08 Sep 2004 13:08:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Dawson Engler <engler@coverity.dreamhost.com>
CC: linux-kernel@vger.kernel.org, developers@coverity.com
Subject: Re: [CHECKER] potential NFS deadlock in 2.6.8.1
References: <Pine.LNX.4.58.0409071949070.28006@coverity.dreamhost.com>
In-Reply-To: <Pine.LNX.4.58.0409071949070.28006@coverity.dreamhost.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler wrote:
> Hi All,
> 
> below is a possible deadlock in the linux-2.6.8.1 NFS found by a static
> deadlock checker I'm writing.  Let me know if it looks valid and/or
> whether the output is too cryptic.
> 
> Thanks,
> Dawson
> 
> ------------------------------------------------------------------
> 
> ERROR:DEADLOCK: 2 thread cycle:
>      lock_kernel  <<===>>  client_sema
> 

Hi Dawson, your tool looks nice. I don't think the output is too
cryptic.

However, I think these deadlocks may be incorrect because
lock_kernel is not a normal lock. It gets dropped when the
thread blocks, so I *think* it is basically invisible to any
sort of blocking lock when it comes to deadlock cycles.

So if your threads interleave like this:
1			2
lock_kernel();
			down(semaphore);
			lock_kernel();
down(semaphore);

Then thread 2 will spin on the lock_kernel lock (bkl) until
thread 1 hits down(semaphore) and goes to sleep, releasing
the bkl. Thread 2 takes the bkl and proceeds.

I think?
