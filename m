Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWHBWt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWHBWt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWHBWt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:49:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13767
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932248AbWHBWt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:49:58 -0400
Date: Wed, 02 Aug 2006 15:49:54 -0700 (PDT)
Message-Id: <20060802.154954.112624420.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, jbaron@redhat.com
Subject: Re: frequent slab corruption (since a long time)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060802222321.GH3639@redhat.com>
References: <20060801.220538.89280517.davem@davemloft.net>
	<20060801.223110.56811869.davem@davemloft.net>
	<20060802222321.GH3639@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Wed, 2 Aug 2006 18:23:21 -0400

> None of the code manipulating tty->count seems to be under
> the tty_mutex.  Should it be ?
> Or is this protected through some other means?

It is in the primary code paths at least, all callers of init_dev()
(which increments tty->count) grab the mutex and also release_dev()
grabs the mutex around tty->count manipulations.

I'm surprised that when this triggers we don't get one of these
two messages:

	if (pty_master) {
		if (--o_tty->count < 0) {
			printk(KERN_WARNING "release_dev: bad pty slave count "
					    "(%d) for %s\n",
			       o_tty->count, tty_name(o_tty, buf));
			o_tty->count = 0;
		}
	}
	if (--tty->count < 0) {
		printk(KERN_WARNING "release_dev: bad tty->count (%d) for %s\n",
		       tty->count, tty_name(tty, buf));
		tty->count = 0;
	}

However, there seems to be some kind of dependency of TTY opennings
holding the BKL, as least as far as this comment on con_close() is
concerned:

		/*
		 * tty_mutex is released, but we still hold BKL, so there is
		 * still exclusion against init_dev()
		 */

But it is not clear to me that tty_open() and ptmx_open() always run
with the BKL held.  chrdev_open() wraps the ->open call with the BKL
held, but then it plugs in the device's fops which should allow a
direct filp->fops->open() call from the VFS layer without the BKL
grabbing right?

chrdev_open() should catch /dev/foo char device opens, but what about
the sysfs instances?  They might bypass this path too somehow, thus
another case where the BKL won't be held on open().

Hmmm...
