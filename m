Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUIOQav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUIOQav (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUIOQ3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:29:38 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:12585 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S266775AbUIOQ0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:26:47 -0400
Subject: Re: PATCH: tty locking for 2.6.9rc2
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040914163426.GA29253@devserv.devel.redhat.com>
References: <20040914163426.GA29253@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095265595.2924.27.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Sep 2004 11:26:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 11:34, Alan Cox wrote:
> This updates the ldisc locking patch for the 2.6.9rc2 changes.

I tried this patch and can't change line disciplines.
The user program waits forever on ioctl(TIOCSETD).
I am going to add printk statements to
find out more.

Looking at your patch I have a question:

Each line discipline has a refcount.
This single refcount is modified by all
entities using that line discipline.

tty_set_ldisc() in tty_io.c waits until the
old ldisc refcount goes to zero before setting
the new ldisc. This seems to cause a problem
in the following situation:

1. two tty instances start with the same ldisc
2. first tty instance holds reference to ldisc
3. second tty instance tries to change ldisc

The second tty instance must wait for the first
tty instance to drop the ldisc reference before
it can change to a new ldisc.

Each tty instance should be able to change
line discipline independant of other tty instances.

Or am I not understanding this correctly?

--
Paul Fulghum
paulkf@microgate.com


