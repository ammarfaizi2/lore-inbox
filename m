Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVAVVYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVAVVYq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 16:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVAVVXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 16:23:36 -0500
Received: from mail.joq.us ([67.65.12.105]:54419 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262752AbVAVVWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 16:22:33 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 22 Jan 2005 15:23:54 -0600
In-Reply-To: <20050122165458.GA14426@elte.hu> (Ingo Molnar's message of
 "Sat, 22 Jan 2005 17:54:58 +0100")
Message-ID: <87hdl940ph.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> thanks for the testing. The important result is that nice--20
> performance is roughly the same as SCHED_ISO. This somewhat
> reduces the urgency of the introduction of SCHED_ISO.

I can see why you feel that way, but don't share your conclusion.

  First, only SCHED_FIFO worked reliably in my tests.  In Con's tests
  even that did not work.  My system is probably better tuned for low
  latency than his.  Until we can determine why there were so many
  xruns, it is premature to declare victory for either scheduler.
  Preferably, we should compare them on a well-tuned low-latency
  system running your Realtime Preemption kernel.

  Second, the nice(-20) scheduler provides no clear way to support
  multiple realtime priorities.  This is necessary for some audio
  applications, but not jack_test3.2.

  Third, your prototype denies SCHED_FIFO to privileged threads.  This
  is a serious problem, even for testing (though perhaps easy to fix).

  Most important, let's not forget that this long discussion started
  because ordinary users need access to realtime scheduling.  Con's
  scheduler provides a solution for that problem.  Your prototype does
  not.

Chris Wright and Arjan van de Ven have outlined a proposal to address
the privilege issue using rlimits.  This is still the only workable
alternative to the realtime LSM on the table.  If the decision were up
to me, I would choose the simplicity and better security of the LSM.
But their approach is adequate, if implemented in a timely fashion.  I
would like to see some progress on this in addition to the scheduler
work.  People still need SCHED_FIFO for some applications.

Right now, SCHED_ISO still looks better than nice(-20) for audio.  It
works without special permissions.  The throttling threshold is
adjustable with appropriate privileges.  It has the potential to
support multiple priorities.  

Being less entangled with SCHED_NORMAL makes me worry less about
someone coming along later and messing it up while working on some
unrelated problem.  Right now for example, mounting an encrypted
filesystem starts a `loop0' kernel thread at nice -20.
-- 
  joq
