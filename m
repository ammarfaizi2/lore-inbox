Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130191AbRCBAlh>; Thu, 1 Mar 2001 19:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130198AbRCBAl2>; Thu, 1 Mar 2001 19:41:28 -0500
Received: from laird.ocp.internap.com ([64.94.114.35]:5962 "EHLO
	laird.ocp.internap.com") by vger.kernel.org with ESMTP
	id <S130191AbRCBAlN>; Thu, 1 Mar 2001 19:41:13 -0500
Date: Thu, 1 Mar 2001 16:41:01 -0800 (PST)
From: Scott Laird <laird@internap.com>
X-X-Sender: <laird@laird.ocp.internap.com>
To: <linux-kernel@vger.kernel.org>
Subject: Another rsync over ssh hang (repeatable, with 2.4.1 on both ends)
Message-ID: <Pine.LNX.4.33.0103011607540.17365-100000@laird.ocp.internap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a fairly repeatable rsync over ssh stall that I'm seeing between
two Linux boxes, both running identical 2.4.1 kernels.  The stall is
fairly easy to repeat in our environment -- it can happen up to several
times per minute, and usually happens at least once per minute.  It
doesn't really seem to be data-sensitive.  The stall will last until the
session times out *unless* I take one of two steps to "unstall" it.  The
easiest way to do this is to run 'strace -p $PID' against the sending ssh
process.  As soon as the strace is started, rsync starts working again,
but will stall again (even with strace still running) after a short period
of time.

We've seen this bug (or a *very* similar one) with 2.2.16 and 2.4.[01].  I
haven't tried a newer 2.2.x or 2.4.2 or -acX.


One system is a P2/400, the other is a P3/800.  The two boxes are
communicating over a mostly idle Ethernet, through 3 switches.  One end is
a EEPro 100, the other end is an Acenic, although that shouldn't matter.

During a stall, the sending end shows a lot of data stuck in the Recv-Q:

Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp    72848      0 ref.lab.ocp.interna:840 ref-0.sys.pnap.net:ssh  ESTABLISHED

The receiving end shows a similar problem, but on the sending queue:

Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0  28960 ref-0.sys.pnap.net:ssh  ref.lab.ocp.interna:840 ESTABLISHED

Like I said, I don't believe that this is a network issue, because I can
un-stall the rsync by either stracing the *sending* ssh process, or by
putting the sending rsync into the background with ^Z and then popping it
back into the foreground.  I have tcpdumps that I can send, but they look
pretty straightforward to me -- the window fills, so data stops flowing.

Strace doesn't seem to be particularly informative:

<blocked, strace starts>
select(4, [0], [1], NULL, NULL) = 1 (out [1])
write(1, "xxxxxxxxxxxxx"..., 66156) = 66156
...
select(4, [0], [1 3], NULL, NULL)       = 2 (out [1 3])
write(1, "\0\0\0\0\274\2\0\0\0\0\0\0\271\30\0\0\0\0\0\0\274\2\0\0"..., 69526
<blocked again>

Strace on the receiving end shows the obvious -- it's sitting in select
waiting for data to arrive.

According to 'ps l', the ssh process is waiting in 'sock_wait_for_wmem'.

We've tried changing versions of rsync and ssh without any success.  FWIW,
this kernel was compiled with GCC 2.95.2, from Debian potato.


Scott

