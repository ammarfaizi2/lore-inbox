Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUGQTCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUGQTCI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 15:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUGQTCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 15:02:07 -0400
Received: from c-67-171-146-69.client.comcast.net ([67.171.146.69]:30606 "EHLO
	kryten.internal.splhi.com") by vger.kernel.org with ESMTP
	id S265249AbUGQTBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 15:01:51 -0400
Subject: Re: [PATCH] was: [RFC] removal of sync in panic
From: Tim Wright <timw@splhi.com>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, lmb@suse.de
In-Reply-To: <200407150658.54925.linux-kernel@borntraeger.net>
References: <200407141745.47107.linux-kernel@borntraeger.net>
	 <200407141939.52316.linux-kernel@borntraeger.net>
	 <20040714143112.1d8d1892.akpm@osdl.org>
	 <200407150658.54925.linux-kernel@borntraeger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Splhi
Message-Id: <1090090902.14032.15.camel@kryten.internal.splhi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 17 Jul 2004 12:01:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I've seen this multiple times.
I also agree that it seems a sensible patch. I have one dumb question.
Given that we're panicing and we know things are "bad", is there any
reason not to call smp_send_stop() as early as possible, rather than as
the last thing which we currently do? As you say, the other cpus are
happily continuing, potentially destroying data, and it seems that
stopping this as quickly as possible would be desirable.

Tim

On Wed, 2004-07-14 at 21:58, Christian Borntraeger wrote:
> Andrew Morton wrote:
> > I agree with the patch in principle, but I'd be interested in what
> > observed problem motivated it?
> 
> see the first posting.
> 
> -----------snip--------------
> I have seen panic failing two times lately on an SMP system. The box 
> panic'ed but was running happily on the other cpus. The culprit of this 
> failure is the fact, that these panics have been caused by a block device 
> or a filesystem (e.g. using errors=panic). In these cases the  likelihood 
> of a failure/hang of  sys_sync() is high. This is exactly what happened in 
> both cases I have seen. Meanwhile the other cpus are happily continuing  
> destroying data as the kernel has a severe problem but its not aware of 
> that as smp_send_stop happens after sys_sync.
> 
> I can imagine several changes but I am not sure if this is a problem which 
> must be fixed and which fix is the best.
> Here are my alternatives:
> 
> 1. remove sys_sync completely: syslogd and klogd use fsync. No need to help 
> them. Furthermore we have a severe problem which is worth a panic, so we 
> better dont do any I/O.
> 2. move smp_send_stop before sys_sync. This at least prevents other cpus of 
> doing harm if sys_sync hangs. Here I am not sure if this is really working.
> 3. Add an 
>         if (doing_io())
>                 printk(KERN_EMERG "In I/O routine - not syncing\n");
> check like in_interrupt check. Unfortunately I have no clue how this can be 
> achieved and it looks quite ugly.
> ---------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Tim Wright <timw@splhi.com>
Splhi
