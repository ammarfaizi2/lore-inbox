Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268794AbRHBF4W>; Thu, 2 Aug 2001 01:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268802AbRHBF4M>; Thu, 2 Aug 2001 01:56:12 -0400
Received: from rj.sgi.com ([204.94.215.100]:33005 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S268794AbRHBFz5>;
	Thu, 2 Aug 2001 01:55:57 -0400
Date: Wed, 1 Aug 2001 22:55:00 -0700 (PDT)
From: jeremy@classic.engr.sgi.com (Jeremy Higdon)
Message-Id: <10108012254.ZM192062@classic.engr.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux-kernel@vger.kernel.org
Subject: changes to kiobuf support in 2.4.(?)4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious about the changes made to kiobuf support, apparently in
order to improve raw I/O performance.  I was reading through some old
posts circa early April, where I saw reference to a rawio-bench program.
Can someone explain what it does?

I have a driver that uses kiobufs to perform I/O.  Prior to these
changes, the kiobuf allocation and manipulation was very quick and
efficient.  It is now very slow.

The kiobuf part of the I/O request is as follows:

	alloc_kiovec()
	map_user_kiobuf()
	... do I/O, using kiobuf to store mappings ...
	kiobuf_wait_for_io()
	free_kiovec()

Now that the kiobuf is several KB in size, and 1024 buffer heads
are allocated, the alloc_kiovec part goes from a percent or so of
CPU usage to do 13000 requests per second to around 90% CPU usage
to do 3000 per second.

It looks as though the raw driver allocates one kiobuf at open time
(rather than on a per-request basis), but if two or more requests
are issued to a single raw device, it too devolves into the allocate
on every request strategy.

Before I go further, I'd appreciate if someone could confirm my
hypotheses and also explain rawio-bench (and maybe point me to some
source, if available).

thanks

jeremy
