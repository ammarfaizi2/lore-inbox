Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVBWXSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVBWXSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVBWXPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:15:01 -0500
Received: from gw.goop.org ([64.81.55.164]:36802 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261680AbVBWXKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:10:07 -0500
Message-ID: <421D0D3F.40902@goop.org>
Date: Wed, 23 Feb 2005 15:09:51 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Roland McGrath <roland@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Always send siginfo for synchronous signals
References: <421C25BE.1090700@goop.org> <20050223201903.GF21662@shell0.pdx.osdl.net>
In-Reply-To: <20050223201903.GF21662@shell0.pdx.osdl.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>It's not quite inexplicable.  It means that task has hit its limit for
>pending signals ;-)  But I agree, this should be fixed.  I think I had
>tested this with broken test cases, thanks for catching.
>  
>
It's particularly confusing for users, because it's a per-user limit
rather than a per-process one, and its not at all apparent which program
is causing the problem (/proc/N/status will tell you that a process has
a signal pending, but it won't tell you how many are pending).

In fact, bugs with these symptoms have been reported against Valgrind
from time to time for years, and its only recently I worked out what's
going on (mostly because I introduced a bug which caused Valgrind to do
it to itself).

>>+static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags, int always)
>>    
>>
>maybe force_info instead of always?
>  
>
I suppose, but it doesn't "force" it really.  The allocation could still
fail (it is GFP_ATOMIC after all), and you'd still get no siginfo.  I
don't care much either way.

>> 	/*
>> 	 * fast-pathed signals for kernel-internal things like SIGSTOP
>>@@ -785,6 +793,13 @@ static int send_signal(int sig, struct s
>> 	if ((unsigned long)info == 2)
>> 		goto out_set;
>> 
>>+	/* Always attempt to send siginfo with an unblocked
>>+	   fault-generated signal. */
>>+	always = sig_kernel_sync(sig) &&
>>+		!sigismember(&t->blocked, sig) &&
>>    
>>
>Aren't these already unblocked?
>  
>
I can't think of a case where they wouldn't be, but I wanted to make
sure this couldn't be used to create a new DoS.

>>+		(unsigned long)info > 2 &&
>>+		info->si_code > SI_USER;
>>    
>>
>In what case is != SI_KERNEL OK?
>  
>
Fault signals rarely have an si_code of SI_KERNEL (0x80); they generally
have a small integer to describe what the fault was really about
(SEGV_MAPERR, etc).  All si_codes > SI_USER (0) are defined to have come
from the kernel.  Hm, I see there's a macro, SI_FROMKERNEL, for doing
this test.

Updated patch attached.

    J
