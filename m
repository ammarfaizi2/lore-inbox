Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271162AbUJVA4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271162AbUJVA4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271146AbUJVAuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:50:18 -0400
Received: from mail.timesys.com ([65.117.135.102]:35255 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S271052AbUJVAsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:48:02 -0400
Message-ID: <41785879.1040805@timesys.com>
Date: Thu, 21 Oct 2004 20:46:49 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Scott Wood <scott@timesys.com>, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Jens Axboe <axboe@suse.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <Pine.OSF.4.05.10410212232050.26965-100000@da410.ifa.au.dk>
In-Reply-To: <Pine.OSF.4.05.10410212232050.26965-100000@da410.ifa.au.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2004 00:42:57.0968 (UTC) FILETIME=[1364F300:01C4B7D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:

>Anyway, I am not sure recursive acquisition is such a good idea: It will
>make the mutex more expensive to use and promote sloppy coding where you
>don't really know what mutexes are held right now.
>
In my experience I haven't quite found this to be the case.
Rather allowing a lock/mutex/etc.. to be recursively acquired
within a given path can greatly simplify APIs. Such as
cases where a primitive acquires a lock internally which is
also know by and suited to protect data in the caller's context.
This avoids the "who has the lock?" information which must
otherwise get stuffed into the API. Nested function calls
simply observe correct lock usage at their respective levels
and all unwinds correctly.

The one notable place where this doesn't work is where
locks must be conditionally acquired in an out-of-order sequence.
However often these cases can be pushed out of the externally
visible API. Another operational consideration is maintaining
debug information in the lock. Keeping track of where each
lock acquisition was made is at odds with a fixed sized lock
data footprint. Still recursive acquisitions scale only
with available stack space so a fair upper limit approximation
is possible when running on fixed size stacks. Note I'm
refering to single-owner spinlocks/mutexes here rather than
reader/write locks.

>I think it is better that the sloppy coder discoveres that he
>deadlocks on himself before getting other sub-systems involved :-)
>
I agree. But I don't think the above precludes doing so.
Detecting violations of unbalanced lock/unlock calls isn't
really different than for non-recursive primitives.

-john

-- 
john.cooper@timesys.com

