Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286462AbSAGBEN>; Sun, 6 Jan 2002 20:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289062AbSAGBED>; Sun, 6 Jan 2002 20:04:03 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:1287 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286462AbSAGBDu>; Sun, 6 Jan 2002 20:03:50 -0500
Message-ID: <3C38F2BE.EF5E5DA3@zip.com.au>
Date: Sun, 06 Jan 2002 16:58:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stefan Frank <sfr@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2nd Oops] 2.4.17, looks ext3 related
In-Reply-To: <20020106224633.GA725@asterix>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Frank wrote:
> 
> Some more oopses occured this evening after a  strange behaviour:
> 
> A few hours ago i noticed that the system load was stable around 1, but
> according to top no process was responsible. I just ignored it but
> then vim got stuck when quitting it inside a xterm. What followed were 3
> oopses of different processes (see ksymoops decoding below).
> 
> Somewhere between the 2nd and the 3rd oops (i'm NOT exactly shure when) the
> system load went up to around 7. Again no, process seemed responsible.

The system load goes up by one for each process which is stuck on
a semaphore.  You have lots of processes stuck on a semaphore because
a process took an oops with a semaphore held, and killed itself
without releasing the semaphore.

> Jan  6 19:58:46 asterix kernel:  printing eip:
> Jan  6 19:58:46 asterix kernel: c012ea98
> Jan  6 19:58:46 asterix kernel: Oops: 0000
> Jan  6 19:58:46 asterix kernel: CPU:    0
> Jan  6 19:58:46 asterix kernel: EIP:    0010:[get_hash_table+104/144]

We appear to not have the faulting address.  And because klogd attempted
to interpret the oops, we don't have the instruction decode which would
allow us to work out the faulting address.

Please.  edit /etc/rc.d/init.f/syslog (or equivalent) and ensure that
klogd is launched with the `-x' option:

        daemon klogd -x $KLOGD_OPTIONS

Once this is done, your logs will be ksymoops-friendly.

So.  Why did it oops?  Don't know.  The buffercache hashtable has
become corrupted.  Could be bad memory, could be some part of the
kernel (any part) scribbled on memory.  And the latter is one of
the very hardest bugs to find.

-
