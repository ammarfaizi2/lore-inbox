Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269042AbUJERcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269042AbUJERcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269107AbUJERb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:31:59 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:60649 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269042AbUJERb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:31:28 -0400
Date: Tue, 5 Oct 2004 10:29:20 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, johnstul@ibm.com,
       george@mvista.com
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: <200410050515.i955Fa15004063@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0410051018470.27140@schroedinger.engr.sgi.com>
References: <200410050515.i955Fa15004063@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just reviewed the code and to my surprise the simple things like

clock_gettime(CLOCK_PROCESS_CPUTIME_ID) and
clock_gettime(CLOCK_THREAD_CPUTIME_ID) are not supported. I guess glibc
would have to do multiple calls to add up all the threads in order to get
these values. This also leaves glibc in control of clocks and does not
allow the kernel to define its own clocks.

The code is pretty invasive and I am not sure that this brings us much
nor that it is done the right way.

The kernel interface is rather strange with the bits that may be set for
each special clock which is then combined with the pid. It may be
advisable to have a separate function call to do this like

get_process_clock(pid,type,&timespec)

instead of using the posix calls. The thread specific time
measurements have nothing to do with the posix standard and may best
be kept separate.

The benefit of the patches that I proposed is that it is a clean
implementation of the posix interface, the kernel has full
control over posix clocks and that driver specific clocks as well as other
time sources can be defined that may also utilize the timed interrupt
features of those clock chips. Rolands patch does not allow that and
instead will lead to more complex logic in glibc and a rather strange
kernel interface.
