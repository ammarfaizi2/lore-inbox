Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUBOWO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUBOWOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:14:55 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32933 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265210AbUBOWOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:14:50 -0500
Message-ID: <402FEF1F.2030308@us.ibm.com>
Date: Sun, 15 Feb 2004 14:13:51 -0800
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kthread vs. dm-daemon
References: <402A4B52.1080800@centrum.cz>	 <1076866470.20140.13.camel@leto.cs.pocnet.net>	 <20040215180226.A8426@infradead.org>	 <1076870572.20140.16.camel@leto.cs.pocnet.net>	 <20040215185331.A8719@infradead.org>	 <1076873760.21477.8.camel@leto.cs.pocnet.net>	 <20040215194633.A8948@infradead.org> <1076876668.21968.22.camel@leto.cs.pocnet.net>
In-Reply-To: <1076876668.21968.22.camel@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> Am So, den 15.02.2004 schrieb Christoph Hellwig um 20:46:
> 
> 
>>>The only reason, I guess, is that it depends on this very small
>>>dm-daemon thing:
>>>http://people.sistina.com/~thornber/dm/patches/2.6-unstable/2.6.2/2.6.2-udm1/00016.patch
>>
>>Well, actually the above code should not enter the kernel tree at all.
>>Care to rewrite dm-crypt to use Rusty's kthread code in -mm instead and
>>submit a patch to Andrew?  Whenever he merges the kthread stuff to mainline
>>he could just include dm-crypt then.
> 
> 
> Sure I could.
> 
> But kthread is currently not a full replacement for dm-daemon. kthread
> provides thread creation and destruction functions. But dm-daemon
> additionaly does mainloop handling.
> 
> Usually, the dm-daemon client adds some work to a list under a spinlock
> and calls dm_daemon_wake. The next time the thread runs it calls the
> client work function which usually just grabs the whole list and
> processes it.
> The client work function can also indicate it wants periodic wakeup
> using a return value which is currently used in the multipath target but
> it's not sure whether this will be moved to a userspace daemon.
>
> There seems to beg a small race conditition that can appear when using
> only wake_up for notifies so dm-daemon uses an additional atomic_t
> variable to make sure nothing gets missed. Just see the function
> ``daemon'' in dm-daemon.c.
> 
> Making dm-daemon use the kthread primitives would make dm-daemon a very
> small and stupid wrapper. Changing all dm targets to handle worker
> thread notification themselves would result in unnecessary code
> duplication.
> 

When dm-multipath is more stable it could be using a work queue (my 
patch was prematurely sent). Imagine a large number of dm-mp devices 
multipathing across two fabrics and one switch failing. Every dm-mp 
device could be resubmitting io at the same time. That leaves dm-raid1, 
dm-snap and your target. The raid1 code looks like it could also benefit 
from swithing. If every write for every dm-raid1 device is going through 
a single dm-daemon, it could become a bottleneck. This is all assuming 
the number of processors and DM devices on your machine makes sense.

I guess you could also just do a thread per target instance, but maybe 
this was ruled as excessive for thousands of DM devices?

Mike Christie
mikenc@us.ibm.com
