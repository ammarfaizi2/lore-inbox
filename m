Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267988AbUJGVD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUJGVD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUJGVDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:03:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11698 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268127AbUJGUjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:39:41 -0400
Subject: Re: [RFC][PATCH] TTY flip buffer SMP changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097179099.1519.17.camel@deimos.microgate.com>
References: <1097179099.1519.17.camel@deimos.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097177830.31768.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 20:37:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry not quoting but if you will use attachments 8))

Problem 1:
Agree. Using a common function is definitely needed, lets at least have
all the bugs in one place.

Problem 2:
Known. See the comment in the Documentation/tty.txt

Add:
Problem 3:
The buffering model is useless for virtualised devices or high speeds.


I've been pondering taking a very small performance hit to fix the
entire flipping mess (pardon the pun) and also to speed up the actual
common critical path (ppp) in the process.

Now that networking is not a kernel option it seems slightly dumb that
the tty layer doesn't just use the sk_buff model (probably not code).
kmalloc is very fast and it kills TTY_DONT_FLIP because every buffer is
owned by _one_ person at a time. (sk_buff's dont direclty fit too well
because we push both error and bits per byte and don't last time I
checked support recycling).

Another nice effect is simplifying the ldisc and driver level locking.
Drivers queue buffers, ldiscs eat buffers. If the driver queues a buffer
and there is temporarily no ldisc it does not get lost. 

This also saves us memory - most tty's spend most of their time idle.

Alan

