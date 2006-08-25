Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWHYRIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWHYRIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWHYRIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:08:09 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:12507 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030208AbWHYRIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:08:06 -0400
Message-ID: <44EF2E6F.1040905@fr.ibm.com>
Date: Fri, 25 Aug 2006 19:07:59 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Cedric Le Goater <clg@fr.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@suse.de>, nfs@lists.sourceforge.net
Subject: Re: [NFS] kthread: update lockd to use kthread
References: <44EEA5E5.6000509@fr.ibm.com> <20060825135824.GA10659@infradead.org>
In-Reply-To: <20060825135824.GA10659@infradead.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

Christoph Hellwig wrote:
>>  	host->h_nsmstate = newstate;
>>  	if (!host->h_reclaiming++) {
>> +		struct task_struct* task;
>> +
>>  		nlm_get_host(host);
>>  		__module_get(THIS_MODULE);
>> -		if (kernel_thread(reclaimer, host, CLONE_KERNEL) < 0)
>> +		task = kthread_run(reclaimer, host, "%s-reclaim", host->h_name);
>> +		if (IS_ERR(task))
>>  			module_put(THIS_MODULE);
> 
> Folks, this kind of patches is really useless.  If I wanted to just replace
> kernel_thread() with kthread_run() I could do it myself in a day or two.

ok ok. The real work that needs to be done is in sunrpc and I'm still
*very* far from providing any patches.

This kernel thread is a sub thread of the lockd thread. It's a bit more
simple and does not require as much modification. It still depends on the
way its parent is killed and it will require some more work when the sunrpc
thread are fixed.

> The whole point of the kthread API is that we now have a coherent set
> of functions that deal with all aspects of kernel thread handling.  And
> a conversion to that always involves rething the whole way a driver
> uses kernel threads, and that's a good thing because most users were
> buggy or at least rather odd.
>
> sunrpc is not an exception to that, the thread handling is very interesting,
> including things like using signals for various things possibly not waiting
> for threads to exit.

The SIGKILL used to terminate the threads is a challenge ... it propagates
to sub threads. Some other stuff that bother me in using the kthread api in
sunrpc : nfs_callback_down() uses a wait on a completion with a timeout.
This is not possible with the kthread but might not be really useful. dunno.

We might need some enhancements to kthread to make everyone happy or some
work around in the model.

> If you don't feel like poking into all these nasty internal leave the
> conversation to someone else, preferably a nfs developer.

They would certainly do a better job than me. I'm discovering the code.

Thanks,

C.

