Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268169AbTBNDZw>; Thu, 13 Feb 2003 22:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268170AbTBNDZw>; Thu, 13 Feb 2003 22:25:52 -0500
Received: from web13803.mail.yahoo.com ([216.136.175.13]:61474 "HELO
	web13803.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268169AbTBNDZv>; Thu, 13 Feb 2003 22:25:51 -0500
Message-ID: <20030214033543.26042.qmail@web13803.mail.yahoo.com>
Date: Thu, 13 Feb 2003 19:35:43 -0800 (PST)
From: William Chow <lilbilchow@yahoo.com>
Subject: missing a wakeup from pending signal
To: linux-kernel@vger.kernel.org
Cc: lilbilchow@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am finding that my kernel thread will occasionally
fail to wake up eventhough it has a signal pending.
The thread is calling wait_event_interruptible and
waiting for SIGIO (from the sg driver). I only see it
fail to wake up when performing intensive sg activity.
>From kdb, the task shows the signal was delivered
(sigpending==1 and pending.signal.sig[0]==0x10000000).

So, I was just wondering if anyone was aware of a fix
(I'm using 2.4.18 on i386). A google search failed to
turn up anything obvious. My code is pretty basic
stuff but here the wait loop just in case:

for (;;) {
  gotsig = wait_event_interruptible();
  if (gotsig) {
    sigemptyset(&set);
    spin_lock_irq(&current->sigmask_lock);
    signum = dequeue_signal(&set, &info);
    spin_unlock_irq(&current->sigmask_lock);
    if (signum != SIGIO)
      break;
    process_io();
  }
}

Please CC me in the response. Thanks in advance.

__________________________________________________
Do you Yahoo!?
Yahoo! Shopping - Send Flowers for Valentine's Day
http://shopping.yahoo.com
