Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTH1WpB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTH1WpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:45:00 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54151 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264314AbTH1Wo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:44:59 -0400
Date: Thu, 28 Aug 2003 23:44:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: ->pid in dnotify
Message-ID: <20030828224438.GB10035@mail.jlokier.co.uk>
References: <3F4E4E13.1000301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4E4E13.1000301@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Also keep in mind that threads can go away while the process (and
> therefore file descriptor) remain.  And the ID of the thread can be
> reused

The problem of owner churn goes beyond threads - fds can be passed to
other process and outlive the original thread or process which created
them.  Changing ->pid to ->tgid doesn't fix this.

Using ->tgid in dnotify is at least consistent with fcntl_setlease()
in locks.c, and the call to f_setown() in futex.c.

Unfortunately I can think of a few situations where you would want the
signal delivered to one thread, but none where you'd want it delivered
to a whole process (same for dnotify and setlease).

Userspace can change the pid straight after to ->pid using
fcntl(fd,F_SETOWN,...), but that leaves a time window where a thread
creates a dnotify or lease, and the signal will be delivered
process-wide until the thread can direct it to itself.

-- Jamie
