Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTJ0AWN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 19:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTJ0AWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 19:22:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:37002 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263693AbTJ0AWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 19:22:11 -0500
Date: Sun, 26 Oct 2003 16:21:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Andries.Brouwer@cwi.nl, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>, "David S. Miller" <davem@redhat.com>,
       <kuznet@ms2.inr.ac.ru>
Subject: Re: Linux 2.6.0-test9
In-Reply-To: <20031026160158.74bd09c8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0310261607230.3157-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Oct 2003, Andrew Morton wrote:
> 
> Can someone show us the diff for this?

There's only one change to tcp.c after -test8: it's 

	kuznet@ms2.inr.ac.ru:
	 TCP: do not return -EINTR, when data are available for read()

and I think it should just be reverted: the changeset even removes the 
comment that clearly says:

		/* We need to check signals first, to get correct SIGURG
		 * handling. FIXME: Need to check this doesn't impact 1003.1g
		 * and move it down to the bottom of the loop
		 */

And Alexey apparently tried to do the "FIXME" part, but without thinking 
about the SIGURG part.

We _need_ to stop at urgent data and we _should_ return -EINTR, and let
the SIGURG handler do the URG read. Otherwise we'll lose urgent data (or
we'll just read it inline without realizing that it was urgent data).

I don't know anybody sane who uses urgent data (telnet and rlogin do, I
don't know if they count as sane any more), but it does look like that
patch totally broke it.

I'd revert it myself, but since the networking code is fairly well 
maintained, I'll just wait for David and Alexey to weigh in, and tell me 
that I'm a total moron and I overlooked something. But I don't think I 
missed anything.

Andries, what was the situation that led to a TCP lockup? I don't see 
anything but URG being broken by that patch, so it would be good to verify 
that your breakage really was URG, to see that it's totally understood..

		Linus

