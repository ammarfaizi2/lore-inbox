Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVFJWzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVFJWzX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVFJWzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:55:23 -0400
Received: from web30704.mail.mud.yahoo.com ([68.142.200.137]:42924 "HELO
	web30704.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261368AbVFJWyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:54:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=yBHnuVaYSDHXmZcfQxDTFWYlFR0aXtlfnJdolwLhKo+iHTX4WVdrNA/6X1sqDfuqBEvTLu7y4B7jMeizCZsSAbG1GASrG63sE6ydCARijyYomzFJDWqU12btJkk7InlG1YGaw4CXmSjG5lyFGzF4MIEzaWRoxO71jn7S3EVEKsc=  ;
Message-ID: <20050610225443.75162.qmail@web30704.mail.mud.yahoo.com>
Date: Fri, 10 Jun 2005 15:54:43 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: cfq misbehaving on 2.6.11-1.14_FC3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I am running into a very bad problem on one of my production servers.

* the config
Linux Fedora core 3 latest everything, kernel 2.6.11-1.14_FC3
AMD Opteron 2 GHz, 1 G RAM, 80 GB Hard drive (IDE, Western Digital)

I have a log processor running in the background, it's using sqlite for storing
the information it finds in the logs. It takes a few hours to complete a run.
It's clearly I/O bound (SleepAVG = 98%, according to /proc/pid/status).
I have to use the cfq scheduler because it's the only scheduler that is fair
between processes (or should be, keep reading).

* the problem
Now, after an hour or so of processing, the machine becomes very unresponsive
when trying to do new disk operations. I say new because existing processes
that stream data to disk don't seem to suffer so much.

On the other hand, opening a blank new file in vi and saving it takes about 5
minutes or so.
Logging in with ssh just times out (so I have to keep a connection open to
avoid being locked out). << that's where it's a really bad problem for me :)

Now, if I switch the disk to anticipatory or deadline, by setting
/sys/block/hda/queue/scheduler, things go back to regular times very quickly.
Saving a file in vi takes about 12 seconds (slow, but not unbearable,
considering the machine is doing a lot of things).
Logging in takes less than a second.

I did a strace on the process that is causing havock, and the pattern of usage
is:
* open files
*
about 5000 of combinations of
llseek+read
llseek+write
in 1000 bytes requests.
* close files

The process is also niced to 8, but it doesn't seem to make any difference. I
found references to a "ionice" or "iorenice" syscall, but that doesn't seem to
exist anymore.
I thought that the i/o scheduler was taking the priority into account?

Is this a know problem? I also thought that timed cfq was supposed to take care
of such workloads?

Any idea on how I could improve the situation?

Thanks

Nicolas

