Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUEYCVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUEYCVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 22:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbUEYCVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 22:21:22 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:39399 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264492AbUEYCVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 22:21:20 -0400
From: lm240504@comcast.net
To: linux-kernel@vger.kernel.org
Subject: Invisible threads in 2.6
Date: Tue, 25 May 2004 02:21:19 +0000
Message-Id: <052520040221.14460.40B2AD9F00067A620000387C2200735834CBCFCACFCBCD0304@comcast.net>
X-Mailer: AT&T Message Center Version 1 (May  6 2004)
X-Authenticated-Sender: bG0yNDA1MDRAY29tY2FzdC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experimenting with process/thread accounting in 2.6.x,
and found this strange situation: if the leader thread of a multi-threaded
process terminates, the other threads become undetectable.  After the
main thread becomes a zombie, /proc/<tgid>/task returns ENOENT on
open.  If you happen to know the TID, you can access /proc/<tid>/* directly,
but otherwise, there is no way to observe the remaining threads, as far as
I can see.  Consider this program, for example:

#include <pthread.h>

void *run(void *arg)
{
        for(;;);
}

int main()
{
        pthread_t t;
        int i;
        for (i = 0; i < 10; ++i)
                pthread_create(&t, NULL, run, NULL);
        pthread_exit(NULL);
}

When I run it, the system (predictably) goes to ~100% CPU utilization,
but there seems to be no way to find out who is hogging the CPU with
top(1), ps(1), or anything else.  All they can show is the main thread in
zombie state, consuming 0% CPU.

I'm not sure how to fix this (the pid_alive() test seems to be there for a
reason), but it doesn't seem right.  Any thoughts?
