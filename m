Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132088AbQLQDV2>; Sat, 16 Dec 2000 22:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132163AbQLQDVT>; Sat, 16 Dec 2000 22:21:19 -0500
Received: from p050.as-l001.contactel.cz ([212.65.194.50]:2564 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S132088AbQLQDVP>;
	Sat, 16 Dec 2000 22:21:15 -0500
Date: Sun, 17 Dec 2000 03:49:28 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
Message-ID: <20001217034928.A410@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  my 2.4.0-test13-pre1 just stopped answering to my keystrokes.
I've found that it is looping in tqueue_bh and flush_to_ldisc
still again and again.

  To my surprise I found that flush_to_ldisc() does

if (test_bit(TTY_DONT_FLIP, &tty_flags)) {
   queue_task(&tty->filp.tqueue, &tq_timer);
   return;
}

Looks ok. But only until you'll look at run_task_queue().
It now contains

  while (!list_empty(list)) {
      ...
  }

So postponing event to next timer tick does not work anymore.
It will stop cycling in run_task_queue and machine is dead
(unless you have some spare CPU).

Is current run_task_queue() behavior intentional, or is it
only bug introduced by changing task queue to list based
implementation?
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

P.S.: Yes, I know that I should bought faster computer so that
ldisc buffer does not overflow, but...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
