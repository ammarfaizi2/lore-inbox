Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWFQSsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWFQSsp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWFQSsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:48:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41191 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750793AbWFQSso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:48:44 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44944D8A.6090808@s5r6.in-berlin.de>
Date: Sat, 17 Jun 2006 20:44:26 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Ben Collins <bcollins@ubuntu.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       weihs@ict.tuwien.ac.at, linux1394-devel@lists.sourceforge.net,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
References: <20060610143100.GA15536@sergelap.austin.ibm.com> <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de> <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson> <20060610163859.GA24081@infradead.org> <1149962931.4448.557.camel@grayson> <20060610183703.GA1497@infradead.org>
In-Reply-To: <20060610183703.GA1497@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.877) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote on 2006-06-17:
> Below is a draft patch to convert it to the kthread API and replace the
> reset_sem with a simple wake_up_process scheme.  I removed the down_trylock
> loop there which I think should be fine because we get the wakeup again
> ASAP, but please double-check.
[...]
[in nodemgr_host_thread(), top of event loop]
> @@ -1579,15 +1573,14 @@
>  		unsigned int generation = 0;
>  		int i;
>  
> -		if (down_interruptible(&hi->reset_sem) ||
> -		    down_interruptible(&nodemgr_serialize)) {
> +		if (down_interruptible(&nodemgr_serialize)) {

This won't work. "down_interruptible(&hi->reset_sem)" was there to put 
the thread to sleep after it did its work, until the next bus reset. Now 
the event loop would be entered continuously without an actual bus reset 
event.

(nodemgr_serialize is just a mutex disguised as a semaphore which 
prevents multiple nodemgr host threads to enter their event loop 
concurrently.)

>  			if (try_to_freeze())
>  				continue;
>  			printk("NodeMgr: received unexpected signal?!\n" );
>  			break;
>  		}
>  
> -		if (hi->kill_me) {
> +		if (kthread_should_stop()) {
>  			up(&nodemgr_serialize);
>  			break;
>  		}
> @@ -1608,13 +1601,8 @@
>  			 * returning bogus data. */
>  			generation = get_hpsb_generation(host);
>  
> -			/* If we get a reset before we are done waiting, then
> -			 * start the the waiting over again */
> -			while (!down_trylock(&hi->reset_sem))
> -				i = 0;
[...]

Another minor issue: This check cannot be removed without replacement. 
However we could implement this check easily without a counting 
semaphore. (We could check the bus generation before and after the sleep.)

I will try to rework this patch and split it into more patches: One 
which converts nodemgr to the kthread API but keeps the reset_sem, one 
patch which gets rid of the counting semaphore reset_sem, one patch 
which converts nodemgr_serialize to a mutex.

BTW, it may be possible to remove nodemgr_serialize too. There are other 
exclusion mechanisms in nodemgr.c which should already prevent most if 
not all undesirable concurrency, notably the semaphores 
dev->bus->subsys.rwsem and class->subsys.rwsem.
-- 
Stefan Richter
-=====-=-==- -==- =---=
http://arcgraph.de/sr/
