Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269860AbRHDUtT>; Sat, 4 Aug 2001 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269861AbRHDUtK>; Sat, 4 Aug 2001 16:49:10 -0400
Received: from mx1.eskimo.com ([204.122.16.48]:7940 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S269860AbRHDUtB>;
	Sat, 4 Aug 2001 16:49:01 -0400
Date: Sat, 4 Aug 2001 13:48:55 -0700
From: Elladan <elladan@eskimo.com>
To: redph0enix@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux C2-Style Audit Capability
Message-ID: <20010804134854.A2270@eskimo.eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a classic producer-consumer problem.  There are only two solutions:

* Discard log events (unacceptable for security - anyone could just turn off 
  logging whenever they want by spamming the system with spurious log events)
* Block the producer

So, really, you have no choice but to block the producer of the log events, eg.
block all logged system calls until the buffer is depleted again.

Of course, this leads to all sorts of enjoyable deadlock conditions in the
system...  The audit daemon itself cannot block on anything safely, really.
Eg:

What if the audit daemon is just passing the log events on to a log daemon on
the same machine?  The log daemon itself gets logged, so it gets blocked
waiting for the audit buffer.  The audit daemon is trying to deplete its own
buffer by sending to the log daemon, which will never be available...  Poof!

What if the audit daemon is just passing the log events on to an external log
daemon on another machine?  This seems ok, as long as the other machine is
visible.  As soon as it dies, the audited machine will hang until the log host
comes back.  It can't even be shut down, since the shutdown command will be
logged ...

...  But what if the logging machine itself is just a router that sends off
streams from multiple machines to be warehoused?  This seems fine, except...
What if the warehousing machine is itself audited?  It tries to log its audit
stream back to the router, which comes back to itself, which blocks the entire
computer network until someone kicks something.  Ack! 

So it seems that to avoid losing a few system calls in a kernel ring buffer,
you've now crashed an entire NOC.  :-)


The audit daemon will have to be smart and log to some sort of ring buffer on
disk, but of course, disk space is not infinite, so eventually it will have to
start throwing away old log events, just as the kernel does.  So we're right
back where we started.  But perhaps it will take a few days before you have to
do this, with a big disk buffer.  

(Or perhaps not...  If you logged every lstat(), and each log line was 100 
bytes, it seems a malicious user could generate 103 gigabytes of log data in 1
hour, thus erasing their malicious actions at the start of the hour.)

-J
