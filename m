Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273751AbRI0SCF>; Thu, 27 Sep 2001 14:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273754AbRI0SBz>; Thu, 27 Sep 2001 14:01:55 -0400
Received: from c2.e0bed1.client.atlantech.net ([209.190.224.194]:26374 "EHLO
	crb.crb-web.com") by vger.kernel.org with ESMTP id <S273751AbRI0SBw>;
	Thu, 27 Sep 2001 14:01:52 -0400
Date: Thu, 27 Sep 2001 14:12:38 -0500
From: Wayne Cuddy <wcuddy@crb-web.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Synchronization Techniques in 2.2 Kernel
Message-ID: <20010927141238.E5125@crb-web.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a custom driver for a project at work.  We are working with
Debian 2.2, the code is compiled as a module.  At this time I am not able to
switch our project to the 2.4.x kernels so I require a solution using 2.2.x.

The driver has the capability to control many cards at once.  It is written
such that when the read system call is invoked data available on any card is
returned, so we don't use a separate file descriptor for each card.

I believe I have a "race condition" in the drivers read method when blocking
I/O is used and there is no data in the DMA buffers.  Here is some very basic
pseudo code for the driver's read method:

driver_read()
{
	start_card = x;
	
	while(1)
	{
		if(card_has_data(x))
			return data;

		x = next_card(x);
		
		if(start_card == x)
		{
			/* none of the cards has any data, sleep
			 * on a wait queue */
			interruptible_sleep_on.....
		}
	}
}

After the device performs the DMA it will wake the driver via the interrupt
handler.  The problem is how to handle the situation where the driver checks a
card for data, no data is available and it moves on to the next card.  While
checking the rest of the cards data may arrive on the 1st card, the interrupt
handler will fire and complete before the driver goes to sleep on the wait
queue.

If I understand wait_queues correctly the process has to be sleeping before a
wake_up call will have any effect (I.E. they are not queued).  Can this be
worked around with semaphores or some other method?  I am open to ideas here.

Any and all help is appreciated.

Wayne


