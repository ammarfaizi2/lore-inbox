Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTIWHd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 03:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbTIWHd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 03:33:59 -0400
Received: from rth.ninka.net ([216.101.162.244]:36259 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261928AbTIWHd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 03:33:58 -0400
Date: Tue, 23 Sep 2003 00:33:57 -0700
From: "David S. Miller" <davem@redhat.com>
To: Abhijit Menon-Sen <ams@wiw.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how is recv(..., MSG_PEEK) racy?
Message-Id: <20030923003357.7c6bb130.davem@redhat.com>
In-Reply-To: <20030923121545.D700@lustre.dyn.wiw.org>
References: <20030923121545.D700@lustre.dyn.wiw.org>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 12:15:45 +0530
Abhijit Menon-Sen <ams@wiw.org> wrote:

> While fetchmail doesn't seem to be triggering that printk(), I'm curious
> about what the race condition is. Google found a post by DaveM saying it
> has something to do with URG data, but without any further details. I'd
> appreciate any explanation of the problem(s).

If multiple threads do reads to the same socket, one using
MSG_PEEK and one without, there is a race because the thread
doing MSG_PEEK doesn't expect the bytes it is "peeking" at
to be removed from the receive queue from the socket, but that
is exactly what the other thread will do.

When using URG data, the kernel becomes the "other thread doing
non-MSG_PEEK reads" on the socket.  So if you use MSG_PEEK and
URG data at the same time, you will likely trigger the race and
that printk() alerting you to this fact.
