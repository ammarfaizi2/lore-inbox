Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271982AbRIMTbp>; Thu, 13 Sep 2001 15:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271989AbRIMTbf>; Thu, 13 Sep 2001 15:31:35 -0400
Received: from [216.219.239.237] ([216.219.239.237]:17160 "EHLO
	www.sensoria.com") by vger.kernel.org with ESMTP id <S271982AbRIMTb3>;
	Thu, 13 Sep 2001 15:31:29 -0400
From: "Bao C. Ha" <baoha@sensoria.com>
To: <twoller@crystal.cirrus.com>
Cc: <audio@crystal.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Problems with Crystal cs4281 driver in 2.4.8
Date: Thu, 13 Sep 2001 12:29:28 -0700
Message-ID: <002401c13c8a$68864d30$456c020a@SENSORIA>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are running kernel 2.4.8 on the sh4 platform.
We are encoutering a problem with the cs4281
driver as described in the following:

The device file is opened normally.  Everything
is working fine.  Then, when it is closed, the
application hangs.  A ctrl-C is required to get
out of it.  Upon further examining, we find that
the close() call is not returning.  It is stuck
at the drain_adc().

In the cs4281_release(),
...
        if (file->f_mode & FMODE_READ) {
------>         drain_adc(s, file->f_flags & O_NONBLOCK);
                down(&s->open_sem_adc);
                stop_adc(s);
...

And in the drain_adc(),
...
        for (;;) {
                set_current_state(TASK_INTERRUPTIBLE);
                spin_lock_irqsave(&s->lock, flags);
----->          count = s->dma_adc.count;
                CS_DBGOUT(CS_FUNCTION, 2,
                          printk(KERN_INFO "cs4281: drain_adc() %d\n",
count));
                spin_unlock_irqrestore(&s->lock, flags);
...

It seems that since s->dma_adc.count=8192, we
are going into an infinite loop there, in
drain_adc(),

The work-around that we are currently looking
at is setting the flag to O_NONBLOCKING just
prior to closing the device to take advantages
of this.
...
                if (nonblock) {
                        remove_wait_queue(&s->dma_adc.wait, &wait);
                        current->state = TASK_RUNNING;
                        return -EBUSY;
                }
...

Unfortunately, it causes problems later
since it is in non-blocking mode.  Do a
fcntl(fd, F_SETFL, 0);
did not reset to the normal/blocking mode.

What would be the proper way to handle this
situation?  Since I am not familiar with the
driver, I don't know if removing the
drain_adc() from cs4281_release() would cause
problems later or not.  I am also not sure
this behavior is specific to the sh4-linux
port or not.

Appreciate any suggestions/comments.

Regards.
Bao

