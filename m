Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUCCAHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbUCCAHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:07:44 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:64913 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261798AbUCCAHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:07:40 -0500
Message-ID: <404521B2.2030504@americasm01.nt.com>
Date: Tue, 02 Mar 2004 19:07:14 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "John Muir" <muirj@nortelnetworks.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: poll() in 2.6 and beyond
References: <Pine.LNX.4.53.0403021817050.9351@chaos>
In-Reply-To: <Pine.LNX.4.53.0403021817050.9351@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> > Could you maybe go back to the initial report, which is that after
> > poll() gets wrong status? It's nice to argue about where the process
> > waits, but the issue is if it gets the same status with 2.4 and 2.6, 
> and
> > if not which one should be fixed.
> >
> > Richard: can you show this with a small demo program? I assume you
> > didn't find this just by reading code ;-)
>
> Yes. The code I attached earlier shows that the poll() in a driver
> gets called (correctly), then it calls poll_wait(). Unfortunately
> the call to poll_wait() returns immediately so that the return
> value from the driver's poll() is whatever it was before some
> event occurred that the driver was going to signal with
> wake_up_interruptible().
>
The documentation referred to earlier 
(http://www.xml.com/ldd/chapter/book/ch05.html#t3) clearly states that 
the poll function implementation for a device should:
"1. Call /poll_wait/ on one or more wait queues that could indicate a 
change in the poll status.
2. Return a bit mask describing operations that could be immediately 
performed without blocking."
What happens is if your device has data ready RIGHT NOW (without any 
waiting), the information regarding that is returned.

Now, if you look closely at the implementation of do_poll(), it will 
loop forever until any device returns that data is available (or the 
timeout occurs). After data is available, do_pollfd() function no longer 
adds the devices to the wait queue.

What this means is that the first time through each device is added to 
the wait queue. After the process is woken up from schedule_timeout (or 
the timeout occurs), then it will loop through each device again to 
either add that device to the wait queue again, or determine that there 
is data ready to be read/written, or an error or whatever. do_pollfd() 
then increases count, and do_poll() exits from it's loop (and wait 
queues are cleaned-up in sys_poll()).

So, yes, the poll_wait() returns immediately, it should not wait, and 
your poll method should return the device's CURRENT status in the poll 
mask. Don't worry, because when your device wakes the waiting process 
when data is ready, the device's poll function is called again and you 
again can return the CURRENT status.

Please let me know if I'm misunderstanding this, but quite frankly, 
poll_wait CANNOT wait, for the very reasons described in previous posts: 
when multiple devices are polled, then poll_wait is called FOR EACH DEVICE.

Cheers,

..John


