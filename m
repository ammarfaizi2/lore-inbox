Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbSISLD5>; Thu, 19 Sep 2002 07:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbSISLD5>; Thu, 19 Sep 2002 07:03:57 -0400
Received: from zeus.kernel.org ([204.152.189.113]:60631 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263118AbSISLD4>;
	Thu, 19 Sep 2002 07:03:56 -0400
Date: Thu, 19 Sep 2002 03:59:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
Message-ID: <20020919105940.GJ28202@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209182304040.4563-100000@home.transmeta.com> <Pine.LNX.4.44.0209191116070.2377-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209191116070.2377-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 11:25:11AM +0200, Ingo Molnar wrote:
> i'll add some debugging code to the old code to print out cases when
> p->tty == tty but p->session != tty->session and start up X, that should
> prove or disprove this theory, right?
> (i cant remember any other place where the code transformation was not
> identity, but will double-check this again.)
> William, you did the original transformation, was this optimization done
> intentionally?
> 	Ingo

Sorry, I was debugging some boot-time issues I ran into.

I did this intentionally. Basically, sys_setsid() does the right thing,
but tty_ioctl() does not. There is already some inconsistency
about how task->tty is locked, and I'd not yet come to a conclusion.

On second thought, I really hope I'm imagining things here:

For instance, tty_open() does the following while not holding the
tasklist_lock for writing:

	if (IS_TTY_DEV(device)) {
		if (!current->tty)
			return -ENXIO;
		device = current->tty->device;


So tiocsctty() appears to have the following race against tty_open():

A                                       B
-----------------------------------------
tty->session > 0         if (!current->tty)
                           return -ENXIO; (test fails, don't return)

iterate tasklist,        delay...
  setting p->tty = NULL       current->tty is set to NULL

        (this looks like an attempt to obtain a unique
         reference by blowing away everyone else's)

task_lock(current)       device = current->tty->device
current->tty = tty       OOPS
task_unlock(task)

tiocsctty() holds the BKL (from sys_ioctl() itself) and the
tasklist_lock for reading, but tty_open() seems to hold only some
vfs references. release_dev() does the same style of iteration, but
doesn't even hold the BKL, only the tasklist_lock for reading. And
is very ominously called by tty_open() itself.

Also, most other accesses to tty->session and/or tty->pgrp seem to
be protected by the BKL.


Bill
