Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUC2K0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 05:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbUC2K0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 05:26:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:54668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262774AbUC2K0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 05:26:06 -0500
Date: Mon, 29 Mar 2004 02:25:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm5
Message-Id: <20040329022556.255c71bb.akpm@osdl.org>
In-Reply-To: <20040329105729.A20272@flint.arm.linux.org.uk>
References: <20040329014525.29a09cc6.akpm@osdl.org>
	<20040329105729.A20272@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Mon, Mar 29, 2004 at 01:45:25AM -0800, Andrew Morton wrote:
> > +remove-down_tty_sem.patch
> > +tty-locking-again.patch
> > 
> >  Really, really fix the tty open/close race.
> 
> Erm, note that tty drivers are supposed to handle the open/close stuff
> themselves,

They cannot.  This bug relates to racy handling of tty->count at the
tty_io.c level.  If the driver's ->close sleeps and drops the BKL.

> and it is completely valid for ->close to be called while
> another thread is in ->open.  In fact, it's desirable since ->open may
> be waiting for the DCD line from a modem to activate, while there may
> be a simultaneous O_NONBLOCK open/ioctl/close from stty.

->open is not called under tty_sem.  With this change, ->close is called
under tty_sem.

Are ->close implementations likely to block on hardware events?
