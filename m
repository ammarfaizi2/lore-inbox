Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263456AbRFFCYy>; Tue, 5 Jun 2001 22:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263461AbRFFCYp>; Tue, 5 Jun 2001 22:24:45 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:23001 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263456AbRFFCY1>; Tue, 5 Jun 2001 22:24:27 -0400
Message-ID: <3B1D927E.1B2EBE76@uow.edu.au>
Date: Wed, 06 Jun 2001 12:16:30 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeffrey W. Baker" <jwbaker@acm.org>
CC: Derek Glidden <dglidden@illusionary.com>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeffrey W. Baker" wrote:
> 
> Because the 2.4 VM is so broken, and
> because my machines are frequently deeply swapped,

The swapoff algorithms in 2.2 and 2.4 are basically identical.
The problem *appears* worse in 2.4 because it uses lots
more swap.

> they can sometimes take over 30 minutes to shutdown.

Yes. The sys_swapoff() system call can take many minutes
of CPU time.  It basically does:

	for (each page in swap device) {
		for (each process) {
			for (each page used by this process)
				stuff

It's interesting that you've found a case where this
actually has an operational impact.

Haven't looked at it closely, but I think the algorithm
could become something like:

	for (each process) {
		for (each page in this process) {
			if (page is on target swap device)
				get_it_off()
		}
	}

	for (each page in swap device) {
		if (it is busy)
			complain()
	}

That's 10^4 to 10^6 times faster.

-
