Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUDBCMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUDBCMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:12:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:64163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263555AbUDBCMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:12:03 -0500
Date: Thu, 1 Apr 2004 18:08:39 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ken Ashcraft <kash@stanford.edu>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, mc@cs.stanford.edu
Subject: Re: [CHECKER] Race condition in i2o_core.c
Message-Id: <20040401180839.0dbcc224.rddunlap@osdl.org>
In-Reply-To: <5.2.1.1.2.20040401172809.01bcfa50@kash.pobox.stanford.edu>
References: <5.2.1.1.2.20040401172809.01bcfa50@kash.pobox.stanford.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Apr 2004 17:46:00 -0800 Ken Ashcraft wrote:

| Looks like there is a race condition in i2o_core_reply involving the 
| variable "evt_in".  Notice that the increment of evt_in is protected by the 
| lock, but the reads are not protected.  It looks like "events" should also 
| be protected by the lock.  If this is not a race condition, the increment 
| should not be inside the critical section.
| 
| Feedback is appreciated.
| 
| thanks,
| Ken Ashcraft
| -----------------------------------
| /home/kash/interface/linux-2.6.3/drivers/message/i2o/i2o_core.c:264:i2o_core_reply: 
| ERROR:RACE: 264:264:Possible race condition on variable "evt_in", No locks 
| held on read on line 264, Locks {&i2o_evt_lock } held on write on line 268 
| [COUNTER=i2o_handler.reply] [fit=1] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
| [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = -4.35889894354067]
| 
|                  return;
|          }
| 
|          if(m->function == I2O_CMD_UTIL_EVT_REGISTER)
|          {
| 
| Error --->
|                  memcpy(events[evt_in].msg, msg, (msg[0]>>16)<<2);

static int evt_in;
Access to <int> is (considered to be) atomic.
However, the MODINC() macro is nowhere close to atomic.
Does that help?

|                  events[evt_in].iop = c;
| 
|                  spin_lock(&i2o_evt_lock);
|                  MODINC(evt_in, I2O_EVT_Q_LEN);
|                  if(evt_q_len == I2O_EVT_Q_LEN)
|                          MODINC(evt_out, I2O_EVT_Q_LEN);
|                  else
|                          evt_q_len++;
|                  spin_unlock(&i2o_evt_lock);
| 
|                  up(&evt_sem);
|                  wake_up_interruptible(&evt_wait);
|                  return;


--
~Randy
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
