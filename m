Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269099AbUI2Wcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269099AbUI2Wcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269093AbUI2Wa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:30:29 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:27020 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S269099AbUI2WIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:08:49 -0400
Date: Wed, 29 Sep 2004 15:01:13 -0700
From: Hui Huang <Hui.Huang@Sun.COM>
Subject: Re: heap-stack-gap for 2.6
In-reply-to: <20040929142325.GK4084@dualathlon.random>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Message-id: <415B30A9.5030103@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
References: <20040925162252.GN3309@dualathlon.random>
 <415903E4.1030808@sun.com> <20040928141914.GE2412@dualathlon.random>
 <415A7564.2090909@sun.com> <20040929142325.GK4084@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
>>Now another wish - instead of a system-wide property, a per-process
>>mechanism to change heap-stack-gap. Applications that need the gap
>>can set up the appropriate size, while others like Java that manage
>>heap and stack can simply disable the gap. Is it possible?
> 
> 
> This is a very reasonable request, and yes, this is definitely possible,
> I feel this is a much better feature than the mprotect trapping, which
> is possible too, but it sounds not worth it.
> 
> As for the api, should that be a prctl, /proc/<pid>/heap-stack-gap, or a
> brand new syscall? I personally enjoy the /proc/<pid>/heap-stack-gap
> approach, but that's just me, the prctl and syscall would be more
> efficient at runtime (but the point is that this doesn't need to be more
> efficient and echo xx > /proc/<pid>/heap-stack-gap is so much easier to
> play with for experiments)

Hi Andrea,

 From our perspective prctl is the most attractive approach. Performance
is not an issue, as it's only used once during startup. The problem
with /proc is that we are not always able to access /proc (e.g.
java code is run with chroot). Stack overflow in chroot'ed program
probably is a corner case, but I'm afraid we'll have to deal with it
if the heap-stack-gap becomes more widespread. System call is better
but we need to remember different syscall numbers on different
platforms.

> 
> If we can choose the API together I'll take care of implementing the
> rest. I'd like to still leave a global sysctl for global system safety
> (since most apps needs it and they won't all be required to tune it by
> hand), so that the final number will be choose with:
> 
> 	if (likely(per_process_setting < 0))
> 		return global_sysctl;
> 	else
> 		return per_process_setting;


Sounds good.

thanks,
-hui
