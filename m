Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbTIJAX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 20:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTIJAX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 20:23:57 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:6665
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S265059AbTIJAXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 20:23:53 -0400
Message-ID: <3F5E6F15.6040507@cyberone.com.au>
Date: Wed, 10 Sep 2003 10:23:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Yau <jyau_kernel_dev@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Priority Inversion in Scheduling
References: <LAW10-OE63Zc1WPsAVe0000ab93@hotmail.com>
In-Reply-To: <LAW10-OE63Zc1WPsAVe0000ab93@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Yau wrote:

>Hi folks,
>
>I've noticed some very interesting priority inversion scenarios in the test4
>scheduling.
>
>For example let's say you have task dumps-a-lot, which is a CPU hog and
>dumps a lot of data to stdout and task interactive/real-time (e.g. xmms,
>Emacs, Mozilla).  When stdout of dumps-a-lot is directed to a terminal under
>X, X's priority is demoted to 25, because X spends a lot of time rendering
>data from dumps-a-lot.  In the mean while, because dumps-a-lot is not
>actually doing much because it's sleeping quite a lot, it's priority is at
>15-17 or so and continues to flood X whenever it gets a chance to.  This
>leaves the interactive/real-time, who's priorities are at 15-17 as well have
>an effective priority of 25 because they have to wait for X to service them,
>thus making them feel not so interactive anymore to the user.  When the
>stdout of dumps-a-lot is pointed to /dev/null, interactive/real-time
>responds just fine.
>
>To get around scenarios such as this and priority inversions in general, I
>propose to have some sort of priority inheritance mechanism in futex and the
>scheduler.  If a task is blocked by something of lower priority, the higher
>priority task "donates" its time to the lower priority task in hopes of
>resolving the block.  The time is charged to the higher priority task in
>this situation so that it cannot do this forever without being penalized.
>This way in the above scenario dumps-a-lot gets penalized for being a CPU
>hog and interactive/real-time stays interactive though they get penalized
>too.
>
>I'd like some feedback on the above proposal, especially from folks working
>heavily on the scheduler.  If the consensus is that it'd be worthwhile to
>have such a mechanism, I'll go ahead and code a patch.  I haven't had a
>chance to look at code outside of Linus' branch in detail, so Nick, Con,
>Ingo, or Andrew have already dealt with this, let me know and point me to
>the code.
>

Hi John,
Your mechanism is basically "backboost". Its how you get X to keep a
high piroirity, but quite unpredictable. Giving a boost to a process
holding a semaphore is an interesting idea, but it doesn't address the
X problem.

The scheduler in Linus' tree is basically obsolete now, so there isn't
any point testing it really. Test Con's or my patches, and let us know
if you're still having problems with sir dumps-a-lot.


