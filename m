Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbUDNG0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 02:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263907AbUDNG0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 02:26:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4225 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263918AbUDNG0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 02:26:36 -0400
Date: Wed, 14 Apr 2004 02:26:03 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: Fw: [PATCH] Fix mq_notify with SIGEV_NONE notification
Message-ID: <20040414062603.GB31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040413163605.031af36c.akpm@osdl.org> <407CC3AB.6050602@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407CC3AB.6050602@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 06:52:59AM +0200, Manfred Spraul wrote:
> >mq_notify (q, NULL)
> >and
> >struct sigevent ev = { .sigev_notify = SIGEV_NONE };
> >mq_notify (q, &ev)
> >are not the same thing in POSIX, yet the kernel treats them the same.
> >
> What should mq_notify(q, &{.sigev_notify = SIGEV_NONE}) do? Register a 
> notification, but deliver nothing?

Yes.  It makes it impossible to mq_notify for others until the owner
mq_notify (q, NULL) or until a message arrives at the queue while nobody is
blocked in mq_{,timed}receive or until the mqd_t through which it has been
registered is mq_close()d.
It is not very useful, sure, but neither is having two different
ways how to unregister notification, one is completely enough.
At which point it is IMHO better to follow the standard (and what other
OSes do), rather than invent something new.

	Jakub
