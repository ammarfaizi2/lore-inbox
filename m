Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbUCMLoY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 06:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbUCMLoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 06:44:24 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:61613 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S263080AbUCMLoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 06:44:23 -0500
From: Stefan Rompf <srompf@isg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: calling flush_scheduled_work()
Date: Sat, 13 Mar 2004 12:45:51 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403131245.53119.srompf@isg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>> In short we have a case where mntput() is called from the kevetd
>> workqueue.
>> When that mntput() hit an NFS mount, we got a deadlock.  It turns out
>> that
>> deep in the RPC code, someone calls flush_scheduled_work().  Deadlock.
> 
> Seems simple enough to fix the workqueue code to handle this situation.

Code fixing one corner case won't help. Some time ago, there has been a 
deadlock between a network driver that called flush_scheduled_work() while 
the kernel held the rtnl semaphore and work scheduled by the linkwatch code 
that needs rtnl.

I had posted a patch that changed linkwatch not to block waiting for rtnl, 
however it was dropped in favor of fixing the driver (I don't own that card, 
so I can't tell you if it works by now)

However, this is another example for the problem: Any code can 
schedule_work(), any other code can wait in any place for this work to 
complete. As long as we don't have some known consent on what functions that 
runs inside the keventd workqueue may (not) do, and when it is ok to call 
flush_scheduled_work(), we are always at risk that the workqueue mechanism 
creates a deadlock by accident.

Stefan
