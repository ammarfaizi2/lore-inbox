Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751725AbWBMLZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbWBMLZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWBMLZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:25:46 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:17886 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751725AbWBMLZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:25:45 -0500
Date: Mon, 13 Feb 2006 12:25:42 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
In-Reply-To: <1139827927.4932.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0602131208050.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
 <1139827927.4932.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Thomas Gleixner wrote:

> This adds an artificial offset to the expiry time, for what reason? The
> expiry code makes sure that timers can not expire early. See:
> 
> 	timer = rb_entry(node, struct hrtimer, node);
> 	if (now.tv64 <= timer->expires.tv64)
> 		break;
> 
> in kernel/hrtimers.c:run_hrtimer_queue(), where now is already tick
> aligned.
> 
> Please provide a testcase (or detailed use-case) which proves that this
> is necessary.

Let's assume a get_time() which simply returns xtime and so has a 
resolution of around TICK_NSEC. This means the real time when one calls 
get_time() is somewhere between xtime and xtime+TICK_NSEC. Assuming the 
real time is xtime+TICK_NSEC-1, get_time() will return xtime and a 
relative timer with TICK_NSEC-1 will expire immediately.
The old code did this correctly. For most hardware this is not a real 
issue, as the delivery time is larger than the clock resolution, but 
unless you can guarantee it's not an issue on _any_ supported hardware, 
this fix is needed. As I already said this can be better fixed as soon as 
we have a better clock abstraction, until then this is only restores the 
old behaviour.

bye, Roman
