Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTJISJW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTJISJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:09:22 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28688 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262360AbTJISJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:09:19 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: 9 Oct 2003 17:59:36 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bm47m8$56n$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0310071621280.16239-100000@home.osdl.org> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com>
X-Trace: gatekeeper.tmr.com 1065722376 5335 192.168.12.62 (9 Oct 2003 17:59:36 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com>,
Robert White <rwhite@casabyte.com> wrote:
| 
| 
| -----Original Message-----
| From: linux-kernel-owner@vger.kernel.org
| [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Linus Torvalds
| 
| 
| > And when you have _that_ kind of model (with assymetric specialized 
| > threads), it makes perfect sense for the threads to have independent file 
| > descriptors.
| 
| (Preface disclaimer) I don't "just use pthreads" as the other half of my
| life is embedded work using RTXC (od nausium 8-) and on occasion windows
| nonsense.  I've also used the LWP features of solaris without the pthread
| library.  I experience the differences between the posix thread and the
| lightweight process paradigms daily.
| 
| What is gained by having the independent file descriptor context that would
| be *broken* for lack of that independence?

To start with, if I have a server with 1400 clients, instead of 1400
threads with 1400(+overhead) fd's each, I have 1400 threads with
1(+overhead) fd's. While memory waste is "broken" the way you mean, it
is significant.

And since one thread can close a file which it's done with it, without
affecting all the other threads, or open a file without forcing it into
all other threads, so system overhead is reduced there as well.

| Even in a game or for very specialized threads that don't talk much if at
| all, can you give me one example where two threads simply *must* have the
| same file descriptor number active for two separate files at the same time?
| 
| That is, where this is the truth table for FDs:

The truth table is "if you don't like the way it works don't use it."
Since this only affects programs which choose to use it you can pretend
it isn't there.

| So CLONE_THREAD is supposed to create (essentially) the conjoined LWP
| environment in as much as you are creating a "thread within a process", but
| you want to decouple "file" from "process" to separately and multiply
| re-couple it with each "thread".  Yet further, you want to leave "file"
| bound to "process" if there is only one thread.  That is an expensive
| change, especially when it is apparently being done case-by-case. You aren't
| unilaterally redefining "process" to be a set of one or more threads, if you
| were /proc/<pid>/fd/* would have to disappear in favor of
| /proc/<pid>/<tid>/fd/* and /proc/self would mutate into a set of dynamic
| references, some to /proc/<pid>/<tid>/whatever and some to just
| /proc/<pid>/whatever.

I have already suggested that traditional threads just have their fd be
a symlink to the main process fd, making it easy to identify, and for
non-fd-sharing threads have the fd entries which refer to inherited fd's
also be symlinks. Others have independently made the same or similar
suggestions. What you suggest would seem to break existing software
which expects an fd directory in /proc/<pid>.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
