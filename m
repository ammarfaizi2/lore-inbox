Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031382AbWLEU74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031382AbWLEU74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031360AbWLEU74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:59:56 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:34662 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031384AbWLEU7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:59:55 -0500
In-Reply-To: <20061205123958.497a7bd6.akpm@osdl.org>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org> <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl> <20061205123958.497a7bd6.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Content-Transfer-Encoding: 7bit
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Date: Tue, 5 Dec 2006 14:59:31 -0600
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 5, 2006, at 14:39, Andrew Morton wrote:

> On Tue, 5 Dec 2006 17:48:05 +0000 (GMT)
> "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>
>>  Essentially there is a race when disconnecting from a PHY, because
>> interrupt delivery uses the event queue for processing.  The  
>> function to
>> handle interrupts that is called from the event queue is phy_change 
>> ().
>> It takes a pointer to a structure that is associated with the  
>> PHY.  At the
>> time phy_stop_interrupts() is called there may be one or more  
>> calls to
>> phy_change() still pending on the event queue.  They may not be  
>> able to be
>> processed until the structure passed to phy_change() have been  
>> freed, at
>> which point calling the function is wrong.
>>
>>  One way of avoiding it is calling flush_scheduled_work() from
>> phy_stop_interrupts().  This is fine as long as a caller of
>> phy_stop_interrupts() (not necessarily the immediate one calling into
>> libphy) does not hold the netlink lock.
>
> So let me try to rephrase...
>
> - phy_change() is the workqueue callback function.  It is executed by
>   keventd.
>
> - Something under phy_change() takes rtnl_lock() (but what??)


I don't think it's phy_change().  It's something else that may be  
scheduled.


>
> - phy_stop_interrupts() does flush_scheduled_work().  This has to
>   following logic:
>
>   - if I am kevetnd, run phy_change() directly.
>
>   - If I am not keventd, wait for keventd() to run phy_change()
>
> - So if the caller of phy_stop_interrupt() already holds rtnl_lock(),
>   and if that caller is keventd then it will recur onto rntl_lock()  
> and
>   will deadlock.
>
> Problem is, if the caller of phy_stop_interrupt() is *not* keventd,  
> that
> caller will still deadlock, because that caller is waiting for  
> keventd to
> run phy_change(), and keventd cannot do that, because the not-keventd
> process already holds rtnl_lock.
>
>
> Now, afaict, there are only two callers of phy_stop_interrupts(): the
> close() handlers of gianfar.c and fs_enet-main.c (confusingly held in
> netdevice.stop (confusingly called by dev_close())).  Via  
> phy_disconnect.
> Did I miss anything?


Right now, that's probably about right.


>
> And the dev_close() caller holds rtnl_lock.
>


Ok, I think this is the summary:

- phy_change() is the work queue callback function (scheduled when a  
PHY interrupt occurs)

- dev_close() invokes the controller's stop/close/whatever function,  
and it calls phy_disconnect()

- phy_disconnect() calls phy_stop_interrupts().  To prevent any  
pending phy_change() calls from getting confused, phy_stop_interrupts 
() needs to flush the queue.  Otherwise, subsequent memory freeings  
will leave phy_change() hanging.

- If phy_stop_interrupts() calls flush_scheduled_work(), keventd will  
execute its queues while rtnl_lock is held, providing opportunity for  
other callbacks to deadlock.

- innocent puppies are slaughtered, and the world mourns.


Maciej's solution is to schedule phy_disconnect() to be called from a  
work queue.  That solution should work, but it sounds like it doesn't  
require the check for if keventd is running.

Of course, my objection to it is that it now requires the ethernet  
controller to be excessively aware of the details of how the PHY Lib  
is handling the PHY interrupts (by scheduling them on a work queue).

Andy


