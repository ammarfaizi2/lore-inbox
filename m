Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVAGWBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVAGWBl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVAGWAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:00:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:37281 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261662AbVAGWAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:00:04 -0500
Date: Fri, 7 Jan 2005 13:59:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501071349320.2272@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru>  <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
 <1105113998.24187.361.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org>
 <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jan 2005, Linus Torvalds wrote:
> 
> I want to highlight this again. The increase in throughput did _not_ come
> from avoiding a copy. It came purely from the fact that we have multiple
> buffers, and thus a throughput-intensive load gets to do several bigger
> chunks before it needs to wait for the recipient. So the increase in
> throughput comes from fewer synchronization points (scheduling and
> locking), not from anything else.

Btw, from limited testing this effect seems to be much more pronounced on
SMP.

I've done some more benchmarking, and on a single-CPU Banias laptop,
bandwidth didn't really change much, and latency goes up measurably
(roughly 2.5us -> 3.0us). In contrast, on a P4 with HT, latency was not
noticeable (looks like 10.4us -> 10.7us), since there the locking and
system call costs dominate, and throughput goes up from 370MB/s to
900+MB/s (ie > 100% improvement).

So it's not always a win, but at the same time sometimes it's quite a big
win. We might tune the number of buffers down for the UP case, or
something.

Side note: the UNIX domain socket lmbench numbers are higher than the
memory copy numbers, implying that at least the UNIX domain socket tests
have the data set fit in the L2. That may be the reason why lmbench says 
that sockets outperform pipes.

		Linus
