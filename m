Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbSLNUKR>; Sat, 14 Dec 2002 15:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbSLNUKR>; Sat, 14 Dec 2002 15:10:17 -0500
Received: from pD9540C18.dip.t-dialin.net ([217.84.12.24]:60040 "EHLO felicia")
	by vger.kernel.org with ESMTP id <S265854AbSLNUKQ>;
	Sat, 14 Dec 2002 15:10:16 -0500
Date: Sat, 14 Dec 2002 21:16:37 +0100
From: Juergen Quade <quade@hsnr.de>
To: linux-kernel@vger.kernel.org
Cc: quade@hs-niederrhein.de
Subject: tasklet_kill: bug or feature?
Message-ID: <20021214201637.GA3073@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had a closer look to the tasklet implementation, especially
to tasklet_kill. I do not understand, why at the end of
the function the TASKLET_STATE_SCHED bit is cleared. Is it
a bug or a feature? Maybe someone can help me.

	The function tasklet_schedule does two things:
	1. it sets the schedule_bit (TASKLET_STATE_SCHED)
	2. if the bit wasn't set (cleared) it puts the tasklet on the
	   tasklet_vec list.
	
	By the trick, to set the schedule_bit without putting
	the tasklet on the list, a tasklet can be "killed"
	(it is not on the list and tasklet_schedule is not going
	to put it on the list). But in the current implementation
	of tasklet_kill the schedule_bit is cleared (last line of
	the function)? In this case the next tasklet_schedule
	"works" and the tasklet-function will be called again.
	So, is it a bug? What do we achieve by clearing the
	schedule_bit? Can we remove the "clear_bit" line
	(it is not necessary to call "set_bit", because
	"test_and_set_bit" has set it before)?
	Or what is _exactly_ the purpose of tasklet_kill?

	Juergen.

=====================
void tasklet_kill(struct tasklet_struct *t)
{
	if (in_interrupt())
		printk("Attempt to kill tasklet from interrupt\n");

	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
		do
			yield();
		while (test_bit(TASKLET_STATE_SCHED, &t->state));
	}
	tasklet_unlock_wait(t);
	clear_bit(TASKLET_STATE_SCHED, &t->state);
}
