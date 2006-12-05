Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031330AbWLEUkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031330AbWLEUkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968690AbWLEUkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:40:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55726 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968688AbWLEUkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:40:18 -0500
Date: Tue, 5 Dec 2006 12:39:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061205123958.497a7bd6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 17:48:05 +0000 (GMT)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  Essentially there is a race when disconnecting from a PHY, because 
> interrupt delivery uses the event queue for processing.  The function to 
> handle interrupts that is called from the event queue is phy_change().  
> It takes a pointer to a structure that is associated with the PHY.  At the 
> time phy_stop_interrupts() is called there may be one or more calls to 
> phy_change() still pending on the event queue.  They may not be able to be 
> processed until the structure passed to phy_change() have been freed, at 
> which point calling the function is wrong.
> 
>  One way of avoiding it is calling flush_scheduled_work() from 
> phy_stop_interrupts().  This is fine as long as a caller of 
> phy_stop_interrupts() (not necessarily the immediate one calling into 
> libphy) does not hold the netlink lock.

So let me try to rephrase...

- phy_change() is the workqueue callback function.  It is executed by
  keventd.

- Something under phy_change() takes rtnl_lock() (but what??)

- phy_stop_interrupts() does flush_scheduled_work().  This has to
  following logic:

  - if I am kevetnd, run phy_change() directly.

  - If I am not keventd, wait for keventd() to run phy_change()

- So if the caller of phy_stop_interrupt() already holds rtnl_lock(),
  and if that caller is keventd then it will recur onto rntl_lock() and
  will deadlock.

Problem is, if the caller of phy_stop_interrupt() is *not* keventd, that
caller will still deadlock, because that caller is waiting for keventd to
run phy_change(), and keventd cannot do that, because the not-keventd
process already holds rtnl_lock.


Now, afaict, there are only two callers of phy_stop_interrupts(): the
close() handlers of gianfar.c and fs_enet-main.c (confusingly held in
netdevice.stop (confusingly called by dev_close())).  Via phy_disconnect. 
Did I miss anything?

And the dev_close() caller holds rtnl_lock.


Summary:

a) Please tell us what code under phy_change() wants to take rtnl_lock

b) I think it should deadlock whether or not the caller of
   phy_stop_interrupt() is keventd.  What am I missing?
