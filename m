Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUIOS4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUIOS4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUIOS4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:56:51 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:12852 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267310AbUIOSy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:54:56 -0400
Subject: Re: PATCH: tty locking for 2.6.9rc2
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040915163051.GA9096@devserv.devel.redhat.com>
References: <20040914163426.GA29253@devserv.devel.redhat.com>
	 <1095265595.2924.27.camel@deimos.microgate.com>
	 <20040915163051.GA9096@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095274482.2686.16.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Sep 2004 13:54:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 11:30, Alan Cox wrote:
> On Wed, Sep 15, 2004 at 11:26:35AM -0500, Paul Fulghum wrote:
> > I tried this patch and can't change line disciplines.
> > The user program waits forever on ioctl(TIOCSETD).
> > I am going to add printk statements to
> 
> Is the tty currently in use - that implies maybe an ldisc leak
> 
> > Each line discipline has a refcount.
> > This single refcount is modified by all
> > entities using that line discipline.
> 
> Nope. tty->ldisc is a -copy- of the ldisc structure rather than a 
> pointer. It has always been that way

Got it.

Global ldisc array refcount is used to know
when an ldisc module can be unloaded.

Per tty ldisc refcount is used to know
when an ldisc can be switched.

The problem is that the per tty ldisc structure is being
initialized with the global ldisc array entry
including the global refcount.

So the per tty refcount starts non zero and
never goes to zero and can't be changed.

The per tty ldisc refcount must be initialized to zero 
after copying the global ldisc structure.

There are 6 places where this needs to be done:
3 in tty_set_ldisc
2 in release_dev
1 in initialize_tty_struct

Also:
Switching back to N_TTY ldisc in release_dev() of tty_io.c
takes a global ldisc reference (tty_ldisc_get) but
then frees the tty structure. This causes a reference
leak (global ldisc refcount) on N_TTY because there
is no corresponding tty_ldisc_put.


--
Paul Fulghum
paulkf@microgate.com


