Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVBPV0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVBPV0d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVBPV0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:26:33 -0500
Received: from tierw.net.avaya.com ([198.152.13.100]:59330 "EHLO
	tierw.net.avaya.com") by vger.kernel.org with ESMTP id S262073AbVBPV02 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:26:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: TTY driver race condition in 2.4 kernels?
Date: Wed, 16 Feb 2005 14:26:14 -0700
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC07023978@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: TTY driver race condition in 2.4 kernels?
Thread-Index: AcUUbiR0wQlTi3RvR8iLS1z6VtgvzA==
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since my mail about a potential race condition in the TTY layer was
ignored, I'm reposting it to grab peoples attention to this issue we are
seeing with real customers of Avaya's large real-time
priority-preemption telecommunications systems using USB modems for PPP
access. 

In the 2.4 kernels (we're using 2.4.20, but this applies universally),
is there a race window when a wake_up() of the tty->write_wait queue
from the underlying tty_driver can be lost in la-la-land, while a task
is sleeping on it from tty_wait_until_sent() ? 

I am seeing something similar. I have the "pppd" daemon in the
TASK_INTERRUPTIBLE state stuck in tty_wait_until_sent() [determined from
wchan] as a result of its ioctl(fd, TIOCSETD, [N_TTY]) call while about
to exit. 

A debug module I wrote is showing that the tty->write_wait queue is
empty. As a result, *nothing* will wake up pppd from its
TASK_INTERRUPTIBLE state. 

How could that be? Just to show that I've done my homework, attached is
my analysis of the issue. 

I've seen references to race conditions in the changing of
line-disciplines in postings by Alan Cox, but none of those references
seems to explain what I am seeing. 

Any insight would be greatly appreciated!

Thanks 
- Bhavesh 

Analysis: 

pppd: 
   Calls ioctl(modemfd [/dev/usb/ttyACM0], TIOCSETD, (N_TTY)) 
   In the kernel: 
        tty_ioctl() calls tty_wait_until_sent(tty, 0) 
        tty_wait_until_sent(tty, 0) 
                checks tty->driver.chars_in_buffer func ptr. If true, 
                Adds pppd to the tty->write_wait wait queue 
                Calls tty->driver.chars_in_buffer(tty). If true, 
                        Translates to acm_tty_chars_in_buffer() 
                        Returns 0 if acm->writeurb.status != EINPROGRESS

                        Returns -EINVAL if !ACM_READY() 
                        Returns acm->writeurb.transfer_buffer_length if 
                                acm->writeurb.status==EINPROGRESS 
                Calls schedule_timeout(MAX_SCHEDULE_TIMEOUT) 


   To wake up pppd from schedule_timeout(MAX_SCHEDULE_TIMEOUT), 
	someone has to wake_up the tty->write_wait wait queue 
   One candidate to do so is acm_softint() 
   acm_softint() is called in bottom-half of acm_write_bulk() 
   acm_write_bulk() is called as a completion routine for the write URB 
      Most likely happens in interrupt context, as the outstanding 
      UHCI TD is completed. That's why it queues a IMMEDIATE_BH task 
      to do acm_softint() 


POTENTIALS FOR RACE CONDITION: 
Another task does a write() on /dev/usb/ttyACM0 
  Translates to acm_tty_write() 
     acm->writeurb.tranfer_buffer_length = count passed in 
     usb_submit_urb(&acm->writeurb) 
        UHCI driver writes TD to USB controller 
If pppd does its ioctl(TIOCSETD) *after* usb_submit_urb() from other
task, then its tty_wait_until_sent(tty, 0) routine will get a non-zero
acm_tty_chars_in_buffer(). By that time, pppd has added itself to the
tty->write_wait queue. So on completion of the TD/URB, acm_softint()
*should* wake up pppd correctly 

What happens if the TD completion interrupt (and hence the call to
acm_write_bulk()) comes in right before pppd calls
schedule_timeout(MAX_SCHEULE_TIMEOUT) ? 
It queues an IMMEDIATE_BH task to do acm_softint(), which won't be
executed until *after* the schedule_timeout() call from pppd (*I THINK*,
due to the non-preemptible nature of the 2.4.20 kernel). acm_softint()
*should* be 
executed by the ksoftirqd kernel thread, which runs *after* pppd has
called schedule_timeout(). So the wake-up of tty->write_wait *should*
wake up pppd correctly 

What can I do to see if pppd is still on the write_wait queue for the
tty? 
Write a module whose init routine will filp_open the modem tty, and
examine its write_wait queue and other members of tty_struct. 

ORIGINAL POST:
[http://marc.theaimsgroup.com/?l=linux-kernel&m=110850749526598&w=2] 

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com
