Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUKOA4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUKOA4w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 19:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUKOA4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 19:56:52 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38275 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261389AbUKOA4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 19:56:49 -0500
Date: Mon, 15 Nov 2004 09:58:42 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: Futex queue_me/get_user ordering
In-reply-to: <20041114092308.GA4389@mail.shareable.org>
To: Jamie Lokier <jamie@shareable.org>, mingo@elte.hu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl
Message-id: <4197FF42.9070706@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja, en-us, en
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
References: <20041113164048.2f31a8dd.akpm@osdl.org>
 <20041114090023.GA478@mail.shareable.org>
 <20041114010943.3d56985a.akpm@osdl.org>
 <20041114092308.GA4389@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Andrew Morton wrote:
> 
>>The patch wasn't supposed to optimise anything.  It fixed a bug which was
>>causing hangs.  See
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/futex_wait-fix.patch
>>
>>Or are you saying that userspace is buggy??
> 
> 
> I haven't looked at the NPTL code, but that URL's pseudo-code is buggy.
> The call to FUTEX_WAKE should be doing wake++ conditionally on the
> return value, not unconditionally.
(snip)
> 
> So I don't know if NPTL is buggy, but the pseudo-code given in the bug
> report is (because of unconditional wake++), and so is the failure
> example (because it doesn't use a mutex).
> 
> -- Jamie

from glibc-2.3.3(RHEL4b2):

   31 int
   32 __pthread_cond_signal (cond)
   33      pthread_cond_t *cond;
   34 {
   35   /* Make sure we are alone.  */
   36   lll_mutex_lock (cond->__data.__lock);
   37
   38   /* Are there any waiters to be woken?  */
   39   if (cond->__data.__total_seq > cond->__data.__wakeup_seq)
   40     {
   41       /* Yes.  Mark one of them as woken.  */
   42       ++cond->__data.__wakeup_seq;
   43       ++cond->__data.__futex;
   44
   45       /* Wake one.  */
   46       lll_futex_wake (&cond->__data.__futex, 1);
   47     }
   48
   49   /* We are done.  */
   50   lll_mutex_unlock (cond->__data.__lock);
   51
   52   return 0;
   53 }

Ingo, is this buggy?

We should start again with a question:
   Is this a kernel's bug or NPTL's bug?


Thanks,
H.Seto

