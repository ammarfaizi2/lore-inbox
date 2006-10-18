Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423071AbWJRXfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423071AbWJRXfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423144AbWJRXfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:35:09 -0400
Received: from web58114.mail.re3.yahoo.com ([68.142.236.137]:38836 "HELO
	web58114.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1423105AbWJRXfI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:35:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FLYGvLFOFbz7bmJ6bs70psWzs3IohyovJ3S2QD7JlQaGW2LvHeGE5sCr+CaXrk1ZWxSK5bYU6uBE0+/Yrl9w60kPodR5jaK0SMkdOrbGZ5XIt6Xp5QjrJpYLwPOnsLGx6iHBkmM/7zSk4gMCMbw4TdkpekLeSM7tfBdhgXyxKco=  ;
Message-ID: <20061018233507.16615.qmail@web58114.mail.re3.yahoo.com>
Date: Wed, 18 Oct 2006 16:35:07 -0700 (PDT)
From: Open Source <opensource3141@yahoo.com>
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13 (CRITICAL???)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan and all,

I have run the "strace -r -f" as you had recommended
and the problem revealed itself.  I did some cross-checking
and I'm pretty sure I have found the issue.

Basically, I was barking up the wrong tree in assuming
this was a USB subsystem issue.  As people correctly
pointed out, the change to CONFIG_HZ has affected
many things.  In my case, I was using a library that issued
a nanosleep for a particular amount of time. Most often
the sleep time is 0, but the library was still calling
nanosleep({0, 0}).  This seemed to put the running process
to sleep (for 0 time) but it only was woken up at the next
timer interrupt (1 ms period for pre-2.6.13 and 4 ms for
2.6.13 and up).

I do not know if this is the desired behavior of nanosleep.
 For example, In Windows, calling Sleep with a zero time,
and no other processes hogging the CPU, does not seem
illicit the same effect as in Linux.  There, no time is
expended.  However, I can understand that there could
be technical reasons to leave nanosleep's behavior like this.

In any case, I apologize for causing ruckus and shifting
the blame incorrectly to USB.  Thank you all for your
advice.  I wouldn't have been able to narrow it down so
easily without it, especially the use of "strace -r" which is
something very useful that I did not know despite
developing on Linux for over a decade!

Furthermore, I am very glad to know that this is not one
of those user-mode-issues-that-can-only-be-solved-by-going-
to-kernel-mode. At least my intuition was correct there.  Things
should be snappy if no other processes are running on the system,
even if the application is in user mode!

Also, here are a few articles that might be useful to other
scheduler newbies like myself:

] http://josh.trancesoftware.com/linux/linux_cpu_scheduler.pdf
] http://kerneltrap.org/node/5411

Thanks again.
Satisfied Open Source Fan


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







