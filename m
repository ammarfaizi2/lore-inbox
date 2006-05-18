Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWERAgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWERAgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 20:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWERAgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 20:36:00 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:57249 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751069AbWERAf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 20:35:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Thu, 18 May 2006 10:35:14 +1000
User-Agent: KMail/1.9.1
Cc: tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       "Andrew Morton" <akpm@osdl.org>, "Mike Galbraith" <efault@gmx.de>
References: <4t16i2$13uiu1@orsmga001.jf.intel.com>
In-Reply-To: <4t16i2$13uiu1@orsmga001.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181035.15142.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 05:33, Chen, Kenneth W wrote:
> The assignment of p->sleep_avg = ceiling doesn't make much logical sense.
> Because INTERACTIVE_SLEEP is scaled proportionally with nice value, e.g.
> the lower the nice value, the lower the interactive_sleep.  However,
> priority calculation is inverse of p->sleep_avg, e.g. the smaller the
> sleep_avg, the smaller the bonus, thus the higher dynamic priority.
>
> Take one concrete example: for a prolonged sleep, say 1 second, nice(-10)
> will have a priority boost of 4 while nice(0) will have a priority boost of
> 9. The ceiling algorithm looks like is reversed. I would think kernel
> should at least enforce same ceiling value independent of nice value.

I see why you don't like it. However I still don't think you understand why 
the ceiling of that magnitude is there. Tasks behave very differently 
depending on whether their priority is low enough that they expire at the end 
of every timeslice and get put on the expired array, or their priority is 
high enough that they get reinserted into the active array. It's an intrinsic 
quirk in the "interactive" design of the scheduler that basically means we 
have two classes of task - interactive enough to be reinserted into the 
active array or not. As the comment already says the ceiling is there to 
prevent one sleep from getting them to best priority. I don't want them to 
get high priority with one large enough sleep, but I do want them to get into 
the reinsertion class which behaves entirely differently. What is missing 
from the comment is to say that it is also designed to stop them at the 
lowest possible priority that still keeps them in the interactive reinsertion 
class. Using a constant ceiling value irrespective of nice will not guarantee 
that tasks fall into the active reinsertion class dependant on their nice 
value.

-- 
-ck
