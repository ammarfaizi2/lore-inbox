Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUAMVuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265385AbUAMVuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:50:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:30395 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265438AbUAMVuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:50:37 -0500
Date: Tue, 13 Jan 2004 13:51:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Haakon Riiser <haakon.riiser@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-Id: <20040113135152.3ed26b85.akpm@osdl.org>
In-Reply-To: <20040113210923.GA955@s.chello.no>
References: <20040113210923.GA955@s.chello.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haakon Riiser <haakon.riiser@fys.uio.no> wrote:
>
> The entire output from strace is available for download from
> <http://home.chello.no/~hakonrk/2.6.1.strace.out>, but I think
> only this line is interesting:
> 
>   5083  16:00:30.714309 write(5, "\0", 1) = 1 <1.637019>
> 
> This the only write() to file descriptor 5 issued by qmail-queue,
> right before it exists, and this is what causes the delay.
> Notice that writing this single NUL-byte takes almost 1.64 seconds
> (the number in the angle brackets at the end of the line is the
> time spent in the system call, given by the -T flag to strace).
> Furthermore, the kernel appears to be busy-waiting in this system
> call, because the CPU usage quickly jumps to 100%.

Odd.

5083  16:00:30.714217 open("lock/trigger", O_WRONLY|O_NONBLOCK) = 5 <0.000013>
5083  16:00:30.714260 fcntl64(5, F_GETFL) = 0x801 (flags O_WRONLY|O_NONBLOCK) <0.000004>
5083  16:00:30.714287 fcntl64(5, F_SETFL, O_WRONLY|O_NONBLOCK) = 0 <0.000004>
5083  16:00:30.714309 write(5, "\0", 1) = 1 <1.637019>
5083  16:00:32.351378 close(5)          = 0 <0.000005>

Seems innocuous.  What filesystem type is lock/trigger on?

Can you generate a kernel profile of this activity?

Boot with `profile=1', copy this:

SM=/boot/System.map
TIMEFILE=/tmp/prof.time
sudo readprofile -r
sudo readprofile -M10
time $@
readprofile -n -v -m $SM | sort -n +2 | tail -40 | tee $TIMEFILE >&2

into /tmp/foo and do

	/tmp/foo whatever-command-you-were-using

Thanks.
