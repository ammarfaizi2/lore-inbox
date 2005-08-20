Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVHTWIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVHTWIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 18:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVHTWIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 18:08:16 -0400
Received: from [80.71.243.242] ([80.71.243.242]:57755 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S1750707AbVHTWIQ (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 20 Aug 2005 18:08:16 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17159.43478.693740.446153@gargle.gargle.HOWL>
Date: Sun, 21 Aug 2005 02:08:22 +0400
To: Howard Chu <hyc@symas.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: sched_yield() makes OpenLDAP slow
In-Reply-To: <43078954.2030905@symas.com>
References: <43057641.70700@symas.com>
	<17157.45712.877795.437505@gargle.gargle.HOWL>
	<430666DB.70802@symas.com>
	<17159.11995.869374.370114@gargle.gargle.HOWL>
	<43078954.2030905@symas.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu writes:
 > Nikita Danilov wrote:
 > > That returns us to the core of the problem: sched_yield() is used to
 > > implement a synchronization primitive and non-portable assumptions are
 > > made about its behavior: SUS defines that after sched_yield() thread
 > > ceases to run on the CPU "until it again becomes the head of its thread
 > > list", and "thread list" discipline is only defined for real-time
 > > scheduling policies. E.g., 
 > >
 > > int sched_yield(void)
 > > {
 > >        return 0;
 > > }
 > >
 > > and
 > >
 > > int sched_yield(void)
 > > {
 > >        sleep(100);
 > >        return 0;
 > > }
 > >
 > > are both valid sched_yield() implementation for non-rt (SCHED_OTHER)
 > > threads.
 > I think you're mistaken:
 > http://groups.google.com/group/comp.programming.threads/browse_frm/thread/0d4eaf3703131e86/da051ebe58976b00#da051ebe58976b00
 > 
 > sched_yield() is required to be supported even if priority scheduling is 
 > not supported, and it is required to cause the calling thread (not 
 > process) to yield the processor.

Of course sched_yield() is required to be supported, the question is for
how long CPU is yielded. Here is the quote from the SUS (actually the
complete definition of sched_yield()):

    The sched_yield() function shall force the running thread to
    relinquish the processor until it again becomes the head of its
    thread list.

As far as I can see, SUS doesn't specify how "thread list" is maintained
for non-RT scheduling policy, and implementation that immediately places
SCHED_OTHER thread that called sched_yield() back at the head of its
thread list is perfectly valid. Also valid is an implementation that
waits for 100 seconds and then places sched_yield() caller to the head
of the list, etc. Basically, while semantics of sched_yield() are well
defined for RT scheduling policy, for SCHED_OTHER policy standard leaves
it implementation defined.

 > 
 > -- 
 >   -- Howard Chu

Nikita.
