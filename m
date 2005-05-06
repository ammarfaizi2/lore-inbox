Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVEFLzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVEFLzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 07:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVEFLzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 07:55:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:49078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261163AbVEFLz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 07:55:26 -0400
Date: Fri, 6 May 2005 04:54:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Fabio Brugnara <brugnara@itc.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with mmap over nfs
Message-Id: <20050506045446.1deba35d.akpm@osdl.org>
In-Reply-To: <20050506095023.GS9742@maestoso.itc.it>
References: <20050506095023.GS9742@maestoso.itc.it>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Brugnara <brugnara@itc.it> wrote:
>
> 	The problem is related to the use of memory mapped files over a nfs
>  mounted filesystem. In a rather complex system (speech recognition) that we
>  developed and use, we need to share large read-only data structures between
>  different processes, also on several machines. Until a few months ago, we
>  observed that it was perfectly adequate to just mmap() a file residing on a
>  particular disk, that machines other as the owner mounted via nfs. This was
>  very convenient, as we had only a single physical copy of the data
>  structure, and it did not introduce any significant performance penalty. We
>  have used this method for years.
>  	Now, after the machines have been upgraded to kernel 2.6.10 from
>  kernel 2.4.20, something disappointing happens. Everything still works
>  correctly, but somehow it introduces a massive slowdown of the machines.
>  While the processes are running, the machines that map the shared file via
>  nfs (not the one that owns it) report (with "top") a very high usage of
>  system time (e.g. 50% or more), and also become very unresponsive at the
>  shell prompt.

Could you please generate a kernel profile?

- Compile with CONFIG_PROFILING

- Start the workload, wait for steady state.

- As root, run:

#!/bin/sh

SM=/boot/System.map
TIMEFILE=/tmp/prof.time
readprofile -r
sleep 10
readprofile -n -v -m $SM | sort -n +2 | tail -40 | tee $TIMEFILE >&2

(make sure that /boot/System.map is from the currently-running kernel)

More in Documentation/basic_profiling.txt



Even better, learn to drive oprofile.  Once it's running properly I usually
use this silly script:

#!/bin/sh
opcontrol --stop
opcontrol --shutdown
rm -rf /var/lib/oprofile
opcontrol --vmlinux=/boot/vmlinux-$(uname -r)
opcontrol --start-daemon
opcontrol --start
sleep 10
opcontrol --stop
opcontrol --shutdown
opreport -l /boot/vmlinux-$(uname -r) | head -50

