Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282679AbRK0AiE>; Mon, 26 Nov 2001 19:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282683AbRK0Ahy>; Mon, 26 Nov 2001 19:37:54 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:9235 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282679AbRK0Ahm>; Mon, 26 Nov 2001 19:37:42 -0500
Message-ID: <3C02E009.7C1F17C6@zip.com.au>
Date: Mon, 26 Nov 2001 16:36:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Nathan G. Grennan" <ngrennan@okcforum.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <E168U3m-00077F-00@the-village.bc.nu> <Pine.LNX.4.33L.0111262156140.4079-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> However, I suspect this unresponsiveness issue is related to
> either IO scheduling or write throttling, and that code is
> the same in both VMs. I'll take a look at smoothing out writes
> so we can get this thing fixed in both VMs.
> 

umm...  What I said.

balance_dirty_state() is allowing writes to flood the machine
with locked buffers.

elevator is penalising reads horridly.  Try this on your
64 megabyte box:

	dd if=/dev/zero of=foo bs=1024k count=8000

and then try to log in to it.  Be patient.  Very patient. Five
minutes pass.  Still being patient?  In fact with this test I've
never been able to get a login prompt.  The filesystem which 
holds `foo' is only 8 gigs, and it fills up, permitting the login
to happen.

What happens is this:  sshd gets paged out.  It wakes up, faults
and tries to read a page.  That read gets stuck on the request
queue behind about 50 megabytes of write data.  Eventually, it
gets read.  Then sshd faults in another page.  That gets stuck
on the request queue behind about 50 megabytes of data.  By the time
this one gets read, the first page is probably paged out again.  See
how this isn't getting us very far?

The patch I sent puts read requests near the head of the request
queue, and to hell with aggregate throughput.  It's tunable with
`elvtune -b'.  And it fixes it.

-
