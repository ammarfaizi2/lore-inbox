Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWJMXa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWJMXa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbWJMXaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:30:25 -0400
Received: from web58107.mail.re3.yahoo.com ([68.142.236.130]:27500 "HELO
	web58107.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1751840AbWJMXaZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:30:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5EbDZCaYg0bFldZ41zSbz2c1YTQcJhh0wpeSUKHthtlowPk3DPuLiZMQQ08shJd4jd332Qnv+keAB05zDN04f3bLGvgYSiQ4cAg6Qo9n1ke6Edqq59B4iLzn/VIvTf/wqI/8ipVmpd2PjDlvs/PApZ7b9ONl6H0XnP36lksM9Cw=  ;
Message-ID: <20061013233024.5786.qmail@web58107.mail.re3.yahoo.com>
Date: Fri, 13 Oct 2006 16:30:24 -0700 (PDT)
From: Open Source <opensource3141@yahoo.com>
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan (and all),

Thanks for your message.

There is an ioctl that is waiting for the URB to be reaped.
I am almost certain it is this syscall that is taking 4 ms (as
opposed to 1 ms with CONFIG_HZ=1000).

Let me ask a very specific question related to my
previous email about devio.c.

Say I have a process that has done the following:
--
        add_wait_queue(&ps->wait, &wait);
        for (;;) {
                __set_current_state(TASK_INTERRUPTIBLE);
                if ((as = async_getcompleted(ps)))
                        break;
                if (signal_pending(current))
                        break;
                usb_unlock_device(dev);
                schedule();
                usb_lock_device(dev);
        }
        remove_wait_queue(&ps->wait, &wait);
--

Then later, a USB interrupt triggers, and the following is called
after a bunch of code:
--
wake_up(&ps->wait)
--

Will the first piece of code wake up immediately or only after the
next HZ timeslice?  If it is the latter, which is what I am starting to
fear now, that would explain everything.  Then, the question is
whether or not there is anyway to improve this situation.  If it does
wake up immediatley, then the delay is elsewhere and probably
has nothing to do with kernel mode versus user mode issues.

Thanks again.


----- Original Message ----
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Open Source <opensource3141@yahoo.com>
Cc: Alan Stern <stern@rowland.harvard.edu>; linux-usb-devel@lists.sourceforge.net; WolfgangMües <wolfgang@iksw-muees.de>; linux-kernel@vger.kernel.org
Sent: Friday, October 13, 2006 4:41:44 PM
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13 (CRITICAL???)

Ar Gwe, 2006-10-13 am 16:02 -0700, ysgrifennodd Open Source:
> clear understanding of what is causing it.  As it stands it doesn't
> seem like even the experts know exactly where this
> delay is being caused.

strace should tell you precisely how long each syscall takes if you ask
it to trace things nicely. If you have code trying to wait for a tiny
time then HZ will bump the wait to be longer (kernel or user) but for
other cases all should be fine either way.

The other issues like priority and paging caused delays can generally be
dealt with by having the relevant service code running mlockall and real
time priority.







