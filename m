Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVHAMg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVHAMg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 08:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVHAMg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 08:36:57 -0400
Received: from fmr19.intel.com ([134.134.136.18]:5340 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261813AbVHAMg4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 08:36:56 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] S3 and sigwait (was Re: 2.6.13-rc3: swsusp works (TP 600X))
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Mon, 1 Aug 2005 20:36:36 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F11308AD@pdsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] S3 and sigwait (was Re: 2.6.13-rc3: swsusp works (TP 600X))
Thread-Index: AcWWaAODSxvKKurrT42sg10lu83A5wALPAZg
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 01 Aug 2005 12:36:37.0827 (UTC) FILETIME=[A8EC2930:01C59695]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>> > If you think it is a linux bug, can you produce small test case
doing
>> > just the sigwait, and post it on l-k with big title "sigwait()
breaks
>> > when straced, and on suspend"?
>> >
>> > That way it is going to get some attetion, and you'll get either
>> > documentation or kernel fixed.
>> Looks like a linux bug to me. The refrigerator fake signal waked the
>> task up and without restart for the sigwait case. How about below
>> patch:
>
>Is there chance to fix strace case, too? sigwait() is broken in more
>than one way it seems...
Not sure about it. strace shows sigwait using sigtimedwait, which
doesn't say it can't return error.

>>  linux-2.6.13-rc4-root/kernel/signal.c |   11 ++++++++++-
>>  1 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff -puN kernel/signal.c~sigwait-suspend-resume kernel/signal.c
>> --- linux-2.6.13-rc4/kernel/signal.c~sigwait-suspend-resume	2005-08-
>01 14:00:39.089460688 +0800
>> +++ linux-2.6.13-rc4-root/kernel/signal.c	2005-08-01
>14:30:13.821660384 +0800
>> @@ -2188,6 +2188,7 @@ sys_rt_sigtimedwait(const sigset_t __use
>>  	struct timespec ts;
>>  	siginfo_t info;
>>  	long timeout = 0;
>> +	int recover = 0;
>>
>>  	/* XXX: Don't preclude handling different sized sigset_t's.  */
>>  	if (sigsetsize != sizeof(sigset_t))
>> @@ -2225,15 +2226,23 @@ sys_rt_sigtimedwait(const sigset_t __use
>>  			 * be awakened when they arrive.  */
>>  			current->real_blocked = current->blocked;
>>  			sigandsets(&current->blocked, &current->blocked,
&these);
>> +do_recover:
>>  			recalc_sigpending();
>>  			spin_unlock_irq(&current->sighand->siglock);
>>
>>  			current->state = TASK_INTERRUPTIBLE;
>>  			timeout = schedule_timeout(timeout);
>>
>> -			try_to_freeze();
>> +			if (try_to_freeze())
>> +				recover = 1;
>
>Can't you just goto do_recover here?
Not sure again.

Thanks,
Shaohua
