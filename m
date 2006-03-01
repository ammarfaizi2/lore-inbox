Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWCABzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWCABzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 20:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWCABzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 20:55:45 -0500
Received: from mail.host.bg ([87.120.40.5]:3264 "EHLO mail.host.bg")
	by vger.kernel.org with ESMTP id S964803AbWCABzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 20:55:44 -0500
Subject: Re: Thread safety for epoll/libaio
From: Anton Titov <a.titov@host.bg>
To: "Li, Peng" <ringer9cs@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <598a055d0602281236m7eac9c09oc60af9ce28e7e4bf@mail.gmail.com>
References: <598a055d0602281236m7eac9c09oc60af9ce28e7e4bf@mail.gmail.com>
Content-Type: text/plain
Organization: Host.bg
Date: Wed, 01 Mar 2006 03:55:42 +0200
Message-Id: <1141178142.7208.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 15:36 -0500, Li, Peng wrote:

> Thread B:  while(1) { epoll_wait();  ... }
> // same as thread A
> Thread D:  ... epoll_ctl(); ....
> 
> Suppose thread B calls epoll_wait and blocks before thread D calls
> epoll_ctl.  Is it safe to do so? Will thread B be notified for the
> event submitted by thread D? 

Hello,

I have some (more) expirience with epoll and threads and it seem to work
well. If you have epoll_wait() in one thread and another thread do
epoll_ctl to add a handle, epoll_wait will wake up as soon as the handle
is ready for operation (most of the time instantly, when operation is
write). 

epoll man page states:

              Q6     Will the close of an fd cause it to be removed from
all epoll sets automatically?

              A6     Yes.
but I was experiencing some (rare) segfaults with my application while
benchmarking it when I just closing my descriptors. Debugging showed,
that I'm getting events for destroyed objects (with closed descriptors).
Adding epoll_ctl(..., EPOLL_CTL_DEL, ...) fixed this.



