Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265327AbUBPC67 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbUBPC67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:58:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9111 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265327AbUBPC6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:58:54 -0500
Message-ID: <403031DF.9050506@pobox.com>
Date: Sun, 15 Feb 2004 21:58:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@redhat.com>,
       Mike Christie <mikenc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread
References: <402A4B52.1080800@centrum.cz>	 <1076866470.20140.13.camel@leto.cs.pocnet.net>	 <20040215180226.A8426@infradead.org>	 <1076870572.20140.16.camel@leto.cs.pocnet.net>	 <20040215185331.A8719@infradead.org>	 <1076873760.21477.8.camel@leto.cs.pocnet.net>	 <20040215194633.A8948@infradead.org>	 <20040216014433.GA5430@leto.cs.pocnet.net>  <4030268C.6050701@pobox.com> <1076899244.5601.21.camel@leto.cs.pocnet.net>
In-Reply-To: <1076899244.5601.21.camel@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> Am Mo, den 16.02.2004 schrieb Jeff Garzik um 03:10:
> 
> 
>>>+		/*
>>>+		 * if additional pages cannot be allocated without waiting,
>>>+		 * return a partially allocated bio, the caller will then try
>>>+		 * to allocate additional bios while submitting this partial bio
>>>+		 */
>>>+		if ((i - bio->bi_idx) == (MIN_BIO_PAGES - 1))
>>>+			gfp_mask = (gfp_mask | __GFP_NOWARN) & ~__GFP_WAIT;
>>
>>If the caller said they can wait, why not wait?
> 
> 
> How can the caller say this?

There is a gfp_mask there :)


>>>+		set_task_state(current, TASK_INTERRUPTIBLE);
>>>+		while (!(bio = kcryptd_get_bios())) {
>>>+			schedule();
>>>+			if (signal_pending(current))
>>>+				return 0;
>>>+		}
>>>+		set_task_state(current, TASK_RUNNING);
>>
>>You just keep calling schedule() rapid-fire until you get a bio?  That's 
>>a bit sub-optimal.
> 
> 
> That's wrong anyway. I was just making sure I was calling
> kcryptd_get_bios after schedule. schedule() will sleep and woken after
> someone added a bio to the list.
> 
> I've changed it to an if now and call kcryptd_get_bios after schedule.
> 
> I'm calling it twice because it is likely that someone started a new
> list while the old list is being processed and I don't want to sleep in
> this case, just fall through.
> 
> The kcryptd_get_bios needs to be after state = TASK_INTERRUPTIBLE to
> avoid a race. If someone wakes the process after kcryptd_get_bios but
> before schedule it resets the state to TASK_RUNNING so that the schedule
> won't sleep.

This sounds like a lot of work, just to reimplement what a semaphore 
does for you :)

When you down(), you sleep, waiting for new work.  Each time new work 
occurs, on any cpu, you call up().  This is perfect for a kernel thread, 
which can sleep, just like a semaphore needs.  If you want to be 
interruptible by signals (such as sysadmin killing your thread, for some 
reason), then use down_interruptible().

There is typically one special case -- killing your thread on shutdown. 
  The typical solution is to set a flag thread_shutdown, and then up().

	Jeff



