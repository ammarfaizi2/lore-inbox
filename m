Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSFZKcn>; Wed, 26 Jun 2002 06:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSFZKcm>; Wed, 26 Jun 2002 06:32:42 -0400
Received: from abricot.axialys.net ([217.146.226.10]:51707 "EHLO kiwi")
	by vger.kernel.org with ESMTP id <S316491AbSFZKcl>;
	Wed, 26 Jun 2002 06:32:41 -0400
Date: Wed, 26 Jun 2002 12:32:43 +0200
From: Nicolas Bougues <nbougues-listes@axialys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Problems with wait queues
Message-ID: <20020626103243.GA4797@kiwi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Axialys Interactive http://www.axialys.net
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I'm writing a device driver for a PCI board that sends/receives one
frame (80 bytes) of data every 100th/sec. The kernel is 2.4.18 non SMP.

I use the timer task, and every 100th/sec, I transmit any pending
buffer and store the received one, so that it can be handled by the
user mode app.

The driver is accessible using a standard device node.

I implemented a wait queue mechanism in order to deal with blocking
read/writes from user mode. When the dev_write sees the TX queue is
full, it wait_event_interruptible(txq, condition). Idem for RX.

And every 100th/sec, when it gets more data for RX or more room for
TX, it wake_up_interruptible(txq|rxq).

My problem is that I wrote a test app that loops around read() or
write() on my device in user mode, and when running this app, my
loadavg increases, up to 1.00, which is surprising.

But, in the meantime :
- vmstat shows no user mode nor system activity. 
- time of the user mode test app shows 0.00 for both user and
system time.
- a busy task (such as dd if=/dev/zero of=/dev/null bs=1024k
  count=300000) takes the same amount of time to run when the test app
  is running, as it took when the system was idle.

If I insert an usleep(1000*100), which will wait about 1/100th sec,
in the loop around read()/write(), the wait queues aren't used anymore
in the driver (since there is always room for TX or data for RX), and
the loadavg stays at 0.00, which is what is expected.

Does anybody have any idea on what I may have done wrong, and why
would loadavg increase when vmstat show no activity ?

Thanks.
--
Nicolas Bougues

