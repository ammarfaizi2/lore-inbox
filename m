Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSBCIhg>; Sun, 3 Feb 2002 03:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSBCIh1>; Sun, 3 Feb 2002 03:37:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55058 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286521AbSBCIhQ>;
	Sun, 3 Feb 2002 03:37:16 -0500
Message-ID: <3C5CF686.1145AE14@zip.com.au>
Date: Sun, 03 Feb 2002 00:36:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: Vincent Sweeney <v.sweeney@barrysworld.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "coder-com@undernet.org" <coder-com@undernet.org>,
        "Kevin L. Mitchell" <klmitch@mit.edu>
Subject: Re: PROBLEM: high system usage / poor SMP network performance
In-Reply-To: <3C56E327.69F8B70F@kegel.com> <001901c1a900$e2bc7420$0201010a@frodo> <3C58D50B.FD44524F@kegel.com> <001d01c1aa8e$2e067e60$0201010a@frodo> <3C5CEEED.E98D35B7@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
