Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUDBBqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbUDBBqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:46:11 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:8143 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263540AbUDBBqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:46:06 -0500
Message-Id: <5.2.1.1.2.20040401172809.01bcfa50@kash.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Thu, 01 Apr 2004 17:46:00 -0800
To: linux-kernel@vger.kernel.org
From: Ken Ashcraft <kash@stanford.edu>
Subject: [CHECKER] Race condition in i2o_core.c
Cc: alan@redhat.com, mc@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like there is a race condition in i2o_core_reply involving the 
variable "evt_in".  Notice that the increment of evt_in is protected by the 
lock, but the reads are not protected.  It looks like "events" should also 
be protected by the lock.  If this is not a race condition, the increment 
should not be inside the critical section.

Feedback is appreciated.

thanks,
Ken Ashcraft
-----------------------------------
/home/kash/interface/linux-2.6.3/drivers/message/i2o/i2o_core.c:264:i2o_core_reply: 
ERROR:RACE: 264:264:Possible race condition on variable "evt_in", No locks 
held on read on line 264, Locks {&i2o_evt_lock } held on write on line 268 
[COUNTER=i2o_handler.reply] [fit=1] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=1] [counter=1] [z = -2.91998558035372] [fn-z = -4.35889894354067]

                 return;
         }

         if(m->function == I2O_CMD_UTIL_EVT_REGISTER)
         {

Error --->
                 memcpy(events[evt_in].msg, msg, (msg[0]>>16)<<2);
                 events[evt_in].iop = c;

                 spin_lock(&i2o_evt_lock);
                 MODINC(evt_in, I2O_EVT_Q_LEN);
                 if(evt_q_len == I2O_EVT_Q_LEN)
                         MODINC(evt_out, I2O_EVT_Q_LEN);
                 else
                         evt_q_len++;
                 spin_unlock(&i2o_evt_lock);

                 up(&evt_sem);
                 wake_up_interruptible(&evt_wait);
                 return;


