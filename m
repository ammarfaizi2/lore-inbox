Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbTITSzh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 14:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTITSzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 14:55:37 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:51469 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S261943AbTITSze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 14:55:34 -0400
Date: Sat, 20 Sep 2003 13:55:17 -0500 (CDT)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200309201855.h8KItHuf000466@sullivan.realtime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Omen Wild <Omen.Wild@Dartmouth.EDU>,
       <linux-kernel@vger.kernel.org>
Subject: Re: call_usermodehelper does not report exit status?
In-Reply-To: <20030919124213.7fc93067.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> Omen Wild <Omen.Wild@Dartmouth.EDU> wrote:
> >
> > I found the call_usermodehelper function and
> > call it with the wait flag set, but I cannot get a non-zero return
> > status of the program to propagate into the kernel.
> 
> This might fix it.


I think you missed the why behind the comment just above your first change.

 		/* We don't have a SIGCHLD signal handler, so this
 		 * always returns -ECHILD, but the important thing is
 		 * that it blocks. */
-		sys_wait4(pid, NULL, 0, NULL);
+		sys_wait4(pid, &sub_info->retval, 0, NULL);


The exit code notices that there is no signal handler for SIGCHILD and
does a fast exit, then we notice when woken up the child no longer exists.

Rusty discovered this back in June when we were trying to fix a checker
error on the wait call, and decided that at the time no one was using the
return value, hence the simpler fix.  

http://linux.bkbits.net:8080/linux-2.5/cset@1.1046.366.23?nav=index.html|src/|src/kernel|related/kernel/kmod.c


milton
