Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272020AbRIMU3w>; Thu, 13 Sep 2001 16:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272038AbRIMU3n>; Thu, 13 Sep 2001 16:29:43 -0400
Received: from cs6625192-102.austin.rr.com ([66.25.192.102]:272 "EHLO
	mail1.cirrus.com") by vger.kernel.org with ESMTP id <S272020AbRIMU3b>;
	Thu, 13 Sep 2001 16:29:31 -0400
Message-ID: <973C11FE0E3ED41183B200508BC7774C022FB771@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'Bao C. Ha'" <baoha@sensoria.com>,
        "Woller, Thomas" <twoller@crystal.cirrus.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Problems with Crystal cs4281 driver in 2.4.8
Date: Thu, 13 Sep 2001 15:31:16 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you send me the source that you have with separate email
(tar/bzip2)? I am wondering if the source base is old.  Send to
twoller@crystal.cirrus.com  I'll take a look at it with what I
have as the latest. 
I don't know of any such problem on the x86 or the IA64
platforms.  
Now, if you are trying use the MMAP interface with capture (ADC)
then I know that there will be some problems.  non-mmap capture
should work fine.  Also, if s->dma_adc.count is not decrementing
then interrupts have ceased or there is a bug in the driver,
maybe a race condition in the driver that needs to be fixed.
Thanks
tom

 -----Original Message-----
From: 	Bao C. Ha [mailto:baoha@sensoria.com] 
Sent:	Thursday, September 13, 2001 2:29 PM
To:	twoller@crystal.cirrus.com
Cc:	audio@crystal.cirrus.com; linux-kernel@vger.kernel.org
Subject:	Problems with Crystal cs4281 driver in 2.4.8


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
                          printk(KERN_INFO "cs4281: drain_adc()
%d\n",
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
                        remove_wait_queue(&s->dma_adc.wait,
&wait);
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
