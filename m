Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUF1C6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUF1C6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 22:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUF1C6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 22:58:41 -0400
Received: from holomorphy.com ([207.189.100.168]:12959 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264640AbUF1C6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 22:58:35 -0400
Date: Sun, 27 Jun 2004 19:58:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian <bmg300@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel VM bug?
Message-ID: <20040628025832.GM21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian <bmg300@yahoo.com>, linux-kernel@vger.kernel.org
References: <20040628023039.70960.qmail@web41505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628023039.70960.qmail@web41505.mail.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 07:30:39PM -0700, Brian wrote:
> While doing massive memory allocation (I'm using GRASS to project
> NASA's BlueMarble maps) the kernel apparently tries to kill grass but
> fails. When I try to access /proc/<grass_pid>/stat the process hangs.
> For example, an 'strace' of 'ps' ends like this:
> open("/proc/1783/stat", O_RDONLY) = 6
> read(6, <PS and strace hang here>
> I am able to project a few files, but once the filesystem cache fills
> up, GRASS hangs or gives a panic in vm_stat:381. The strange thing
> is, very little swap space is in use, and the filesystem cache
> continues to use most of the RAM.
> Is this a kernel bug, or do I need to use kernel 2.6.x (I am using
> kernel 2.4.26) and /proc/sys/vm/overcommit_memory or similar hack?
> Since I am a kernel-newbie, these links might help explain the
> problem better ;)
> http://seclists.org/linux-kernel/2001/Dec/1604.html
> http://www.mail-archive.com/debian-glibc@lists.debian.org/msg10070.html

2.6 has had many of these kinds of failure modes addressed, but it's
not clear what the precise relationship of your issue is to the various
work that's gone on there. This description isn't really enough to go
on, but by "guesswork" I suspect it is a semaphore deadlock related to
an interaction coredumping and process resource usage reporting in /proc/.
Excerpts of system logs related to the killing of the process may also
be useful to diagnose the problem.

In general, what needs to go on is for us to be able to reproduce your
failure. However, there are categories of problems, design flaws, that
require work too invasive to be addressed in 2.4, and because of the
ones that have been addressed in 2.6 related to this specific area, I'd
suspect there is a good chance that using 2.6 will resolve your problem.

Strict non-overcommit is also good to have in order for orderly
application shutdown or otherwise application self-regulation of
resource demands to occur at the time of hardware resource exhaustion.
This is by necessity enabled by default and has to be disabled at
runtime. You shouldn't have to do anything to enable it, but to
doublecheck that strict non-overcommit hasn't been disabled by e.g.
initscripts, please check that /proc/sys/vm/overcommit_memory stays 0.

To investigate what may have happened in 2.4, it may be helpful for us
to be able to run GRASS on a similar data set (IIRC it is open source
and freely available for download) and to arrange for testing on a
similar machine, which by and large we can arrange for ourselves given
a sufficiently detailed description.

Thanks.


-- wli
