Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWAKNDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWAKNDd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWAKNDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:03:33 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:662 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1750909AbWAKNDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:03:32 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: OT: fork(): parent or child should run first?
Date: Wed, 11 Jan 2006 13:03:30 +0000 (UTC)
Organization: Cistron
Message-ID: <dq2vn2$dmr$1@news.cistron.nl>
References: <20060111123745.GB30219@lgb.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: ncc1701.cistron.net 1136984610 14043 194.109.0.112 (11 Jan 2006 13:03:30 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20060111123745.GB30219@lgb.hu>,
Gábor Lénárt  <lgb@lgb.hu> wrote:
>The following problem may be simple for you, so I hope someone can answer
>here. We've got a complex software using child processes and a table
>to keep data of them together, like this:
>
>childs[n].pid=fork();
>
>where "n" is an integer contains a free "slot" in the childs struct array.
>
>I also handle SIGCHLD in the parent and signal handler  searches the childs
>array for the pid returned by waitpid(). However here is my problem. The
>child process can be fast, ie exits before scheduler of the kernel give
>chance the parent process to run, so storing pid into childs[n].pid in the
>parent context is not done yet. Child may exit, than scheduler gives control
>to the signal handler before doing the store of the pid (if child run for
>more time, eg 10 seconds it works of course). So it's impossible to store
>child pids and search by that information in eg the signal handler?

Simply block sigchld like this:

	sigemptyset(&set);
	sigaddset(&set, SIGCHLD);
	sigprocmask(SIG_BLOCK, &set, &oldset);
	pid = fork();
	if (pid == 0) {
		sigprocmask(SIG_SETMASK, &oldset, NULL);
		do_whatever();
		exit(0);
	}
	childs[n].pid = pid;
	sigprocmask(SIG_SETMASK, &oldset, NULL);

This is a common problem. When you have data structures that are
handled by both the main program and by a signal handler, *always* block
the signal when you're handling the data structures in the main program.

Mike.
-- 
Freedom is no longer a problem.

