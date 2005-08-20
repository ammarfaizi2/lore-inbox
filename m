Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVHTNXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVHTNXp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 09:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVHTNXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 09:23:45 -0400
Received: from [80.71.243.242] ([80.71.243.242]:51592 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S1750714AbVHTNXo (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 20 Aug 2005 09:23:44 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17159.11995.869374.370114@gargle.gargle.HOWL>
Date: Sat, 20 Aug 2005 17:23:39 +0400
To: Howard Chu <hyc@symas.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: sched_yield() makes OpenLDAP slow
In-Reply-To: <430666DB.70802@symas.com>
References: <43057641.70700@symas.com>
	<17157.45712.877795.437505@gargle.gargle.HOWL>
	<430666DB.70802@symas.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu writes:
 > Nikita Danilov wrote:

[...]

 > 
 > >  What prevents transaction monitor from using, say, condition
 > >  variables to "yield cpu"? That would have an additional advantage of
 > >  blocking thread precisely until specific event occurs, instead of
 > >  blocking for some vague indeterminate load and platform dependent
 > >  amount of time.
 > 
 > Condition variables offer no control over which thread is waken up. 

When only one thread waits on a condition variable, which is exactly a
scenario involved, --sorry if I weren't clear enough-- condition signal
provides precise control over which thread is woken up.

 > We're wandering into the design of the SleepyCat BerkeleyDB library 
 > here, and we don't exert any control over that either. BerkeleyDB 
 > doesn't appear to use pthread condition variables; it seems to construct 
 > its own synchronization mechanisms on top of mutexes (and yield calls). 

That returns us to the core of the problem: sched_yield() is used to
implement a synchronization primitive and non-portable assumptions are
made about its behavior: SUS defines that after sched_yield() thread
ceases to run on the CPU "until it again becomes the head of its thread
list", and "thread list" discipline is only defined for real-time
scheduling policies. E.g., 

int sched_yield(void)
{
       return 0;
}

and

int sched_yield(void)
{
       sleep(100);
       return 0;
}

are both valid sched_yield() implementation for non-rt (SCHED_OTHER)
threads.

Nikita.
