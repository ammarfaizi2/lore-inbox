Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289004AbSBDO61>; Mon, 4 Feb 2002 09:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289007AbSBDO6L>; Mon, 4 Feb 2002 09:58:11 -0500
Received: from proxyscan.quakenet.org ([213.221.173.2]:30990 "EHLO
	grail.phat-pipe.net") by vger.kernel.org with ESMTP
	id <S289004AbSBDO6C>; Mon, 4 Feb 2002 09:58:02 -0500
From: "Darren Smith" <data@barrysworld.com>
To: "'Andrew Morton'" <akpm@zip.com.au>, "'Dan Kegel'" <dank@kegel.com>
Cc: "'Vincent Sweeney'" <v.sweeney@barrysworld.com>,
        <linux-kernel@vger.kernel.org>, <coder-com@undernet.org>,
        "'Kevin L. Mitchell'" <klmitch@mit.edu>
Subject: RE: [Coder-Com] Re: PROBLEM: high system usage / poor SMP network performance
Date: Mon, 4 Feb 2002 14:57:48 -0000
Message-ID: <000201c1ad8c$4fcc99c0$c2f0bcc3@wilma>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <3C5CF686.1145AE14@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've been testing the modified Undernet (2.10.10) code with Vincent
Sweeney based on the simple usleep(100000) addition to s_bsd.c

PRI NICE  SIZE    RES STATE  C   TIME   WCPU    CPU | # USERS
 2   0 96348K 96144K poll   0  29.0H 39.01% 39.01%  |  1700 <- Without
Patch
10   0 77584K 77336K nanslp 0   7:08  5.71%  5.71%  |  1500 <- With
Patch

Spot the difference!

It doesn't appear to be lagging, yet is using 1/7th the cpu!

Anyone else tried this?

Regards

Darren Smith

-----Original Message-----
From: owner-coder-com@undernet.org [mailto:owner-coder-com@undernet.org]
On Behalf Of Andrew Morton
Sent: 03 February 2002 08:36
To: Dan Kegel
Cc: Vincent Sweeney; linux-kernel@vger.kernel.org;
coder-com@undernet.org; Kevin L. Mitchell
Subject: [Coder-Com] Re: PROBLEM: high system usage / poor SMP network
performance

Dan Kegel wrote:
>
> Before I did any work, I'd measure CPU
> usage under a simulated load of 2000 clients, just to verify that
> poll() was indeed a bottleneck (ok, can't imagine it not being a
> bottleneck, but it's nice to have a baseline to compare the improved
> version against).

I half-did this earlier in the week.  It seems that Vincent's
machine is calling poll() maybe 100 times/second.  Each call
is taking maybe 10 milliseconds, and is returning approximately
one measly little packet.

select and poll suck for thousands of fds.  Always did, always
will.  Applications need to work around this.

And the workaround is rather simple:

	....
+	usleep(100000);
	poll(...);

This will add up to 0.1 seconds latency, but it means that
the poll will gather activity on ten times as many fds,
and that it will be called ten times less often, and that
CPU load will fall by a factor of ten.

This seems an appropriate hack for an IRC server.  I guess it
could be souped up a bit:

	usleep(nr_fds * 50);

-


